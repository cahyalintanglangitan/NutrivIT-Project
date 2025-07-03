// Tampilkan tanggal hari ini
function updateCurrentDate() {
  const dateElement = document.getElementById("current-date");
  if (dateElement) {
    const now = new Date();
    const options = { weekday: "long", year: "numeric", month: "long", day: "numeric" };
    dateElement.textContent = now.toLocaleDateString("id-ID", options);
  }
}

// Navigasi ke halaman profil
function handleProfile() {
  window.location.href = "profile.php";
}

// Panel Notifikasi
function toggleNotificationPanel() {
  const panel = document.getElementById('notificationPanel');
  panel.classList.toggle('active');
  if (panel.classList.contains('active')) {
    setTimeout(() => document.addEventListener('click', closeNotificationOnOutsideClick), 100);
  } else {
    document.removeEventListener('click', closeNotificationOnOutsideClick);
  }
}

function closeNotificationOnOutsideClick(event) {
  const panel = document.getElementById('notificationPanel');
  const bell = document.querySelector('.notification-bell');
  if (!panel.contains(event.target) && !bell.contains(event.target)) {
    panel.classList.remove('active');
    document.removeEventListener('click', closeNotificationOnOutsideClick);
  }
}

function markAllAsRead() {
  document.querySelectorAll('.notification-item.unread').forEach(item => {
    item.classList.remove('unread');
    const dot = item.querySelector('.unread-dot');
    if (dot) dot.remove();
  });
  const badge = document.querySelector('.notification-badge');
  if (badge) {
    badge.textContent = '0';
    badge.style.display = 'none';
  }
  showNotification('Semua notifikasi telah ditandai sebagai dibaca', 'success');
}

// Notifikasi
function showNotification(message, type = 'info') {
  const notification = document.createElement('div');
  notification.className = `notification notification-${type}`;
  notification.innerHTML = `
    <div class="notification-content">
      <i class="fas fa-${getNotificationIcon(type)}"></i>
      <span>${message}</span>
    </div>
  `;
  notification.style.cssText = `
    position: fixed;
    top: 20px;
    right: 20px;
    background: ${getNotificationColor(type)};
    color: white;
    padding: 15px 20px;
    border-radius: 12px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
    z-index: 9999;
    min-width: 300px;
    transform: translateX(100%);
    transition: transform 0.3s ease;
  `;
  document.body.appendChild(notification);
  setTimeout(() => notification.style.transform = 'translateX(0)', 100);
  setTimeout(() => {
    notification.style.transform = 'translateX(100%)';
    setTimeout(() => notification.remove(), 300);
  }, 3000);
}

function getNotificationIcon(type) {
  switch (type) {
    case 'success': return 'check-circle';
    case 'error': return 'exclamation-triangle';
    case 'warning': return 'exclamation-circle';
    default: return 'info-circle';
  }
}

function getNotificationColor(type) {
  switch (type) {
    case 'success': return '#08A55A';
    case 'error': return '#dc3545';
    case 'warning': return '#ffc107';
    default: return '#3FCAEA';
  }
}

// Modal Detail Produk
function viewProductDetail(name, sku, category, price, stock, sales, rating, description) {
  document.getElementById('productDetailName').textContent = name;
  document.getElementById('productDetailSku').textContent = 'SKU: ' + sku;
  document.getElementById('productDetailPrice').textContent = price;
  document.getElementById('productDetailStock').textContent = stock;
  document.getElementById('productDetailSales').textContent = sales;
  document.getElementById('productDetailRating').textContent = rating;
  document.getElementById('productDetailDescription').textContent = description;

  const categoryElement = document.getElementById('productDetailCategory');
  let categoryClass = '';
  if (category.includes('Vitamin')) categoryClass = 'category-vitamin';
  else if (category.includes('Herbal')) categoryClass = 'category-herbal';
  else if (category.includes('Fitness')) categoryClass = 'category-fitness';
  categoryElement.innerHTML = `<span class="category-badge ${categoryClass}">${category}</span>`;

  const modal = document.getElementById('productDetailModal');
  modal.classList.add('active');
  setTimeout(() => document.addEventListener('click', closeModalOnOutsideClick), 100);
}

function closeProductDetailModal() {
  const modal = document.getElementById('productDetailModal');
  modal.classList.remove('active');
  document.removeEventListener('click', closeModalOnOutsideClick);
}

function closeModalOnOutsideClick(event) {
  const modal = document.getElementById('productDetailModal');
  const modalContent = modal.querySelector('.modal-content');
  if (modal.classList.contains('active') && !modalContent.contains(event.target)) {
    closeProductDetailModal();
  }
}

// Filter Produk (Nama & Kategori)
function filterProducts() {
  const input = document.getElementById("searchInput").value.toLowerCase();
  const selectedCategory = document.getElementById("categoryFilter").value.toLowerCase();
  const table = document.querySelector(".data-table");
  const allRows = table.querySelectorAll("tbody tr");
  let matchFound = false;

  allRows.forEach(row => {
    if (row.closest("#noDataMessage")) return;
    const name = row.querySelector(".product-name")?.textContent.toLowerCase() || "";
    const category = row.querySelector(".category-badge")?.textContent.toLowerCase().trim() || "";
    const nameMatch = name.includes(input);
    const categoryMatch = !selectedCategory || category === selectedCategory;
    if (nameMatch && categoryMatch) {
      row.style.display = "";
      row.classList.add("row-hover-effect");
      matchFound = true;
    } else {
      row.style.display = "none";
      row.classList.remove("row-hover-effect");
    }
  });
  document.getElementById("noDataMessage").style.display = matchFound ? "none" : "";
}

// Filter Produk Berdasarkan Stok
function filterByStock(mode, btn) {
  const rows = document.querySelectorAll(".data-table tbody tr");
  let matchFound = false;

  rows.forEach(row => {
    const stockText = row.querySelector(".stock-indicator")?.textContent || "0";
    const stock = parseInt(stockText.replace(/\D/g, '')) || 0;

    let showRow = false;
    if (mode === 'all') showRow = true;
    else if (mode === 'in-stock') showRow = stock >= 20;
    else if (mode === 'low-stock') showRow = stock < 20;

    if (showRow) {
      row.style.display = "";
      row.classList.add("row-hover-effect");
      matchFound = true;
    } else {
      row.style.display = "none";
      row.classList.remove("row-hover-effect");
    }
  });

  // Tampilkan atau sembunyikan pesan "tidak ditemukan"
  const noDataEl = document.getElementById("noDataMessage");
  if (noDataEl) noDataEl.style.display = matchFound ? "none" : "";

  // Ubah status tombol yang aktif
  document.querySelectorAll(".filter-btn").forEach(button => {
    button.classList.remove("active", "btn-success");
  });
  if (btn) {
    btn.classList.add("active", "btn-success");
  } else {
    const autoBtn = document.querySelector(`.filter-btn[data-mode="${mode}"]`);
    if (autoBtn) autoBtn.classList.add("active", "btn-success");
  }
}

// Tutup modal dengan tombol Escape
document.addEventListener('keydown', function(event) {
  if (event.key === 'Escape') {
    const notificationPanel = document.getElementById('notificationPanel');
    const productModal = document.getElementById('productDetailModal');
    if (notificationPanel && notificationPanel.classList.contains('active')) {
      toggleNotificationPanel();
    }
    if (productModal && productModal.classList.contains('active')) {
      closeProductDetailModal();
    }
  }
});

// Inisialisasi saat DOM siap
document.addEventListener("DOMContentLoaded", function () {
  updateCurrentDate();
  initializeCategoryDropdown();
  setTimeout(initializeCharts, 100);
  filterProducts();
});
