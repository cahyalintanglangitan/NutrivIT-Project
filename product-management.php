<!DOCTYPE html>
<html lang="id">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Product Management - NutriVit Dashboard</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
  <script src="auth-guard.js"></script>
  <link rel="stylesheet" href="/assets/css/product-management.css">
</head>

<body>
  <div class="dashboard-container">
    <!-- Sidebar -->
    <?php include 'bar/navbar.php'; ?>  

    <!-- Main Content -->
    <div class="main-content">
      <!-- Header -->
      <div class="main-header">
        <div class="header-left">
          <h2><i class="fas fa-boxes"></i> Product Management</h2>
          <p class="page-subtitle">Kelola produk kesehatan dan analisis penjualan</p>
        </div>
        <div class="header-actions">
          <div class="notification-bell" onclick="toggleNotificationPanel()">
            <i class="fas fa-bell"></i>
            <span class="notification-badge">3</span>
          </div>
          <div class="date">
            <i class="fas fa-calendar-alt"></i>
            <span id="current-date"></span>
          </div>
        </div>
      </div>

      <!-- Content Section -->
      <div class="content-section">
        <!-- Statistics Cards -->
        <div class="stats-grid">
          <div class="stat-card">
            <div class="stat-icon total-products">
              <i class="fas fa-boxes"></i>
            </div>
            <div class="stat-info">
              <h3>Total Products</h3>
              <div class="stat-number">8</div>
              <div class="stat-change">
                <i class="fas fa-arrow-up"></i>
                +8% dari bulan lalu
              </div>
            </div>
          </div>

          <div class="stat-card">
            <div class="stat-icon total-revenue">
              <i class="fas fa-chart-line"></i>
            </div>
            <div class="stat-info">
              <h3>Total Revenue</h3>
              <div class="stat-number">Rp 3.25M</div>
              <div class="stat-change">
                <i class="fas fa-arrow-up"></i>
                +15% dari bulan lalu
              </div>
            </div>
          </div>

          <div class="stat-card">
            <div class="stat-icon best-seller">
              <i class="fas fa-trophy"></i>
            </div>
            <div class="stat-info">
              <h3>Best Seller</h3>
              <div class="stat-number">NuVit-Multi</div>
              <div class="stat-change">
                <i class="fas fa-fire"></i>
                1,245 terjual bulan ini
              </div>
            </div>
          </div>

          <div class="stat-card">
            <div class="stat-icon low-stock">
              <i class="fas fa-exclamation-triangle"></i>
            </div>
            <div class="stat-info">
              <h3>Low Stock Items</h3>
              <div class="stat-number">3</div>
              <div class="stat-change">
                <i class="fas fa-exclamation-circle"></i>
                Perlu restok segera
              </div>
            </div>
          </div>
        </div>

        <!-- Charts -->
        <div class="charts-grid">
          <div class="chart-card">
            <div class="chart-header">
              <h4><i class="fas fa-chart-line"></i> Sales Performance</h4>
            </div>
            <div class="chart-container">
              <canvas id="salesChart"></canvas>
            </div>
          </div>

          <div class="chart-card">
            <div class="chart-header">
              <h4><i class="fas fa-chart-pie"></i> Category Distribution</h4>
            </div>
            <div class="chart-container">
              <canvas id="categoryChart"></canvas>
            </div>
          </div>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
          <div class="filter-row">
            <div class="search-filters">
              <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Cari produk...">
              </div>
              <div class="category-filter">
                <select id="categoryFilter">
                  <option value="">Semua Kategori</option>
                  <option value="Vitamin & Suplemen">Vitamin & Suplemen</option>
                  <option value="Herbal & Natural">Herbal & Natural</option>
                  <option value="Fitness & Protein">Fitness & Protein</option>
                </select>
              </div>
            </div>
            <div class="filter-buttons">
              <button class="filter-btn active" onclick="filterByStock('all')">
                <i class="fas fa-list"></i>
                Semua (8)
              </button>
              <button class="filter-btn" onclick="filterByStock('in-stock')">
                <i class="fas fa-check-circle"></i>
                Tersedia (5)
              </button>
              <button class="filter-btn" onclick="filterByStock('low-stock')">
                <i class="fas fa-exclamation-triangle"></i>
                Stok Rendah (3)
              </button>
            </div>
          </div>
        </div>

        <!-- Product Table -->
        <div class="table-container">
          <div class="table-header">
            <div class="table-title">
              <i class="fas fa-table"></i>
              Daftar Produk
            </div>
          </div>
          <table class="data-table">
            <thead>
              <tr>
                <th>Produk</th>
                <th>Kategori</th>
                <th>Harga</th>
                <th>Stok</th>
                <th>Terjual</th>
                <th>Rating</th>
                <th>Status</th>
                <th>Aksi</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>
                  <div class="product-cell">
                    <div class="product-placeholder">
                      <i class="fas fa-image"></i>
                    </div>
                    <div class="product-info">
                      <div class="product-name">NuVit-C Boost</div>
                      <div class="product-sku">SKU: NUV-C-1000</div>
                    </div>
                  </div>
                </td>
                <td>
                  <span class="category-badge category-vitamin">Vitamin & Suplemen</span>
                </td>
                <td class="price-cell">Rp 125,000</td>
                <td>
                  <span class="stock-indicator stock-high">850</span>
                </td>
                <td>14,230</td>
                <td>
                  <div class="rating-cell">
                    <div class="rating-stars">
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                    </div>
                    <div class="rating-value">4.8</div>
                  </div>
                </td>
                <td>
                  <span class="status-badge active">
                    <i class="fas fa-check-circle"></i>
                    Active
                  </span>
                </td>
                <td>
                  <div class="action-buttons">
                    <button class="btn-small btn-view"
                      onclick="viewProductDetail('NuVit-C Boost', 'NUV-C-1000', 'Vitamin & Suplemen', 'Rp 125,000', '850', '14,230', '4.8', 'High potency vitamin C supplement for immunity boost and overall health support')">
                      <i class="fas fa-eye"></i>
                    </button>
                    <button class="btn-small btn-edit">
                      <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn-small btn-delete">
                      <i class="fas fa-trash"></i>
                    </button>
                  </div>
                </td>
              </tr>
              <tr>
                <td>
                  <div class="product-cell">
                    <div class="product-placeholder">
                      <i class="fas fa-image"></i>
                    </div>
                    <div class="product-info">
                      <div class="product-name">NuVit-Omega Brain</div>
                      <div class="product-sku">SKU: NUV-OMG-500</div>
                    </div>
                  </div>
                </td>
                <td>
                  <span class="category-badge category-vitamin">Vitamin & Suplemen</span>
                </td>
                <td class="price-cell">Rp 180,000</td>
                <td>
                  <span class="stock-indicator stock-medium">145</span>
                </td>
                <td>11,890</td>
                <td>
                  <div class="rating-cell">
                    <div class="rating-stars">
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star-half-alt"></i>
                    </div>
                    <div class="rating-value">4.6</div>
                  </div>
                </td>
                <td>
                  <span class="status-badge active">
                    <i class="fas fa-check-circle"></i>
                    Active
                  </span>
                </td>
                <td>
                  <div class="action-buttons">
                    <button class="btn-small btn-view"
                      onclick="viewProductDetail('NuVit-Omega Brain', 'NUV-OMG-500', 'Vitamin & Suplemen', 'Rp 180,000', '145', '11,890', '4.6', 'Premium omega-3 supplement for brain health, cognitive function, and cardiovascular support')">
                      <i class="fas fa-eye"></i>
                    </button>
                    <button class="btn-small btn-edit">
                      <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn-small btn-delete">
                      <i class="fas fa-trash"></i>
                    </button>
                  </div>
                </td>
              </tr>
              <tr>
                <td>
                  <div class="product-cell">
                    <div class="product-placeholder">
                      <i class="fas fa-image"></i>
                    </div>
                    <div class="product-info">
                      <div class="product-name">NuVit-Curcuma Gold</div>
                      <div class="product-sku">SKU: NUV-CUR-250</div>
                    </div>
                  </div>
                </td>
                <td>
                  <span class="category-badge category-herbal">Herbal & Natural</span>
                </td>
                <td class="price-cell">Rp 95,000</td>
                <td>
                  <span class="stock-indicator stock-medium">186</span>
                </td>
                <td>8,450</td>
                <td>
                  <div class="rating-cell">
                    <div class="rating-stars">
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star-half-alt"></i>
                    </div>
                    <div class="rating-value">4.7</div>
                  </div>
                </td>
                <td>
                  <span class="status-badge active">
                    <i class="fas fa-check-circle"></i>
                    Active
                  </span>
                </td>
                <td>
                  <div class="action-buttons">
                    <button class="btn-small btn-view"
                      onclick="viewProductDetail('NuVit-Curcuma Gold', 'NUV-CUR-250', 'Herbal & Natural', 'Rp 95,000', '186', '8,450', '4.7', 'Natural anti-inflammatory turmeric extract with curcumin for joint health and wellness')">
                      <i class="fas fa-eye"></i>
                    </button>
                    <button class="btn-small btn-edit">
                      <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn-small btn-delete">
                      <i class="fas fa-trash"></i>
                    </button>
                  </div>
                </td>
              </tr>
              <tr>
                <td>
                  <div class="product-cell">
                    <div class="product-placeholder">
                      <i class="fas fa-image"></i>
                    </div>
                    <div class="product-info">
                      <div class="product-name">NuVit-Whey Muscle</div>
                      <div class="product-sku">SKU: NUV-WHY-1KG</div>
                    </div>
                  </div>
                </td>
                <td>
                  <span class="category-badge category-fitness">Fitness & Protein</span>
                </td>
                <td class="price-cell">Rp 340,000</td>
                <td>
                  <span class="stock-indicator stock-low">89</span>
                </td>
                <td>14,720</td>
                <td>
                  <div class="rating-cell">
                    <div class="rating-stars">
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="far fa-star"></i>
                    </div>
                    <div class="rating-value">4.4</div>
                  </div>
                </td>
                <td>
                  <span class="status-badge active">
                    <i class="fas fa-check-circle"></i>
                    Active
                  </span>
                </td>
                <td>
                  <div class="action-buttons">
                    <button class="btn-small btn-view"
                      onclick="viewProductDetail('NuVit-Whey Muscle', 'NUV-WHY-1KG', 'Fitness & Protein', 'Rp 340,000', '89', '14,720', '4.4', 'Premium whey protein isolate for muscle building, recovery, and athletic performance')">
                      <i class="fas fa-eye"></i>
                    </button>
                    <button class="btn-small btn-edit">
                      <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn-small btn-delete">
                      <i class="fas fa-trash"></i>
                    </button>
                  </div>
                </td>
              </tr>
              <tr>
                <td>
                  <div class="product-cell">
                    <div class="product-placeholder">
                      <i class="fas fa-image"></i>
                    </div>
                    <div class="product-info">
                      <div class="product-name">NuVit-Multi Core</div>
                      <div class="product-sku">SKU: NUV-MUL-90</div>
                    </div>
                  </div>
                </td>
                <td>
                  <span class="category-badge category-vitamin">Vitamin & Suplemen</span>
                </td>
                <td class="price-cell">Rp 165,000</td>
                <td>
                  <span class="stock-indicator stock-medium">234</span>
                </td>
                <td>16,650</td>
                <td>
                  <div class="rating-cell">
                    <div class="rating-stars">
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star-half-alt"></i>
                    </div>
                    <div class="rating-value">4.5</div>
                  </div>
                </td>
                <td>
                  <span class="status-badge active">
                    <i class="fas fa-check-circle"></i>
                    Active
                  </span>
                </td>
                <td>
                  <div class="action-buttons">
                    <button class="btn-small btn-view"
                      onclick="viewProductDetail('NuVit-Multi Core', 'NUV-MUL-90', 'Vitamin & Suplemen', 'Rp 165,000', '234', '16,650', '4.5', 'Complete daily vitamin and mineral supplement for overall health and wellness support')">
                      <i class="fas fa-eye"></i>
                    </button>
                    <button class="btn-small btn-edit">
                      <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn-small btn-delete">
                      <i class="fas fa-trash"></i>
                    </button>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <!-- Notification Panel -->
  <div class="notification-panel" id="notificationPanel">
    <div class="notification-header">
      <h3><i class="fas fa-bell"></i> Notifikasi</h3>
      <button class="close-notification" onclick="toggleNotificationPanel()">
        <i class="fas fa-times"></i>
      </button>
    </div>
    <div class="notification-content">
      <div class="notification-item unread">
        <div class="notification-icon warning">
          <i class="fas fa-exclamation-triangle"></i>
        </div>
        <div class="notification-details">
          <h4>Stok Rendah</h4>
          <p>NuVit-Whey Muscle memiliki stok rendah (89 unit tersisa)</p>
          <span class="notification-time">2 menit yang lalu</span>
        </div>
        <div class="notification-status">
          <span class="unread-dot"></span>
        </div>
      </div>

      <div class="notification-item unread">
        <div class="notification-icon success">
          <i class="fas fa-chart-line"></i>
        </div>
        <div class="notification-details">
          <h4>Penjualan Meningkat</h4>
          <p>NuVit-Multi Core mencapai target penjualan bulanan</p>
          <span class="notification-time">1 jam yang lalu</span>
        </div>
        <div class="notification-status">
          <span class="unread-dot"></span>
        </div>
      </div>

      <div class="notification-item unread">
        <div class="notification-icon info">
          <i class="fas fa-star"></i>
        </div>
        <div class="notification-details">
          <h4>Review Baru</h4>
          <p>NuVit-C Boost mendapat review 5 bintang dari pelanggan</p>
          <span class="notification-time">3 jam yang lalu</span>
        </div>
        <div class="notification-status">
          <span class="unread-dot"></span>
        </div>
      </div>

      <div class="notification-item read">
        <div class="notification-icon info">
          <i class="fas fa-box"></i>
        </div>
        <div class="notification-details">
          <h4>Produk Baru Ditambahkan</h4>
          <p>NuVit-Green Detox berhasil ditambahkan ke katalog</p>
          <span class="notification-time">1 hari yang lalu</span>
        </div>
      </div>

      <div class="notification-item read">
        <div class="notification-icon success">
          <i class="fas fa-truck"></i>
        </div>
        <div class="notification-details">
          <h4>Pengiriman Selesai</h4>
          <p>Batch pengiriman #12345 telah sampai ke gudang</p>
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

  <!-- Product Detail Modal -->
  <div class="modal-overlay" id="productDetailModal">
    <div class="modal-content">
      <div class="modal-header">
        <h3><i class="fas fa-eye"></i> Detail Produk</h3>
        <button class="modal-close" onclick="closeProductDetailModal()">
          <i class="fas fa-times"></i>
        </button>
      </div>
      <div class="modal-body">
        <div class="product-detail-container">
          <div class="product-detail-header">
            <div class="product-detail-image">
              <div class="product-placeholder-large">
                <i class="fas fa-image"></i>
              </div>
            </div>
            <div class="product-detail-info">
              <h2 id="productDetailName">Product Name</h2>
              <p class="product-detail-sku" id="productDetailSku">SKU: </p>
              <div class="product-detail-category" id="productDetailCategory"></div>
              <div class="product-detail-price" id="productDetailPrice">Rp 0</div>
            </div>
          </div>

          <div class="product-detail-stats">
            <div class="detail-stat-card">
              <div class="detail-stat-icon stock">
                <i class="fas fa-boxes"></i>
              </div>
              <div class="detail-stat-info">
                <h4>Stok Tersedia</h4>
                <p id="productDetailStock">0</p>
              </div>
            </div>

            <div class="detail-stat-card">
              <div class="detail-stat-icon sales">
                <i class="fas fa-chart-bar"></i>
              </div>
              <div class="detail-stat-info">
                <h4>Total Terjual</h4>
                <p id="productDetailSales">0</p>
              </div>
            </div>

            <div class="detail-stat-card">
              <div class="detail-stat-icon rating">
                <i class="fas fa-star"></i>
              </div>
              <div class="detail-stat-info">
                <h4>Rating</h4>
                <p id="productDetailRating">0</p>
              </div>
            </div>
          </div>

          <div class="product-detail-description">
            <h4><i class="fas fa-info-circle"></i> Deskripsi Produk</h4>
            <p id="productDetailDescription">Product description will appear here...</p>
          </div>

          <div class="product-detail-actions">
            <button class="btn-detail-action edit">
              <i class="fas fa-edit"></i>
              Edit Produk
            </button>
            <button class="btn-detail-action delete">
              <i class="fas fa-trash"></i>
              Hapus Produk
            </button>
            <button class="btn-detail-action duplicate">
              <i class="fas fa-copy"></i>
              Duplikat Produk
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script src="/assets/js/product-management.js"></script>
</body>

</html>