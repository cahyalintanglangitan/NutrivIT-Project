<!DOCTYPE html>
<html lang="id">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Profile & Settings - NutrivIT</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="./assets/css/profile.css" />
</head>

<body>
  <div class="dashboard-container">
    <!-- Sidebar -->
    <?php include 'bar/navbar.php'; ?>  

    <!-- Main Content -->
    <div class="main-content">
      <header class="main-header">
        <div class="header-left">
          <h2 id="page-title">Profile & Settings</h2>
          <p class="page-subtitle">Kelola profil dan pengaturan sistem NutrivIT</p>
        </div>
        <div class="header-actions">
          <div class="notification-bell">
            <i class="fas fa-bell"></i>
            <span class="notification-badge">3</span>
          </div>
          <span class="date">
            <i class="fas fa-calendar-alt"></i>
            <span id="current-date"></span>
          </span>
        </div>
      </header>

      <!-- Profile & Settings Content -->
      <div class="content-section active">
        <!-- Profile Section -->
        <div class="profile-section">
          <div class="profile-header">
            <div class="profile-banner">
              <div class="banner-overlay"></div>
              <div class="profile-info">
                <div class="profile-avatar-large">
                  <i class="fas fa-user"></i>
                  <div class="avatar-upload">
                    <i class="fas fa-camera"></i>
                  </div>
                </div>
                <div class="profile-details">
                  <h2>Yanto Kusyanto Nuryanto</h2>
                  <p>NutrivIT Manager</p>
                </div>
              </div>
            </div>
          </div>

          <!-- Tab Navigation -->
          <div class="tab-navigation">
            <button class="tab-btn active" data-tab="profile">
              <i class="fas fa-user"></i> Profil
            </button>
            <button class="tab-btn" data-tab="security">
              <i class="fas fa-shield-alt"></i> Keamanan
            </button>
            <button class="tab-btn" data-tab="system">
              <i class="fas fa-cogs"></i> Pengaturan Sistem
            </button>
            <button class="tab-btn" data-tab="notifications">
              <i class="fas fa-bell"></i> Notifikasi
            </button>
          </div>

          <!-- Tab Contents -->
          <div class="tab-content">
            <!-- Profile Tab -->
            <div class="tab-pane active" id="profile">
              <div class="settings-grid">
                <div class="settings-card">
                  <div class="settings-header">
                    <h4><i class="fas fa-user-edit"></i> Informasi Personal</h4>
                  </div>
                  <div class="settings-form">
                    <div class="form-row">
                      <div class="form-group">
                        <label for="fullName">
                          <i class="fas fa-user"></i> Nama Lengkap
                        </label>
                        <input type="text" id="fullName" placeholder="Yanto Kusyanto Nuryanto" />
                      </div>
                    </div>
                    <div class="form-row">
                      <div class="form-group">
                        <label for="email">
                          <i class="fas fa-envelope"></i> Email
                        </label>
                        <input type="email" id="email" placeholder="manager@nutrivit.com" />
                      </div>
                      <div class="form-group">
                        <label for="phone">
                          <i class="fas fa-phone"></i> Nomor Telepon
                        </label>
                        <input type="tel" id="phone" placeholder="+62 812-3456-7890" />
                      </div>
                    </div>
                    <div class="form-actions">
                      <button class="btn-primary">
                        <i class="fas fa-save"></i> Simpan Perubahan
                      </button>
                      <button class="btn-secondary">
                        <i class="fas fa-undo"></i> Reset
                      </button>
                    </div>
                  </div>
                </div>

                <div class="settings-card">
                  <div class="settings-header">
                    <h4><i class="fas fa-briefcase"></i> Informasi Pekerjaan</h4>
                  </div>
                  <div class="settings-form">
                    <div class="form-group">
                      <label for="position">
                        <i class="fas fa-id-badge"></i> Posisi
                      </label>
                      <input type="text" id="position" placeholder="NutrivIT Manager" />
                    </div>
                    <div class="form-group">
                      <label for="department">
                        <i class="fas fa-building"></i> Departemen
                      </label>
                      <select id="department">
                        <option value="it">IT & Technology</option>
                        <option value="management">Management</option>
                        <option value="operations">Operations</option>
                      </select>
                    </div>
                    <div class="form-row">
                      <div class="form-group">
                        <label for="joinDate">
                          <i class="fas fa-calendar"></i> Tanggal Bergabung
                        </label>
                        <input type="date" id="joinDate" value="2022-01-15" />
                      </div>
                      <div class="form-group">
                        <label for="employeeId">
                          <i class="fas fa-id-card"></i> ID Karyawan
                        </label>
                        <input type="text" id="employeeId" value="NTV-001" readonly />
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Security Tab -->
            <div class="tab-pane" id="security">
              <div class="settings-grid">
                <div class="settings-card">
                  <div class="settings-header">
                    <h4><i class="fas fa-key"></i> Ubah Password</h4>
                  </div>
                  <div class="settings-form">
                    <div class="form-group">
                      <label for="currentPassword">
                        <i class="fas fa-lock"></i> Password Saat Ini
                      </label>
                      <input type="password" id="currentPassword" placeholder="Masukkan password saat ini" />
                    </div>
                    <div class="form-row">
                      <div class="form-group">
                        <label for="newPassword">
                          <i class="fas fa-key"></i> Password Baru
                        </label>
                        <input type="password" id="newPassword" placeholder="Masukkan password baru" />
                      </div>
                      <div class="form-group">
                        <label for="confirmPassword">
                          <i class="fas fa-check"></i> Konfirmasi Password
                        </label>
                        <input type="password" id="confirmPassword" placeholder="Konfirmasi password baru" />
                      </div>
                    </div>
                    <div class="password-requirements">
                      <h5>Persyaratan Password:</h5>
                      <ul>
                        <li><i class="fas fa-check"></i> Minimal 8 karakter</li>
                        <li><i class="fas fa-check"></i> Mengandung huruf besar dan kecil</li>
                        <li><i class="fas fa-check"></i> Mengandung angka</li>
                        <li><i class="fas fa-check"></i> Mengandung karakter khusus</li>
                      </ul>
                    </div>
                    <div class="form-actions">
                      <button class="btn-primary">
                        <i class="fas fa-save"></i> Ubah Password
                      </button>
                    </div>
                  </div>
                </div>

                <div class="settings-card">
                  <div class="settings-header">
                    <h4><i class="fas fa-shield-alt"></i> Keamanan Akun</h4>
                  </div>
                  <div class="settings-form">
                    <div class="security-option">
                      <div class="option-info">
                        <h5><i class="fas fa-mobile-alt"></i> Two-Factor Authentication</h5>
                        <p>Tambahkan lapisan keamanan ekstra untuk akun Anda</p>
                      </div>
                      <label class="toggle-switch">
                        <input type="checkbox" checked>
                        <span class="toggle-slider"></span>
                      </label>
                    </div>
                    <div class="security-option">
                      <div class="option-info">
                        <h5><i class="fas fa-envelope"></i> Email Notifications</h5>
                        <p>Terima notifikasi email untuk aktivitas login</p>
                      </div>
                      <label class="toggle-switch">
                        <input type="checkbox" checked>
                        <span class="toggle-slider"></span>
                      </label>
                    </div>
                    <div class="security-option">
                      <div class="option-info">
                        <h5><i class="fas fa-clock"></i> Session Timeout</h5>
                        <p>Logout otomatis setelah tidak aktif</p>
                      </div>
                      <select class="security-select">
                        <option value="30">30 menit</option>
                        <option value="60" selected>1 jam</option>
                        <option value="120">2 jam</option>
                        <option value="240">4 jam</option>
                      </select>
                    </div>
                  </div>
                </div>

                <div class="settings-card">
                  <div class="settings-header">
                    <h4><i class="fas fa-history"></i> Aktivitas Login</h4>
                  </div>
                  <div class="activity-list">
                    <div class="activity-item">
                      <div class="activity-icon success">
                        <i class="fas fa-check"></i>
                      </div>
                      <div class="activity-details">
                        <h5>Login Berhasil</h5>
                        <p>Chrome on Windows • Jakarta, Indonesia</p>
                        <span class="activity-time">2 jam yang lalu</span>
                      </div>
                    </div>
                    <div class="activity-item">
                      <div class="activity-icon success">
                        <i class="fas fa-check"></i>
                      </div>
                      <div class="activity-details">
                        <h5>Login Berhasil</h5>
                        <p>Mobile App • Jakarta, Indonesia</p>
                        <span class="activity-time">1 hari yang lalu</span>
                      </div>
                    </div>
                    <div class="activity-item">
                      <div class="activity-icon warning">
                        <i class="fas fa-exclamation"></i>
                      </div>
                      <div class="activity-details">
                        <h5>Login Gagal</h5>
                        <p>Chrome on Windows • Jakarta, Indonesia</p>
                        <span class="activity-time">3 hari yang lalu</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- System Settings Tab -->
            <div class="tab-pane" id="system">
              <div class="settings-grid">
                <div class="settings-card">
                  <div class="settings-header">
                    <h4><i class="fas fa-cogs"></i> Pengaturan Umum</h4>
                  </div>
                  <div class="settings-form">
                    <div class="form-row">
                      <div class="form-group">
                        <label for="timezone">
                          <i class="fas fa-clock"></i> Timezone
                        </label>
                        <select id="timezone">
                          <option value="Asia/Jakarta" selected>Asia/Jakarta (WIB)</option>
                          <option value="Asia/Makassar">Asia/Makassar (WITA)</option>
                          <option value="Asia/Jayapura">Asia/Jayapura (WIT)</option>
                        </select>
                      </div>
                      <div class="form-group">
                        <label for="language">
                          <i class="fas fa-language"></i> Bahasa
                        </label>
                        <select id="language">
                          <option value="id" selected>Bahasa Indonesia</option>
                          <option value="en">English</option>
                        </select>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="settings-card">
                  <div class="settings-header">
                    <h4><i class="fas fa-database"></i> Pengaturan Database</h4>
                  </div>
                  <div class="settings-form">
                    <div class="system-option">
                      <div class="option-info">
                        <h5><i class="fas fa-save"></i> Auto Backup</h5>
                        <p>Backup otomatis database setiap hari</p>
                      </div>
                      <label class="toggle-switch">
                        <input type="checkbox" checked>
                        <span class="toggle-slider"></span>
                      </label>
                    </div>
                    <div class="system-option">
                      <div class="option-info">
                        <h5><i class="fas fa-trash"></i> Auto Cleanup</h5>
                        <p>Hapus data lama secara otomatis</p>
                      </div>
                      <label class="toggle-switch">
                        <input type="checkbox">
                        <span class="toggle-slider"></span>
                      </label>
                    </div>
                    <div class="form-group">
                      <label for="backupTime">
                        <i class="fas fa-clock"></i> Waktu Backup
                      </label>
                      <input type="time" id="backupTime" value="02:00" />
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Notifications Tab -->
            <div class="tab-pane" id="notifications">
              <div class="settings-grid">
                <div class="settings-card">
                  <div class="settings-header">
                    <h4><i class="fas fa-bell"></i> Preferensi Notifikasi</h4>
                  </div>
                  <div class="settings-form">
                    <div class="notification-category">
                      <h5><i class="fas fa-box"></i> Product Management</h5>
                      <div class="notification-options">
                        <div class="notification-option">
                          <span>Stok produk menipis</span>
                          <div class="notification-toggles">
                            <label class="toggle-switch small">
                              <input type="checkbox" checked>
                              <span class="toggle-slider"></span>
                            </label>
                            <span class="toggle-label">Email</span>
                            <label class="toggle-switch small">
                              <input type="checkbox" checked>
                              <span class="toggle-slider"></span>
                            </label>
                            <span class="toggle-label">Push</span>
                          </div>
                        </div>
                        <div class="notification-option">
                          <span>Produk baru ditambahkan</span>
                          <div class="notification-toggles">
                            <label class="toggle-switch small">
                              <input type="checkbox">
                              <span class="toggle-slider"></span>
                            </label>
                            <span class="toggle-label">Email</span>
                            <label class="toggle-switch small">
                              <input type="checkbox" checked>
                              <span class="toggle-slider"></span>
                            </label>
                            <span class="toggle-label">Push</span>
                          </div>
                        </div>
                      </div>
                    </div>

                    <div class="notification-category">
                      <h5><i class="fas fa-exclamation-triangle"></i> System Alerts</h5>
                      <div class="notification-options">
                        <div class="notification-option">
                          <span>Error sistem</span>
                          <div class="notification-toggles">
                            <label class="toggle-switch small">
                              <input type="checkbox" checked>
                              <span class="toggle-slider"></span>
                            </label>
                            <span class="toggle-label">Email</span>
                            <label class="toggle-switch small">
                              <input type="checkbox" checked>
                              <span class="toggle-slider"></span>
                            </label>
                            <span class="toggle-label">Push</span>
                          </div>
                        </div>
                        <div class="notification-option">
                          <span>Backup berhasil</span>
                          <div class="notification-toggles">
                            <label class="toggle-switch small">
                              <input type="checkbox">
                              <span class="toggle-slider"></span>
                            </label>
                            <span class="toggle-label">Email</span>
                            <label class="toggle-switch small">
                              <input type="checkbox">
                              <span class="toggle-slider"></span>
                            </label>
                            <span class="toggle-label">Push</span>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="settings-card">
                  <div class="settings-header">
                    <h4><i class="fas fa-clock"></i> Jadwal Notifikasi</h4>
                  </div>
                  <div class="settings-form">
                    <div class="form-row">
                      <div class="form-group">
                        <label for="quietStart">
                          <i class="fas fa-moon"></i> Mulai Quiet Hours
                        </label>
                        <input type="time" id="quietStart" value="22:00" />
                      </div>
                      <div class="form-group">
                        <label for="quietEnd">
                          <i class="fas fa-sun"></i> Akhir Quiet Hours
                        </label>
                        <input type="time" id="quietEnd" value="07:00" />
                      </div>
                    </div>
                    <div class="system-option">
                      <div class="option-info">
                        <h5><i class="fas fa-calendar-week"></i> Weekend Notifications</h5>
                        <p>Terima notifikasi di akhir pekan</p>
                      </div>
                      <label class="toggle-switch">
                        <input type="checkbox">
                        <span class="toggle-slider"></span>
                      </label>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script>
    // Profile functionality
    function handleProfile() {
      // Already on profile page, do nothing or refresh
      window.location.reload();
    }

    // Check authentication
    if (!localStorage.getItem("auth")) {
      window.location.href = "login.php";
    }

    // Set current date
    document.getElementById('current-date').textContent = new Date().toLocaleDateString('id-ID', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });

    // Tab functionality
    document.addEventListener('DOMContentLoaded', function () {
      const tabBtns = document.querySelectorAll('.tab-btn');
      const tabPanes = document.querySelectorAll('.tab-pane');

      tabBtns.forEach(btn => {
        btn.addEventListener('click', function () {
          const targetTab = this.getAttribute('data-tab');

          // Remove active class from all tabs and panes
          tabBtns.forEach(b => b.classList.remove('active'));
          tabPanes.forEach(p => p.classList.remove('active'));

          // Add active class to clicked tab and corresponding pane
          this.classList.add('active');
          document.getElementById(targetTab).classList.add('active');
        });
      });

      // Form submission handlers
      const forms = document.querySelectorAll('.settings-form');
      forms.forEach(form => {
        const saveBtn = form.querySelector('.btn-primary');
        if (saveBtn) {
          saveBtn.addEventListener('click', function (e) {
            e.preventDefault();
            // Show success message
            showNotification('Pengaturan berhasil disimpan!', 'success');
          });
        }
      });
    });

    // Notification function
    function showNotification(message, type = 'success') {
      const notification = document.createElement('div');
      notification.className = `notification ${type}`;
      notification.innerHTML = `
        <i class="fas ${type === 'success' ? 'fa-check-circle' : 'fa-exclamation-circle'}"></i>
        <span>${message}</span>
      `;

      document.body.appendChild(notification);

      setTimeout(() => {
        notification.classList.add('show');
      }, 100);

      setTimeout(() => {
        notification.classList.remove('show');
        setTimeout(() => {
          document.body.removeChild(notification);
        }, 300);
      }, 3000);
    }

    // Avatar upload functionality
    document.querySelector('.avatar-upload').addEventListener('click', function () {
      const input = document.createElement('input');
      input.type = 'file';
      input.accept = 'image/*';
      input.onchange = function (e) {
        const file = e.target.files[0];
        if (file) {
          const reader = new FileReader();
          reader.onload = function (e) {
            // Here you would typically upload the image to server
            showNotification('Foto profil berhasil diupdate!', 'success');
          };
          reader.readAsDataURL(file);
        }
      };
      input.click();
    });
  </script>
</body>

</html>