// Profile functionality
function handleProfile() {
  window.location.href = "profile.html";
}

// Check authentication
if (!localStorage.getItem("auth")) {
  window.location.href = "login.html";
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

// Chart initialization
function initializeCharts() {
  // Complaints Trend Chart
  const complaintsCtx = document.getElementById("complaintsChart");
  if (complaintsCtx) {
    updateComplaintsData();
  }
  // Product Category Chart
  const productCategoryCtx = document.getElementById("productCategoryChart");
  if (productCategoryCtx) {
    new Chart(productCategoryCtx, {
      type: "doughnut",
      data: {
        labels: ["Vitamin & Suplemen", "Herbal & Natural", "Fitness & Protein"],
        datasets: [
          {
            data: [45, 30, 25],
            backgroundColor: ["#08A55A", "#3FCAEA", "#667eea"],
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

  // Nutrition Achievement Chart
  const nutritionAchievementCtx = document.getElementById(
    "nutritionAchievementChart"
  );
  if (nutritionAchievementCtx) {
    new Chart(nutritionAchievementCtx, {
      type: "bar",
      data: {
        labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
        datasets: [
          {
            label: "Protein",
            // Jan: 68% (Kelelahan), Feb: 70%, Mar: 73% (Obesitas), Apr: 75%, May: 78%, Jun: 80%
            data: [68, 70, 73, 75, 78, 80],
            backgroundColor: "#08A55A",
            borderRadius: 4,
          },
          {
            label: "Karbohidrat",
            // Jan: 75%, Feb: 78% (Pencernaan-quality rendah), Mar: 80%, Apr: 82%, May: 85%, Jun: 87%
            data: [75, 78, 80, 82, 85, 87],
            backgroundColor: "#3FCAEA",
            borderRadius: 4,
          },
          {
            label: "Lemak",
            // Jan: 62% (Paling rendah-Kelelahan), Feb: 65%, Mar: 68%, Apr: 70%, May: 73%, Jun: 75%
            data: [62, 65, 68, 70, 73, 75],
            backgroundColor: "#667eea",
            borderRadius: 4,
          },
          {
            label: "Vitamin",
            // Jan: 65%, Feb: 68%, Mar: 70%, Apr: 72%, May: 75% (Rendah-Imunitas), Jun: 77%
            data: [65, 68, 70, 72, 75, 77],
            backgroundColor: "#f093fb",
            borderRadius: 4,
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            position: "top",
          },
        },
        scales: {
          y: {
            beginAtZero: true,
            max: 100,
            grid: {
              color: "rgba(0,0,0,0.1)",
            },
          },
          x: {
            grid: {
              display: false,
            },
          },
        },
      },
    });
  }

  const nutritionNeedsCtx = document.getElementById("nutritionNeedsChart");
  if (nutritionNeedsCtx) {
    new Chart(nutritionNeedsCtx, {
      type: "line",
      data: {
        labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
        datasets: [
          {
            label: "Protein (kg)",
            // Jan: 480kg (32% gap), Feb: 450kg, Mar: 405kg, Apr: 375kg, May: 330kg, Jun: 300kg
            data: [480, 450, 405, 375, 330, 300],
            borderColor: "#08A55A",
            backgroundColor: "rgba(8, 165, 90, 0.1)",
            tension: 0.4,
            fill: true,
          },
          {
            label: "Karbohidrat (kg)",
            // Jan: 375kg (25% gap), Feb: 330kg, Mar: 300kg, Apr: 270kg, May: 225kg, Jun: 195kg
            data: [375, 330, 300, 270, 225, 195],
            borderColor: "#3FCAEA",
            backgroundColor: "rgba(63, 202, 234, 0.1)",
            tension: 0.4,
            fill: true,
          },
          {
            label: "Lemak (kg)",
            // Jan: 570kg (38% gap-Tertinggi), Feb: 525kg, Mar: 480kg, Apr: 450kg, May: 405kg, Jun: 375kg
            data: [570, 525, 480, 450, 405, 375],
            borderColor: "#667eea",
            backgroundColor: "rgba(102, 126, 234, 0.1)",
            tension: 0.4,
            fill: true,
          },
          {
            label: "Vitamin (ribu IU)",
            // Jan: 525 ribu IU (35% gap), Feb: 480, Mar: 450, Apr: 420, May: 375 (Imunitas), Jun: 345
            data: [525, 480, 450, 420, 375, 345],
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
          legend: {
            position: "top",
          },
        },
        scales: {
          y: {
            beginAtZero: true,
            grid: {
              color: "rgba(0,0,0,0.1)",
            },
          },
          x: {
            grid: {
              display: false,
            },
          },
        },
      },
    });
  }

  // Best Selling Products Chart
  const bestSellingCtx = document.getElementById("bestSellingChart");
  if (bestSellingCtx) {
    new Chart(bestSellingCtx, {
      type: "bar",
      data: {
        labels: [
          "NuVit-Multi Core",
          "NuVit-Green Detox",
          "NuVit-Whey Muscle",
          "NuVit-C Boost",
          "NuVit-Omega Brain",
          "NuVit-Honey Natural",
          "NuVit-Curcuma Gold",
          "NuVit-BCAA Recovery",
        ],
        datasets: [
          {
            label: "Penjualan 6 Bulan",
            data: [16650, 15830, 14720, 14230, 11890, 10380, 8450, 7920],
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

// Filter functionality
document.querySelectorAll(".filter-btn").forEach((btn) => {
  btn.addEventListener("click", function () {
    document
      .querySelectorAll(".filter-btn")
      .forEach((b) => b.classList.remove("active"));
    this.classList.add("active");
  });
});
