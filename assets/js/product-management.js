// ==============================
// GLOBAL VARIABLES
// ==============================
let currentProduct = null;
const API_BASE_URL = 'assets/php/';

// ==============================
// INIT: When DOM is Ready
// ==============================
document.addEventListener("DOMContentLoaded", () => {
  updateCurrentDate();
  initializeCategoryDropdown();
  initializeCharts();
  filterProducts();
  setupEventListeners();
});

// ==============================
// EVENT LISTENERS SETUP
// ==============================
function setupEventListeners() {
  document.addEventListener("keydown", e => {
    if (e.key === "Escape") {
      document.getElementById("notificationPanel")?.classList.remove("active");
      document.getElementById("productDetailModal")?.classList.remove("active");
    }
  });

  document.getElementById("searchInput")?.addEventListener("input", filterProducts);
  document.getElementById("categoryFilter")?.addEventListener("change", filterProducts);
}

// ==============================
// PRODUCT DETAIL MANAGEMENT
// ==============================
async function viewProductDetail(productId) {
  try {
    const response = await fetch(`${API_BASE_URL}detail-product.php?id=${encodeURIComponent(productId)}`);

    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }

    const product = await response.json();

    if (product.error) {
      showNotification(product.error, 'error');
      return;
    }

    currentProduct = product;
    populateProductModal(product);
    loadProductReviews(product.id);
    showModal("productDetailModal");

  } catch (err) {
    console.error("Product detail error:", err);
    showNotification('Gagal memuat detail produk.', 'error');
  }
}

function loadProductReviews(productId) {
  const reviewContainer = document.getElementById("productReviewList");
  if (!reviewContainer) return;

  reviewContainer.innerHTML = "<p>Memuat ulasan...</p>";

  fetch(`${API_BASE_URL}detail-product.php?review_only=true&id=${encodeURIComponent(productId)}`)
    .then(response => {
      if (!response.ok) {
        throw new Error("Gagal memuat ulasan");
      }
      return response.json();
    })
    .then(result => {
      if (!result.reviews || result.reviews.length === 0) {
        reviewContainer.innerHTML = "<p>Belum ada ulasan untuk produk ini.</p>";
        return;
      }

      reviewContainer.innerHTML = "";
      result.reviews.forEach(r => {
        const reviewItem = document.createElement("div");
        reviewItem.className = "review-item";
        reviewItem.innerHTML = `
          <div class="review-header">
            <strong>${r.user_name}</strong> <span class="review-date">(${r.created_at})</span>
          </div>
          <div class="review-rating">Rating: ⭐ ${r.rating}</div>
          <div class="review-text">${r.review_text}</div>
        `;
        reviewContainer.appendChild(reviewItem);
      });
    })
    .catch(err => {
      reviewContainer.innerHTML = "<p class='error'>Gagal memuat ulasan produk.</p>";
      console.error(err);
    });
}

function populateProductModal(product) {
  // Set text content
  setText('productDetailName', product.name);
  setText('productDetailSku', `SKU: ${product.id}`);
  setText('productDetailPrice', formatCurrency(product.price));
  setText('productDetailStock', product.stock);
  setText('productDetailSales', product.total_sold ?? '-');
  setText('productDetailRating', product.rating ?? '-');
  setText('productDetailDescription', product.description ?? '-');

  // Set category badge
  const category = product.category?.toLowerCase() || 'lainnya';
  const categoryClasses = {
    vitamin: 'category-vitamin',
    herbal: 'category-herbal',
    protein: 'category-protein',
    supplement: 'category-supplement',
    organic: 'category-organic'
  };
  const categoryEl = document.getElementById('productDetailCategory');
  if (categoryEl) {
    categoryEl.innerHTML = `
      <span class="category-badge ${categoryClasses[category] || 'category-default'}">
        ${product.category}
      </span>
    `;
  }

  // Render reviews
  const reviewsContainer = document.getElementById('productDetailReviews');
  if (reviewsContainer) {
    reviewsContainer.innerHTML = '';

    if (product.reviews && product.reviews.length > 0) {
      product.reviews.forEach(review => {
        const reviewHTML = `
          <div class="review-item">
            <div class="review-header">
              <strong>${review.user_name}</strong> 
              <span class="review-date">${review.created_at}</span>
            </div>
            <div class="review-rating">Rating: ${review.rating} ★</div>
            <div class="review-text">${review.review_text}</div>
          </div>
        `;
        reviewsContainer.innerHTML += reviewHTML;
      });
    } else {
      reviewsContainer.innerHTML = `<p class="no-review">Belum ada ulasan untuk produk ini.</p>`;
    }
  }
}


// ==============================
// MODAL MANAGEMENT
// ==============================
function showModal(modalId) {
  const modal = document.getElementById(modalId);
  if (modal) {
    modal.classList.add("active");
    setTimeout(() => {
      document.addEventListener('click', closeModalOnOutsideClick);
    }, 100);
  }
}

function closeModal(modalId) {
  const modal = document.getElementById(modalId);
  if (modal) {
    modal.classList.remove("active");
    document.removeEventListener('click', closeModalOnOutsideClick);
  }
}

function closeModalOnOutsideClick(e) {
  const modal = document.getElementById("productDetailModal");
  if (modal?.classList.contains("active") && 
      !modal.querySelector(".modal-content")?.contains(e.target)) {
    closeModal("productDetailModal");
  }
}

// ==============================
// PRODUCT EDIT FUNCTIONS
// ==============================
function enableEditMode() {
  if (!currentProduct) return;

  // Toggle visibility
  toggleDisplay('productDetailStock', false);
  toggleDisplay('editProductStock', true, currentProduct.stock);
  
  toggleDisplay('productDetailDescription', false);
  toggleDisplay('editProductDescription', true, currentProduct.description);
  
  toggleDisplay('editBtn', false);
  toggleDisplay('saveBtn', true);
  toggleDisplay('cancelBtn', true);
}

async function saveProductChanges() {
  if (!currentProduct) return;

  const newStock = document.getElementById('editProductStock')?.value;
  const newDescription = document.getElementById('editProductDescription')?.value;

  try {
    const response = await fetch(`${API_BASE_URL}update_product.php`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        id: currentProduct.id,
        stock: newStock,
        description: newDescription
      })
    });
    
    const data = await response.json();

    if (data.success) {
      // Update current product data
      currentProduct.stock = newStock;
      currentProduct.description = newDescription;
      
      // Update UI
      setText('productDetailStock', newStock);
      setText('productDetailDescription', newDescription || '-');
      
      // Reset edit mode
      toggleEditMode(false);
      
      showNotification('Produk berhasil diperbarui', 'success');
    } else {
      showNotification(data.error || 'Gagal memperbarui produk', 'error');
    }
  } catch (err) {
    console.error("Update error:", err);
    showNotification('Terjadi kesalahan server', 'error');
  }
}

function toggleEditMode(enable) {
  toggleDisplay('productDetailStock', !enable);
  toggleDisplay('editProductStock', enable);
  
  toggleDisplay('productDetailDescription', !enable);
  toggleDisplay('editProductDescription', enable);
  
  toggleDisplay('editBtn', !enable);
  toggleDisplay('saveBtn', enable);
  toggleDisplay('cancelBtn', enable);
}

function cancelEdit() {
  toggleEditMode(false);
}

// ==============================
// PRODUCT DELETE FUNCTION
// ==============================
async function deleteProduct(productId) {
  if (!confirm("Yakin ingin menghapus produk ini?")) return;

  try {
    const response = await fetch(`${API_BASE_URL}delete_product.php?id=${productId}`, { 
      method: 'DELETE' 
    });
    const data = await response.json();

    if (data.success) {
      showNotification('Produk berhasil dihapus', 'success');
      setTimeout(() => location.reload(), 1500);
    } else {
      showNotification(data.error || 'Gagal menghapus produk', 'error');
    }
  } catch (err) {
    console.error("Delete error:", err);
    showNotification('Terjadi kesalahan saat menghapus produk', 'error');
  }
}

// ==============================
// FILTER FUNCTIONS
// ==============================
function filterProducts() {
  const keyword = document.getElementById("searchInput")?.value.toLowerCase() || '';
  const selectedCategory = document.getElementById("categoryFilter")?.value.toLowerCase() || '';
  const rows = document.querySelectorAll(".data-table tbody tr");
  let hasMatches = false;

  rows.forEach(row => {
    if (row.id === "noDataMessage") return;
    
    const name = row.querySelector(".product-name")?.textContent.toLowerCase() || "";
    const category = row.querySelector(".category-badge")?.textContent.toLowerCase() || "";
    
    const showRow = name.includes(keyword) && 
                   (!selectedCategory || category === selectedCategory);
    
    row.style.display = showRow ? "" : "none";
    if (showRow) hasMatches = true;
  });

  const noDataMessage = document.getElementById("noDataMessage");
  if (noDataMessage) {
    noDataMessage.style.display = hasMatches ? "none" : "";
  }
}

function filterByStock(mode, btn = null) {
  const rows = document.querySelectorAll(".data-table tbody tr");
  let hasMatches = false;

  rows.forEach(row => {
    if (row.id === "noDataMessage") return;
    
    const stockText = row.querySelector(".stock-indicator")?.textContent || "0";
    const stock = parseInt(stockText.replace(/\D/g, '')) || 0;
    
    let showRow = false;
    switch (mode) {
      case 'in-stock': showRow = stock >= 20; break;
      case 'low-stock': showRow = stock < 20; break;
      default: showRow = true; // 'all'
    }
    
    row.style.display = showRow ? "" : "none";
    if (showRow) hasMatches = true;
  });

  const noDataMessage = document.getElementById("noDataMessage");
  if (noDataMessage) {
    noDataMessage.style.display = hasMatches ? "none" : "";
  }

  // Update active button state
  document.querySelectorAll(".filter-btn").forEach(b => 
    b.classList.remove("active", "btn-success")
  );
  
  const activeBtn = btn || document.querySelector(`.filter-btn[data-mode="${mode}"]`);
  activeBtn?.classList.add("active", "btn-success");
}

// ==============================
// NOTIFICATION SYSTEM
// ==============================
function showNotification(msg, type = 'info') {
  const notification = document.createElement('div');
  notification.className = `notification notification-${type}`;
  notification.innerHTML = `
    <div class="notification-content">
      <i class="fas fa-${getNotificationIcon(type)}"></i>
      <span>${msg}</span>
    </div>
  `;
  
  Object.assign(notification.style, {
    position: 'fixed',
    top: '20px',
    right: '20px',
    background: getNotificationColor(type),
    color: 'white',
    padding: '15px 20px',
    borderRadius: '12px',
    boxShadow: '0 8px 25px rgba(0,0,0,0.15)',
    zIndex: '9999',
    minWidth: '300px',
    transform: 'translateX(100%)',
    transition: 'transform 0.3s ease'
  });
  
  document.body.appendChild(notification);
  
  // Show notification
  setTimeout(() => notification.style.transform = 'translateX(0)', 100);
  
  // Auto-hide after 3 seconds
  setTimeout(() => {
    notification.style.transform = 'translateX(100%)';
    setTimeout(() => notification.remove(), 300);
  }, 3000);
}

function getNotificationIcon(type) {
  const icons = {
    success: 'check-circle',
    error: 'exclamation-triangle',
    warning: 'exclamation-circle'
  };
  return icons[type] || 'info-circle';
}

function getNotificationColor(type) {
  const colors = {
    success: '#08A55A',
    error: '#dc3545',
    warning: '#ffc107'
  };
  return colors[type] || '#3FCAEA';
}

// ==============================
// UTILITY FUNCTIONS
// ==============================
function setText(id, text) {
  const element = document.getElementById(id);
  if (element) element.textContent = text ?? "-";
}

function toggleDisplay(id, show, value = null) {
  const element = document.getElementById(id);
  if (!element) return;

  element.style.display = show ? 'block' : 'none';

  if (value !== null) {
    if (element.tagName === 'INPUT' || element.tagName === 'TEXTAREA') {
      element.value = value;
    } else {
      element.textContent = value;
    }
  }
}

function formatCurrency(amount) {
  return 'Rp ' + Number(amount).toLocaleString('id-ID');
}

function updateCurrentDate() {
  const element = document.getElementById("current-date");
  if (element) {
    const now = new Date();
    element.textContent = now.toLocaleDateString("id-ID", {
      weekday: "long", 
      year: "numeric", 
      month: "long", 
      day: "numeric"
    });
  }
}

// ==============================
// INITIALIZATION FUNCTIONS
// ==============================
function initializeCategoryDropdown() {
  const categories = window.categoryLabels || [];
  const select = document.getElementById("categoryFilter");
  
  if (select) {
    select.innerHTML = `
      <option value="">Semua Kategori</option>
      ${categories.map(cat => `<option value="${cat}">${cat}</option>`).join('')}
    `;
  }
}

function initializeCharts() {
  // Sales Chart
  const salesChartEl = document.getElementById("salesChart");
  if (salesChartEl && window.salesData) {
    new Chart(salesChartEl.getContext("2d"), {
      type: "line",
      data: {
        labels: window.salesLabels || [],
        datasets: [{
          label: "Penjualan (Rp Million)",
          data: window.salesData,
          borderColor: "#08A55A",
          backgroundColor: "rgba(8, 165, 90, 0.1)",
          tension: 0.4,
          fill: true
        }]
      },
      options: getChartOptions()
    });
  }

  // Category Chart
  const catChartEl = document.getElementById("categoryChart");
  if (catChartEl && window.categoryCounts) {
    new Chart(catChartEl.getContext("2d"), {
      type: "pie",
      data: {
        labels: window.categoryLabels || [],
        datasets: [{
          data: window.categoryCounts,
          backgroundColor: ["#4CAF50", "#FFC107", "#2196F3", "#9C27B0", "#FF5722"]
        }]
      },
      options: getChartOptions(true)
    });
  }
}

function getChartOptions(isPie = false) {
  const baseOptions = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        position: isPie ? "bottom" : "top",
        labels: {
          usePointStyle: true,
          padding: 20
        }
      }
    }
  };
  
  if (isPie) {
    baseOptions.plugins.tooltip = {
      callbacks: {
        label: ctx => `${ctx.label}: ${ctx.raw} produk`
      }
    };
  } else {
    baseOptions.scales = {
      x: { grid: { display: false } },
      y: { grid: { color: "rgba(0,0,0,0.1)" } }
    };
  }
  
  return baseOptions;
}
