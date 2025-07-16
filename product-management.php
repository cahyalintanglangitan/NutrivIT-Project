<?php
include 'koneksi.php';

// Query Produk
$sql = "SELECT * FROM products ORDER BY created_at DESC";
$result = $conn->query($sql);

// Statistik
$totalProducts = $conn->query("SELECT COUNT(*) AS total FROM products")->fetch_assoc()['total'];
$lowStock = $conn->query("SELECT COUNT(*) AS total FROM products WHERE stock < 20")->fetch_assoc()['total'];
$bestSeller = $conn->query("SELECT name FROM products ORDER BY stock DESC LIMIT 1")->fetch_assoc()['name'] ?? '-';
$totalRevenue = $conn->query("SELECT SUM(total_price) AS total FROM sales")->fetch_assoc()['total'] ?? 0;

// Penjualan per bulan (6 bulan terakhir)
$salesQuery = $conn->query("
    SELECT DATE_FORMAT(sale_date, '%b') AS month, 
           SUM(total_price) / 1000000 AS total_million 
      FROM sales 
     WHERE sale_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
  GROUP BY MONTH(sale_date)
  ORDER BY MONTH(sale_date)
");
$salesLabels = $salesData = [];
while ($row = $salesQuery->fetch_assoc()) {
    $salesLabels[] = $row['month'];
    $salesData[] = round($row['total_million'], 2);
}

// Produk per kategori
$categoryQuery = $conn->query("
    SELECT category, COUNT(*) AS total 
      FROM products 
  GROUP BY category
");
$categoryLabels = $categoryCounts = [];
while ($row = $categoryQuery->fetch_assoc()) {
    $categoryLabels[] = ucfirst($row['category']);
    $categoryCounts[] = $row['total'];
}
?>
<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management - NutriVit Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <script src="auth-guard.js"></script>
    <link rel="stylesheet" href="./assets/css/product-management.css">
</head>

<body>
    <div class="dashboard-container">
        <?php include 'bar/navbar.php'; ?>
        <div class="main-content">
            <div class="main-header">
                <div class="header-left">
                    <h2><i class="fas fa-boxes"></i> Product Management</h2>
                    <p class="page-subtitle">Kelola produk kesehatan dan analisis penjualan</p>
                </div>
                <div class="header-actions">
                    <div class="date">
                        <i class="fas fa-calendar-alt"></i>
                        <span id="current-date"></span>
                    </div>
                </div>
            </div>
            <div class="content-section">
                <!-- Statistics Cards -->
                <?php include './assets/php/stat-product.php'; ?>
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
                                <input type="text" id="searchInput" placeholder="Cari produk..." oninput="filterProducts()">
                            </div>
                            <div class="category-filter">
                                <select id="categoryFilter" onchange="filterProducts()">
                                    <option value="">Semua Kategori</option>
                                </select>
                            </div>
                        </div>
                        <div class="filter-buttons">
                            <button class="filter-btn active btn-success" data-mode="all" onclick="filterByStock('all', this)">
                                <i class="fas fa-list"></i> Semua
                            </button>
                            <button class="filter-btn" data-mode="in-stock" onclick="filterByStock('in-stock', this)">
                                <i class="fas fa-check-circle"></i> Tersedia
                            </button>
                            <button class="filter-btn" data-mode="low-stock" onclick="filterByStock('low-stock', this)">
                                <i class="fas fa-exclamation-triangle"></i> Stok Rendah
                            </button>
                        </div>
                    </div>
                </div>
                <!-- Product Table -->
                <div class="table-container">
                    <div class="table-header">
                        <div class="table-title">
                            <i class="fas fa-table"></i> Daftar Produk
                        </div>
                    </div>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Produk</th>
                                <th>Kategori</th>
                                <th>Harga</th>
                                <th>Stok</th>
                                <th>Rating</th>
                                <th>Status</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php include './assets/php/table-product.php'; ?>
                        </tbody>
                        <tr id="noDataMessage" style="display: none; text-align: center;">
                            <td colspan="8" style="padding: 1em; text-align: center; font-style: italic; color: #999;">
                                <i class="fas fa-info-circle"></i> Tidak ada produk yang ditemukan.
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
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
                    <!-- HEADER: Nama, Gambar, SKU -->
                    <div class="product-detail-header">
                        <div class="product-detail-image">
                            <img id="productDetailImage" src="" alt="Gambar Produk" class="product-image-preview" onerror="this.src='default-image.png'">
                        </div>
                        <div class="product-detail-info">
                            <h2 id="productDetailName">Product Name</h2>
                            <p class="product-detail-sku" id="productDetailSku">SKU: </p>
                            <div class="product-detail-category" id="productDetailCategory"></div>
                            <div class="product-detail-price" id="productDetailPrice">Rp 0</div>
                        </div>
                    </div>

                    <!-- STATS PRODUK -->
                    <div class="product-detail-stats">
                        <!-- STOK -->
                        <div class="detail-stat-card">
                            <div class="detail-stat-icon stock"><i class="fas fa-boxes"></i></div>
                            <div class="detail-stat-info">
                                <h4>Stok Tersedia</h4>
                                <p id="productDetailStock" class="detail-view">0</p>
                                <input type="number" id="editProductStock" class="detail-edit" style="display: none;" />
                            </div>
                        </div>

                        <!-- TERJUAL -->
                        <div class="detail-stat-card">
                            <div class="detail-stat-icon sales"><i class="fas fa-chart-bar"></i></div>
                            <div class="detail-stat-info">
                                <h4>Total Terjual</h4>
                                <p id="productDetailSales">0</p>
                            </div>
                        </div>

                        <!-- RATING -->
                        <div class="detail-stat-card">
                            <div class="detail-stat-icon rating"><i class="fas fa-star"></i></div>
                            <div class="detail-stat-info">
                                <h4>Rating</h4>
                                <p id="productDetailRating">-</p>
                            </div>
                        </div>
                    </div>

                    <!-- DESKRIPSI PRODUK -->
                    <div class="product-detail-description">
                        <h4><i class="fas fa-info-circle"></i> Deskripsi Produk</h4>
                        <p id="productDetailDescription" class="detail-view">-</p>
                        <textarea id="editProductDescription" class="detail-edit" style="display: none;"></textarea>
                    </div>

                </div>
            </div>
        </div>
        <script src="./assets/js/product-management.js"></script>
        <script>
            window.salesLabels = <?= json_encode($salesLabels) ?>;
            window.salesData = <?= json_encode($salesData) ?>;
            window.categoryLabels = <?= json_encode($categoryLabels) ?>;
            window.categoryCounts = <?= json_encode($categoryCounts) ?>;
        </script>
</body>

</html>