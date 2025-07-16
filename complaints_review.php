<?php
require_once 'koneksi.php';

// ==============================
// Handle AJAX requests
// ==============================
if (isset($_GET['action'])) {
    header('Content-Type: application/json');

    switch ($_GET['action']) {
        case 'get_complaints':
            echo json_encode(getComplaints($conn, $_GET));
            break;
        case 'get_reviews':
            echo json_encode(getReviews($conn, $_GET));
            break;
        case 'update_complaint_status':
            echo json_encode(updateComplaintStatus($conn, $_POST));
            break;
        case 'get_analytics':
            echo json_encode(getAnalytics($conn));
            break;
        default:
            echo json_encode(['error' => 'Invalid action']);
    }
    exit();
}

// ==============================
// Function: Get Complaints
// ==============================
function getComplaints($conn, $filters = []) {
    $sql = "SELECT uc.*, u.name, u.email 
            FROM user_complaints uc 
            LEFT JOIN users u ON uc.user_id = u.id 
            WHERE 1=1";

    $params = [];
    $types = "";

    if (!empty($filters['status']) && $filters['status'] !== 'all') {
        $sql .= " AND uc.status = ?";
        $params[] = $filters['status'];
        $types .= "s";
    }

    if (!empty($filters['type']) && $filters['type'] !== 'all') {
        $sql .= " AND uc.complaint_type = ?";
        $params[] = $filters['type'];
        $types .= "s";
    }

    if (!empty($filters['period']) && $filters['period'] !== 'all') {
        switch ($filters['period']) {
            case 'today':
                $sql .= " AND DATE(uc.created_at) = CURDATE()";
                break;
            case 'week':
                $sql .= " AND uc.created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)";
                break;
            case 'month':
                $sql .= " AND uc.created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)";
                break;
        }
    }

    if (!empty($filters['search'])) {
        $sql .= " AND (uc.description LIKE ? OR u.name LIKE ? OR u.email LIKE ?)";
        $searchTerm = '%' . $filters['search'] . '%';
        array_push($params, $searchTerm, $searchTerm, $searchTerm);
        $types .= "sss";
    }

    $sql .= " ORDER BY uc.created_at DESC LIMIT 50";

    $stmt = $conn->prepare($sql);
    if (!empty($params)) {
        $stmt->bind_param($types, ...$params);
    }

    $stmt->execute();
    $result = $stmt->get_result();

    $complaints = [];
    while ($row = $result->fetch_assoc()) {
        $complaints[] = $row;
    }

    return $complaints;
}

// ==============================
// Function: Get Reviews
// ==============================
function getReviews($conn, $filters = []) {
    $sql = "SELECT pr.*, u.name AS name, u.email, p.name AS product_name
        FROM product_reviews pr 
        LEFT JOIN users u ON pr.user_id = u.id 
        LEFT JOIN products p ON pr.product_id = p.id 
        WHERE 1=1";


    $params = [];
    $types = "";

    if (!empty($filters['rating']) && $filters['rating'] !== 'all') {
        $sql .= " AND FLOOR(pr.rating) = ?";
        $params[] = intval($filters['rating']);
        $types .= "i";
    }

    if (!empty($filters['product']) && $filters['product'] !== 'all') {
        $sql .= " AND pr.product_id = ?";
        $params[] = $filters['product'];
        $types .= "s";
    }

    if (!empty($filters['period']) && $filters['period'] !== 'all') {
        switch ($filters['period']) {
            case 'today':
                $sql .= " AND DATE(pr.created_at) = CURDATE()";
                break;
            case 'week':
                $sql .= " AND pr.created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)";
                break;
            case 'month':
                $sql .= " AND pr.created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)";
                break;
        }
    }

    if (!empty($filters['search'])) {
        $sql .= " AND (pr.review_text LIKE ? OR u.name LIKE ? OR p.name LIKE ?)";
        $searchTerm = '%' . $filters['search'] . '%';
        array_push($params, $searchTerm, $searchTerm, $searchTerm);
        $types .= "sss";
    }

    $sql .= " ORDER BY pr.created_at DESC LIMIT 50";

    $stmt = $conn->prepare($sql);
    if (!empty($params)) {
        $stmt->bind_param($types, ...$params);
    }

    $stmt->execute();
    $result = $stmt->get_result();

    $reviews = [];
    while ($row = $result->fetch_assoc()) {
        $reviews[] = $row;
    }

    return $reviews;
}

// ==============================
// Function: Update Complaint Status
// ==============================
function updateComplaintStatus($conn, $data) {
    $sql = "UPDATE user_complaints SET status = ?, updated_at = NOW() WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("si", $data['status'], $data['complaint_id']);

    if ($stmt->execute()) {
        return ['success' => true, 'message' => 'Status berhasil diupdate'];
    } else {
        return ['success' => false, 'message' => 'Gagal mengupdate status'];
    }
}

// ==============================
// Function: Get Analytics
// ==============================
function getAnalytics($conn) {
    $analytics = [];

    $result = $conn->query("SELECT COUNT(*) as total FROM user_complaints");
    $analytics['total_complaints'] = $result->fetch_assoc()['total'];

    $result = $conn->query("SELECT COUNT(*) as total FROM product_reviews");
    $analytics['total_reviews'] = $result->fetch_assoc()['total'];

    $result = $conn->query("SELECT AVG(rating) as avg_rating FROM product_reviews");
    $analytics['avg_rating'] = round($result->fetch_assoc()['avg_rating'], 1);

    $result = $conn->query("SELECT COUNT(*) as total FROM user_complaints WHERE status = 'pending'");
    $analytics['pending_complaints'] = $result->fetch_assoc()['total'];

    $result = $conn->query("
        SELECT DATE_FORMAT(created_at, '%Y-%m') as month, COUNT(*) as count
        FROM user_complaints 
        WHERE created_at >= DATE_SUB(NOW(), INTERVAL 6 MONTH)
        GROUP BY month
        ORDER BY month
    ");
    $analytics['complaint_trends'] = $result->fetch_all(MYSQLI_ASSOC);

    $result = $conn->query("
        SELECT complaint_type, COUNT(*) as count 
        FROM user_complaints 
        GROUP BY complaint_type
    ");
    $analytics['complaint_types'] = $result->fetch_all(MYSQLI_ASSOC);

    $result = $conn->query("
        SELECT FLOOR(rating) as rating_floor, COUNT(*) as count 
        FROM product_reviews 
        GROUP BY rating_floor
        ORDER BY rating_floor
    ");
    $analytics['rating_distribution'] = $result->fetch_all(MYSQLI_ASSOC);

    return $analytics;
}

// ==============================
// Function: Get Products (for filter dropdown)
// ==============================
function getProducts($conn) {
    $result = $conn->query("SELECT id, name AS product_name FROM products ORDER BY name");
    return $result->fetch_all(MYSQLI_ASSOC);
}

// Load product list and analytics globally
$products = getProducts($conn);
$analytics = getAnalytics($conn);
?>



<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaints & Review - NutrivIT</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="./assets/css/complaints_review.css">
    <link rel="stylesheet" href="./assets/css/dashboard.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <?php include 'bar/navbar.php'; ?>

        <main class="main-content">
            <header class="main-header">
                <div class="header-left">
                    <h2><i class="fas fa-comments"></i> Complaints & Review</h2>
                    <p class="page-subtitle">Sampaikan keluhan dan ulasan Anda demi layanan yang lebih baik.</p>
                </div>
                <div class="header-actions">
                    <span class="date">
                        <i class="fas fa-calendar-alt"></i>
                        <span id="current-date"></span>
                    </span>
                </div>
            </header>

            <div class="content-area">
                <!-- Overview Cards -->
                <div class="overview-cards">
                    <div class="overview-card">
                        <div class="card-icon complaints">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        <div class="card-content">
                            <h3>Total Complaints</h3>
                            <div class="card-number" data-target="<?php echo $analytics['total_complaints']; ?>"><?php echo $analytics['total_complaints']; ?></div>
                            <div class="card-trend negative">
                                <i class="fas fa-arrow-down"></i> 12% from last month
                            </div>
                        </div>
                    </div>

                    <div class="overview-card">
                        <div class="card-icon reviews">
                            <i class="fas fa-star"></i>
                        </div>
                        <div class="card-content">
                            <h3>Total Reviews</h3>
                            <div class="card-number" data-target="<?php echo $analytics['total_reviews']; ?>"><?php echo $analytics['total_reviews']; ?></div>
                            <div class="card-trend positive">
                                <i class="fas fa-arrow-up"></i> 8% from last month
                            </div>
                        </div>
                    </div>

                    <div class="overview-card">
                        <div class="card-icon rating">
                            <i class="fas fa-thumbs-up"></i>
                        </div>
                        <div class="card-content">
                            <h3>Average Rating</h3>
                            <div class="card-number"><?php echo $analytics['avg_rating']; ?></div>
                            <div class="card-trend positive">
                                <i class="fas fa-arrow-up"></i> 0.2 from last month
                            </div>
                        </div>
                    </div>

                    <div class="overview-card">
                        <div class="card-icon pending">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="card-content">
                            <h3>Pending Issues</h3>
                            <div class="card-number" data-target="<?php echo $analytics['pending_complaints']; ?>"><?php echo $analytics['pending_complaints']; ?></div>
                            <div class="card-trend negative">
                                <i class="fas fa-arrow-up"></i> 3 new today
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tab Navigation -->
                <div class="tab-navigation">
                    <button class="tab-btn active" onclick="switchTab('complaints')">
                        <i class="fas fa-exclamation-triangle"></i>
                        Complaints Management
                    </button>
                    <button class="tab-btn" onclick="switchTab('reviews')">
                        <i class="fas fa-star"></i>
                        Product Reviews
                    </button>
                    <button class="tab-btn" onclick="switchTab('analytics')">
                        <i class="fas fa-chart-bar"></i>
                        Analytics & Insights
                    </button>
                </div>

                <!-- Complaints Tab -->
                <div id="complaints-tab" class="tab-content active">
                    <!-- Filters -->
                    <div class="filters-section">
                        <div class="filter-group">
                            <label>Status</label>
                            <select id="complaint-status-filter" onchange="filterComplaints()">
                                <option value="all">All Status</option>
                                <option value="open">Open</option>
                                <option value="pending">Pending</option>
                                <option value="resolved">Resolved</option>
                            </select>
                        </div>

                        <div class="filter-group">
                            <label>Type</label>
                            <select id="complaint-type-filter" onchange="filterComplaints()">
                                <option value="all">All Types</option>
                                <option value="energy">Energy</option>
                                <option value="weight">Weight</option>
                                <option value="digestion">Digestion</option>
                                <option value="immunity">Immunity</option>
                                <option value="sleep">Sleep</option>
                                <option value="other">Other</option>
                            </select>
                        </div>

                        <div class="filter-group">
                            <label>Period</label>
                            <select id="complaint-period-filter" onchange="filterComplaints()">
                                <option value="all">All Time</option>
                                <option value="today">Today</option>
                                <option value="week">This Week</option>
                                <option value="month">This Month</option>
                            </select>
                        </div>

                        <div class="search-group">
                            <input type="text" id="complaint-search" placeholder="Search complaints..." onkeyup="searchComplaints()">
                            <i class="fas fa-search"></i>
                        </div>
                    </div>

                    <!-- Section Header -->
                    <div class="section-header">
                        <h3><i class="fas fa-list"></i> Complaints List</h3>
                        <div class="header-actions">
                            <button class="btn-secondary" onclick="exportComplaints()">
                                <i class="fas fa-download"></i> Export
                            </button>
                            <button class="btn-primary" onclick="showBulkActions()">
                                <i class="fas fa-tasks"></i> Bulk Actions
                            </button>
                        </div>
                    </div>

                    <!-- Complaints List -->
                    <div class="complaints-container">
                        <div id="complaints-list" class="complaints-list">
                            <!-- Complaints will be loaded here via JavaScript -->
                        </div>
                    </div>
                </div>

                <!-- Reviews Tab -->
                <div id="reviews-tab" class="tab-content">
                    <!-- Filters -->
                    <div class="filters-section">
                        <div class="filter-group">
                            <label>Rating</label>
                            <select id="review-rating-filter" onchange="filterReviews()">
                                <option value="all">All Ratings</option>
                                <option value="5">5 Stars</option>
                                <option value="4">4 Stars</option>
                                <option value="3">3 Stars</option>
                                <option value="2">2 Stars</option>
                                <option value="1">1 Star</option>
                            </select>
                        </div>

                        <div class="filter-group">
                            <label>Product</label>
                            <select id="review-product-filter" onchange="filterReviews()">
                                <option value="all">All Products</option>
                                <?php foreach ($products as $product): ?>
                                    <option value="<?php echo $product['id']; ?>"><?php echo htmlspecialchars($product['product_name']); ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>

                        <div class="filter-group">
                            <label>Period</label>
                            <select id="review-period-filter" onchange="filterReviews()">
                                <option value="all">All Time</option>
                                <option value="today">Today</option>
                                <option value="week">This Week</option>
                                <option value="month">This Month</option>
                            </select>
                        </div>

                        <div class="search-group">
                            <input type="text" id="review-search" placeholder="Search reviews..." onkeyup="searchReviews()">
                            <i class="fas fa-search"></i>
                        </div>
                    </div>

                    <!-- Section Header -->
                    <div class="section-header">
                        <h3><i class="fas fa-star"></i> Product Reviews</h3>
                        <div class="header-actions">
                            <button class="btn-secondary" onclick="exportReviews()">
                                <i class="fas fa-download"></i> Export
                            </button>
                            <button class="btn-primary" onclick="showReviewAnalytics()">
                                <i class="fas fa-chart-line"></i> Analytics
                            </button>
                        </div>
                    </div>

                    <!-- Reviews List -->
                    <div class="reviews-container">
                        <div id="reviews-list" class="reviews-list">
                            <!-- Reviews will be loaded here via JavaScript -->
                        </div>
                    </div>
                </div>

                <!-- Analytics Tab -->
                <div id="analytics-tab" class="tab-content">
                    <!-- Analytics Grid -->
                    <div class="analytics-grid">
                        <div class="analytics-card">
                            <div class="card-header">
                                <h3><i class="fas fa-chart-line"></i> Complaint Trends</h3>
                                <select id="complaint-trend-period" onchange="updateComplaintTrends()">
                                    <option value="6months">Last 6 Months</option>
                                    <option value="year">This Year</option>
                                    <option value="all">All Time</option>
                                </select>
                            </div>
                            <div class="chart-container">
                                <canvas id="complaintTrendsChart"></canvas>
                            </div>
                        </div>

                        <div class="analytics-card">
                            <div class="card-header">
                                <h3><i class="fas fa-chart-pie"></i> Complaint Types</h3>
                            </div>
                            <div class="chart-container">
                                <canvas id="complaintTypesChart"></canvas>
                            </div>
                        </div>

                        <div class="analytics-card">
                            <div class="card-header">
                                <h3><i class="fas fa-star"></i> Rating Distribution</h3>
                            </div>
                            <div class="chart-container">
                                <canvas id="ratingDistributionChart"></canvas>
                            </div>
                        </div>

                        <div class="analytics-card">
                            <div class="card-header">
                                <h3><i class="fas fa-trophy"></i> Top Reviewed Products</h3>
                            </div>
                            <div class="chart-container">
                                <canvas id="topReviewedProductsChart"></canvas>
                            </div>
                        </div>
                    </div>

                    <!-- Insights Section -->
                    <div class="insights-section">
                        <h3><i class="fas fa-lightbulb"></i> Key Insights & Recommendations</h3>
                        <div class="insights-grid">
                            <div class="insight-card positive">
                                <div class="insight-icon">
                                    <i class="fas fa-thumbs-up"></i>
                                </div>
                                <div class="insight-content">
                                    <h4>Customer Satisfaction Improving</h4>
                                    <p>Average rating increased by 0.2 points this month, indicating better product quality and customer service.</p>
                                    <span class="insight-action">View detailed analysis</span>
                                </div>
                            </div>

                            <div class="insight-card warning">
                                <div class="insight-icon">
                                    <i class="fas fa-exclamation-triangle"></i>
                                </div>
                                <div class="insight-content">
                                    <h4>Energy-Related Complaints Rising</h4>
                                    <p>35% of complaints are energy-related. Consider reviewing Multi Core formula or dosage recommendations.</p>
                                    <span class="insight-action">Review product details</span>
                                </div>
                            </div>

                            <div class="insight-card info">
                                <div class="insight-icon">
                                    <i class="fas fa-chart-bar"></i>
                                </div>
                                <div class="insight-content">
                                    <h4>Review Response Rate Low</h4>
                                    <p>Only 23% of reviews have responses. Increasing engagement could improve customer relationships.</p>
                                    <span class="insight-action">Set response targets</span>
                                </div>
                            </div>

                            <div class="insight-card negative">
                                <div class="insight-icon">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <div class="insight-content">
                                    <h4>Complaint Resolution Time</h4>
                                    <p>Average resolution time is 4.2 days. Consider streamlining the complaint handling process.</p>
                                    <span class="insight-action">Optimize workflow</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- Modals -->
    <div id="complaintModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3><i class="fas fa-exclamation-triangle"></i> Complaint Details</h3>
                <button class="close-modal" onclick="closeModal('complaintModal')">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="modal-body" id="complaintModalBody">
                <!-- Content will be loaded dynamically -->
            </div>
        </div>
    </div>

    <div id="reviewModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3><i class="fas fa-star"></i> Review Details</h3>
                <button class="close-modal" onclick="closeModal('reviewModal')">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="modal-body" id="reviewModalBody">
                <!-- Content will be loaded dynamically -->
            </div>
        </div>
    </div>

    <script>
        const analyticsData = <?php echo json_encode($analytics); ?>;
        const productsData = <?php echo json_encode($products); ?>;
    </script>
    <script src="./assets/js/complaints_review.js"></script>
</body>

</html>