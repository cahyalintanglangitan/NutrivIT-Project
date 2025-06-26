    // Profile functionality
    function handleProfile() {
      window.location.href = "profile.html";
    }

    // Check authentication
    if (!localStorage.getItem("auth")) {
      window.location.href = "login.html";
    }

    // Set current date
    document.getElementById('current-date').textContent = new Date().toLocaleDateString('id-ID', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric'
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
    document.addEventListener('DOMContentLoaded', function() {
      const numberElements = document.querySelectorAll('[data-target]');
      numberElements.forEach(element => {
        const target = parseInt(element.getAttribute('data-target'));
        animateNumber(element, target);
      });

      // Initialize charts
      initializeCharts();
    });

    // Chart initialization
    function initializeCharts() {
      // Complaints Trend Chart
      const complaintsCtx = document.getElementById('complaintsChart');
      if (complaintsCtx) {
        new Chart(complaintsCtx, {
          type: 'line',
          data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            datasets: [{
              label: 'Keluhan',
              data: [45, 38, 42, 35, 28, 32, 25, 30, 22, 18, 23, 20],
              borderColor: '#dc3545',
              backgroundColor: 'rgba(220, 53, 69, 0.1)',
              tension: 0.4,
              fill: true
            }]
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
              legend: {
                display: false
              }
            },
            scales: {
              y: {
                beginAtZero: true,
                grid: {
                  color: 'rgba(0,0,0,0.1)'
                }
              },
              x: {
                grid: {
                  display: false
                }
              }
            }
          }
        });
      }

      // Product Category Chart
      const productCategoryCtx = document.getElementById('productCategoryChart');
      if (productCategoryCtx) {
        new Chart(productCategoryCtx, {
          type: 'doughnut',
          data: {
            labels: ['Vitamin & Suplemen', 'Herbal & Natural', 'Fitness & Protein'],
            datasets: [{
              data: [45, 30, 25],
              backgroundColor: ['#08A55A', '#3FCAEA', '#667eea'],
              borderWidth: 0
            }]
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
              legend: {
                display: false
              }
            }
          }
        });
      }

      // Nutrition Achievement Chart
      const nutritionAchievementCtx = document.getElementById('nutritionAchievementChart');
      if (nutritionAchievementCtx) {
        new Chart(nutritionAchievementCtx, {
          type: 'bar',
          data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            datasets: [
              {
                label: 'Kalori',
                data: [72, 75, 78, 80, 82, 85, 83, 86, 88, 85, 87, 89],
                backgroundColor: '#08A55A',
                borderRadius: 4
              },
              {
                label: 'Protein',
                data: [68, 70, 73, 75, 78, 80, 82, 84, 86, 83, 85, 87],
                backgroundColor: '#3FCAEA',
                borderRadius: 4
              },
              {
                label: 'Vitamin',
                data: [65, 68, 70, 72, 75, 77, 79, 81, 83, 80, 82, 84],
                backgroundColor: '#667eea',
                borderRadius: 4
              }
            ]
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
              legend: {
                position: 'top'
              }
            },
            scales: {
              y: {
                beginAtZero: true,
                max: 100,
                grid: {
                  color: 'rgba(0,0,0,0.1)'
                }
              },
              x: {
                grid: {
                  display: false
                }
              }
            }
          }
        });
      }

      // Nutrition Needs Chart
      const nutritionNeedsCtx = document.getElementById('nutritionNeedsChart');
      if (nutritionNeedsCtx) {
        new Chart(nutritionNeedsCtx, {
          type: 'line',
          data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            datasets: [
              {
                label: 'Protein',
                data: [850, 920, 980, 1050, 1120, 1180, 1250, 1320, 1380, 1450, 1520, 1580],
                borderColor: '#08A55A',
                backgroundColor: 'rgba(8, 165, 90, 0.1)',
                tension: 0.4
              },
              {
                label: 'Vitamin C',
                data: [650, 720, 780, 850, 920, 980, 1050, 1120, 1180, 1250, 1320, 1380],
                borderColor: '#3FCAEA',
                backgroundColor: 'rgba(63, 202, 234, 0.1)',
                tension: 0.4
              },
              {
                label: 'Kalsium',
                data: [450, 520, 580, 650, 720, 780, 850, 920, 980, 1050, 1120, 1180],
                borderColor: '#667eea',
                backgroundColor: 'rgba(102, 126, 234, 0.1)',
                tension: 0.4
              }
            ]
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
              legend: {
                position: 'top'
              }
            },
            scales: {
              y: {
                beginAtZero: true,
                grid: {
                  color: 'rgba(0,0,0,0.1)'
                }
              },
              x: {
                grid: {
                  display: false
                }
              }
            }
          }
        });
      }

      // Best Selling Products Chart
      const bestSellingCtx = document.getElementById('bestSellingChart');
      if (bestSellingCtx) {
        new Chart(bestSellingCtx, {
          type: 'bar',
          data: {
            labels: ['Vitamin C 1000mg', 'Whey Protein', 'Omega 3 Premium', 'Multivitamin Daily', 'BCAA Complex', 'Ekstrak Kunyit', 'Madu Manuka', 'Teh Hijau Organik'],
            datasets: [{
              label: 'Penjualan',
              data: [2450, 1890, 1650, 1420, 1180, 980, 850, 720],
              backgroundColor: [
                '#08A55A',
                '#3FCAEA', 
                '#667eea',
                '#f093fb',
                '#4facfe',
                '#43e97b',
                '#ffc107',
                '#fd7e14'
              ],
              borderRadius: 6
            }]
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            indexAxis: 'y',
            plugins: {
              legend: {
                display: false
              }
            },
            scales: {
              x: {
                beginAtZero: true,
                grid: {
                  color: 'rgba(0,0,0,0.1)'
                }
              },
              y: {
                grid: {
                  display: false
                }
              }
            }
          }
        });
      }
    }

    // Filter functionality
    document.querySelectorAll('.filter-btn').forEach(btn => {
      btn.addEventListener('click', function() {
        document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
        this.classList.add('active');
      });
    });