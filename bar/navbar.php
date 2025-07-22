<?php
// Pastikan koneksi database tersedia
if (!isset($conn)) {
    require_once __DIR__ . '/../koneksi.php';
}

$current_page = basename($_SERVER['PHP_SELF']);

// Ambil data manager dari database
$manager_data = null;
if (isset($_SESSION['manager_id'])) {
    $manager_id = $_SESSION['manager_id'];
    $query = "SELECT nama_manager, email_manager, photo_url FROM manager WHERE id_manager = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $manager_id);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows > 0) {
        $manager_data = $result->fetch_assoc();
    }
    $stmt->close();
} else {
    // Jika tidak ada session, ambil data manager pertama (fallback)
    $query = "SELECT nama_manager, email_manager, photo_url FROM manager LIMIT 1";
    $result = $conn->query($query);
    if ($result && $result->num_rows > 0) {
        $manager_data = $result->fetch_assoc();
    }
}

// Set default values jika data tidak ditemukan
if (!$manager_data) {
    $manager_data = [
        'nama_manager' => 'Manager',
        'email_manager' => 'manager@nutrivit.com',
        'photo_url' => ''
    ];
}
?>

<style>
  .nav-item::before {
    content: "";
    position: absolute;
    left: 0;
    top: 0;
    bottom: 0;
    width: 0;
    background: rgba(255, 255, 255, 0.1);
    transition: width 0.3s ease;
  }

  .nav-item:hover::before {
    width: 100%;
  }

  .nav-item:hover {
    border-left-color: white;
    background: rgba(255, 255, 255, 0.1);
  }

  .nav-item.active {
    background: rgba(255, 255, 255, 0.2);
    border-left-color: white;
    font-weight: 600;
    box-shadow: inset 0 0 20px rgba(255, 255, 255, 0.1);
  }

  .user-avatar {
    width: 45px;
    height: 45px;
    background: rgba(255, 255, 255, 0.2);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    margin-right: 12px;
    overflow: hidden;
    border: 2px solid rgba(255, 255, 255, 0.3);
    transition: all 0.3s ease;
  }

  .user-avatar:hover {
    transform: scale(1.05);
    border-color: rgba(255, 255, 255, 0.5);
  }

  .user-avatar img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 50%;
  }

  .user-avatar .default-avatar {
    font-size: 18px;
    color: white;
  }

  .user-info {
    display: flex;
    align-items: center;
    margin-bottom: 15px;
    padding: 12px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 12px;
    transition: all 0.3s ease;
    cursor: pointer;
  }

  .user-info:hover {
    background: rgba(255, 255, 255, 0.15);
    transform: translateY(-2px);
  }

  .user-details {
    flex: 1;
    min-width: 0; /* Untuk text truncation */
  }

  .user-name {
    font-weight: 600;
    margin-bottom: 3px;
    font-size: 14px;
    color: white;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }

  .user-email {
    font-size: 11px;
    opacity: 0.8;
    color: rgba(255, 255, 255, 0.8);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }

  .user-status {
    display: flex;
    align-items: center;
    gap: 5px;
    margin-top: 2px;
  }

  .status-dot {
    width: 8px;
    height: 8px;
    background: #4ade80;
    border-radius: 50%;
    animation: pulse 2s infinite;
  }

  .status-text {
    font-size: 10px;
    color: rgba(255, 255, 255, 0.7);
  }

  @keyframes pulse {
    0%, 100% {
      opacity: 1;
    }
    50% {
      opacity: 0.5;
    }
  }

  /* Responsive adjustments */
  @media (max-width: 768px) {
    .user-name {
      font-size: 13px;
    }
    
    .user-email {
      font-size: 10px;
    }
    
    .user-avatar {
      width: 40px;
      height: 40px;
    }
  }
</style>

<!-- Sidebar -->
<div class="sidebar">
  <div class="sidebar-header">
    <h1><i class="fas fa-leaf"></i> NutriVit</h1>
    <p class="subtitle">Management System</p>
  </div>

  <nav class="sidebar-nav">
    <a href="./dashboard.php" class="nav-item<?php if ($current_page == 'dashboard.php') echo ' active'; ?>">
      <i class="fas fa-chart-pie nav-icon"></i>
      Dashboard
    </a>
    <a href="./user-management.php" class="nav-item<?php if ($current_page == 'user-management.php') echo ' active'; ?>">
      <i class="fas fa-users nav-icon"></i>
      User Management
    </a>
    <a href="./product-management.php" class="nav-item<?php if ($current_page == 'product-management.php') echo ' active'; ?>">
      <i class="fas fa-boxes nav-icon"></i>
      Product Management
    </a>
    <a href="./ai-analysis.php" class="nav-item<?php if ($current_page == 'ai-analysis.php') echo ' active'; ?>">
      <i class="fas fa-robot nav-icon"></i>
      AI Business Analyst
    </a>
    <a href="./complaints.php" class="nav-item<?php if ($current_page == 'complaints.php') echo ' active'; ?>">
      <i class="fas fa-solid fa-list-check nav-icon"></i>
      Complaint Management
    </a>
  </nav>

  <div class="sidebar-footer" onclick="handleProfile()" style="cursor: pointer;">
    <div class="user-info">
      <div class="user-avatar">
        <?php if (!empty($manager_data['photo_url']) && file_exists($manager_data['photo_url'])): ?>
          <img src="<?php echo htmlspecialchars($manager_data['photo_url']); ?>" 
               alt="<?php echo htmlspecialchars($manager_data['nama_manager']); ?>"
               title="<?php echo htmlspecialchars($manager_data['nama_manager']); ?>">
        <?php else: ?>
          <div class="default-avatar">
            <i class="fas fa-user"></i>
          </div>
        <?php endif; ?>
      </div>
      <div class="user-details">
        <p class="user-name" title="<?php echo htmlspecialchars($manager_data['nama_manager']); ?>">
          <?php echo htmlspecialchars($manager_data['nama_manager']); ?>
        </p>
        <p class="user-email" title="<?php echo htmlspecialchars($manager_data['email_manager']); ?>">
          <?php echo htmlspecialchars($manager_data['email_manager']); ?>
        </p>
        <div class="user-status">
          <div class="status-dot"></div>
          <span class="status-text">Online</span>
        </div>
      </div>
    </div>
  </div>
</div>

<script>
  function handleProfile() {
    window.location.href = "profile.php";
  }

  // Add hover effect untuk user info
  document.addEventListener('DOMContentLoaded', function() {
    const userInfo = document.querySelector('.user-info');
    if (userInfo) {
      userInfo.addEventListener('mouseenter', function() {
        this.style.transform = 'translateY(-2px)';
      });
      
      userInfo.addEventListener('mouseleave', function() {
        this.style.transform = 'translateY(0)';
      });
    }
  });
</script>
