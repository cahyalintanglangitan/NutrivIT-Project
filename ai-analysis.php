<!DOCTYPE html>
<html lang="id">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>AI Business Analyst - NutrivIT</title>
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
          <h2><i class="fas fa-robot"></i> AI Business Analyst</h2>
          <p class="page-subtitle">Konsultasi cerdas berdasarkan data real-time NutrivIT untuk pengambilan keputusan strategis</p>
        </div>
        <div class="header-actions">
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
              <span>AI Business Analyst Online</span>
            </div>
            <div class="last-updated">
              <i class="fas fa-database"></i>
              <span>Terhubung ke database real-time NutrivIT</span>
            </div>
          </div>
          <div class="ai-logo">
            <i class="fas fa-chart-line"></i>
          </div>
        </div>

        <!-- Quick Insights from Database -->
        <div class="insights-grid">
          <div class="insight-card opportunity">
            <div class="insight-icon">
              <i class="fas fa-chart-line"></i>
            </div>
            <div class="insight-content">
              <h4>Revenue Growth</h4>
              <p>Analisis tren pendapatan bulanan menunjukkan pola pertumbuhan yang konsisten</p>
              <span class="insight-action">Tanyakan detail tren revenue</span>
            </div>
          </div>

          <div class="insight-card trending">
            <div class="insight-icon">
              <i class="fas fa-fire"></i>
            </div>
            <div class="insight-content">
              <h4>Produk Terlaris</h4>
              <p>Identifikasi produk dengan performa terbaik berdasarkan data penjualan real-time</p>
              <span class="insight-action">Analisis produk top performer</span>
            </div>
          </div>

          <div class="insight-card urgent">
            <div class="insight-icon">
              <i class="fas fa-exclamation-triangle"></i>
            </div>
            <div class="insight-content">
              <h4>Keluhan Pengguna</h4>
              <p>Pola keluhan terbanyak yang perlu mendapat perhatian segera</p>
              <span class="insight-action">Review keluhan terbanyak</span>
            </div>
          </div>

          <div class="insight-card prediction">
            <div class="insight-icon">
              <i class="fas fa-users"></i>
            </div>
            <div class="insight-content">
              <h4>Demografi Pengguna</h4>
              <p>Analisis segmentasi pengguna untuk strategi targeting yang lebih efektif</p>
              <span class="insight-action">Lihat profil pengguna</span>
            </div>
          </div>
        </div>

        <!-- Main AI Chat Interface -->
        <div class="ai-chat-container">
          <div class="chat-header">
            <div class="chat-title">
              <i class="fas fa-robot"></i>
              <h3>Konsultasi AI Business Analyst</h3>
            </div>
            <div class="chat-actions">
              <button class="btn-secondary" onclick="clearChat()">
                <i class="fas fa-broom"></i> Bersihkan Chat
              </button>
              <button class="btn-secondary" onclick="exportChat()">
                <i class="fas fa-download"></i> Export
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
                  Halo! Saya AI Business Analyst NutrivIT yang terhubung langsung dengan database perusahaan. 
                  Saya dapat membantu Anda menganalisis:
                  <br><br>
                  • <strong>Data Penjualan & Revenue</strong> - Tren, performa produk, analisis bulanan
                  <br>• <strong>Profil Pengguna</strong> - Demografi, perilaku, segmentasi
                  <br>• <strong>Keluhan & Feedback</strong> - Pola masalah, tingkat kepuasan
                  <br>• <strong>Performa Produk</strong> - Best sellers, review, rating
                  <br>• <strong>Insight Strategis</strong> - Peluang bisnis, rekomendasi
                  <br><br>
                  Semua analisis berdasarkan data real-time dari database. Apa yang ingin Anda ketahui?
                </div>
                <div class="message-time">
                  <span id="welcome-time"></span>
                </div>
              </div>
            </div>
          </div>

          <div class="chat-input-container">
            <div class="quick-questions">
              <span class="quick-label">Pertanyaan Cepat Berdasarkan Data:</span>
              <div class="quick-buttons">
                <button class="quick-btn" onclick="askQuickQuestion('revenue-analysis')">
                  <i class="fas fa-chart-line"></i> Analisis Revenue 2025
                </button>
                <button class="quick-btn" onclick="askQuickQuestion('top-products')">
                  <i class="fas fa-trophy"></i> Produk Terlaris
                </button>
                <button class="quick-btn" onclick="askQuickQuestion('user-complaints')">
                  <i class="fas fa-exclamation-circle"></i> Keluhan Terbanyak
                </button>
                <button class="quick-btn" onclick="askQuickQuestion('user-demographics')">
                  <i class="fas fa-users"></i> Profil Pengguna
                </button>
                <button class="quick-btn" onclick="askQuickQuestion('nutrition-insights')">
                  <i class="fas fa-heartbeat"></i> Insight Nutrisi
                </button>
                <button class="quick-btn" onclick="askQuickQuestion('business-opportunities')">
                  <i class="fas fa-lightbulb"></i> Peluang Bisnis
                </button>
              </div>
            </div>

            <div class="input-box">
              <textarea id="user-input"
                placeholder="Tanyakan tentang data bisnis NutrivIT: revenue, produk, pengguna, keluhan, nutrisi, atau minta rekomendasi strategis berdasarkan data..."
                rows="3"></textarea>
              <button class="send-btn" onclick="sendMessage()" id="send-btn">
                <i class="fas fa-paper-plane"></i>
              </button>
            </div>
          </div>
        </div>

        <!-- Data Sources Panel -->
        <div class="data-sources">
          <h3><i class="fas fa-database"></i> Sumber Data Real-Time</h3>
          <div class="sources-grid">
            <div class="source-item">
              <div class="source-icon">
                <i class="fas fa-users"></i>
              </div>
              <div class="source-info">
                <h4>Database Pengguna</h4>
                <p>Data lengkap profil & aktivitas</p>
                <span class="source-status active">Live</span>
              </div>
            </div>

            <div class="source-item">
              <div class="source-icon">
                <i class="fas fa-shopping-cart"></i>
              </div>
              <div class="source-info">
                <h4>Transaksi & Orders</h4>
                <p>Real-time sales data</p>
                <span class="source-status active">Live</span>
              </div>
            </div>

            <div class="source-item">
              <div class="source-icon">
                <i class="fas fa-box"></i>
              </div>
              <div class="source-info">
                <h4>Katalog Produk</h4>
                <p>Inventory & performance</p>
                <span class="source-status active">Live</span>
              </div>
            </div>

            <div class="source-item">
              <div class="source-icon">
                <i class="fas fa-comments"></i>
              </div>
              <div class="source-info">
                <h4>Keluhan & Review</h4>
                <p>Customer feedback</p>
                <span class="source-status active">Live</span>
              </div>
            </div>

            <div class="source-item">
              <div class="source-icon">
                <i class="fas fa-heartbeat"></i>
              </div>
              <div class="source-info">
                <h4>Data Nutrisi</h4>
                <p>Achievement & goals</p>
                <span class="source-status active">Live</span>
              </div>
            </div>

            <div class="source-item">
              <div class="source-icon">
                <i class="fas fa-robot"></i>
              </div>
              <div class="source-info">
                <h4>AI Consultations</h4>
                <p>User interaction data</p>
                <span class="source-status active">Live</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script src="./assets/js/ai-analysis.js"></script>
</body>

</html>
