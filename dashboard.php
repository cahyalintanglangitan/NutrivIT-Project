<?php
include 'koneksi.php';

function formatRupiahShort($number) {
    if ($number >= 1_000_000_000) return number_format($number / 1_000_000_000, 1, ',', '.') . ' M';
    if ($number >= 1_000_000) return number_format($number / 1_000_000, 1, ',', '.') . ' Jt';
    if ($number >= 1_000) return number_format($number / 1_000, 1, ',', '.') . ' Rb';
    return number_format($number, 0, ',', '.');
}

function getSingleValue($conn, $query, $key = 'total') {
    $result = $conn->query($query);
    return $result ? ($result->fetch_assoc()[$key] ?? 0) : 0;
}

// Mengambil data statistik
$totalUsers = getSingleValue($conn, "SELECT COUNT(*) AS total FROM users");
$totalProducts = getSingleValue($conn, "SELECT COUNT(*) AS total FROM products");
$totalRevenue = getSingleValue($conn, "SELECT SUM(total_price) AS total FROM sales");
$totalComplaints = getSingleValue($conn, "SELECT COUNT(*) AS total FROM user_complaints");

// Mengambil data kategori produk
$categoryQuery = "
  SELECT category, COUNT(*) AS count
  FROM products
  WHERE product_status = 'Active'
  GROUP BY category
";

$categoryDefaults = ['vitamin', 'supplement', 'herbal', 'organic', 'protein'];
$categories = array_fill_keys($categoryDefaults, 0);

if ($result = $conn->query($categoryQuery)) {
    while ($row = $result->fetch_assoc()) {
        $key = $row['category'];
        if (isset($categories[$key])) $categories[$key] = (int)$row['count'];
    }
}

$productCategoryData = [
    'labels' => array_map('ucfirst', $categoryDefaults),
    'data' => array_values($categories)
];

// Mengambil data capaian gizi
$nutritionAchievements = [
    'user_ids' => [],
    'calories_achieved' => [],
    'calories_target' => [],
    'protein_achieved' => [],
    'protein_target' => [],
    'carbs_achieved' => [],
    'carbs_target' => [],
    'fat_achieved' => [],
    'fat_target' => [],
    'percentage_achieved' => []
];

$sql = "SELECT user_id, calories_achieved, calories_target, protein_achieved, protein_target, carbs_achieved, carbs_target, fat_achieved, fat_target, percentage_achieved FROM nutrition_achievements";
$result = $conn->query($sql);

while ($row = $result->fetch_assoc()) {
    $nutritionAchievements['user_ids'][] = $row['user_id'];
    $nutritionAchievements['calories_achieved'][] = (int)$row['calories_achieved'];
    $nutritionAchievements['calories_target'][] = (int)$row['calories_target'];
    $nutritionAchievements['protein_achieved'][] = (float)$row['protein_achieved'];
    $nutritionAchievements['protein_target'][] = (float)$row['protein_target'];
    $nutritionAchievements['carbs_achieved'][] = (float)$row['carbs_achieved'];
    $nutritionAchievements['carbs_target'][] = (float)$row['carbs_target'];
    $nutritionAchievements['fat_achieved'][] = (float)$row['fat_achieved'];
    $nutritionAchievements['fat_target'][] = (float)$row['fat_target'];
    $nutritionAchievements['percentage_achieved'][] = (float)$row['percentage_achieved'];
}

// Mengonversi data ke format JSON
$nutritionAchievementsJson = json_encode($nutritionAchievements);


// Mengambil kebutuhan gizi
$nutritionNeeds = [
    'months' => [], 'protein' => [], 'carbs' => [], 'fat' => [], 'vitamin' => []
];

$sql = "SELECT month, protein_kg, carbs_kg, fat_kg, vitamin_iu FROM nutrition_needs ORDER BY FIELD(month, 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun')";
$result = $conn->query($sql);

while ($row = $result->fetch_assoc()) {
    $nutritionNeeds['months'][] = $row['month'];
    $nutritionNeeds['protein'][] = (float)$row['protein_kg'];
    $nutritionNeeds['carbs'][] = (float)$row['carbs_kg'];
    $nutritionNeeds['fat'][] = (float)$row['fat_kg'];
    $nutritionNeeds['vitamin'][] = (float)$row['vitamin_iu'];
}

// Mengambil produk terlaris
$topProducts = ['labels' => [], 'data' => []];
$sql = "
  SELECT p.name AS product_name, SUM(oi.quantity) AS total_sold
  FROM order_items oi
  JOIN products p ON oi.product_id = p.id
  JOIN orders o ON oi.order_id = o.id
  GROUP BY oi.product_id
  ORDER BY total_sold DESC
  LIMIT 8
";

$result = $conn->query($sql);
while ($row = $result->fetch_assoc()) {
    $topProducts['labels'][] = $row['product_name'];
    $topProducts['data'][] = (int)$row['total_sold'];
}


// Mengonversi data ke format JSON
$productCategoryDataJson = json_encode($productCategoryData);
$nutritionNeedsJson = json_encode($nutritionNeeds);
$topProductsJson = json_encode($topProducts);
?>

<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Dashboard - NutrivIT</title>
  
  <!-- CSS & Icon -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="./assets/css/dashboard.css" />

  <!-- Chart.js CDN -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

  <!-- Injected Data from PHP -->
<script>
    const productCategoryDataFromPHP = <?= $productCategoryDataJson ?>;
    const nutritionNeedsData = <?= $nutritionNeedsJson ?>;
    const bestSellingDataFromPHP = <?= $topProductsJson ?>;
    const nutritionAchievementsData = <?= $nutritionAchievementsJson ?>; // Tambahkan ini
</script>
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
            <span class="date"></span>
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
              <p class="stat-number"><?= number_format($totalUsers) ?></p>
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
              <p class="stat-number"><?= number_format($totalProducts) ?></p>
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
              <p class="stat-number">Rp <?= formatRupiahShort($totalRevenue) ?></p>
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
              <p class="stat-number"><?= number_format($totalComplaints) ?></p>
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
            <!-- Top Keluhan Gizi -->
            <div class="chart-card large">
              <div class="chart-header">
                <h4><i class="fas fa-stethoscope"></i> Top Keluhan Gizi</h4>
                <div class="chart-actions">
                  <div class="month-selector">
                    <label for="monthSelect">Bulan:</label>
                    <select id="monthSelect" class="month-dropdown">
                      <option value="januari">Januari 2025</option>
                      <option value="februari">Februari 2025</option>
                      <option value="maret">Maret 2025</option>
                      <option value="april">April 2025</option>
                      <option value="mei">Mei 2025</option>
                      <option value="juni">Juni 2025</option>
                      <option value="juli">Juli 2025</option>
                      <option value="agustus">Agustus 2025</option>
                      <option value="september">September 2025</option>
                      <option value="oktober">Oktober 2025</option>
                      <option value="november">November 2025</option>
                      <option value="desember">Desember 2025</option>
                    </select>
                  </div>
                  <button class="chart-btn" title="Perbesar Grafik">
                    <i class="fas fa-expand"></i>
                  </button>
                  <button class="chart-btn" title="Unduh Data">
                    <i class="fas fa-download"></i>
                  </button>
                </div>
              </div>

              <div class="chart-container" style="position: relative; height: 400px;">
                <canvas id="complaintsChart"></canvas>
              </div>

              <div class="chart-insights">
                <div class="insight-item">
                  <span class="insight-label">Total keluhan bulan ini:</span>
                  <span class="insight-value" id="totalComplaints">-</span>
                </div>
                <div class="insight-item">
                  <span class="insight-label">Keluhan tertinggi:</span>
                  <span class="insight-value" id="topComplaint">-</span>
                </div>
                <div class="insight-item">
                  <span class="insight-label">Tren vs bulan lalu:</span>
                  <span class="insight-value" id="trendValue">-</span>
                </div>
              </div>
            </div>

            <!-- Kategori Produk -->
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
              <div class="chart-legend" style="display: flex; flex-wrap: wrap; gap: 16px; justify-content: center; margin-top: 10px;">
                <div class="legend-item" style="display: flex; align-items: center; gap: 6px;">
                  <span class="legend-color" style="background: #08A55A; width: 12px; height: 12px; border-radius: 50%; display: inline-block;"></span>
                  <span>Vitamin</span>
                </div>
                <div class="legend-item" style="display: flex; align-items: center; gap: 6px;">
                  <span class="legend-color" style="background: #3FCAEA; width: 12px; height: 12px; border-radius: 50%; display: inline-block;"></span>
                  <span>Suplemen</span>
                </div>
                <div class="legend-item" style="display: flex; align-items: center; gap: 6px;">
                  <span class="legend-color" style="background: #667eea; width: 12px; height: 12px; border-radius: 50%; display: inline-block;"></span>
                  <span>Herbal</span>
                </div>
                <div class="legend-item" style="display: flex; align-items: center; gap: 6px;">
                  <span class="legend-color" style="background: #FFCE56; width: 12px; height: 12px; border-radius: 50%; display: inline-block;"></span>
                  <span>Organik</span>
                </div>
                <div class="legend-item" style="display: flex; align-items: center; gap: 6px;">
                  <span class="legend-color" style="background: #A259FF; width: 12px; height: 12px; border-radius: 50%; display: inline-block;"></span>
                  <span>Protein</span>
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
        <div class="chart-container" style="height: 400px;"> <!-- Atur tinggi chart -->
            <canvas id="nutritionAchievementChart"></canvas>
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
        <div class="chart-container" style="height: 400px;"> <!-- Atur tinggi chart -->
            <canvas id="nutritionNeedsChart"></canvas>
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

  <script src="./assets/js/dashboard.js"></script>
<script>
    // Chart untuk capaian gizi
    const ctx = document.getElementById('nutritionAchievementChart').getContext('2d');
    const nutritionAchievementChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: nutritionAchievementsData.user_ids,
            datasets: [
                {
                    label: 'Calories Achieved',
                    data: nutritionAchievementsData.calories_achieved,
                    backgroundColor: 'rgba(255, 99, 132, 0.6)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 1,
                    borderRadius: 5, // Menambahkan sudut melengkung
                },
                {
                    label: 'Protein Achieved',
                    data: nutritionAchievementsData.protein_achieved,
                    backgroundColor: 'rgba(75, 192, 192, 0.6)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1,
                    borderRadius: 5,
                },
                {
                    label: 'Carbs Achieved',
                    data: nutritionAchievementsData.carbs_achieved,
                    backgroundColor: 'rgba(255, 206, 86, 0.6)',
                    borderColor: 'rgba(255, 206, 86, 1)',
                    borderWidth: 1,
                    borderRadius: 5,
                },
                {
                    label: 'Fat Achieved',
                    data: nutritionAchievementsData.fat_achieved,
                    backgroundColor: 'rgba(54, 162, 235, 0.6)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1,
                    borderRadius: 5,
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false, // Memungkinkan chart untuk menyesuaikan dengan kontainer
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Nutritional Values',
                        font: {
                            size: 16,
                            weight: 'bold'
                        }
                    },
                    ticks: {
                        color: '#333', // Warna teks sumbu Y
                    },
                    grid: {
                        color: 'rgba(0, 0, 0, 0.1)', // Warna grid
                    }
                },
                x: {
                    title: {
                        display: true,
                        text: 'Users',
                        font: {
                            size: 16,
                            weight: 'bold'
                        }
                    },
                    ticks: {
                        color: '#333', // Warna teks sumbu X
                        maxRotation: 45, // Memutar label sumbu X
                        minRotation: 45,
                    },
                    grid: {
                        display: false // Menyembunyikan grid pada sumbu X
                    }
                }
            },
            plugins: {
                legend: {
                    position: 'top',
                    labels: {
                        font: {
                            size: 14,
                        },
                        boxWidth: 20, // Lebar kotak legend
                    }
                },
                title: {
                    display: true,
                    text: 'Nutrition Achievements by User',
                    font: {
                        size: 18,
                        weight: 'bold'
                    }
                },
                tooltip: {
                    callbacks: {
                        label: function(tooltipItem) {
                            const label = tooltipItem.dataset.label || '';
                            const value = tooltipItem.raw;
                            return `${label}: ${value}`;
                        }
                    }
                }
            },
            animation: {
                duration: 1000, // Durasi animasi saat chart ditampilkan
                easing: 'easeOutBounce' // Jenis easing untuk animasi
            }
        }
    });
</script>


</body>

</html>