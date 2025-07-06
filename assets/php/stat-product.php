<div class="stats-grid">
    <!-- Total Products -->
    <div class="stat-card">
        <div class="stat-icon total-products">
            <i class="fas fa-boxes"></i>
        </div>
        <div class="stat-info">
            <h3>Total Products</h3>
            <div class="stat-number"><?= $totalProducts ?></div>
            <div class="stat-change up">
                <i class="fas fa-arrow-up"></i>
                <span>+8% dari bulan lalu</span>
            </div>
        </div>
    </div>
    <!-- Total Revenue -->
    <div class="stat-card">
        <div class="stat-icon total-revenue">
            <i class="fas fa-chart-line"></i>
        </div>
        <div class="stat-info">
            <h3>Total Revenue</h3>
            <div class="stat-number">Rp <?= number_format($totalRevenue, 0, ',', '.') ?></div>
            <div class="stat-change up">
                <i class="fas fa-arrow-up"></i>
                <span>+15% dari bulan lalu</span>
            </div>
        </div>
    </div>
    <!-- Best Seller -->
    <div class="stat-card">
        <div class="stat-icon best-seller">
            <i class="fas fa-trophy"></i>
        </div>
        <div class="stat-info">
            <h3>Best Seller</h3>
            <div class="stat-number"><?= $bestSeller ?></div>
            <div class="stat-change hot">
                <i class="fas fa-fire"></i>
                <span>Terjual bulan ini</span>
            </div>
        </div>
    </div>
    <!-- Low Stock Items -->
    <div class="stat-card">
        <div class="stat-icon low-stock">
            <i class="fas fa-exclamation-triangle"></i>
        </div>
        <div class="stat-info">
            <h3>Low Stock Items</h3>
            <div class="stat-number"><?= $lowStock ?></div>
            <div class="stat-change alert">
                <i class="fas fa-exclamation-circle"></i>
                <span>Perlu restok segera</span>
            </div>
        </div>
    </div>
</div>