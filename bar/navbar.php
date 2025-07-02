    <!-- Sidebar -->
    <div class="sidebar">
      <div class="sidebar-header">
        <h1><i class="fas fa-leaf"></i> NutriVit</h1>
        <p class="subtitle">Management System</p>
      </div>

      <nav class="sidebar-nav">
        <a href="/dashboard.php" class="nav-item active">
          <i class="fas fa-chart-pie nav-icon"></i>
          Dashboard
        </a>
        <a href="/user-management.php" class="nav-item">
          <i class="fas fa-users nav-icon"></i>
          User Management
        </a>
        <a href="/product-management.php" class="nav-item">
          <i class="fas fa-boxes nav-icon"></i>
          Product Management
        </a>
        <a href="/ai-analysis.php" class="nav-item">
          <i class="fas fa-robot nav-icon"></i>
          Manajerial AI
        </a>
      </nav>

      <div class="sidebar-footer" onclick="handleProfile()" style="cursor: pointer;">
        <div class="user-info">
          <div class="user-avatar">
            <i class="fas fa-user"></i>
          </div>
          <div class="user-details">
            <p class="user-name">Manager</p>
            <p class="user-email">manager@email.com</p>
          </div>
        </div>
      </div>
    </div>