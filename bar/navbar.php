<?php
$current_page = basename($_SERVER['PHP_SELF']);
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
      Manajerial AI
    </a>
    <a href="./complaints_review.php" class="nav-item<?php if ($current_page == 'complaints_review.php') echo ' active'; ?>">
      <i class="fas fa-comments nav-icon"></i>
      Complaints & Review
    </a>
  </nav>

  <div class="sidebar-footer" onclick="handleProfile()" style="cursor: pointer;">
    <div class="user-info">
      <div class="user-avatar">
        <i class="fas fa-user"></i>
      </div>
      <div class="user-details">
        <p class="user-name">Go Yoon Jung</p>
        <p class="user-email">goyoonjung@nutrivit.com</p>
      </div>
    </div>
  </div>
</div>
<script>
  function handleProfile() {
  window.location.href = "profile.php";
}
</script>
