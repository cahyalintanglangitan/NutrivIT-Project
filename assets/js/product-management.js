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
  window.location.href = "profile.html";
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

// Initialize when DOM is loaded
document.addEventListener("DOMContentLoaded", function () {
  updateCurrentDate();

  // Initialize charts after a short delay
  setTimeout(() => {
    initializeCharts();
  }, 100);
});
