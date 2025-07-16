<?php
// Mulai session di paling atas
session_start();

// Sertakan koneksi
require 'koneksi.php';

// Cek apakah manager sudah login, jika tidak, redirect ke halaman login
if (!isset($_SESSION['manager_id'])) {
  header('Location: login.php');
  exit;
}

// Ambil ID manager dari session
$manager_id = $_SESSION['manager_id'];
$updateMessage = '';
$passwordMessage = '';
$photoMessage = '';
$passwordError = false;
$photoError = false;

// --- LOGIKA UNTUK UPLOAD FOTO ---
if (isset($_FILES['profile_picture']) && $_FILES['profile_picture']['error'] == 0) {
  // UBAH BARIS DI BAWAH INI
  $uploadDir = 'assets/images/'; // Disesuaikan dengan folder Anda

  // Cek apakah direktori ada, jika tidak, coba buat.
  if (!is_dir($uploadDir)) {
    if (!mkdir($uploadDir, 0777, true)) {
      $photoMessage = "KRITIS: Gagal membuat direktori unggahan.";
      $photoError = true;
      goto end_photo_logic;
    }
  }

  $allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
  $maxSize = 2 * 1024 * 1024; // 2 MB

  $fileType = mime_content_type($_FILES['profile_picture']['tmp_name']);
  $fileSize = $_FILES['profile_picture']['size'];

  if (in_array($fileType, $allowedTypes)) {
    if ($fileSize <= $maxSize) {
      // Hapus foto lama jika ada
      $stmt = $conn->prepare("SELECT photo_url FROM manager WHERE id_manager = ?");
      $stmt->bind_param("i", $manager_id);
      $stmt->execute();
      $res = $stmt->get_result();
      $oldData = $res->fetch_assoc();
      if (!empty($oldData['photo_url']) && file_exists($oldData['photo_url'])) {
        unlink($oldData['photo_url']);
      }
      $stmt->close();

      // Buat nama file baru yang unik
      $fileExtension = pathinfo($_FILES['profile_picture']['name'], PATHINFO_EXTENSION);
      $newFileName = $uploadDir . 'manager_' . $manager_id . '_' . time() . '.' . $fileExtension;

      if (move_uploaded_file($_FILES['profile_picture']['tmp_name'], $newFileName)) {
        // Update path foto di database
        $stmt = $conn->prepare("UPDATE manager SET photo_url = ? WHERE id_manager = ?");
        $stmt->bind_param("si", $newFileName, $manager_id);
        if ($stmt->execute()) {
          $photoMessage = "Foto profil berhasil diperbarui.";
        } else {
          $photoMessage = "Gagal menyimpan path foto ke database.";
          $photoError = true;
        }
        $stmt->close();
      } else {
        $photoMessage = "Gagal memindahkan file. Pastikan folder tujuan dapat ditulis (writable).";
        $photoError = true;
      }
    } else {
      $photoMessage = "Ukuran file terlalu besar. Maksimal 2MB.";
      $photoError = true;
    }
  } else {
    $photoMessage = "Tipe file tidak valid. Hanya JPG, PNG, dan GIF yang diizinkan.";
    $photoError = true;
  }

  end_photo_logic: // Label tujuan untuk goto
}

// --- LOGIKA UNTUK UPDATE PROFIL ---
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'update_profile') {
  // ... (Logika update profil tetap sama) ...
  $fullName = $_POST['fullName'];
  $email = $_POST['email'];
  $phone = $_POST['phone'];
  $joinDate = $_POST['joinDate'];
  $employeeId = $_POST['employeeId'];

  $stmt = $conn->prepare("UPDATE manager SET nama_manager = ?, email_manager = ?, no_telp = ?, date_joined = ?, id_karyawan = ? WHERE id_manager = ?");
  $stmt->bind_param("sssssi", $fullName, $email, $phone, $joinDate, $employeeId, $manager_id);
  if ($stmt->execute()) {
    $updateMessage = 'Profil berhasil diperbarui!';
  } else {
    $updateMessage = 'Gagal memperbarui profil: ' . $conn->error;
  }
  $stmt->close();
}

// --- LOGIKA UNTUK UBAH PASSWORD ---
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'change_password') {
  // ... (Logika ubah password tetap sama) ...
  $currentPassword = $_POST['currentPassword'];
  $newPassword = $_POST['newPassword'];
  $confirmPassword = $_POST['confirmPassword'];

  $stmt = $conn->prepare("SELECT password FROM manager WHERE id_manager = ?");
  $stmt->bind_param("i", $manager_id);
  $stmt->execute();
  $result = $stmt->get_result();
  $managerData = $result->fetch_assoc();
  $stmt->close();

  if (password_verify($currentPassword, $managerData['password'])) {
    if ($newPassword === $confirmPassword) {
      if (strlen($newPassword) >= 8) {
        $newHashedPassword = password_hash($newPassword, PASSWORD_DEFAULT);
        $updateStmt = $conn->prepare("UPDATE manager SET password = ? WHERE id_manager = ?");
        $updateStmt->bind_param("si", $newHashedPassword, $manager_id);
        if ($updateStmt->execute()) {
          $passwordMessage = 'Password berhasil diubah!';
          $passwordError = false;
        } else {
          $passwordMessage = 'Gagal mengubah password.';
          $passwordError = true;
        }
        $updateStmt->close();
      } else {
        $passwordMessage = 'Password baru harus minimal 8 karakter.';
        $passwordError = true;
      }
    } else {
      $passwordMessage = 'Konfirmasi password baru tidak cocok.';
      $passwordError = true;
    }
  } else {
    $passwordMessage = 'Password saat ini salah.';
    $passwordError = true;
  }
}

// --- Ambil data terbaru dari DB untuk ditampilkan ---
$stmt = $conn->prepare("SELECT * FROM manager WHERE id_manager = ?");
$stmt->bind_param("i", $manager_id);
$stmt->execute();
$result = $stmt->get_result();
$manager = $result->fetch_assoc();
$stmt->close();
$conn->close();

// Tentukan path gambar profil
$profilePicture = (!empty($manager['photo_url']) && file_exists($manager['photo_url']))
  ? $manager['photo_url']
  : 'assets/images/default-avatar.png'; // Pastikan Anda punya gambar default ini

?>
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
    <?php include 'bar/navbar.php'; ?>

    <div class="main-content">
      <header class="main-header">
        <div class="header-left">
          <h2 id="page-title">Profile & Settings</h2>
          <p class="page-subtitle">Kelola profil dan pengaturan sistem NutrivIT</p>
        </div>
        <div class="header-actions">
          <span class="date">
            <i class="fas fa-calendar-alt"></i>
            <span id="current-date"></span>
          </span>
        </div>
      </header>

      <div class="content-section active">
        <div class="profile-section">
          <div class="profile-header">
            <div class="profile-banner">
              <div class="banner-overlay"></div>
              <div class="profile-info">
                <form id="photoForm" method="POST" enctype="multipart/form-data" action="profile.php" style="position: relative;">
                  <div class="profile-avatar-large">
                    <img src="<?php echo htmlspecialchars($profilePicture); ?>" alt="Profile Picture" id="avatarImage" />
                    <div class="avatar-upload" onclick="document.getElementById('profile_picture').click();">
                      <i class="fas fa-camera"></i>
                    </div>
                  </div>
                  <input type="file" name="profile_picture" id="profile_picture" style="display: none;" onchange="document.getElementById('photoForm').submit();">
                </form>
                <div class="profile-details">
                  <h2><?php echo htmlspecialchars($manager['nama_manager']); ?></h2>
                  <p>NutrivIT Manager</p>
                  <?php if (!empty($photoMessage)): ?>
                    <p style="color: <?php echo $photoError ? 'red' : 'green'; ?>; font-size: 14px;"><?php echo $photoMessage; ?></p>
                  <?php endif; ?>
                </div>
              </div>
            </div>
          </div>

          <div class="tab-navigation">
            <button class="tab-btn active" data-tab="profile"><i class="fas fa-user"></i> Profil</button>
            <button class="tab-btn" data-tab="security"><i class="fas fa-shield-alt"></i> Keamanan</button>
            <button class="tab-btn" data-tab="system"><i class="fas fa-cogs"></i> Pengaturan Sistem</button>
          </div>

          <div class="tab-content">
            <div class="tab-pane active" id="profile">
              <div class="settings-grid">
                <div class="settings-card">
                  <div class="settings-header">
                    <h4><i class="fas fa-user-edit"></i> Informasi Personal</h4>
                    <?php if (!empty($updateMessage)): ?>
                      <p style="color: green;"><?php echo $updateMessage; ?></p>
                    <?php endif; ?>
                  </div>
                  <form class="settings-form" method="POST" action="profile.php">
                    <input type="hidden" name="action" value="update_profile">
                    <div class="form-row">
                      <div class="form-group">
                        <label for="fullName"><i class="fas fa-user"></i> Nama Lengkap</label>
                        <input type="text" id="fullName" name="fullName" value="<?php echo htmlspecialchars($manager['nama_manager']); ?>" readonly />
                      </div>
                    </div>
                    <div class="form-row">
                      <div class="form-group">
                        <label for="email"><i class="fas fa-envelope"></i> Email</label>
                        <input type="email" id="email" name="email" value="<?php echo htmlspecialchars($manager['email_manager']); ?>" readonly />
                      </div>
                      <div class="form-group">
                        <label for="phone"><i class="fas fa-phone"></i> Nomor Telepon</label>
                        <input type="tel" id="phone" name="phone" value="<?php echo htmlspecialchars($manager['no_telp']); ?>" />
                      </div>
                    </div>
                    <div class="form-actions">
                      <button type="submit" class="btn-primary"><i class="fas fa-save"></i> Simpan Perubahan</button>
                    </div>
                  </form>
                </div>

                <div class="settings-card">
                  <div class="settings-header">
                    <h4><i class="fas fa-briefcase"></i> Informasi Pekerjaan</h4>
                  </div>
                  <form class="settings-form" method="POST" action="profile.php">
                    <input type="hidden" name="action" value="update_profile">
                    <div class="form-group">
                      <label for="position"><i class="fas fa-id-badge"></i> Posisi</label>
                      <input type="text" id="position" value="NutrivIT Manager" readonly />
                    </div>
                    <div class="form-group">
                      <label for="department"><i class="fas fa-building"></i> Departemen</label>
                      <select id="department" disabled>
                        <option>Management</option>
                      </select>
                    </div>
                    <div class="form-row">
                      <div class="form-group">
                        <label for="joinDate"><i class="fas fa-calendar"></i> Tanggal Bergabung</label>
                        <input type="date" id="joinDate" name="joinDate" value="<?php echo htmlspecialchars($manager['date_joined']); ?>" readonly />
                      </div>
                      <div class="form-group">
                        <label for="employeeId"><i class="fas fa-id-card"></i> ID Karyawan</label>
                        <input type="text" id="employeeId" name="employeeId" value="<?php echo htmlspecialchars($manager['id_karyawan']); ?>" readonly />
                      </div>
                    </div>
                  </form>
                </div>
              </div>
            </div>

            <div class="tab-pane" id="security">
              <div class="settings-grid">
                <div class="settings-card">
                  <div class="settings-header">
                    <h4><i class="fas fa-key"></i> Ubah Password</h4>
                    <?php if (!empty($passwordMessage)): ?>
                      <p style="color: <?php echo $passwordError ? 'red' : 'green'; ?>;"><?php echo $passwordMessage; ?></p>
                    <?php endif; ?>
                  </div>
                  <form class="settings-form" method="POST" action="profile.php">
                    <input type="hidden" name="action" value="change_password">
                    <div class="form-group">
                      <label for="currentPassword"><i class="fas fa-lock"></i> Password Saat Ini</label>
                      <input type="password" id="currentPassword" name="currentPassword" placeholder="Masukkan password saat ini" required />
                    </div>
                    <div class="form-row">
                      <div class="form-group">
                        <label for="newPassword"><i class="fas fa-key"></i> Password Baru</label>
                        <input type="password" id="newPassword" name="newPassword" placeholder="Masukkan password baru" required />
                      </div>
                      <div class="form-group">
                        <label for="confirmPassword"><i class="fas fa-check"></i> Konfirmasi Password</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Konfirmasi password baru" required />
                      </div>
                    </div>
                    <div class="form-actions">
                      <button type="submit" class="btn-primary"><i class="fas fa-save"></i> Ubah Password</button>
                    </div>
                  </form>
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
                  </div>
                </div>
              </div>
            </div>

            <div class="tab-pane" id="system">
              <div class="settings-grid">
                <div class="settings-card">
                  <div class="settings-header">
                    <h4><i class="fas fa-cogs"></i> Pengaturan Umum</h4>
                  </div>
                  <div class="settings-form">
                    <div class="form-row">
                      <div class="form-group">
                        <label for="timezone"><i class="fas fa-clock"></i> Timezone</label>
                        <select id="timezone">
                          <option value="Asia/Jakarta" selected>Asia/Jakarta (WIB)</option>
                          <option value="Asia/Makassar">Asia/Makassar (WITA)</option>
                          <option value="Asia/Jayapura">Asia/Jayapura (WIT)</option>
                        </select>
                      </div>
                      <div class="form-group">
                        <label for="language"><i class="fas fa-language"></i> Bahasa</label>
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
                    <div class="form-group">
                      <label for="backupTime"><i class="fas fa-clock"></i> Waktu Backup</label>
                      <input type="time" id="backupTime" value="02:00" />
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
    // Set current date
    document.getElementById('current-date').textContent = new Date().toLocaleDateString('id-ID', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });

    // Tab functionality
    document.addEventListener('DOMContentLoaded', function() {
      const tabBtns = document.querySelectorAll('.tab-btn');
      const tabPanes = document.querySelectorAll('.tab-pane');

      tabBtns.forEach(btn => {
        btn.addEventListener('click', function() {
          const targetTab = this.getAttribute('data-tab');

          // Sembunyikan semua pesan feedback saat berganti tab
          document.querySelectorAll('.update-message, .password-message, .photo-message').forEach(el => el.style.display = 'none');

          tabBtns.forEach(b => b.classList.remove('active'));
          tabPanes.forEach(p => p.classList.remove('active'));
          this.classList.add('active');
          document.getElementById(targetTab).classList.add('active');
        });
      });
    });
  </script>
</body>

</html>