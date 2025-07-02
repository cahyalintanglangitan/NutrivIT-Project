// Set current date
function updateCurrentDate() {
  const dateElement = document.getElementById("current-date");
  if (dateElement) {
    const now = new Date();
    const options = {
      weekday: "long",
      year: "numeric",
      month: "long",
      day: "numeric",
    };
    dateElement.textContent = now.toLocaleDateString("id-ID", options);
  }
}

// Handle profile click
function handleProfile() {
  window.location.href = "profile.php";
}

// Filter functions
function filterByStock(type) {
  // Update active filter button
  document.querySelectorAll(".filter-btn").forEach((btn) => {
    btn.classList.remove("active");
  });
  event.target.classList.add("active");

  // Filter logic would go here
  console.log("Filtering by:", type);
}

function showAddProductModal() {
  alert("Add Product modal would open here");
}

// Notification Panel Functions
function toggleNotificationPanel() {
  const panel = document.getElementById('notificationPanel');
  panel.classList.toggle('active');
  
  // Close panel when clicking outside
  if (panel.classList.contains('active')) {
    setTimeout(() => {
      document.addEventListener('click', closeNotificationOnOutsideClick);
    }, 100);
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
  const unreadItems = document.querySelectorAll('.notification-item.unread');
  unreadItems.forEach(item => {
    item.classList.remove('unread');
    const dot = item.querySelector('.unread-dot');
    if (dot) {
      dot.remove();
    }
  });
  
  // Update notification badge
  const badge = document.querySelector('.notification-badge');
  if (badge) {
    badge.textContent = '0';
    badge.style.display = 'none';
  }
  
  showNotification('Semua not')
    badge.textContent = '0';
    badge.style.display = 'none';
  }
  
  showNotification('Semua notifikasi telah ditandai sebagai dibaca', 'success');


function viewAllNotifications() {
  alert('Fitur lihat semua notifikasi akan segera tersedia');
}

// Product Detail Modal Functions
function viewProductDetail(name, sku, category, price, stock, sales, rating, description) {
  // Populate modal with product data
  document.getElementById('productDetailName').textContent = name;
  document.getElementById('productDetailSku').textContent = 'SKU: ' + sku;
  document.getElementById('productDetailPrice').textContent = price;
  document.getElementById('productDetailStock').textContent = stock;
  document.getElementById('productDetailSales').textContent = sales;
  document.getElementById('productDetailRating').textContent = rating;
  document.getElementById('productDetailDescription').textContent = description;
  
  // Set category badge
  const categoryElement = document.getElementById('productDetailCategory');
  let categoryClass = '';
  if (category.includes('Vitamin')) {
    categoryClass = 'category-vitamin';
  } else if (category.includes('Herbal')) {
    categoryClass = 'category-herbal';
  } else if (category.includes('Fitness')) {
    categoryClass = 'category-fitness';
  }
  
  categoryElement.innerHTML = `<span class="category-badge ${categoryClass}">${category}</span>`;
  
  // Show modal
  const modal = document.getElementById('productDetailModal');
  modal.classList.add('active');
  
  // Close modal when clicking outside
  setTimeout(() => {
    document.addEventListener('click', closeModalOnOutsideClick);
  }, 100);
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

// Show notification function
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
  
  setTimeout(() => {
    notification.style.transform = 'translateX(0)';
  }, 100);
  
  setTimeout(() => {
    notification.style.transform = 'translateX(100%)';
    setTimeout(() => {
      if (notification.parentNode) {
        notification.parentNode.removeChild(notification);
      }
    }, 300);
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

// Initialize charts
function initializeCharts() {
  const ctx1 = document.getElementById("salesChart");
  const ctx2 = document.getElementById("categoryChart");

  // Sales Performance Chart
  new Chart(ctx1, {
    type: "line",
    data: {
      labels: ["Jan", "Feb", "Mar", "Apr", "Mei", "Jun"],
      datasets: [
        {
          label: "Penjualan (Rp Million)",
          data: [1.8, 2.1, 1.9, 2.4, 2.2, 2.6],
          borderColor: "#08A55A",
          backgroundColor: "rgba(8, 165, 90, 0.1)",
          tension: 0.4,
          fill: true,
          pointBackgroundColor: "#08A55A",
          pointBorderColor: "#fff",
          pointBorderWidth: 2,
          pointRadius: 6,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          position: "top",
          labels: {
            usePointStyle: true,
            padding: 20,
          },
        },
      },
      scales: {
        x: {
          grid: {
            display: false,
          },
        },
        y: {
          grid: {
            color: "rgba(0,0,0,0.1)",
          },
        },
      },
    },
  });

  // Category Distribution Chart
  new Chart(ctx2, {
    type: "doughnut",
    data: {
      labels: ["Vitamin & Suplemen", "Herbal & Natural", "Fitness & Protein"],
      datasets: [
        {
          data: [3, 3, 2],
          backgroundColor: ["#667eea", "#43e97b", "#f093fb"],
          borderWidth: 3,
          borderColor: "#fff",
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      cutout: "60%",
      plugins: {
        legend: {
          position: "bottom",
          labels: {
            padding: 20,
            usePointStyle: true,
          },
        },
      },
    },
  });
}

// Handle escape key to close modals
document.addEventListener('keydown', function(event) {
  if (event.key === 'Escape') {
    const notificationPanel = document.getElementById('notificationPanel');
    const productModal = document.getElementById('productDetailModal');
    
    if (notificationPanel.classList.contains('active')) {
      toggleNotificationPanel();
    }
    
    if (productModal.classList.contains('active')) {
      closeProductDetailModal();
    }
  }
});

// Initialize when DOM is loaded
document.addEventListener("DOMContentLoaded", function () {
  updateCurrentDate();

  // Initialize charts after a short delay
  setTimeout(() => {
    initializeCharts();
  }, 100);
});