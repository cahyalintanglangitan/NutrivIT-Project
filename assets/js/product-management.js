// ==============================
// INIT: Saat DOM Siap
// ==============================
document.addEventListener("DOMContentLoaded", () => {
  updateCurrentDate();
  initializeCategoryDropdown();
  initializeCharts();
  filterProducts();
});

// ==============================
// VARIABEL GLOBAL
// ==============================
let currentProduct = {}; // Menyimpan data produk aktif

// ==============================
// FUNGSI UTAMA
// ==============================

// Menampilkan detail produk ke modal
function viewProductDetail(productId) {
  fetch(`detail-product.php?id=${productId}`)
    .then(response => response.json())
    .then(product => {
      if (product.error) return showNotification(product.error, 'error');

      currentProduct = product; // Simpan produk aktif

      // Set konten tampilan
      setText('productDetailName', product.name);
      setText('productDetailSku', 'SKU: ' + product.id);
      setText('productDetailPrice', 'Rp ' + Number(product.price).toLocaleString('id-ID'));
      setText('productDetailStock', product.stock);
      setText('productDetailSales', product.total_sold);
      setText('productDetailRating', product.rating || '-');
      setText('productDetailDescription', product.description || '-');

      // Kategori badge
      const category = product.category || 'lainnya';
      document.getElementById('productDetailCategory').innerHTML =
        `<span class="category-badge category-${category.toLowerCase()}">${category}</span>`;

      // Tampilkan modal
      document.getElementById('productDetailModal').classList.add('active');

      // Aktifkan listener klik luar modal
      setTimeout(() => {
        document.addEventListener('click', closeModalOnOutsideClick);
      }, 100);
    })
    .catch(err => {
      console.error(err);
      showNotification('Gagal memuat detail produk.', 'error');
    });
}

// Mengaktifkan mode edit di modal
function enableEditMode() {
  // Ganti tampilan ke input
  toggleDisplay('productDetailStock', false);
  toggleDisplay('editProductStock', true, currentProduct.stock);

  toggleDisplay('productDetailDescription', false);
  toggleDisplay('editProductDescription', true, currentProduct.description);

  toggleDisplay('editBtn', false);
  toggleDisplay('saveBtn', true);
}

// Menyimpan perubahan produk
function saveProductChanges() {
  const newStock = document.getElementById('editProductStock').value;
  const newDescription = document.getElementById('editProductDescription').value;

  fetch('update_product.php', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      id: currentProduct.id,
      stock: newStock,
      description: newDescription
    })
  })
    .then(res => res.json())
    .then(data => {
      if (data.success) {
        alert('✅ Produk berhasil diperbarui');

        // Update data dan tampilan
        currentProduct.stock = newStock;
        currentProduct.description = newDescription;

        setText('productDetailStock', newStock);
        setText('productDetailDescription', newDescription);

        toggleDisplay('productDetailStock', true);
        toggleDisplay('editProductStock', false);

        toggleDisplay('productDetailDescription', true);
        toggleDisplay('editProductDescription', false);

        toggleDisplay('editBtn', true);
        toggleDisplay('saveBtn', false);
      } else {
        alert('❌ Gagal memperbarui produk');
      }
    })
    .catch(() => alert('❌ Terjadi kesalahan server'));
}

// Menghapus produk
function deleteProduct(productId) {
  if (!confirm("Yakin ingin menghapus produk ini?")) return;

  fetch(`delete_product.php?id=${productId}`, { method: 'DELETE' })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        alert("Produk berhasil dihapus!");
        location.reload();
      } else {
        alert("Gagal menghapus produk.");
      }
    })
    .catch(() => alert("Terjadi kesalahan saat menghapus produk."));
}

// ==============================
// UTILITAS
// ==============================

// Mengatur teks elemen
function setText(id, text) {
  const el = document.getElementById(id);
  if (el) el.textContent = text;
}

// Toggle tampilan antara view/edit
function toggleDisplay(id, show, value = null) {
  const el = document.getElementById(id);
  if (!el) return;

  el.style.display = show ? 'block' : 'none';

  // Jika input, isi nilainya
  if (value !== null) {
    if (el.tagName === 'INPUT' || el.tagName === 'TEXTAREA') {
      el.value = value;
    } else {
      el.textContent = value;
    }
  }
}



// ==============================
// Tanggal Hari Ini
// ==============================
function updateCurrentDate() {
  const el = document.getElementById("current-date");
  if (el) {
    const now = new Date();
    el.textContent = now.toLocaleDateString("id-ID", {
      weekday: "long", year: "numeric", month: "long", day: "numeric"
    });
  }
}

// ==============================
// Navigasi
// ==============================
function handleProfile() {
  window.location.href = "profile.php";
}

// ==============================
// Panel Notifikasi
// ==============================
function toggleNotificationPanel() {
  const panel = document.getElementById("notificationPanel");
  panel.classList.toggle("active");
  if (panel.classList.contains("active")) {
    setTimeout(() => document.addEventListener("click", closeNotificationOnOutsideClick), 100);
  } else {
    document.removeEventListener("click", closeNotificationOnOutsideClick);
  }
}

function closeNotificationOnOutsideClick(e) {
  const panel = document.getElementById("notificationPanel");
  const bell = document.querySelector(".notification-bell");
  if (!panel.contains(e.target) && !bell.contains(e.target)) {
    panel.classList.remove("active");
    document.removeEventListener("click", closeNotificationOnOutsideClick);
  }
}

function markAllAsRead() {
  document.querySelectorAll(".notification-item.unread").forEach(item => {
    item.classList.remove("unread");
    item.querySelector(".unread-dot")?.remove();
  });
  const badge = document.querySelector(".notification-badge");
  if (badge) {
    badge.textContent = '0';
    badge.style.display = 'none';
  }
  showNotification('Semua notifikasi telah ditandai sebagai dibaca', 'success');
}

// ==============================
// Toast Notification
// ==============================
function showNotification(msg, type = 'info') {
  const notif = document.createElement('div');
  notif.className = `notification notification-${type}`;
  notif.innerHTML = `
    <div class="notification-content">
      <i class="fas fa-${getNotificationIcon(type)}"></i>
      <span>${msg}</span>
    </div>`;
  notif.style.cssText = `
    position: fixed; top: 20px; right: 20px;
    background: ${getNotificationColor(type)};
    color: white; padding: 15px 20px;
    border-radius: 12px; box-shadow: 0 8px 25px rgba(0,0,0,0.15);
    z-index: 9999; min-width: 300px;
    transform: translateX(100%); transition: transform 0.3s ease;`;
  document.body.appendChild(notif);
  setTimeout(() => notif.style.transform = 'translateX(0)', 100);
  setTimeout(() => {
    notif.style.transform = 'translateX(100%)';
    setTimeout(() => notif.remove(), 300);
  }, 3000);
}

function getNotificationIcon(type) {
  return {
    success: 'check-circle',
    error: 'exclamation-triangle',
    warning: 'exclamation-circle'
  }[type] || 'info-circle';
}

function getNotificationColor(type) {
  return {
    success: '#08A55A',
    error: '#dc3545',
    warning: '#ffc107'
  }[type] || '#3FCAEA';
}

// ==============================
// Modal Produk
// ==============================
function viewProductDetail(name, sku, category, price, stock, sales, rating, description) {
  setText("productDetailName", name);
  setText("productDetailSku", `SKU: ${sku}`);
  setText("productDetailPrice", price);
  setText("productDetailStock", stock);
  setText("productDetailSales", sales);
  setText("productDetailRating", rating);
  setText("productDetailDescription", description);

  const categoryEl = document.getElementById("productDetailCategory");
  const classMap = {
    vitamin: 'category-vitamin',
    herbal: 'category-herbal',
    fitness: 'category-fitness'
  };
  const lower = category.toLowerCase();
  const catClass = Object.keys(classMap).find(k => lower.includes(k)) || '';
  categoryEl.innerHTML = `<span class="category-badge ${classMap[catClass] || ''}">${category}</span>`;

  const modal = document.getElementById("productDetailModal");
  modal.classList.add("active");
  setTimeout(() => document.addEventListener('click', closeModalOnOutsideClick), 100);
}

function closeProductDetailModal() {
  document.getElementById("productDetailModal").classList.remove("active");
  document.removeEventListener('click', closeModalOnOutsideClick);
}

function closeModalOnOutsideClick(e) {
  const modal = document.getElementById("productDetailModal");
  if (modal.classList.contains("active") && !modal.querySelector(".modal-content").contains(e.target)) {
    closeProductDetailModal();
  }
}

// ==============================
// Filter Produk (Nama & Kategori)
// ==============================
function filterProducts() {
  const keyword = document.getElementById("searchInput").value.toLowerCase();
  const selectedCategory = document.getElementById("categoryFilter").value.toLowerCase();
  const rows = document.querySelectorAll(".data-table tbody tr");
  let match = false;

  rows.forEach(row => {
    if (row.id === "noDataMessage") return;
    const name = row.querySelector(".product-name")?.textContent.toLowerCase() || "";
    const cat = row.querySelector(".category-badge")?.textContent.toLowerCase() || "";
    const show = name.includes(keyword) && (!selectedCategory || cat === selectedCategory);
    row.style.display = show ? "" : "none";
    row.classList.toggle("row-hover-effect", show);
    if (show) match = true;
  });

  document.getElementById("noDataMessage").style.display = match ? "none" : "";
}

// ==============================
// Filter Produk Berdasarkan Stok
// ==============================
function filterByStock(mode, btn = null) {
  const rows = document.querySelectorAll(".data-table tbody tr");
  let match = false;

  rows.forEach(row => {
    const stock = parseInt(row.querySelector(".stock-indicator")?.textContent.replace(/\D/g, '')) || 0;
    let show = mode === 'all' || (mode === 'in-stock' && stock >= 20) || (mode === 'low-stock' && stock < 20);
    row.style.display = show ? "" : "none";
    row.classList.toggle("row-hover-effect", show);
    if (show) match = true;
  });

  document.getElementById("noDataMessage").style.display = match ? "none" : "";

  document.querySelectorAll(".filter-btn").forEach(b => b.classList.remove("active", "btn-success"));
  (btn || document.querySelector(`.filter-btn[data-mode="${mode}"]`))?.classList.add("active", "btn-success");
}

// ==============================
// Esc Listener: Tutup Modal / Panel
// ==============================
document.addEventListener("keydown", e => {
  if (e.key === "Escape") {
    document.getElementById("notificationPanel")?.classList.remove("active");
    document.getElementById("productDetailModal")?.classList.remove("active");
  }
});

// ==============================
// Helpers
// ==============================
function setText(id, val) {
  const el = document.getElementById(id);
  if (el) el.textContent = val ?? "-";
}

// ==============================
// Inisialisasi Dropdown Kategori
// ==============================
function initializeCategoryDropdown() {
  const categories = window.categoryLabels || [];
  const select = document.getElementById("categoryFilter");
  if (select) {
    select.innerHTML = '<option value="">Semua Kategori</option>' +
      categories.map(cat => `<option value="${cat}">${cat}</option>`).join("");
  }

  const style = document.createElement("style");
  style.textContent = `.row-hover-effect:hover {
    background-color: rgba(8, 165, 90, 0.08); cursor: pointer;
  }`;
  document.head.appendChild(style);
}

// ==============================
// Inisialisasi Chart.js
// ==============================
function initializeCharts() {
  const salesChartEl = document.getElementById("salesChart");
  const catChartEl = document.getElementById("categoryChart");

  if (salesChartEl) {
    new Chart(salesChartEl.getContext("2d"), {
      type: "line",
      data: {
        labels: window.salesLabels || [],
        datasets: [{
          label: "Penjualan (Rp Million)",
          data: window.salesData || [],
          borderColor: "#08A55A",
          backgroundColor: "rgba(8, 165, 90, 0.1)",
          tension: 0.4,
          fill: true,
          pointBackgroundColor: "#08A55A",
          pointBorderColor: "#fff",
          pointBorderWidth: 2,
          pointRadius: 6,
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            position: "top",
            labels: { usePointStyle: true, padding: 20 }
          }
        },
        scales: {
          x: { grid: { display: false } },
          y: { grid: { color: "rgba(0,0,0,0.1)" } }
        }
      }
    });
  }

  if (catChartEl) {
    new Chart(catChartEl.getContext("2d"), {
      type: "pie",
      data: {
        labels: window.categoryLabels || [],
        datasets: [{
          data: window.categoryCounts || [],
          backgroundColor: ["#4CAF50", "#FFC107", "#2196F3", "#9C27B0", "#FF5722"],
          borderColor: "#fff",
          borderWidth: 2
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            position: "bottom",
            labels: { usePointStyle: true, padding: 20 }
          },
          tooltip: {
            callbacks: {
              label: ctx => `${ctx.label}: ${ctx.raw} produk`
            }
          }
        }
      }
    });



}



  }
