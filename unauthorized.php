<!DOCTYPE html>
<html lang="id">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Unauthorized Access - NutrivIT</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="/assets/css/unauthorized.css" />
</head>

<body>
  <div class="unauthorized-container">
    <!-- Background Animation -->
    <div class="background-animation">
      <div class="floating-shape shape-1"></div>
      <div class="floating-shape shape-2"></div>
      <div class="floating-shape shape-3"></div>
      <div class="floating-shape shape-4"></div>
      <div class="floating-shape shape-5"></div>
    </div>

    <!-- Main Content -->
    <div class="unauthorized-content">
      <!-- Logo Section -->
      <div class="logo-section">
        <div class="logo-container">
          <i class="fas fa-leaf logo-icon"></i>
          <h1 class="logo-text">NutriVit</h1>
        </div>
        <p class="logo-subtitle">Management System</p>
      </div>

      <!-- Error Section -->
      <div class="error-section">
        <div class="error-icon-container">
          <div class="error-icon-bg">
            <i class="fas fa-shield-alt error-icon"></i>
          </div>
          <div class="warning-badge">
            <i class="fas fa-exclamation-triangle"></i>
          </div>
        </div>

        <div class="error-content">
          <h2 class="error-title">Akses Tidak Diizinkan</h2>
          <h3 class="error-subtitle">Unauthorized Access Detected</h3>

          <div class="error-message">
            <p class="primary-message">
              Maaf, Anda tidak memiliki izin untuk mengakses halaman ini.
            </p>
            <p class="secondary-message">
              Sistem telah mendeteksi upaya akses yang tidak sah. Jika Anda merasa ini adalah kesalahan,
              silakan hubungi administrator sistem.
            </p>
          </div>

          <!-- Error Details -->
          <div class="error-details">
            <div class="detail-item">
              <i class="fas fa-clock detail-icon"></i>
              <div class="detail-content">
                <span class="detail-label">Waktu:</span>
                <span class="detail-value" id="error-time"></span>
              </div>
            </div>
            <div class="detail-item">
              <i class="fas fa-globe detail-icon"></i>
              <div class="detail-content">
                <span class="detail-label">IP Address:</span>
                <span class="detail-value" id="user-ip">Loading...</span>
              </div>
            </div>
            <div class="detail-item">
              <i class="fas fa-code detail-icon"></i>
              <div class="detail-content">
                <span class="detail-label">Error Code:</span>
                <span class="detail-value">403 - FORBIDDEN</span>
              </div>
            </div>
            <div class="detail-item">
              <i class="fas fa-link detail-icon"></i>
              <div class="detail-content">
                <span class="detail-label">Requested URL:</span>
                <span class="detail-value" id="requested-url"></span>
              </div>
            </div>
          </div>

          <!-- Security Notice -->
          <div class="security-notice">
            <div class="notice-header">
              <i class="fas fa-info-circle notice-icon"></i>
              <h4>Pemberitahuan Keamanan</h4>
            </div>
            <ul class="notice-list">
              <li>Aktivitas ini telah dicatat dalam log sistem</li>
              <li>Administrator telah diberitahu tentang upaya akses ini</li>
              <li>Akses berulang tanpa izin dapat mengakibatkan pemblokiran IP</li>
            </ul>
          </div>

          <!-- Action Buttons -->
          <div class="action-buttons">
            <button class="btn-primary" onclick="goToLogin()">
              <i class="fas fa-sign-in-alt"></i>
              Login Ulang
            </button>
            <button class="btn-secondary" onclick="goToDashboard()">
              <i class="fas fa-home"></i>
              Kembali ke Dashboard
            </button>
            <button class="btn-tertiary" onclick="contactSupport()">
              <i class="fas fa-headset"></i>
              Hubungi Support
            </button>
          </div>

          <!-- Countdown Timer -->
          <div class="countdown-section">
            <p class="countdown-text">
              Anda akan diarahkan ke halaman login dalam
              <span class="countdown-timer" id="countdown">30</span> detik
            </p>
            <div class="countdown-progress">
              <div class="progress-bar" id="progress-bar"></div>
            </div>
          </div>
        </div>
      </div>

      <!-- Footer -->
      <div class="unauthorized-footer">
        <p>&copy; 2024 NutrivIT Management System. All rights reserved.</p>
        <div class="footer-links">
          <a href="#" onclick="showPrivacyPolicy()">Privacy Policy</a>
          <span class="separator">|</span>
          <a href="#" onclick="showTerms()">Terms of Service</a>
          <span class="separator">|</span>
          <a href="#" onclick="contactSupport()">Support</a>
        </div>
      </div>
    </div>

    <!-- Modal for Support Contact -->
    <div class="modal-overlay" id="supportModal">
      <div class="modal-content">
        <div class="modal-header">
          <h3><i class="fas fa-headset"></i> Hubungi Support</h3>
          <button class="modal-close" onclick="closeSupportModal()">
            <i class="fas fa-times"></i>
          </button>
        </div>
        <div class="modal-body">
          <div class="support-options">
            <div class="support-option">
              <div class="support-icon">
                <i class="fas fa-envelope"></i>
              </div>
              <div class="support-details">
                <h4>Email Support</h4>
                <p>support@nutrivit.com</p>
                <small>Response time: 2-4 hours</small>
              </div>
            </div>
            <div class="support-option">
              <div class="support-icon">
                <i class="fas fa-phone"></i>
              </div>
              <div class="support-details">
                <h4>Phone Support</h4>
                <p>+62 21 1234-5678</p>
                <small>Available: Mon-Fri 9AM-6PM</small>
              </div>
            </div>
            <div class="support-option">
              <div class="support-icon">
                <i class="fas fa-comments"></i>
              </div>
              <div class="support-details">
                <h4>Live Chat</h4>
                <p>Available 24/7</p>
                <small>Average response: 5 minutes</small>
              </div>
            </div>
          </div>
          <div class="quick-report">
            <h4>Laporkan Masalah Ini</h4>
            <textarea placeholder="Jelaskan apa yang sedang Anda coba lakukan ketika error ini terjadi..."
              rows="4"></textarea>
            <button class="btn-primary" onclick="submitReport()">
              <i class="fas fa-paper-plane"></i>
              Kirim Laporan
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script>
    // Set error time
    document.getElementById('error-time').textContent = new Date().toLocaleString('id-ID', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit'
    });

    // Set requested URL
    document.getElementById('requested-url').textContent = window.location.href;

    // Get user IP (using a free service)
    fetch('https://api.ipify.org?format=json')
      .then(response => response.json())
      .then(data => {
        document.getElementById('user-ip').textContent = data.ip;
      })
      .catch(() => {
        document.getElementById('user-ip').textContent = 'Unable to detect';
      });

    // Countdown timer
    let countdown = 30;
    const countdownElement = document.getElementById('countdown');
    const progressBar = document.getElementById('progress-bar');

    function updateCountdown() {
      countdownElement.textContent = countdown;
      const progress = ((30 - countdown) / 30) * 100;
      progressBar.style.width = progress + '%';

      if (countdown <= 0) {
        goToLogin();
      } else {
        countdown--;
        setTimeout(updateCountdown, 1000);
      }
    }

    // Start countdown
    updateCountdown();

    // Navigation functions
    function goToLogin() {
      // Clear any existing auth
      localStorage.removeItem('auth');
      sessionStorage.clear();
      window.location.href = 'login.php';
    }

    function goToDashboard() {
      // Check if user has valid auth
      if (localStorage.getItem('auth')) {
        window.location.href = 'dashboard.php';
      } else {
        goToLogin();
      }
    }

    function contactSupport() {
      document.getElementById('supportModal').classList.add('active');
    }

    function closeSupportModal() {
      document.getElementById('supportModal').classList.remove('active');
    }

    function submitReport() {
      const textarea = document.querySelector('.quick-report textarea');
      const report = textarea.value.trim();

      if (report) {
        // Here you would typically send the report to your backend
        alert('Laporan berhasil dikirim. Tim support akan menghubungi Anda segera.');
        closeSupportModal();
      } else {
        alert('Mohon jelaskan masalah yang Anda alami.');
      }
    }

    function showPrivacyPolicy() {
      alert('Privacy Policy akan ditampilkan di sini.');
    }

    function showTerms() {
      alert('Terms of Service akan ditampilkan di sini.');
    }

    // Log unauthorized access attempt
    function logUnauthorizedAccess() {
      const logData = {
        timestamp: new Date().toISOString(),
        url: window.location.href,
        referrer: document.referrer,
        userAgent: navigator.userAgent,
        type: 'unauthorized_access'
      };

      // Here you would typically send this to your backend logging system
      console.warn('Unauthorized access attempt logged:', logData);
    }

    // Log the access attempt
    logUnauthorizedAccess();

    // Prevent back button
    history.pushState(null, null, location.href);
    window.onpopstate = function () {
      history.go(1);
    };

    // Disable right-click context menu
    document.addEventListener('contextmenu', function (e) {
      e.preventDefault();
    });

    // Disable F12, Ctrl+Shift+I, Ctrl+U
    document.addEventListener('keydown', function (e) {
      if (e.key === 'F12' ||
        (e.ctrlKey && e.shiftKey && e.key === 'I') ||
        (e.ctrlKey && e.key === 'u')) {
        e.preventDefault();
      }
    });

    setTimeout(() => {
      document.body.classList.add('loaded');
    }, 500);
  </script>
</body>

</html>