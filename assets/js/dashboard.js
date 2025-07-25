
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

const complaintsData = {
  januari: {
    labels: [
      "Kelelahan Kronis",
      "Gangguan Pencernaan",
      "Tulang & Gigi Lemah",
      "Obesitas",
      "Imunitas Rendah",
    ],
    data: [342, 287, 245, 198, 176],
    percentages: [23.9, 20.0, 17.1, 13.8, 12.3],
    trends: [5.2, -2.1, 8.7, 3.4, -1.8],
    total: 1248,
    topComplaint: "Kelelahan Kronis (23.9%)",
    overallTrend: "Menurun 8%",
  },
  februari: {
    labels: [
      "Gangguan Pencernaan",
      "Kelelahan Kronis",
      "Obesitas",
      "Tulang & Gigi Lemah",
      "Stress & Insomnia",
    ],
    data: [298, 276, 234, 189, 167],
    percentages: [24.1, 22.3, 18.9, 15.3, 13.5],
    trends: [12.3, -3.2, 15.8, -2.1, 8.9],
    total: 1164,
    topComplaint: "Gangguan Pencernaan (24.1%)",
    overallTrend: "Turun 6.7%",
  },
  maret: {
    labels: [
      "Obesitas",
      "Kelelahan Kronis",
      "Imunitas Rendah",
      "Gangguan Pencernaan",
      "Tulang & Gigi Lemah",
    ],
    data: [312, 289, 267, 198, 145],
    percentages: [25.8, 23.9, 22.1, 16.4, 12.0],
    trends: [33.2, 4.7, 51.7, -33.6, -23.3],
    total: 1211,
    topComplaint: "Obesitas (25.8%)",
    overallTrend: "Naik 4.0%",
  },
  april: {
    labels: [
      "Kelelahan Kronis",
      "Imunitas Rendah",
      "Obesitas",
      "Gangguan Pencernaan",
      "Tulang & Gigi Lemah",
    ],
    data: [285, 256, 223, 189, 156],
    percentages: [25.4, 22.8, 19.9, 16.8, 13.9],
    trends: [-1.3, -14.7, -28.5, -4.5, 7.6],
    total: 1109,
    topComplaint: "Kelelahan Kronis (25.4%)",
    overallTrend: "Turun 8.4%",
  },
  mei: {
    labels: [
      "Imunitas Rendah",
      "Kelelahan Kronis",
      "Gangguan Pencernaan",
      "Obesitas",
      "Stress & Insomnia",
    ],
    data: [267, 234, 198, 178, 145],
    percentages: [26.1, 22.9, 19.4, 17.4, 14.2],
    trends: [4.3, -17.9, 4.8, -20.2, -7.1],
    total: 1022,
    topComplaint: "Imunitas Rendah (26.1%)",
    overallTrend: "Turun 7.8%",
  },
  juni: {
    labels: [
      "Kelelahan Kronis",
      "Imunitas Rendah",
      "Stress & Insomnia",
      "Obesitas",
      "Gangguan Pencernaan",
    ],
    data: [298, 245, 189, 167, 145],
    percentages: [28.7, 23.6, 18.2, 16.1, 14.0],
    trends: [27.4, -8.2, 30.3, -6.2, -26.8],
    total: 1044,
    topComplaint: "Kelelahan Kronis (28.7%)",
    overallTrend: "Naik 2.2%",
  },
};

// Global variable untuk chart instance
let complaintsChartInstance = null;

// Function untuk update data keluhan
function updateComplaintsData() {
  const selectedMonth = document.getElementById("monthSelect").value;
  const data = complaintsData[selectedMonth];

  if (!data) return;

  // Update insights
  document.getElementById(
    "totalComplaints"
  ).textContent = `${data.total.toLocaleString()} keluhan`;
  document.getElementById("topComplaint").textContent = data.topComplaint;

  const trendElement = document.getElementById("trendValue");
  trendElement.textContent = data.overallTrend;
  trendElement.className = data.overallTrend.includes("Naik")
    ? "insight-value negative"
    : "insight-value positive";

  // Update chart
  updateComplaintsChart(data);
}

document.getElementById("monthSelect").addEventListener("change", updateComplaintsData);
document.addEventListener("DOMContentLoaded", () => {
  const complaintsCtx = document.getElementById("complaintsChart");
  if (complaintsCtx) {
    updateComplaintsData();
  }
});


function updateComplaintsChart(data) {
  const ctx = document.getElementById("complaintsChart");
  if (complaintsChartInstance) {
    complaintsChartInstance.destroy();
  }

  complaintsChartInstance = new Chart(ctx, {
    type: "bar",
    data: {
      labels: data.labels,
      datasets: [
        {
          label: "Jumlah Keluhan",
          data: data.data,
          backgroundColor: [
            "#667eea",
            "#764ba2",
            "#f093fb",
            "#f5576c",
            "#4facfe",
          ],
          borderColor: ["#5a67d8", "#6b46c1", "#e879f9", "#ef4444", "#3b82f6"],
          borderWidth: 2,
          borderRadius: 8,
          borderSkipped: false,
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
        tooltip: {
          callbacks: {
            label: function (context) {
              const index = context.dataIndex;
              const percentage = data.percentages[index];
              const trend = data.trends[index];
              const trendIcon = trend > 0 ? "↑" : "↓";
              return [
                `Jumlah: ${context.parsed.y} keluhan`,
                `Persentase: ${percentage}%`,
                `Trend: ${trendIcon} ${Math.abs(trend)}%`,
              ];
            },
          },
        },
      },
      scales: {
        y: {
          beginAtZero: true,
          grid: {
            color: "rgba(0,0,0,0.1)",
          },
          ticks: {
            color: "#718096",
          },
        },
        x: {
          grid: {
            display: false,
          },
          ticks: {
            color: "#718096",
            maxRotation: 45,
          },
        },
      },
    },
  });
}

let complaintsChart = null;

function updateComplaintsData() {
  const selectedMonth = document.getElementById("monthSelect").value;

  fetch(`get_complaints_chart.php?month=${selectedMonth}`)
    .then((response) => response.json())
    .then((data) => {
      if (complaintsChart) {
        complaintsChart.destroy();
      }

      const ctx = document.getElementById("complaintsChart").getContext("2d");

      // Warna berbeda untuk setiap jenis keluhan
      const backgroundColors = [
        "#FF6384", "#36A2EB", "#FFCE56", "#4BC0C0", "#9966FF", "#FF9F40"
      ];

      complaintsChart = new Chart(ctx, {
        type: "bar",
        data: {
          labels: data.labels,
          datasets: [{
            label: "Jumlah Keluhan",
            data: data.data,
            backgroundColor: data.labels.map((_, i) => backgroundColors[i % backgroundColors.length]),
            borderRadius: {
              topLeft: 10,
              topRight: 10,
              bottomLeft: 0,
              bottomRight: 0
            },
            borderSkipped: false
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          scales: {
            y: {
              beginAtZero: true,
              ticks: {
                precision: 0
              }
            }
          },
          plugins: {
            legend: {
              display: false
            },
            tooltip: {
              callbacks: {
                label: function(context) {
                  return ` ${context.parsed.y} keluhan`;
                }
              }
            }
          }
        }
      });

      // Update insights
      document.getElementById("totalComplaints").textContent = data.total;
      document.getElementById("topComplaint").textContent = data.topComplaint;
      // (Optional) Tren vs bulan lalu bisa ditambahkan nanti
    })
    .catch((error) => {
      console.error("Error fetching complaints data:", error);
    });
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
})}