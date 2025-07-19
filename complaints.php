<?php
require_once 'koneksi.php';

// Function to get complaints with user details
function getComplaints($status = '', $type = '', $limit = 50, $offset = 0) {
    global $conn;
    
    $sql = "SELECT uc.*, u.name as user_name, u.email as user_email, u.phone 
            FROM user_complaints uc 
            JOIN users u ON uc.user_id = u.id 
            WHERE 1=1";
    
    $params = [];
    $types = "";
    
    if (!empty($status)) {
        $sql .= " AND uc.status = ?";
        $params[] = $status;
        $types .= "s";
    }
    
    if (!empty($type)) {
        $sql .= " AND uc.complaint_type = ?";
        $params[] = $type;
        $types .= "s";
    }
    
    $sql .= " ORDER BY uc.created_at DESC LIMIT ? OFFSET ?";
    $params[] = $limit;
    $params[] = $offset;
    $types .= "ii";
    
    $stmt = $conn->prepare($sql);
    if (!empty($params)) {
        $stmt->bind_param($types, ...$params);
    }
    $stmt->execute();
    return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
}

// Function to get complaint statistics
function getComplaintStats() {
    global $conn;
    
    $stats = [];
    
    // Total complaints
    $result = $conn->query("SELECT COUNT(*) as total FROM user_complaints");
    $stats['total'] = $result->fetch_assoc()['total'];
    
    // By status
    $stats['by_status'] = ['open' => 0, 'pending' => 0, 'resolved' => 0];
    $result = $conn->query("SELECT status, COUNT(*) as count FROM user_complaints GROUP BY status");
    while ($row = $result->fetch_assoc()) {
        $stats['by_status'][$row['status']] = $row['count'];
    }
    
    // By type
    $stats['by_type'] = ['energy' => 0, 'weight' => 0, 'digestion' => 0, 'immunity' => 0, 'sleep' => 0, 'other' => 0];
    $result = $conn->query("SELECT complaint_type, COUNT(*) as count FROM user_complaints GROUP BY complaint_type");
    while ($row = $result->fetch_assoc()) {
        $stats['by_type'][$row['complaint_type']] = $row['count'];
    }
    
    // Recent complaints (last 7 days)
    $result = $conn->query("SELECT COUNT(*) as recent FROM user_complaints WHERE created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)");
    $stats['recent'] = $result->fetch_assoc()['recent'];
    
    return $stats;
}

$stats = getComplaintStats();
$complaints = getComplaints();
?>

<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaints & Review - NutrivIT</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="./assets/css/complaints.css">
    <link rel="stylesheet" href="./assets/css/dashboard.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body>
    <div class="dashboard-container">
        <?php include 'bar/navbar.php'; ?>

        <div class="main-content">
            <div class="main-header">
                <div class="header-left">
                    <h2><i class="fas fa-comments"></i> Complaints & Review</h2>
                    <p class="page-subtitle">Kelola keluhan dan ulasan pelanggan untuk meningkatkan layanan</p>
                </div>
                <div class="header-actions">
                    <div class="date">
                        <i class="fas fa-calendar-alt"></i>
                        <span id="current-date">Loading...</span>
                    </div>
                </div>
            </div>

            <div class="content-section active">
                <!-- Statistics Cards -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon total">
                            <i class="fas fa-comments"></i>
                        </div>
                        <div class="stat-info">
                            <h3>Total Complaints</h3>
                            <span class="stat-number"><?php echo $stats['total']; ?></span>
                            <div class="stat-change positive">
                                <i class="fas fa-arrow-up"></i>
                                <span>+<?php echo $stats['recent']; ?> minggu ini</span>
                            </div>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon open">
                            <i class="fas fa-exclamation-circle"></i>
                        </div>
                        <div class="stat-info">
                            <h3>Open Complaints</h3>
                            <span class="stat-number"><?php echo $stats['by_status']['open']; ?></span>
                            <div class="stat-change">
                                <span>Perlu ditangani</span>
                            </div>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon pending">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="stat-info">
                            <h3>Pending</h3>
                            <span class="stat-number"><?php echo $stats['by_status']['pending']; ?></span>
                            <div class="stat-change">
                                <span>Dalam proses</span>
                            </div>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon resolved">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="stat-info">
                            <h3>Resolved</h3>
                            <span class="stat-number"><?php echo $stats['by_status']['resolved']; ?></span>
                            <div class="stat-change positive">
                                <i class="fas fa-arrow-up"></i>
                                <span>Selesai</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Charts Section -->
                <div class="charts-section">
                    <div class="charts-row">
                        <div class="chart-card">
                            <div class="chart-header">
                                <h4><i class="fas fa-chart-pie"></i> Complaints by Type</h4>
                            </div>
                            <div class="chart-container">
                                <canvas id="complaintsTypeChart"></canvas>
                            </div>
                        </div>

                        <div class="chart-card">
                            <div class="chart-header">
                                <h4><i class="fas fa-chart-bar"></i> Status Distribution</h4>
                            </div>
                            <div class="chart-container">
                                <canvas id="statusChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Filters and Controls -->
                <div class="controls-section">
                    <div class="section-header">
                        <h3><i class="fas fa-list"></i> Daftar Complaints</h3>
                        <div class="controls-group">
                            <select id="statusFilter" class="filter-select">
                                <option value="">Semua Status</option>
                                <option value="open">Open</option>
                                <option value="pending">Pending</option>
                                <option value="resolved">Resolved</option>
                            </select>
                            <select id="typeFilter" class="filter-select">
                                <option value="">Semua Tipe</option>
                                <option value="energy">Energy</option>
                                <option value="weight">Weight</option>
                                <option value="digestion">Digestion</option>
                                <option value="immunity">Immunity</option>
                                <option value="sleep">Sleep</option>
                                <option value="other">Other</option>
                            </select>
                            <button id="refreshBtn" class="btn-refresh">
                                <i class="fas fa-sync-alt"></i> Refresh
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Complaints Table -->
                <div class="table-container">
                    <div class="table-wrapper">
                        <table class="complaints-table">
                            <thead>
                                <tr>
                                    <th width="8%">ID</th>
                                    <th width="20%">User</th>
                                    <th width="12%">Type</th>
                                    <th width="35%">Description</th>
                                    <th width="10%">Status</th>
                                    <th width="12%">Created</th>
                                    <th width="8%">Actions</th>
                                </tr>
                            </thead>
                            <tbody id="complaintsTableBody">
                                <?php foreach ($complaints as $complaint): ?>
                                <tr data-id="<?php echo $complaint['id']; ?>">
                                    <td class="complaint-id">
                                        <span class="id-badge">#<?php echo str_pad($complaint['id'], 4, '0', STR_PAD_LEFT); ?></span>
                                    </td>
                                    <td class="user-info">
                                        <div class="user-details">
                                            <div class="user-name"><?php echo htmlspecialchars($complaint['user_name']); ?></div>
                                            <div class="user-email"><?php echo htmlspecialchars($complaint['user_email']); ?></div>
                                        </div>
                                    </td>
                                    <td class="type-cell">
                                        <span class="type-badge type-<?php echo $complaint['complaint_type']; ?>">
                                            <i class="fas fa-<?php 
                                                echo $complaint['complaint_type'] == 'energy' ? 'bolt' : 
                                                    ($complaint['complaint_type'] == 'weight' ? 'weight' : 
                                                    ($complaint['complaint_type'] == 'digestion' ? 'utensils' : 
                                                    ($complaint['complaint_type'] == 'immunity' ? 'shield-alt' : 
                                                    ($complaint['complaint_type'] == 'sleep' ? 'bed' : 'question-circle'))));
                                            ?>"></i>
                                            <?php echo ucfirst($complaint['complaint_type']); ?>
                                        </span>
                                    </td>
                                    <td class="description">
                                        <div class="description-text" title="<?php echo htmlspecialchars($complaint['description']); ?>">
                                            <?php echo htmlspecialchars(substr($complaint['description'], 0, 80)); ?>
                                            <?php if (strlen($complaint['description']) > 80): ?>
                                                <span class="read-more">... <small>(klik untuk detail)</small></span>
                                            <?php endif; ?>
                                        </div>
                                    </td>
                                    <td class="status-cell">
                                        <span class="status-badge status-<?php echo $complaint['status']; ?>">
                                            <i class="fas fa-<?php 
                                                echo $complaint['status'] == 'open' ? 'exclamation-circle' : 
                                                    ($complaint['status'] == 'pending' ? 'clock' : 'check-circle');
                                            ?>"></i>
                                            <?php echo ucfirst($complaint['status']); ?>
                                        </span>
                                    </td>
                                    <td class="created-date">
                                        <div class="date-info">
                                            <div class="date"><?php echo date('d/m/Y', strtotime($complaint['created_at'])); ?></div>
                                            <div class="time"><?php echo date('H:i', strtotime($complaint['created_at'])); ?></div>
                                        </div>
                                    </td>
                                    <td class="actions">
                                        <div class="action-buttons">
                                            <button class="btn-action btn-view" onclick="viewComplaint(<?php echo $complaint['id']; ?>)" title="View Details">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <button class="btn-action btn-edit" onclick="editStatus(<?php echo $complaint['id']; ?>, '<?php echo $complaint['status']; ?>')" title="Edit Status">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Pagination -->
                <div class="pagination-container">
                    <div class="pagination-info">
                        Menampilkan <span id="showingCount"><?php echo count($complaints); ?></span> dari <span id="totalCount"><?php echo $stats['total']; ?></span> complaints
                    </div>
                    <div class="pagination-controls">
                        <button class="btn-page" id="prevPage" disabled>
                            <i class="fas fa-chevron-left"></i> Previous
                        </button>
                        <span class="page-numbers">
                            <button class="btn-page active">1</button>
                        </span>
                        <button class="btn-page" id="nextPage">
                            Next <i class="fas fa-chevron-right"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for viewing complaint details -->
    <div id="complaintModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3><i class="fas fa-comment-alt"></i> Complaint Details</h3>
                <button class="modal-close" onclick="closeModal()">&times;</button>
            </div>
            <div class="modal-body" id="modalBody">
                <!-- Content will be loaded here -->
            </div>
        </div>
    </div>

    <!-- Modal for editing status -->
    <div id="statusModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3><i class="fas fa-edit"></i> Update Status</h3>
                <button class="modal-close" onclick="closeStatusModal()">&times;</button>
            </div>
            <div class="modal-body">
                <form id="statusForm">
                    <input type="hidden" id="complaintId" name="complaint_id">
                    <div class="form-group">
                        <label for="newStatus">Status Baru:</label>
                        <select id="newStatus" name="status" class="form-control">
                            <option value="open">Open</option>
                            <option value="pending">Pending</option>
                            <option value="resolved">Resolved</option>
                        </select>
                    </div>
                    <div class="form-actions">
                        <button type="button" class="btn-cancel" onclick="closeStatusModal()">Cancel</button>
                        <button type="submit" class="btn-save">Update Status</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Pass PHP data to JavaScript
        window.complaintsData = {
            typeData: <?php echo json_encode($stats['by_type']); ?>,
            statusData: <?php echo json_encode($stats['by_status']); ?>
        };
    </script>
    <script src="./assets/js/complaints.js" defer></script>
</body>

</html>
