// Check authentication
if (!localStorage.getItem("auth")) {
  window.location.href = "login.php";
}

// Set current date
document.getElementById("current-date").textContent =
  new Date().toLocaleDateString("id-ID", {
    weekday: "long",
    year: "numeric",
    month: "long",
    day: "numeric",
  });

// Animate numbers
function animateNumber(element, target) {
  let current = 0;
  const increment = target / 100;
  const timer = setInterval(() => {
    current += increment;
    if (current >= target) {
      current = target;
      clearInterval(timer);
    }
    element.textContent = Math.floor(current);
  }, 20);
}

// Initialize number animations
document.addEventListener("DOMContentLoaded", function () {
  const numberElements = document.querySelectorAll("[data-target]");
  numberElements.forEach((element) => {
    const target = parseInt(element.getAttribute("data-target"));
    animateNumber(element, target);
  });

  // Initialize charts
  initializeCharts();
});

// Global variable for chart instance
let complaintsChartInstance = null;

async function updateComplaintsData() {
  const selectedMonth = document.getElementById("monthSelect").value;

  try {
    const response = await fetch(`get_complaints.php?month=${selectedMonth}`);
    const data = await response.json();

    // Update total keluhan
    document.getElementById("totalComplaints").textContent =
      `${data.total.toLocaleString()} keluhan`;

    // Update keluhan terbanyak
    document.getElementById("topComplaint").textContent = data.topComplaint;

    // Update nilai tren jika tersedia
    const trendElement = document.getElementById("trendValue");
    trendElement.textContent = data.trend || "-";
    trendElement.className = "insight-value";

    // Tampilkan chart
    updateComplaintsChart(data);
  } catch (error) {
    console.error("Gagal memuat data:", error);
    alert("Gagal mengambil data keluhan. Silakan cek koneksi atau server.");
  }
}

function updateComplaintsChart(data) {
  const ctx = document.getElementById("complaintsChart");

  // Hancurkan chart lama jika ada
  if (complaintsChartInstance) {
    complaintsChartInstance.destroy();
  }

  // Buat chart baru
  complaintsChartInstance = new Chart(ctx, {
    type: "bar",
    data: {
      labels: data.labels, // label: ["Kelelahan Kronis", ...]
      datasets: [{
        label: "Jumlah Keluhan",
        data: data.data,     // data: [2, 1, 0, ...]
        backgroundColor: [
          "#667eea", "#764ba2", "#f093fb", "#f5576c", "#4facfe", "#34d399"
        ],
        borderColor: [
          "#5a67d8", "#6b46c1", "#e879f9", "#ef4444", "#3b82f6", "#059669"
        ],
        borderWidth: 2,
        borderRadius: 8,
        borderSkipped: false,
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: { display: false },
        tooltip: {
          callbacks: {
            label: function (context) {
              const index = context.dataIndex;
              const percentage = data.percentages[index] ?? 0;
              return [
                `Jumlah: ${context.parsed.y} keluhan`,
                `Persentase: ${percentage}%`
              ];
            }
          }
        }
      },
      scales: {
        y: {
          beginAtZero: true,
          ticks: { color: "#718096" },
          grid: { color: "rgba(0,0,0,0.1)" }
        },
        x: {
          ticks: { color: "#718096", maxRotation: 45 },
          grid: { display: false }
        }
      }
    }
  });
}

// Jalankan saat halaman selesai dimuat
document.addEventListener("DOMContentLoaded", function () {
  const monthSelect = document.getElementById("monthSelect");
  if (monthSelect) {
    // Trigger update saat halaman pertama dibuka
    updateComplaintsData();

    // Trigger saat bulan diganti
    monthSelect.addEventListener("change", updateComplaintsData);
  }
});

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
  
  showNotification('Semua notifikasi telah ditandai sebagai dibaca', 'success');
}

function viewAllNotifications() {
  alert('Fitur lihat semua notifikasi akan segera tersedia');
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

// Chart initialization
function initializeCharts() {
  // Complaints Trend Chart
  const complaintsCtx = document.getElementById("complaintsChart");
  if (complaintsCtx) {
    updateComplaintsData();
  }

  // Product Category Chart
  const productCategoryCtx = document.getElementById("productCategoryChart");
  if (productCategoryCtx && typeof productCategoryDataFromPHP !== "undefined") {
    new Chart(productCategoryCtx, {
      type: "doughnut",
      data: {
        labels: productCategoryDataFromPHP.labels,
        datasets: [
          {
            data: productCategoryDataFromPHP.data,
            backgroundColor: ["#08A55A", "#3FCAEA", "#667eea", "#FFCE56", "#A259FF"],
            borderWidth: 0,
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: false,
          },
        },
      },
    });
  }

  const nutritionNeedsCtx = document.getElementById("nutritionNeedsChart");
  if (nutritionNeedsCtx && nutritionNeedsData) {
    new Chart(nutritionNeedsCtx, {
      type: "line",
      data: {
        labels: nutritionNeedsData.months,
        datasets: [
          {
            label: "Protein (kg)",
            data: nutritionNeedsData.protein,
            borderColor: "#08A55A",
            backgroundColor: "rgba(8, 165, 90, 0.1)",
            tension: 0.4,
            fill: true,
          },
          {
            label: "Karbohidrat (kg)",
            data: nutritionNeedsData.carbs,
            borderColor: "#3FCAEA",
            backgroundColor: "rgba(63, 202, 234, 0.1)",
            tension: 0.4,
            fill: true,
          },
          {
            label: "Lemak (kg)",
            data: nutritionNeedsData.fat,
            borderColor: "#667eea",
            backgroundColor: "rgba(102, 126, 234, 0.1)",
            tension: 0.4,
            fill: true,
          },
          {
            label: "Vitamin (ribu IU)",
            data: nutritionNeedsData.vitamin,
            borderColor: "#f093fb",
            backgroundColor: "rgba(240, 147, 251, 0.1)",
            tension: 0.4,
            fill: true,
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: { position: "top" },
        },
        scales: {
          y: {
            beginAtZero: true,
            grid: { color: "rgba(0,0,0,0.1)" },
          },
          x: {
            grid: { display: false },
          },
        },
      },
    });
  }

  const bestSellingCtx = document.getElementById("bestSellingChart");
  if (bestSellingCtx && bestSellingDataFromPHP) {
    new Chart(bestSellingCtx, {
      type: "bar",
      data: {
        labels: bestSellingDataFromPHP.labels,
        datasets: [
          {
            label: "Penjualan 6 Bulan",
            data: bestSellingDataFromPHP.data,
            backgroundColor: [
              "#08A55A",
              "#3FCAEA",
              "#667eea",
              "#f093fb",
              "#4facfe",
              "#43e97b",
              "#ffc107",
              "#fd7e14",
            ],
            borderRadius: 6,
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        indexAxis: "y",
        plugins: {
          legend: {
            display: false,
          },
        },
        scales: {
          x: {
            beginAtZero: true,
            grid: {
              color: "rgba(0,0,0,0.1)",
            },
          },
          y: {
            grid: {
              display: false,
            },
          },
        },
      },
    });
  }
}

// Handle escape key to close modals
document.addEventListener('keydown', function(event) {
  if (event.key === 'Escape') {
    const notificationPanel = document.getElementById('notificationPanel');
    
    if (notificationPanel.classList.contains('active')) {
      toggleNotificationPanel();
    }
  }
});

// Filter functionality
document.querySelectorAll(".filter-btn").forEach((btn) => {
  btn.addEventListener("click", function () {
    document
      .querySelectorAll(".filter-btn")
      .forEach((b) => b.classList.remove("active"));
    this.classList.add("active");
  });
});
