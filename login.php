<?php
// Mulai session di paling atas
session_start();

// Jika sudah login, redirect ke dashboard
if (isset($_SESSION['manager_id'])) {
    header('Location: dashboard.php');
    exit;
}

// Sertakan file koneksi database
require 'koneksi.php';

$errorMessage = '';

// Proses form jika metode adalah POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];
    $password = $_POST['password'];

    if (empty($email) || empty($password)) {
        $errorMessage = 'Email dan password tidak boleh kosong.';
    } else {
        // Gunakan prepared statements untuk keamanan
        $stmt = $conn->prepare("SELECT id_manager, nama_manager, password FROM manager WHERE email_manager = ?");
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows === 1) {
            $manager = $result->fetch_assoc();

            // Verifikasi password yang diinput dengan hash di database
            if (password_verify($password, $manager['password'])) {
                // Password benar, simpan data ke session
                $_SESSION['manager_id'] = $manager['id_manager'];
                $_SESSION['manager_name'] = $manager['nama_manager'];

                // Redirect ke dashboard
                header('Location: dashboard.php');
                exit;
            } else {
                // Password salah
                $errorMessage = 'Email atau password salah.';
            }
        } else {
            // Email tidak ditemukan
            $errorMessage = 'Email atau password salah.';
        }
        $stmt->close();
    }
    $conn->close();
}
?>
<!DOCTYPE html>
<html lang="id">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Login - NutriVit</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link rel="stylesheet" href="./assets/css/login.css" />
</head>

<body>
  <div class="login-wrapper">
    <div class="login-left">
      <h1><i class="fas fa-leaf"></i> NutriVit</h1>
      <p class="subtitle">Management System</p>
      <h2>Selamat Datang Kembali!</h2>
      <p>Masuk untuk mengakses dashboard analisis gizi dan manajemen produk kesehatan perusahaan Anda.</p>
    </div>
    <div class="login-right">
      <form method="POST" action="login.php">
        <h2>Masuk ke Akun Anda</h2>
        <p>Masukkan kredensial Anda untuk melanjutkan</p>

        <input type="email" placeholder="nama@perusahaan.com" id="email" name="email" required />

        <div class="password-row">
          <label for="password">Password</label>
          <a href="#">Lupa password?</a>
        </div>

        <input type="password" placeholder="Masukkan password Anda" id="password" name="password" required />

        <?php if (!empty($errorMessage)) : ?>
          <p class="error" id="error-message" style="display: block;"><?php echo htmlspecialchars($errorMessage); ?></p>
        <?php endif; ?>

        <label class="remember-row">
          <input type="checkbox" name="remember" /> Ingat saya
        </label>

        <p>Email: goyoonjung@nutrivit.com</p>
        <p>Password: admin123</p>
        
        <button type="submit">Masuk</button>
      </form>
    </div>
  </div>

  </body>

</html>
