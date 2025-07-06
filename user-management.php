<?php
include 'koneksi.php';

function fetchAssocArray($query, $conn) {
  $result = $conn->query($query);
  $rows = [];
  while ($row = $result?->fetch_assoc()) {
    $rows[] = $row;
  }
  return $rows;
}

$users = [];
$userQuery = "
  SELECT 
    u.id, u.name, u.email, u.joining_date, u.status, u.konsultasi_status,
    u.phone, u.gender, u.age, u.height, u.weight, u.member_type,
    na.percentage_achieved, na.calories_achieved, na.calories_target,
    na.protein_achieved, na.protein_target,
    na.carbs_achieved, na.carbs_target,
    na.fat_achieved, na.fat_target
  FROM users u
  LEFT JOIN (
    SELECT n1.*
    FROM nutrition_achievements n1
    INNER JOIN (
      SELECT user_id, MAX(date) AS max_date
      FROM nutrition_achievements GROUP BY user_id
    ) n2 ON n1.user_id = n2.user_id AND n1.date = n2.max_date
  ) na ON u.id = na.user_id
";

foreach (fetchAssocArray($userQuery, $conn) as $user) {
  $userId = $user['id'];

  // Nutrisi
  $user['daily_calories']  = (int) ($user['calories_achieved'] ?? 0);
  $user['calories_target'] = (int) ($user['calories_target'] ?? 2000);
  $user['protein_percent'] = ($user['protein_target'] ?? 0) > 0 ? round($user['protein_achieved'] / $user['protein_target'] * 100) : 0;
  $user['carbs_percent']   = ($user['carbs_target']   ?? 0) > 0 ? round($user['carbs_achieved'] / $user['carbs_target'] * 100) : 0;
  $user['fat_percent']     = ($user['fat_target']     ?? 0) > 0 ? round($user['fat_achieved'] / $user['fat_target'] * 100) : 0;
  $user['vitamin_percent'] = rand(70, 100); // dummy

  // Keluhan
  $user['last_complaints'] = [];
  $complaints = fetchAssocArray(
    "SELECT complaint_type, description, created_at 
     FROM user_complaints 
     WHERE user_id = '$userId' 
     ORDER BY created_at DESC LIMIT 2", 
    $conn
  );
  foreach ($complaints as $c) {
    $user['last_complaints'][] = [
      'title' => ucwords(str_replace('_', ' ', $c['complaint_type'])),
      'date'  => date('d M Y', strtotime($c['created_at'])),
      'description' => $c['description'] ?? '-'
    ];
  }

  // Konsultasi AI
  $user['consultations'] = [];
  $consultations = fetchAssocArray(
    "SELECT question, ai_response, consultation_duration, satisfaction_rating, created_at 
     FROM ai_consultations 
     WHERE user_id = '$userId' 
     ORDER BY created_at DESC LIMIT 5", 
    $conn
  );
  foreach ($consultations as $c) {
    $user['consultations'][] = [
      'topic' => ucfirst($c['question']),
      'date' => date('d F Y', strtotime($c['created_at'])),
      'summary' => mb_substr(strip_tags($c['ai_response']), 0, 100) . '...',
      'rating' => (float) ($c['satisfaction_rating'] ?? 0),
      'duration' => (int) $c['consultation_duration']
    ];
  }

  // Riwayat Pembelian
  $user['orders'] = [];
  $totalAmount = 0;
  $totalItems = 0;
  $lastPurchase = null;

  $orderQuery = "
    SELECT o.created_at, p.name AS product_name, oi.quantity, p.price
    FROM orders o
    LEFT JOIN order_items oi ON o.id = oi.order_id
    LEFT JOIN products p ON oi.product_id = p.id
    WHERE o.user_id = '$userId'
    ORDER BY o.created_at DESC
  ";
  $orders = fetchAssocArray($orderQuery, $conn);
  foreach ($orders as $o) {
    $user['orders'][] = [
      'product' => $o['product_name'],
      'date' => date('d F Y', strtotime($o['created_at'])),
      'quantity' => (int) $o['quantity'],
      'price' => 'Rp ' . number_format((float) $o['price'], 0, ',', '.')
    ];
    $totalAmount += (float) $o['price'] * (int) $o['quantity'];
    $totalItems += (int) $o['quantity'];
    if (!$lastPurchase) $lastPurchase = $o['created_at'];
  }

  $user['purchase_summary'] = [
    'total_amount' => 'Rp ' . number_format($totalAmount, 0, ',', '.'),
    'total_items' => $totalItems,
    'last_purchase' => $lastPurchase ? date_diff(date_create($lastPurchase), date_create())->days . ' hari lalu' : '-'
  ];

  // Tambahan properti
  $user['nutritionProgress'] = (int) ($user['percentage_achieved'] ?? 0);
  $user['consultationStatus'] = $user['konsultasi_status'] ?? 'pending';

  $users[] = $user;
}

// Statistik Dashboard
$totalUsers = (int) ($conn->query("SELECT COUNT(*) as total FROM users")?->fetch_assoc()['total'] ?? 0);
$activeConsultations = (int) ($conn->query("SELECT COUNT(*) as total FROM users WHERE konsultasi_status = 'active'")?->fetch_assoc()['total'] ?? 0);
$avgNutrition = round((float) ($conn->query("
  SELECT AVG(percentage_achieved) as avg_percentage
  FROM (
    SELECT n1.percentage_achieved
    FROM nutrition_achievements n1
    INNER JOIN (
      SELECT user_id, MAX(date) AS max_date
      FROM nutrition_achievements GROUP BY user_id
    ) n2 ON n1.user_id = n2.user_id AND n1.date = n2.max_date
  ) latest
")?->fetch_assoc()['avg_percentage'] ?? 0));
$avgNutritionText = "$avgNutrition%";

// Total pembelian bulan ini
$purchasesThisMonth = (int) ($conn->query("
  SELECT COUNT(*) as total
  FROM orders
  WHERE MONTH(created_at) = MONTH(CURRENT_DATE())
    AND YEAR(created_at) = YEAR(CURRENT_DATE())
")?->fetch_assoc()['total'] ?? 0);

$conn->close();
?>

<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>User Management - NutrivIT</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="./assets/css/dashboard.css" />
  <link rel="stylesheet" href="./assets/css/user-management.css" />
</head>
<body>
  <div class="dashboard-container">
    <?php include 'bar/navbar.php'; ?>  
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
            <span class="date"></span>
            <i class="fas fa-calendar-alt"></i>
            <span id="current-date"></span>
          </span>
        </div>
      </header>
      <div class="content-section active">
        <!-- Filter & Search -->
        <div class="filter-section">
          <div class="search-box">
            <i class="fas fa-search"></i>
            <input type="text" placeholder="Cari user..." id="user-search" oninput="searchUsers(this.value)">
          </div>
          <div class="filter-buttons">
            <button class="filter-btn active" onclick="filterUsers('all')" id="filter-all">
              <i class="fas fa-users"></i> Semua (<?= count($users) ?>)
            </button>
            <button class="filter-btn" onclick="filterUsers('active')" id="filter-active">
              <i class="fas fa-user-check"></i> Aktif (<?= count(array_filter($users, fn($u) => $u['status'] === 'active')) ?>)
            </button>
            <button class="filter-btn" onclick="filterUsers('consultation')" id="filter-consultation">
              <i class="fas fa-comments"></i> Konsultasi (<?= count(array_filter($users, fn($u) => $u['consultationStatus'] === 'active')) ?>)
            </button>
            <button class="filter-btn" onclick="filterUsers('premium')" id="filter-premium">
              <i class="fas fa-crown"></i> Premium (<?= count(array_filter($users, fn($u) => ($u['member_type'] ?? '') === 'Premium')) ?>)
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
              <p class="stat-number"><?= $totalUsers ?></p>
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
              <p class="stat-number"><?= $activeConsultations ?></p>
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
              <p class="stat-number"><?= $purchasesThisMonth ?></p>
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
              <p class="stat-number"><?= $avgNutritionText ?></p>
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
            <tbody id="users-tbody"></tbody>
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
                        <span class="stat-value" id="daily-calories">-</span>
                      </div>
                    </div>
                    <div class="health-stat">
                      <i class="fas fa-tint"></i>
                      <div>
                        <span class="stat-label">Hidrasi</span>
                        <span class="stat-value" id="hydration">-</span>
                      </div>
                    </div>
                    <div class="health-stat">
                      <i class="fas fa-dumbbell"></i>
                      <div>
                        <span class="stat-label">Aktivitas</span>
                        <span class="stat-value" id="activity">-</span>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="nutrition-progress">
                  <h4>Capaian Nutrisi Hari Ini</h4>
                  <div class="nutrition-item">
                    <span>Protein</span>
                    <div class="progress-bar">
                      <div class="progress-fill" id="protein-bar" style="width: 0%"></div>
                    </div>
                    <span id="protein-val">-</span>
                  </div>
                  <div class="nutrition-item">
                    <span>Karbohidrat</span>
                    <div class="progress-bar">
                      <div class="progress-fill" id="carbs-bar" style="width: 0%"></div>
                    </div>
                    <span id="carbs-val">-</span>
                  </div>
                  <div class="nutrition-item">
                    <span>Lemak</span>
                    <div class="progress-bar">
                      <div class="progress-fill" id="fat-bar" style="width: 0%"></div>
                    </div>
                    <span id="fat-val">-</span>
                  </div>
                  <div class="nutrition-item">
                    <span>Vitamin</span>
                    <div class="progress-bar">
                      <div class="progress-fill" id="vitamin-bar" style="width: 0%"></div>
                    </div>
                    <span id="vitamin-val">-</span>
                  </div>
                </div>
                <div class="health-complaints" id="complaints-container">
                  <h4>Keluhan Gizi Terkini</h4>
                </div>
              </div>

              <!-- Consultation Tab -->
              <div id="consultation-tab" class="tab-content">
                <div class="consultation-stats">
                  <div class="consult-stat">
                    <i class="fas fa-comments"></i>
                    <div>
                      <span class="stat-label">Total Konsultasi</span>
                      <span class="stat-value" id="consult-total">-</span>
                    </div>
                  </div>
                  <div class="consult-stat">
                    <i class="fas fa-clock"></i>
                    <div>
                      <span class="stat-label">Durasi Rata-rata</span>
                      <span class="stat-value" id="consult-duration">-</span>
                    </div>
                  </div>
                  <div class="consult-stat">
                    <i class="fas fa-star"></i>
                    <div>
                      <span class="stat-label">Rating Kepuasan</span>
                      <span class="stat-value" id="consult-rating">-</span>
                    </div>
                  </div>
                </div>
                <div class="consultation-history">
                  <h4>Riwayat Konsultasi AI</h4>
                  <div id="consultation-history-list"></div>
                </div>
              </div>

              <!-- Purchases Tab -->
              <div id="purchases-tab" class="tab-content">
                <div class="purchase-stats">
                  <div class="purchase-stat">
                    <i class="fas fa-shopping-cart"></i>
                    <div>
                      <span class="stat-label">Total Pembelian</span>
                      <span class="stat-value" id="purchase-total">-</span>
                    </div>
                  </div>
                  <div class="purchase-stat">
                    <i class="fas fa-box"></i>
                    <div>
                      <span class="stat-label">Produk Dibeli</span>
                      <span class="stat-value" id="purchase-items">-</span>
                    </div>
                  </div>
                  <div class="purchase-stat">
                    <i class="fas fa-calendar"></i>
                    <div>
                      <span class="stat-label">Pembelian Terakhir</span>
                      <span class="stat-value" id="purchase-last">-</span>
                    </div>
                  </div>
                </div>
                <div class="purchase-history">
                  <h4>Riwayat Pembelian</h4>
                  <div id="purchase-history-list"></div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- End User Modal -->
      </div>
    </div>
  </div>
<script>
  window.usersData = <?= json_encode($users); ?>;
</script>
<script src="./assets/js/user-management.js"></script>


</body>
</html>
