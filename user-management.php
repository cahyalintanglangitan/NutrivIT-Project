<!DOCTYPE html>
<html lang="id">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>User Management - NutrivIT</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="./assets/css/dashboard.css" />
  <link rel="stylesheet" href="./assets/css/user-management.css" />
  <script src="assets/js/dashboard.js"></script>
</head>

<body>
  <div class="dashboard-container">
    <!-- Sidebar -->
    <?php include 'bar/navbar.php'; ?>  

    <!-- Main Content -->
    <div class="main-content">
      <header class="main-header">
        <div class="header-left">
          <h2><i class="fas fa-users"></i> User Management</h2>
          <p class="page-subtitle">Kelola pengguna sistem dan analisis data kesehatan mereka</p>
        </div>
        <div class="header-actions">
          <div class="notification-bell">
            <i class="fas fa-bell"></i>
            <span class="notification-badge">3</span>
          </div>
          <span class="date">
            <i class="fas fa-calendar-alt"></i>
            <span id="current-date"></span>
          </span>
        </div>
      </header>
      <!-- User Management Content -->
      <div class="content-section active">
        <!-- Search and Filter Section -->
        <div class="filter-section">
          <div class="search-box">
            <i class="fas fa-search"></i>
            <input type="text" placeholder="Cari user..." id="user-search">
          </div>
          <div class="filter-buttons">
            <button class="filter-btn active" onclick="filterUsers('all')">
              <i class="fas fa-users"></i> Semua (156)
            </button>
            <button class="filter-btn" onclick="filterUsers('active')">
              <i class="fas fa-user-check"></i> Aktif (134)
            </button>
            <button class="filter-btn" onclick="filterUsers('consultation')">
              <i class="fas fa-comments"></i> Konsultasi (89)
            </button>
            <button class="filter-btn" onclick="filterUsers('premium')">
              <i class="fas fa-crown"></i> Premium (22)
            </button>
          </div>
        </div>

        <!-- Stats Overview -->
        <div class="stats-grid">
          <div class="stat-card">
            <div class="stat-icon users">
              <i class="fas fa-users"></i>
            </div>
            <div class="stat-info">
              <h3>Total Users</h3>
              <p class="stat-number">1,234</p>
              <span class="stat-change positive">
                <i class="fas fa-arrow-up"></i> +12% dari bulan lalu
              </span>
            </div>
          </div>

          <div class="stat-card">
            <div class="stat-icon consultation">
              <i class="fas fa-comments"></i>
            </div>
            <div class="stat-info">
              <h3>Konsultasi Aktif</h3>
              <p class="stat-number">89</p>
              <span class="stat-change positive">
                <i class="fas fa-arrow-up"></i> +8% dari minggu lalu
              </span>
            </div>
          </div>

          <div class="stat-card">
            <div class="stat-icon revenue">
              <i class="fas fa-shopping-cart"></i>
            </div>
            <div class="stat-info">
              <h3>Pembelian Bulan Ini</h3>
              <p class="stat-number">567</p>
              <span class="stat-change positive">
                <i class="fas fa-arrow-up"></i> +15% dari bulan lalu
              </span>
            </div>
          </div>

          <div class="stat-card">
            <div class="stat-icon health">
              <i class="fas fa-heartbeat"></i>
            </div>
            <div class="stat-info">
              <h3>Target Nutrisi Tercapai</h3>
              <p class="stat-number">78%</p>
              <span class="stat-change positive">
                <i class="fas fa-arrow-up"></i> +5% dari minggu lalu
              </span>
            </div>
          </div>
        </div>

        <!-- User Table -->
        <div class="table-container">
          <div class="table-header">
            <h3><i class="fas fa-list"></i> Daftar Pengguna</h3>
          </div>

          <table class="data-table" id="users-table">
            <thead>
              <tr>
                <th><i class="fas fa-user"></i> Nama</th>
                <th><i class="fas fa-envelope"></i> Email</th>
                <th><i class="fas fa-calendar"></i> Bergabung</th>
                <th><i class="fas fa-circle"></i> Status</th>
                <th><i class="fas fa-heartbeat"></i> Capaian Gizi</th>
                <th><i class="fas fa-comments"></i> Konsultasi</th>
                <th><i class="fas fa-cogs"></i> Aksi</th>
              </tr>
            </thead>
            <tbody id="users-tbody">
              <!-- Data akan diisi oleh JavaScript -->
            </tbody>
          </table>
        </div>

        <!-- User Detail Modal -->
        <div id="userModal" class="modal">
          <div class="modal-content">
            <div class="modal-header">
              <h3 id="modal-title">Detail Pengguna</h3>
              <span class="close" onclick="closeUserModal()">&times;</span>
            </div>

            <div class="modal-body">
              <div class="user-detail-tabs">
                <button class="tab-btn active" onclick="showTab('profile')">
                  <i class="fas fa-user"></i> Profil
                </button>
                <button class="tab-btn" onclick="showTab('health')">
                  <i class="fas fa-heartbeat"></i> Kesehatan
                </button>
                <button class="tab-btn" onclick="showTab('consultation')">
                  <i class="fas fa-comments"></i> Konsultasi
                </button>
                <button class="tab-btn" onclick="showTab('purchases')">
                  <i class="fas fa-shopping-cart"></i> Pembelian
                </button>
                <button class="tab-btn" onclick="showTab('reviews')">
                  <i class="fas fa-star"></i> Review
                </button>
              </div>

              <!-- Profile Tab -->
              <div id="profile-tab" class="tab-content active">
                <div class="profile-section">
                  <div class="profile-avatar">
                    <i class="fas fa-user"></i>
                  </div>
                  <div class="profile-info">
                    <h4 id="user-name">-</h4>
                    <p id="user-email">-</p>
                    <p id="user-phone">-</p>
                    <p id="user-address">-</p>
                  </div>
                </div>

                <div class="info-grid">
                  <div class="info-item">
                    <label>Usia:</label>
                    <span id="user-age">-</span>
                  </div>
                  <div class="info-item">
                    <label>Jenis Kelamin:</label>
                    <span id="user-gender">-</span>
                  </div>
                  <div class="info-item">
                    <label>Tinggi Badan:</label>
                    <span id="user-height">-</span>
                  </div>
                  <div class="info-item">
                    <label>Berat Badan:</label>
                    <span id="user-weight">-</span>
                  </div>
                  <div class="info-item">
                    <label>BMI:</label>
                    <span id="user-bmi">-</span>
                  </div>
                  <div class="info-item">
                    <label>Tipe Member:</label>
                    <span id="user-type">-</span>
                  </div>
                </div>
              </div>

              <!-- Health Tab -->
              <div id="health-tab" class="tab-content">
                <div class="health-overview">
                  <h4>Ringkasan Kesehatan</h4>
                  <div class="health-stats">
                    <div class="health-stat">
                      <i class="fas fa-fire"></i>
                      <div>
                        <span class="stat-label">Kalori Harian</span>
                        <span class="stat-value" id="daily-calories">1,850 kkal</span>
                      </div>
                    </div>
                    <div class="health-stat">
                      <i class="fas fa-tint"></i>
                      <div>
                        <span class="stat-label">Hidrasi</span>
                        <span class="stat-value" id="hydration">85%</span>
                      </div>
                    </div>
                    <div class="health-stat">
                      <i class="fas fa-dumbbell"></i>
                      <div>
                        <span class="stat-label">Aktivitas</span>
                        <span class="stat-value" id="activity">Sedang</span>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="nutrition-progress">
                  <h4>Capaian Nutrisi Hari Ini</h4>
                  <div class="nutrition-item">
                    <span>Protein</span>
                    <div class="progress-bar">
                      <div class="progress-fill" style="width: 85%"></div>
                    </div>
                    <span>85%</span>
                  </div>
                  <div class="nutrition-item">
                    <span>Karbohidrat</span>
                    <div class="progress-bar">
                      <div class="progress-fill" style="width: 70%"></div>
                    </div>
                    <span>70%</span>
                  </div>
                  <div class="nutrition-item">
                    <span>Lemak</span>
                    <div class="progress-bar">
                      <div class="progress-fill" style="width: 60%"></div>
                    </div>
                    <span>60%</span>
                  </div>
                  <div class="nutrition-item">
                    <span>Vitamin</span>
                    <div class="progress-bar">
                      <div class="progress-fill" style="width: 90%"></div>
                    </div>
                    <span>90%</span>
                  </div>
                </div>

                <div class="health-complaints">
                  <h4>Keluhan Gizi Terkini</h4>
                  <div class="complaint-item">
                    <i class="fas fa-exclamation-triangle"></i>
                    <div>
                      <span class="complaint-title">Kekurangan Zat Besi</span>
                      <span class="complaint-date">3 hari yang lalu</span>
                    </div>
                  </div>
                  <div class="complaint-item">
                    <i class="fas fa-info-circle"></i>
                    <div>
                      <span class="complaint-title">Kelebihan Gula</span>
                      <span class="complaint-date">1 minggu yang lalu</span>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Consultation Tab -->
              <div id="consultation-tab" class="tab-content">
                <div class="consultation-stats">
                  <div class="consult-stat">
                    <i class="fas fa-comments"></i>
                    <div>
                      <span class="stat-label">Total Konsultasi</span>
                      <span class="stat-value">24</span>
                    </div>
                  </div>
                  <div class="consult-stat">
                    <i class="fas fa-clock"></i>
                    <div>
                      <span class="stat-label">Durasi Rata-rata</span>
                      <span class="stat-value">15 menit</span>
                    </div>
                  </div>
                  <div class="consult-stat">
                    <i class="fas fa-star"></i>
                    <div>
                      <span class="stat-label">Rating Kepuasan</span>
                      <span class="stat-value">4.8/5</span>
                    </div>
                  </div>
                </div>

                <div class="consultation-history">
                  <h4>Riwayat Konsultasi AI</h4>
                  <div class="consult-item">
                    <div class="consult-header">
                      <span class="consult-topic">Diet untuk Menurunkan Berat Badan</span>
                      <span class="consult-date">25 Juni 2025</span>
                    </div>
                    <p class="consult-summary">Mendapatkan rekomendasi menu diet rendah kalori dan tips olahraga...</p>
                    <div class="consult-rating">
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <span>5.0</span>
                    </div>
                  </div>
                  <div class="consult-item">
                    <div class="consult-header">
                      <span class="consult-topic">Suplemen untuk Daya Tahan Tubuh</span>
                      <span class="consult-date">20 Juni 2025</span>
                    </div>
                    <p class="consult-summary">Konsultasi mengenai suplemen vitamin C dan zinc...</p>
                    <div class="consult-rating">
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="far fa-star"></i>
                      <span>4.5</span>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Purchases Tab -->
              <div id="purchases-tab" class="tab-content">
                <div class="purchase-stats">
                  <div class="purchase-stat">
                    <i class="fas fa-shopping-cart"></i>
                    <div>
                      <span class="stat-label">Total Pembelian</span>
                      <span class="stat-value">Rp 2.450.000</span>
                    </div>
                  </div>
                  <div class="purchase-stat">
                    <i class="fas fa-box"></i>
                    <div>
                      <span class="stat-label">Produk Dibeli</span>
                      <span class="stat-value">18 item</span>
                    </div>
                  </div>
                  <div class="purchase-stat">
                    <i class="fas fa-calendar"></i>
                    <div>
                      <span class="stat-label">Pembelian Terakhir</span>
                      <span class="stat-value">3 hari lalu</span>
                    </div>
                  </div>
                </div>

                <div class="purchase-history">
                  <h4>Riwayat Pembelian</h4>
                  <div class="purchase-item">
                    <div class="purchase-info">
                      <span class="product-name">NuVit-C Boost </span>
                      <span class="purchase-date">22 Juni 2025</span>
                    </div>
                    <div class="purchase-details">
                      <span class="quantity">2x</span>
                      <span class="price">Rp 250.000</span>
                    </div>
                  </div>
                  <div class="purchase-item">
                    <div class="purchase-info">
                      <span class="product-name">NuVit-Omega Brain</span>
                      <span class="purchase-date">15 Juni 2025</span>
                    </div>
                    <div class="purchase-details">
                      <span class="quantity">1x</span>
                      <span class="price">Rp 180.000</span>
                    </div>
                  </div>
                  <div class="purchase-item">
                    <div class="purchase-info">
                      <span class="product-name">NuVit-Curcuma Gold</span>
                      <span class="purchase-date">10 Juni 2025</span>
                    </div>
                    <div class="purchase-details">
                      <span class="quantity">1x</span>
                      <span class="price">Rp 95.000</span>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Reviews Tab -->
              <div id="reviews-tab" class="tab-content">
                <div class="review-overview">
                  <div class="review-stat">
                    <i class="fas fa-star"></i>
                    <div>
                      <span class="stat-label">Rating Rata-rata</span>
                      <span class="stat-value">4.6/5</span>
                    </div>
                  </div>
                  <div class="review-stat">
                    <i class="fas fa-comment"></i>
                    <div>
                      <span class="stat-label">Total Review</span>
                      <span class="stat-value">12</span>
                    </div>
                  </div>
                </div>

                <div class="reviews-list">
                  <h4>Review Produk</h4>
                  <div class="review-item">
                    <div class="review-header">
                      <span class="product-name">NuVit-C Boost </span>
                      <div class="review-rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <span>5.0</span>
                      </div>
                    </div>
                    <p class="review-text">Produk sangat bagus, sudah merasakan peningkatan daya tahan tubuh setelah
                      konsumsi rutin selama 2 minggu.</p>
                    <span class="review-date">22 Juni 2025</span>
                  </div>
                  <div class="review-item">
                    <div class="review-header">
                      <span class="product-name">NuVit-Omega Brain</span>
                      <div class="review-rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="far fa-star"></i>
                        <span>4.0</span>
                      </div>
                    </div>
                    <p class="review-text">Kualitas bagus, tapi harga agak mahal. Secara keseluruhan puas dengan
                      hasilnya.</p>
                    <span class="review-date">15 Juni 2025</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script src="./assets/js/user-management.js"></script>
</body>

</html>