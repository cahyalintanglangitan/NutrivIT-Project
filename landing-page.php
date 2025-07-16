<!DOCTYPE html>
<html lang="id">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>NutrivIT - Platform Gizi & Kesehatan Terlengkap</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="./assets/css/landing-page.css" />
</head>

<body>
  <!-- Header -->
  <header class="header">
    <nav class="navbar">
      <div class="nav-brand">
        <i class="fas fa-leaf"></i>
        <span>NutrivIT</span>
      </div>
      <ul class="nav-menu">
        <li><a href="#home" class="nav-link">Beranda</a></li>
        <li><a href="#features" class="nav-link">Fitur</a></li>
        <li><a href="#products" class="nav-link">Produk</a></li>
        <li><a href="#about" class="nav-link">Tentang</a></li>
        <li><a href="#contact" class="nav-link">Kontak</a></li>
      </ul>
      <div class="nav-actions">
        <a href="login.php" class="btn-app">
          <i class="fas fa-user"></i> Log In
        </a>
      </div>
      <div class="hamburger">
        <span></span>
        <span></span>
        <span></span>
      </div>
    </nav>
  </header>

  <!-- Hero Section -->
  <section id="home" class="hero">
    <div class="hero-container">
      <div class="hero-content">
        <div class="hero-badge">
          <i class="fas fa-heart"></i>
          <span>Platform Kesehatan #1 di Indonesia</span>
        </div>
        <h1 class="hero-title">
          Wujudkan <span class="highlight">Hidup Sehat</span>
          dengan Teknologi AI
        </h1>
        <p class="hero-description">
          NutrivIT membantu Anda mencatat kebutuhan gizi harian, berkonsultasi dengan AI,
          dan berbelanja produk kesehatan terpercaya. Semua dalam satu platform yang mudah digunakan.
        </p>
        <div class="hero-actions">
          <button class="btn-primary" onclick="openApp()">
            <i class="fas fa-rocket"></i>
            Mulai Tracking Gizi
          </button>
        </div>
        <div class="hero-stats">
          <div class="stat-item">
            <span class="stat-number">100K+</span>
            <span class="stat-label">Pengguna Aktif</span>
          </div>
          <div class="stat-item">
            <span class="stat-number">1M+</span>
            <span class="stat-label">Makanan Tercatat</span>
          </div>
          <div class="stat-item">
            <span class="stat-number">50K+</span>
            <span class="stat-label">Konsultasi AI</span>
          </div>
        </div>
      </div>
      <div class="hero-visual">
        <div class="app-preview">
          <div class="preview-header">
            <div class="preview-dots">
              <span></span>
              <span></span>
              <span></span>
            </div>
            <span class="preview-title">NutrivIT App</span>
          </div>
          <div class="preview-content">
            <div class="app-screen">
              <div class="screen-header">
                <h3>Halo, Sarah! 👋</h3>
                <p>Target kalori hari ini: 1,800 kcal</p>
              </div>
              <div class="nutrition-progress">
                <div class="progress-item">
                  <span class="progress-label">Kalori</span>
                  <div class="progress-bar">
                    <div class="progress-fill" style="width: 65%"></div>
                  </div>
                  <span class="progress-value">1,170 / 1,800</span>
                </div>
                <div class="progress-item">
                  <span class="progress-label">Protein</span>
                  <div class="progress-bar">
                    <div class="progress-fill protein" style="width: 80%"></div>
                  </div>
                  <span class="progress-value">48g / 60g</span>
                </div>
                <div class="progress-item">
                  <span class="progress-label">Karbohidrat</span>
                  <div class="progress-bar">
                    <div class="progress-fill carbs" style="width: 55%"></div>
                  </div>
                  <span class="progress-value">123g / 225g</span>
                </div>
              </div>
              <div class="quick-actions">
                <div class="action-btn">
                  <i class="fas fa-plus"></i>
                  <span>Tambah Makanan</span>
                </div>
                <div class="action-btn">
                  <i class="fas fa-robot"></i>
                  <span>Konsultasi AI</span>
                </div>
                <div class="action-btn">
                  <i class="fas fa-shopping-cart"></i>
                  <span>Belanja</span>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="floating-elements">
          <div class="floating-card card-1">
            <i class="fas fa-apple-alt"></i>
            <span>Nutrition Tracking</span>
          </div>
          <div class="floating-card card-2">
            <i class="fas fa-robot"></i>
            <span>AI Consultation</span>
          </div>
          <div class="floating-card card-3">
            <i class="fas fa-shopping-bag"></i>
            <span>Health Store</span>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- Features Section -->
  <section id="features" class="features">
    <div class="container">
      <div class="section-header">
        <span class="section-badge">
          <i class="fas fa-star"></i>
          Fitur Unggulan
        </span>
        <h2 class="section-title">
          Semua yang Anda Butuhkan untuk <span class="highlight">Hidup Sehat</span>
        </h2>
        <p class="section-description">
          Platform lengkap untuk tracking gizi, konsultasi kesehatan, dan berbelanja produk terpercaya
        </p>
      </div>

      <div class="features-grid">
        <div class="feature-card featured">
          <div class="feature-badge">
            <i class="fas fa-crown"></i>
            Most Popular
          </div>
          <div class="feature-icon">
            <i class="fas fa-chart-pie"></i>
          </div>
          <h3 class="feature-title">Tracking Gizi Harian</h3>
          <p class="feature-description">
            Catat asupan makanan harian Anda dengan mudah. Dapatkan analisis nutrisi lengkap
            dan rekomendasi untuk mencapai target kesehatan Anda.
          </p>
          <ul class="feature-list">
            <li><i class="fas fa-check"></i> Database 10,000+ makanan Indonesia</li>
            <li><i class="fas fa-check"></i> Scan barcode produk</li>
            <li><i class="fas fa-check"></i> Analisis nutrisi real-time</li>
            <li><i class="fas fa-check"></i> Target kalori personal</li>
          </ul>
        </div>

        <div class="feature-card">
          <div class="feature-icon">
            <i class="fas fa-robot"></i>
          </div>
          <h3 class="feature-title">Konsultasi AI Nutrisionist</h3>
          <p class="feature-description">
            Chatbot AI yang dilatih oleh ahli gizi profesional siap membantu Anda 24/7
            untuk pertanyaan seputar nutrisi dan kesehatan.
          </p>
          <ul class="feature-list">
            <li><i class="fas fa-check"></i> Konsultasi 24/7 gratis</li>
            <li><i class="fas fa-check"></i> Rekomendasi menu personal</li>
            <li><i class="fas fa-check"></i> Tips diet sehat</li>
            <li><i class="fas fa-check"></i> Analisis pola makan</li>
          </ul>
        </div>

        <div class="feature-card">
          <div class="feature-icon">
            <i class="fas fa-shopping-cart"></i>
          </div>
          <h3 class="feature-title">Marketplace Kesehatan</h3>
          <p class="feature-description">
            Berbelanja produk kesehatan, suplemen, dan makanan sehat terpercaya
            dengan rekomendasi yang disesuaikan dengan kebutuhan Anda.
          </p>
          <ul class="feature-list">
            <li><i class="fas fa-check"></i> Produk tersertifikasi BPOM</li>
            <li><i class="fas fa-check"></i> Rekomendasi personal</li>
            <li><i class="fas fa-check"></i> Review dari ahli gizi</li>
            <li><i class="fas fa-check"></i> Pengiriman cepat</li>
          </ul>
        </div>

        <div class="feature-card">
          <div class="feature-icon">
            <i class="fas fa-target"></i>
          </div>
          <h3 class="feature-title">Program Kesehatan Gizi Personal</h3>
          <p class="feature-description">
            Dapatkan program diet yang disesuaikan dengan tujuan Anda, baik untuk
            menurunkan berat badan, menambah massa otot, atau menjaga kesehatan.
          </p>
          <ul class="feature-list">
            <li><i class="fas fa-check"></i> Diet plan personal</li>
            <li><i class="fas fa-check"></i> Tracking progress</li>
            <li><i class="fas fa-check"></i> Reminder makan</li>
          </ul>
        </div>

        <div class="feature-card">
          <div class="feature-icon">
            <i class="fas fa-chart-line"></i>
          </div>
          <h3 class="feature-title">Analisis & Laporan</h3>
          <p class="feature-description">
            Lihat progress kesehatan Anda dengan grafik dan laporan detail.
            Pantau perubahan berat badan, asupan nutrisi, dan pencapaian target.
          </p>
          <ul class="feature-list">
            <li><i class="fas fa-check"></i> Grafik progress mingguan</li>
            <li><i class="fas fa-check"></i> Laporan nutrisi bulanan</li>
            <li><i class="fas fa-check"></i> Analisis tren kesehatan</li>
            <li><i class="fas fa-check"></i> Export data PDF</li>
          </ul>
        </div>
      </div>
    </div>
  </section>

  <!-- Products Section -->
  <section id="products" class="products">
    <div class="container">
      <div class="section-header">
        <span class="section-badge">
          <i class="fas fa-shopping-bag"></i>
          Produk Terpercaya
        </span>
        <h2 class="section-title">
          Produk <span class="highlight">Kesehatan Terbaik</span> untuk Anda
        </h2>
        <p class="section-description">
          Pilihan produk kesehatan berkualitas tinggi yang telah tersertifikasi dan direkomendasikan ahli
        </p>
      </div>

      <div class="product-categories">
        <div class="category-card">
          <div class="category-icon">
            <i class="fas fa-pills"></i>
          </div>
          <h3>Vitamin & Suplemen</h3>
          <p>Suplemen berkualitas untuk mendukung kesehatan optimal Anda</p>
        </div>

        <div class="category-card">
          <div class="category-icon">
            <i class="fas fa-leaf"></i>
          </div>
          <h3>Herbal & Natural</h3>
          <p>Produk herbal alami untuk kesehatan tubuh secara menyeluruh</p>
          <div class="category-products">
            <div class="product-item">
              <span class="product-name" style="color: #333;">NuVit-Curcuma Gold</span>
            </div>
            <div class="product-item">
              <span class="product-name">NuVit-Honey Natural </span>
            </div>
            <div class="product-item">
              <span class="product-name">NuVit-Green Detox</span>
            </div>
          </div>
        </div>

        <div class="category-card">
          <div class="category-icon">
            <i class="fas fa-dumbbell"></i>
          </div>
          <h3>Fitness & Protein</h3>
          <p>Produk untuk mendukung aktivitas olahraga dan pembentukan otot</p>
          <div class="category-products">
            <div class="product-item" style="background: linear-gradient(135deg, #08A55A, #3FCAEA);
  color: white; padding: 10px; border-radius: 8px;">
              <span class="product-name">NuVit-Whey Muscle</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- How It Works -->
  <section class="how-it-works">
    <div class="container">
      <div class="section-header">
        <span class="section-badge">
          <i class="fas fa-lightbulb"></i>
          Cara Kerja
        </span>
        <h2 class="section-title">
          Mulai Hidup Sehat dalam <span class="highlight">3 Langkah Mudah</span>
        </h2>
      </div>

      <div class="steps-container">
        <div class="step-item">
          <div class="step-number">1</div>
          <div class="step-content">
            <div class="step-icon">
              <i class="fas fa-user-plus"></i>
            </div>
            <h3>Daftar & Setup Profil</h3>
            <p>Buat akun gratis dan atur profil kesehatan Anda. Masukkan data seperti usia, tinggi, berat badan, dan
              tujuan kesehatan.</p>
          </div>
        </div>

        <div class="step-arrow">
          <i class="fas fa-arrow-right"></i>
        </div>

        <div class="step-item">
          <div class="step-number">2</div>
          <div class="step-content">
            <div class="step-icon">
              <i class="fas fa-utensils"></i>
            </div>
            <h3>Catat Makanan Harian</h3>
            <p>Mulai mencatat asupan makanan Anda setiap hari. Gunakan fitur scan barcode atau cari dari database
              makanan lengkap kami.</p>
          </div>
        </div>

        <div class="step-arrow">
          <i class="fas fa-arrow-right"></i>
        </div>

        <div class="step-item">
          <div class="step-number">3</div>
          <div class="step-content">
            <div class="step-icon">
              <i class="fas fa-chart-line"></i>
            </div>
            <h3>Pantau & Konsultasi</h3>
            <p>Lihat progress Anda, dapatkan rekomendasi dari AI, dan konsultasi kapan saja. Belanja produk kesehatan
              sesuai kebutuhan.</p>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- Testimonials -->
  <section class="testimonials">
    <div class="container">
      <div class="section-header">
        <span class="section-badge">
          <i class="fas fa-heart"></i>
          Testimoni
        </span>
        <h2 class="section-title">
          Apa Kata <span class="highlight">Pengguna Kami</span>
        </h2>
      </div>

      <div class="testimonials-grid">
        <div class="testimonial-card">
          <div class="testimonial-content">
            <div class="stars">
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
            </div>
            <p>"NutrivIT benar-benar membantu saya mencapai target diet. Fitur AI consultation-nya sangat membantu dan
              responsif. Dalam 3 bulan saya berhasil turun 8kg!"</p>
          </div>
          <div class="testimonial-author">
            <div class="author-avatar">
              <i class="fas fa-user"></i>
            </div>
            <div class="author-info">
              <h4>Sarah Wijaya</h4>
              <span>Ibu Rumah Tangga</span>
            </div>
          </div>
        </div>

        <div class="testimonial-card">
          <div class="testimonial-content">
            <div class="stars">
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
            </div>
            <p>"Sebagai atlet, saya butuh tracking nutrisi yang akurat. NutrivIT memberikan analisis detail yang saya
              butuhkan. Marketplace-nya juga lengkap untuk suplemen."</p>
          </div>
          <div class="testimonial-author">
            <div class="author-avatar">
              <i class="fas fa-user"></i>
            </div>
            <div class="author-info">
              <h4>Budi Santoso</h4>
              <span>Personal Trainer</span>
            </div>
          </div>
        </div>

        <div class="testimonial-card">
          <div class="testimonial-content">
            <div class="stars">
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
            </div>
            <p>"Aplikasi yang sangat user-friendly! Fitur scan barcode memudahkan saya mencatat makanan. Konsultasi
              dengan AI juga sangat membantu untuk menu harian."</p>
          </div>
          <div class="testimonial-author">
            <div class="author-avatar">
              <i class="fas fa-user"></i>
            </div>
            <div class="author-info">
              <h4>Maya Sari</h4>
              <span>Karyawan Swasta</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- CTA Section -->
  <section class="cta">
    <div class="container">
      <div class="cta-content">
        <div class="cta-text">
          <h2 class="cta-title">
            Siap Memulai <span class="highlight">Perjalanan Sehat</span> Anda?
          </h2>
          <p class="cta-description">
            Bergabunglah dengan 100,000+ pengguna yang telah merasakan manfaat hidup sehat bersama NutrivIT.
            Mulai gratis hari ini!
          </p>
        </div>
        <div class="cta-actions">
          <button class="btn-primary" onclick="openApp()">
            <i class="fas fa-rocket"></i>
            Mulai Gratis Sekarang
          </button>
        </div>
      </div>
    </div>
  </section>

  <!-- Footer -->
  <footer class="footer">
    <div class="container">
      <div class="footer-content">
        <div class="footer-brand">
          <div class="brand-logo">
            <i class="fas fa-leaf"></i>
            <span>NutrivIT</span>
          </div>
          <p class="brand-description">
            Platform kesehatan terlengkap untuk tracking gizi, konsultasi AI,
            dan berbelanja produk kesehatan terpercaya.
          </p>
          <div class="social-links">
            <a href="#" class="social-link">
              <i class="fab fa-facebook"></i>
            </a>
            <a href="#" class="social-link">
              <i class="fab fa-twitter"></i>
            </a>
            <a href="#" class="social-link">
              <i class="fab fa-linkedin"></i>
            </a>
            <a href="#" class="social-link">
              <i class="fab fa-instagram"></i>
            </a>
          </div>
        </div>

        <div class="footer-links">
          <div class="footer-column">
            <h4 class="footer-title">Fitur</h4>
            <ul class="footer-list">
              <li><a href="#" class="footer-link">Tracking Gizi</a></li>
              <li><a href="#" class="footer-link">Konsultasi AI</a></li>
              <li><a href="#" class="footer-link">Marketplace</a></li>
              <li><a href="#" class="footer-link">Program Diet</a></li>
            </ul>
          </div>

          <div class="footer-column">
            <h4 class="footer-title">Perusahaan</h4>
            <ul class="footer-list">
              <li><a href="#" class="footer-link">Tentang Kami</a></li>
              <li><a href="#" class="footer-link">Karir</a></li>
              <li><a href="#" class="footer-link">Blog Kesehatan</a></li>
              <li><a href="#" class="footer-link">Press Kit</a></li>
            </ul>
          </div>

          <div class="footer-column">
            <h4 class="footer-title">Support</h4>
            <ul class="footer-list">
              <li><a href="#" class="footer-link">Help Center</a></li>
              <li><a href="#" class="footer-link">Panduan Pengguna</a></li>
              <li><a href="#" class="footer-link">FAQ</a></li>
              <li><a href="#" class="footer-link">Hubungi Kami</a></li>
            </ul>
          </div>

          <div class="footer-column">
            <h4 class="footer-title">Legal</h4>
            <ul class="footer-list">
              <li><a href="#" class="footer-link">Privacy Policy</a></li>
              <li><a href="#" class="footer-link">Terms of Service</a></li>
              <li><a href="#" class="footer-link">Cookie Policy</a></li>
              <li><a href="login.php" class="footer-link">Admin Login</a></li>
            </ul>
          </div>
        </div>
      </div>

      <div class="footer-bottom">
        <p class="copyright">
          © 2024 NutriVit. All rights reserved. Made with <i class="fas fa-heart"></i> for healthier Indonesia.
        </p>
        <div class="footer-bottom-links">
          <a href="#" class="footer-bottom-link">Privacy</a>
          <a href="#" class="footer-bottom-link">Terms</a>
          <a href="#" class="footer-bottom-link">Cookies</a>
        </div>
      </div>
    </div>
  </footer>

  <script>
    // Mobile menu toggle
    const hamburger = document.querySelector('.hamburger');
    const navMenu = document.querySelector('.nav-menu');

    hamburger.addEventListener('click', () => {
      hamburger.classList.toggle('active');
      navMenu.classList.toggle('active');
    });

    // Smooth scrolling for navigation links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
      anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
          target.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
          });
        }
      });
    });

    // Header scroll effect
    window.addEventListener('scroll', () => {
      const header = document.querySelector('.header');
      if (window.scrollY > 100) {
        header.classList.add('scrolled');
      } else {
        header.classList.remove('scrolled');
      }
    });

    // Animation on scroll
    const observerOptions = {
      threshold: 0.1,
      rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('animate');
        }
      });
    }, observerOptions);

    // Observe elements for animation
    document.querySelectorAll('.feature-card, .step-item, .testimonial-card, .category-card').forEach(el => {
      observer.observe(el);
    });

    // Functions for buttons
    function openApp() {
      alert('Aplikasi NutrivIT akan dibuka! Anda akan diarahkan ke halaman aplikasi.');
      // window.location.href = 'app.html';
    }

    function watchDemo() {
      alert('Video demo akan diputar!');
      // Open video modal or redirect to video
    }

    // Floating animation for hero elements
    const floatingCards = document.querySelectorAll('.floating-card');
    floatingCards.forEach((card, index) => {
      card.style.animationDelay = `${index * 0.5}s`;
    });

    // Progress bar animation
    const progressBars = document.querySelectorAll('.progress-fill');
    progressBars.forEach((bar, index) => {
      bar.style.animationDelay = `${index * 0.3}s`;
    });
  </script>
</body>

</html>