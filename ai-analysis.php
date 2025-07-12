<!DOCTYPE html>
<html lang="id">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>AI Analysis - NutrivIT</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="./assets/css/dashboard.css" />
  <link rel="stylesheet" href="./assets/css/ai-analysis.css" />
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
          <h2><i class="fas fa-robot"></i> Manajerial AI</h2>
          <p class="page-subtitle">Analisis cerdas untuk pengambilan keputusan strategis produk kesehatan</p>
        </div>
        <div class="header-actions">
          <div class="notification-bell" onclick="toggleNotificationPanel()">
            <i class="fas fa-bell"></i>
            <span class="notification-badge">4</span>
          </div>
          <span class="date">
            <i class="fas fa-calendar-alt"></i>
            <span id="current-date"></span>
          </span>
        </div>
      </header>

      <!-- AI Analysis Content -->
      <div class="content-section active">
        <!-- AI Status Banner -->
        <div class="ai-status-banner">
          <div class="status-info">
            <div class="status-indicator">
              <i class="fas fa-circle online"></i>
              <span>AI Engine Online</span>
            </div>
            <div class="last-updated">
              <i class="fas fa-clock"></i>
              <span>Terakhir diperbarui: <span id="last-update">2 jam yang lalu</span></span>
            </div>
          </div>
          <div class="ai-logo">
            <i class="fas fa-brain"></i>
          </div>
        </div>

        <!-- Main AI Chat Interface -->
        <div class="ai-chat-container">
          <div class="chat-header">
            <div class="chat-title">
              <i class="fas fa-robot"></i>
              <h3>Konsultasi Strategis AI</h3>
            </div>
            <div class="chat-actions">
              <button class="btn-secondary" onclick="clearChat()">
                <i class="fas fa-broom"></i> Bersihkan Chat
              </button>
            </div>
          </div>

          <div class="chat-messages" id="chat-messages">
            <div class="message ai-message">
              <div class="message-avatar">
                <i class="fas fa-robot"></i>
              </div>
              <div class="message-content">
                <div class="message-text">
                  Halo! Saya AI Assistant NutriVit. Saya siap membantu Anda menganalisis tren kesehatan dan memberikan
                  rekomendasi strategis untuk pengembangan produk. Apa yang ingin Anda ketahui hari ini?
                </div>
                <div class="message-time">
                  <span id="welcome-time"></span>
                </div>
              </div>
            </div>
          </div>

          <div class="chat-input-container">
            <div class="quick-questions">
              <span class="quick-label">Pertanyaan Cepat:</span>
              <div class="quick-buttons">
                <button class="quick-btn" onclick="askQuickQuestion('gap-analysis')">
                  <i class="fas fa-chart-line"></i> Analisis Trend Terkini
                </button>
                <button class="quick-btn" onclick="askQuickQuestion('product-strategy')">
                  <i class="fas fa-lightbulb"></i> Strategi Produk
                </button>
                <button class="quick-btn" onclick="askQuickQuestion('launch-plan')">
                  <i class="fas fa-chess"></i> Rencana Peluncuran
                </button>
                <button class="quick-btn" onclick="askQuickQuestion('market-opportunity')">
                  <i class="fas fa-target"></i> Peluang Pasar
                </button>
              </div>
            </div>

            <div class="input-box">
              <textarea id="user-input"
                placeholder="Tanyakan tentang strategi berdasarkan data dashboard: keluhan gizi, gap nutrisi, performa produk, atau peluang pengembangan..."
                rows="3"></textarea>
              <button class="send-btn" onclick="sendMessage()" id="send-btn">
                <i class="fas fa-paper-plane"></i>
              </button>
            </div>
          </div>
        </div>

        <!-- Data Sources Panel -->
        <div class="data-sources">
          <h3><i class="fas fa-database"></i> Sumber Data Analisis Real-time</h3>
          <div class="sources-grid">
            <div class="source-item">
              <div class="source-icon">
                <i class="fas fa-users"></i>
              </div>
              <div class="source-info">
                <h4>Data Pengguna</h4>
                <p>1,234 pengguna aktif</p>
                <span class="source-status active">Real-time</span>
              </div>
            </div>

            <div class="source-item">
              <div class="source-icon">
                <i class="fas fa-heartbeat"></i>
              </div>
              <div class="source-info">
                <h4>Top Keluhan Gizi</h4>
                <p>Kelelahan Kronis (28.7%)</p>
                <span class="source-status active">Juni 2025</span>
              </div>
            </div>

            <div class="source-item">
              <div class="source-icon">
                <i class="fas fa-shopping-cart"></i>
              </div>
              <div class="source-info">
                <h4>Capaian Gizi</h4>
                <p>72.3% rata-rata 6 bulan</p>
                <span class="source-status active">H1 2025</span>
              </div>
            </div>

            <div class="source-item">
              <div class="source-icon">
                <i class="fas fa-comments"></i>
              </div>
              <div class="source-info">
                <h4>Best Seller</h4>
                <p>Multi Core: 16,650 unit</p>
                <span class="source-status active">H1 2025</span>
              </div>
            </div>

            <div class="source-item">
              <div class="source-icon">
                <i class="fas fa-star"></i>
              </div>
              <div class="source-info">
                <h4>Gap Terbesar</h4>
                <p>Lemak Sehat (30% defisit)</p>
                <span class="source-status active">Real-time</span>
              </div>
            </div>

            <div class="source-item">
              <div class="source-icon">
                <i class="fas fa-globe"></i>
              </div>
              <div class="source-info">
                <h4>Revenue Juni</h4>
                <p>Rp 3.25B (+15%)</p>
                <span class="source-status synced">Monthly</span>
              </div>
            </div>
          </div>
        </div>

  <!-- Notification Panel -->
  <div class="notification-panel" id="notificationPanel">
    <div class="notification-header">
      <h3><i class="fas fa-bell"></i> Notifikasi AI Analysis</h3>
      <button class="close-notification" onclick="toggleNotificationPanel()">
        <i class="fas fa-times"></i>
      </button>
    </div>
    <div class="notification-content">
      <div class="notification-item unread">
        <div class="notification-icon warning">
          <i class="fas fa-robot"></i>
        </div>
        <div class="notification-details">
          <h4>AI Rekomendasi Baru</h4>
          <p>Sistem AI telah mengidentifikasi peluang Omega Premium dengan ROI 180%</p>
          <span class="notification-time">10 menit yang lalu</span>
        </div>
        <div class="notification-status">
          <span class="unread-dot"></span>
        </div>
      </div>

      <div class="notification-item unread">
        <div class="notification-icon success">
          <i class="fas fa-lightbulb"></i>
        </div>
        <div class="notification-details">
          <h4>Insight Strategis Terdeteksi</h4>
          <p>Bundle Energy Booster Pack berpotensi meningkatkan revenue Rp 850M</p>
          <span class="notification-time">30 menit yang lalu</span>
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
          <h4>Gap Nutrisi Kritis</h4>
          <p>Defisit lemak sehat 30% memerlukan tindakan segera untuk Q3</p>
          <span class="notification-time">1 jam yang lalu</span>
        </div>
        <div class="notification-status">
          <span class="unread-dot"></span>
        </div>
      </div>

      <div class="notification-item unread">
        <div class="notification-icon info">
          <i class="fas fa-chart-line"></i>
        </div>
        <div class="notification-details">
          <h4>Prediksi Trend Juli-Agustus</h4>
          <p>AI memprediksi kelelahan kronis akan mencapai puncak dengan demand protein +35%</p>
          <span class="notification-time">2 jam yang lalu</span>
        </div>
        <div class="notification-status">
          <span class="unread-dot"></span>
        </div>
      </div>

      <div class="notification-item read">
        <div class="notification-icon success">
          <i class="fas fa-brain"></i>
        </div>
        <div class="notification-details">
          <h4>AI Engine Update</h4>
          <p>Sistem AI telah diperbarui dengan algoritma analisis terbaru</p>
          <span class="notification-time">1 hari yang lalu</span>
        </div>
      </div>

      <div class="notification-item read">
        <div class="notification-icon info">
          <i class="fas fa-database"></i>
        </div>
        <div class="notification-details">
          <h4>Data Sync Completed</h4>
          <p>Sinkronisasi data dashboard dengan AI engine berhasil diselesaikan</p>
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

  <script src="./assets/js/ai-analysis.js"></script>
</body>

</html>