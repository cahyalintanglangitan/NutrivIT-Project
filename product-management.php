<?php
include 'koneksi.php';

// Query Produk
$sql = "SELECT * FROM products ORDER BY created_at DESC";
$result = $conn->query($sql);

// Statistik
$totalProducts = $conn->query("SELECT COUNT(*) AS total FROM products")->fetch_assoc()['total'];
$lowStock = $conn->query("SELECT COUNT(*) AS total FROM products WHERE stock < 100")->fetch_assoc()['total'];
$bestSeller = $conn->query("SELECT name FROM products ORDER BY stock ASC LIMIT 1")->fetch_assoc()['name'] ?? '-';
$totalRevenue = $conn->query("SELECT SUM(price * stock) AS total FROM products")->fetch_assoc()['total'] ?? 0;

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

        <div class="content-section">
            <!-- Statistics Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon total-products"><i class="fas fa-boxes"></i></div>
                    <div class="stat-info">
                        <h3>Total Products</h3>
                        <div class="stat-number"><?= $totalProducts ?></div>
                        <div class="stat-change"><i class="fas fa-arrow-up"></i> +8% dari bulan lalu</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon total-revenue"><i class="fas fa-chart-line"></i></div>
                    <div class="stat-info">
                        <h3>Total Revenue</h3>
                        <div class="stat-number">Rp <?= number_format($totalRevenue, 0, ',', '.') ?></div>
                        <div class="stat-change"><i class="fas fa-arrow-up"></i> +15% dari bulan lalu</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon best-seller"><i class="fas fa-trophy"></i></div>
                    <div class="stat-info">
                        <h3>Best Seller</h3>
                        <div class="stat-number"><?= $bestSeller ?></div>
                        <div class="stat-change"><i class="fas fa-fire"></i> – terjual bulan ini</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon low-stock"><i class="fas fa-exclamation-triangle"></i></div>
                    <div class="stat-info">
                        <h3>Low Stock Items</h3>
                        <div class="stat-number"><?= $lowStock ?></div>
                        <div class="stat-change"><i class="fas fa-exclamation-circle"></i> Perlu restok segera</div>
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
                    <?php while($row = $result->fetch_assoc()): ?>
                        <tr>
                            <td>
                                <div class="product-cell">
                                    <div class="product-placeholder">
                                        <i class="fas fa-image"></i>
                                    </div>
                                    <div class="product-info">
                                        <div class="product-name"><?= htmlspecialchars($row['name']) ?></div>
                                        <div class="product-sku">ID: <?= htmlspecialchars($row['id']) ?></div>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <span class="category-badge category-<?= htmlspecialchars($row['category']) ?>">
                                    <?= ucfirst(str_replace('_', ' ', $row['category'])) ?>
                                </span>
                            </td>
                            <td class="price-cell">Rp <?= number_format($row['price'], 0, ',', '.') ?></td>
                            <td>
                                <span class="stock-indicator stock-<?= $row['stock'] > 200 ? 'high' : ($row['stock'] > 100 ? 'medium' : 'low') ?>">
                                    <?= $row['stock'] ?>
                                </span>
                            </td>
                            <td>–</td>
                            <td>
                                <span class="status-badge <?= $row['product_status'] === 'Active' ? 'active' : 'inactive' ?>">
                                    <i class="fas fa-<?= $row['product_status'] === 'Active' ? 'check-circle' : 'times-circle' ?>"></i>
                                    <?= $row['product_status'] ?>
                                </span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <button class="btn-small btn-view" onclick="viewProductDetail('<?= addslashes($row['name']) ?>', '<?= $row['id'] ?>', '<?= $row['category'] ?>', 'Rp <?= number_format($row['price'], 0, ',', '.') ?>', '<?= $row['stock'] ?>', '-', '-', '<?= addslashes($row['description']) ?>')">
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
                    <?php endwhile; ?>
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

<script src="assets/js/product-management.js"></script>
<script>
// Inisialisasi Dropdown Kategori & Hover Effect
function initializeCategoryDropdown() {
    const categories = <?= json_encode($categoryLabels) ?>;
    const categoryFilter = document.getElementById("categoryFilter");
    if (categoryFilter) {
        categoryFilter.innerHTML = '<option value="">Semua Kategori</option>';
        categories.forEach(cat => {
            categoryFilter.innerHTML += `<option value="${cat}">${cat}</option>`;
        });
    }
    // Hover effect pada baris tabel
    const style = document.createElement("style");
    style.textContent = `
        .row-hover-effect:hover {
            background-color: rgba(8, 165, 90, 0.08);
            cursor: pointer;
        }
    `;
    document.head.appendChild(style);
}

// Inisialisasi Chart
function initializeCharts() {
    // Sales Chart
    if (document.getElementById("salesChart")) {
        const salesLabels = <?= json_encode($salesLabels) ?>;
        const salesData = <?= json_encode($salesData) ?>;
        const ctxSales = document.getElementById("salesChart").getContext("2d");
        new Chart(ctxSales, {
            type: "line",
            data: {
                labels: salesLabels,
                datasets: [{
                    label: "Penjualan (Rp Million)",
                    data: salesData,
                    borderColor: "#08A55A",
                    backgroundColor: "rgba(8, 165, 90, 0.1)",
                    tension: 0.4,
                    fill: true,
                    pointBackgroundColor: "#08A55A",
                    pointBorderColor: "#fff",
                    pointBorderWidth: 2,
                    pointRadius: 6,
                }],
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: "top",
                        labels: { usePointStyle: true, padding: 20 }
                    }
                },
                scales: {
                    x: { grid: { display: false } },
                    y: { grid: { color: "rgba(0,0,0,0.1)" } }
                }
            }
        });
    }

    // Category Chart
    if (document.getElementById("categoryChart")) {
        const categoryLabels = <?= json_encode($categoryLabels) ?>;
        const categoryCounts = <?= json_encode($categoryCounts) ?>;
        const ctxCategory = document.getElementById("categoryChart").getContext("2d");
        new Chart(ctxCategory, {
            type: "pie",
            data: {
                labels: categoryLabels,
                datasets: [{
                    data: categoryCounts,
                    backgroundColor: [
                        "#4CAF50", "#FFC107", "#2196F3", "#9C27B0", "#FF5722"
                    ],
                    borderColor: "#fff",
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: "bottom",
                        labels: { usePointStyle: true, padding: 20 }
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                let label = context.label || '';
                                let value = context.raw || 0;
                                return `${label}: ${value} produk`;
                            }
                        }
                    }
                }
            }
        });
    }
}
</script>
</body>
</html>
