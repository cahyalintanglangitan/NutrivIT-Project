<!DOCTYPE html>
<html lang="id">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Dashboard - NutrivIT</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="./assets/css/dashboard.css" />
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body>
  
  <div class="dashboard-container">
    <!-- Sidebar -->
    <?php include 'bar/navbar.php'; ?> 

    <!-- Main Content -->
    <div class="main-content">
      <header class="main-header">
        <div class="header-left">
          <h2><i class="fas fa-chart-pie"></i> Dashboard</h2>
          <p class="page-subtitle">Selamat datang kembali di NutrivIT Management System</p>
        </div>
        <div class="header-actions">
          <div class="notification-bell" onclick="toggleNotificationPanel()">
            <i class="fas fa-bell"></i>
            <span class="notification-badge">5</span>
          </div>
          <span class="date">
            <i class="fas fa-calendar-alt"></i>
            <span id="current-date"></span>
          </span>
        </div>
      </header>

      <!-- Enhanced Dashboard Section -->
      <div id="dashboard" class="content-section active">
        <!-- Welcome Banner with Animation -->
        <div class="welcome-banner">
          <div class="banner-content">
            <div class="welcome-text">
              <h3><i class="fas fa-chart-line pulse"></i> Ringkasan Hari Ini</h3>
              <p>Pantau performa bisnis Anda dalam satu dashboard terintegrasi</p>
            </div>
            <div class="quick-stats">
              <div class="mini-stat">
                <span class="mini-number">98%</span>
                <span class="mini-label">Uptime</span>
              </div>
              <div class="mini-stat">
                <span class="mini-number">24/7</span>
                <span class="mini-label">Support</span>
              </div>
            </div>
          </div>
          <div class="banner-visual">
            <div class="floating-icon">
              <i class="fas fa-analytics"></i>
            </div>
            <div class="banner-decoration"></div>
          </div>
        </div>

        <!-- Enhanced Stats Grid -->
        <div class="stats-grid">
          <div class="stat-card users-card">
            <div class="stat-icon users">
              <i class="fas fa-users"></i>
            </div>
            <div class="stat-info">
              <h3>Total Users</h3>
              <p class="stat-number" data-target="1234">0</p>
              <span class="stat-change positive">
                <i class="fas fa-arrow-up"></i> +12% dari bulan lalu
              </span>
              <div class="stat-progress">
                <div class="progress-bar">
                  <div class="progress-fill" style="width: 75%"></div>
                </div>
              </div>
            </div>
          </div>

          <div class="stat-card products-card">
            <div class="stat-icon products">
              <i class="fas fa-box"></i>
            </div>
            <div class="stat-info">
              <h3>Total Produk</h3>
              <p class="stat-number" data-target="8">0</p>
              <span class="stat-change positive">
                <i class="fas fa-arrow-up"></i> +8% dari bulan lalu
              </span>
              <div class="stat-progress">
                <div class="progress-bar">
                  <div class="progress-fill" style="width: 60%"></div>
                </div>
              </div>
            </div>
          </div>

          <div class="stat-card revenue-card">
            <div class="stat-icon revenue">
              <i class="fas fa-dollar-sign"></i>
            </div>
            <div class="stat-info">
              <h3>Revenue</h3>
              <p class="stat-number">Rp 3.25B</p>
              <span class="stat-change positive">
                <i class="fas fa-arrow-up"></i> +15% dari bulan lalu
              </span>
              <div class="stat-progress">
                <div class="progress-bar">
                  <div class="progress-fill" style="width: 85%"></div>
                </div>
              </div>
            </div>
          </div>

          <div class="stat-card complaints-card">
            <div class="stat-icon complaints">
              <i class="fas fa-exclamation-triangle"></i>
            </div>
            <div class="stat-info">
              <h3>Keluhan Bulan Ini</h3>
              <p class="stat-number" data-target="1044">0</p>
              <span class="stat-change negative">
                <i class="fas fa-arrow-up"></i> +2.2% dari bulan lalu
              </span>
              <div class="stat-progress">
                <div class="progress-bar">
                  <div class="progress-fill complaints-fill" style="width: 25%"></div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Enhanced Analytics Section -->
        <div class="analytics-section">
          <div class="section-header">
            <h3><i class="fas fa-chart-bar"></i> Analytics Overview</h3>

          </div>

          <!-- First Row Charts -->
          <div class="charts-row">
            <div class="chart-card large">
              <div class="chart-header">
                <h4><i class="fas fa-stethoscope"></i> Top Keluhan Gizi</h4>
                <div class="chart-actions">
                  <div class="month-selector">
                    <label for="monthSelect">Bulan:</label>
                    <select id="monthSelect" class="month-dropdown" onchange="updateComplaintsData()">
                      <option value="januari">Januari 2025</option>
                      <option value="februari">Februari 2025</option>
                      <option value="maret">Maret 2025</option>
                      <option value="april">April 2025</option>
                      <option value="mei">Mei 2025</option>
                      <option value="juni">Juni 2025</option>
                    </select>
                  </div>
                  <button class="chart-btn"><i class="fas fa-expand"></i></button>
                  <button class="chart-btn"><i class="fas fa-download"></i></button>
                </div>
              </div>
              <div class="chart-container">
                <canvas id="complaintsChart"></canvas>
              </div>
              <div class="chart-insights">
                <div class="insight-item">
                  <span class="insight-label">Total keluhan bulan ini:</span>
                  <span class="insight-value" id="totalComplaints">1,248 keluhan</span>
                </div>
                <div class="insight-item">
                  <span class="insight-label">Keluhan tertinggi:</span>
                  <span class="insight-value" id="topComplaint">Mudah Lelah (23.9%)</span>
                </div>
                <div class="insight-item">
                  <span class="insight-label">Trend vs bulan lalu:</span>
                  <span class="insight-value positive" id="trendValue">Menurun 8%</span>
                </div>
              </div>
            </div>

            <div class="chart-card medium">
              <div class="chart-header">
                <h4><i class="fas fa-chart-pie"></i> Kategori Produk</h4>
                <div class="chart-actions">
                  <button class="chart-btn"><i class="fas fa-expand"></i></button>
                  <button class="chart-btn"><i class="fas fa-download"></i></button>
                </div>
              </div>
              <div class="chart-container">
                <canvas id="productCategoryChart"></canvas>
              </div>
              <div class="chart-legend">
                <div class="legend-item">
                  <span class="legend-color" style="background: #08A55A;"></span>
                  <span>Vitamin & Suplemen (45%)</span>
                </div>
                <div class="legend-item">
                  <span class="legend-color" style="background: #3FCAEA;"></span>
                  <span>Herbal & Natural (30%)</span>
                </div>
                <div class="legend-item">
                  <span class="legend-color" style="background: #667eea;"></span>
                  <span>Fitness & Protein (25%)</span>
                </div>
              </div>
            </div>
          </div>

          <!-- Second Row Charts -->
          <div class="charts-row">
            <div class="chart-card large">
              <div class="chart-header">
                <h4><i class="fas fa-chart-area"></i> Capaian Gizi Pengguna </h4>
                <div class="chart-actions">
                  <button class="chart-btn"><i class="fas fa-expand"></i></button>
                  <button class="chart-btn"><i class="fas fa-download"></i></button>
                </div>
              </div>
              <div class="chart-container">
                <canvas id="nutritionAchievementChart"></canvas>
              </div>
              <div class="chart-insights">
                <div class="insight-item">
                  <span class="insight-label">Rata-rata capaian:</span>
                  <span class="insight-value">72.3%</span>
                </div>
                <div class="insight-item">
                  <span class="insight-label">Defisit terbesar:</span>
                  <span class="insight-value ">Lemak Sehat (30%)</span>
                </div>
              </div>
            </div>

            <div class="chart-card large">
              <div class="chart-header">
                <h4><i class="fas fa-chart-line"></i> Kebutuhan Nutrisi Pengguna </h4>
                <div class="chart-actions">
                  <button class="chart-btn"><i class="fas fa-expand"></i></button>
                  <button class="chart-btn"><i class="fas fa-download"></i></button>
                </div>
              </div>
              <div class="chart-container">
                <canvas id="nutritionNeedsChart"></canvas>
              </div>
              <div class="chart-insights">
                <div class="insight-item">
                  <span class="insight-label">Total defisit:</span>
                  <span class="insight-value">8.7 ton nutrisi</span>
                </div>
                <div class="insight-item">
                  <span class="insight-label">Market opportunity:</span>
                  <span class="insight-value">NuVit-Omega category</span>
                </div>
                <div class="insight-item">
                  <span class="insight-label">Trend:</span>
                  <span class="insight-value negative">Defisit menurun 37%</span>
                </div>
              </div>
            </div>
          </div>

          <!-- Third Row - Best Selling Products -->
          <div class="charts-row">
            <div class="chart-card full-width">
              <div class="chart-header">
                <h4><i class="fas fa-trophy"></i> Produk Terlaris</h4>
                <div class="chart-actions">
                  <button class="chart-btn"><i class="fas fa-expand"></i></button>
                  <button class="chart-btn"><i class="fas fa-download"></i></button>
                </div>
              </div>
              <div class="chart-container">
                <canvas id="bestSellingChart"></canvas>
              </div>
              <div class="bestselling-stats">
                <div class="product-stat">
                  <div class="product-rank">#1</div>
                  <div class="product-info">
                    <h5>NuVit-Multi Core</h5>
                    <p>3,250 terjual bulan ini</p>
                  </div>
                  <div class="product-growth positive">+32%</div>
                </div>
                <div class="product-stat">
                  <div class="product-rank">#2</div>
                  <div class="product-info">
                    <h5>NuVit-Whey Muscle</h5>
                    <p>2,980 terjual bulan ini</p>
                  </div>
                  <div class="product-growth positive">+28%</div>
                </div>
                <div class="product-stat">
                  <div class="product-rank">#3</div>
                  <div class="product-info">
                    <h5>NuVit-Honey Natural</h5>
                    <p>1,850 terjual bulan ini</p>
                  </div>
                  <div class="product-growth positive">+18%</div>
                </div>
                <div class="product-stat">
                  <div class="product-rank">#4</div>
                  <div class="product-info">
                    <h5>NuVit-Omega Brain</h5>
                    <p>1,720 terjual bulan ini</p>
                  </div>
                  <div class="product-growth positive">+12%</div>
                </div>
                <div class="product-stat">
                  <div class="product-rank">#5</div>
                  <div class="product-info">
                    <h5>NuVit-C Boost</h5>
                    <p>1,450 terjual bulan ini</p>
                  </div>
                  <div class="product-growth positive">+8%</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Notification Panel -->
  <div class="notification-panel" id="notificationPanel">
    <div class="notification-header">
      <h3><i class="fas fa-bell"></i> Notifikasi Dashboard</h3>
      <button class="close-notification" onclick="toggleNotificationPanel()">
        <i class="fas fa-times"></i>
      </button>
    </div>
    <div class="notification-content">
      <div class="notification-item unread">
        <div class="notification-icon warning">
          <i class="fas fa-chart-line"></i>
        </div>
        <div class="notification-details">
          <h4>Peningkatan Keluhan Gizi</h4>
          <p>Keluhan kelelahan kronis naik 27.4% di bulan Juni</p>
          <span class="notification-time">5 menit yang lalu</span>
        </div>
        <div class="notification-status">
          <span class="unread-dot"></span>
        </div>
      </div>

      <div class="notification-item unread">
        <div class="notification-icon success">
          <i class="fas fa-trophy"></i>
        </div>
        <div class="notification-details">
          <h4>Target Revenue Tercapai</h4>
          <p>Revenue bulan ini mencapai Rp 3.25B (+15% dari target)</p>
          <span class="notification-time">1 jam yang lalu</span>
        </div>
        <div class="notification-status">
          <span class="unread-dot"></span>
        </div>
      </div>

      <div class="notification-item unread">
        <div class="notification-icon info">
          <i class="fas fa-users"></i>
        </div>
        <div class="notification-details">
          <h4>Pertumbuhan User Aktif</h4>
          <p>1,234 user aktif dengan pertumbuhan +12% bulan ini</p>
          <span class="notification-time">2 jam yang lalu</span>
        </div>
        <div class="notification-status">
          <span class="unread-dot"></span>
        </div>
      </div>

      <div class="notification-item unread">
        <div class="notification-icon warning">
          <i class="fas fa-exclamation-triangle"></i>
        </div>
        <div class="notification-details">
          <h4>Defisit Nutrisi Tinggi</h4>
          <p>Defisit lemak sehat mencapai 38% pada pengguna aktif</p>
          <span class="notification-time">3 jam yang lalu</span>
        </div>
        <div class="notification-status">
          <span class="unread-dot"></span>
        </div>
      </div>

      <div class="notification-item unread">
        <div class="notification-icon success">
          <i class="fas fa-box"></i>
        </div>
        <div class="notification-details">
          <h4>Produk Terlaris Update</h4>
          <p>NuVit-Multi Core memimpin dengan 3,250 penjualan (+32%)</p>
          <span class="notification-time">4 jam yang lalu</span>
        </div>
        <div class="notification-status">
          <span class="unread-dot"></span>
        </div>
      </div>

      <div class="notification-item read">
        <div class="notification-icon info">
          <i class="fas fa-chart-pie"></i>
        </div>
        <div class="notification-details">
          <h4>Laporan Analitik Mingguan</h4>
          <p>Laporan analitik dashboard telah diperbarui</p>
          <span class="notification-time">1 hari yang lalu</span>
        </div>
      </div>

      <div class="notification-item read">
        <div class="notification-icon success">
          <i class="fas fa-leaf"></i>
        </div>
        <div class="notification-details">
          <h4>System Update Berhasil</h4>
          <p>NutrivIT Management System v2.1 berhasil diperbarui</p>
          <span class="notification-time">2 hari yang lalu</span>
        </div>
      </div>
    </div>
    <div class="notification-footer">
      <button class="btn-mark-all-read" onclick="markAllAsRead()">
        <i class="fas fa-check-double"></i>
        Tandai Semua Dibaca
      </button>
      <button class="btn-view-all" onclick="viewAllNotifications()">
        <i class="fas fa-list"></i>
        Lihat Semua
      </button>
    </div>
  </div>

  <script src="/assets/js/dashboard.js"></script>
</body>

</html>