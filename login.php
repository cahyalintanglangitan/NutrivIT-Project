<!DOCTYPE html>
<html lang="id">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Login - NutriVit</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link rel="stylesheet" href="assets/css/login.css" />
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
      <h2>Masuk ke Akun Anda</h2>
      <p>Masukkan kredensial Anda untuk melanjutkan</p>

      <input type="email" placeholder="nama@perusahaan.com" id="email" />

      <div class="password-row">
        <label for="password">Password</label>
        <a href="#">Lupa password?</a>
      </div>

      <input type="password" placeholder="Masukkan password Anda" id="password" />

      <p class="error" id="error-message" style="display: none;">Email atau password salah.</p>

      <label class="remember-row">
        <input type="checkbox" /> Ingat saya
      </label>

      <button onclick="handleLogin()">Masuk</button>
    </div>
  </div>

  <script>
    function handleLogin() {
      const email = document.getElementById("email").value;
      const password = document.getElementById("password").value;
      const errorElement = document.getElementById("error-message");

      if (email === "manager@email.com" && password === "admin123") {
        localStorage.setItem("auth", "true");
        window.location.href = "dashboard.php";
      } else {
        errorElement.style.display = "block";
      }
    }
  </script>
</body>

</html>