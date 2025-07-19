<?php
require_once 'koneksi.php';

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed']);
    exit;
}

$input = json_decode(file_get_contents('php://input'), true);

if (json_last_error() !== JSON_ERROR_NONE) {
    echo json_encode(['success' => false, 'message' => 'Invalid JSON']);
    exit;
}

$action = $input['action'] ?? '';

try {
    switch ($action) {
        case 'filter':
            handleFilter($input);
            break;
        case 'get_detail':
            handleGetDetail($input);
            break;
        case 'update_status':
            handleUpdateStatus($input);
            break;
        default:
            echo json_encode(['success' => false, 'message' => 'Invalid action']);
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => 'Server error: ' . $e->getMessage()]);
}

function handleFilter($input) {
    global $conn;
    
    $status = $input['status'] ?? '';
    $type = $input['type'] ?? '';
    $limit = $input['limit'] ?? 50;
    $offset = $input['offset'] ?? 0;
    
    // Get filtered complaints
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
    $complaints = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    
    // Get updated stats
    $stats = getComplaintStats();
    
    echo json_encode([
        'success' => true,
        'complaints' => $complaints,
        'stats' => $stats
    ]);
}

function handleGetDetail($input) {
    global $conn;
    
    $id = $input['id'] ?? 0;
    
    if (!$id) {
        echo json_encode(['success' => false, 'message' => 'Invalid complaint ID']);
        return;
    }
    
    $stmt = $conn->prepare("
        SELECT uc.*, u.name as user_name, u.email as user_email, u.phone 
        FROM user_complaints uc 
        JOIN users u ON uc.user_id = u.id 
        WHERE uc.id = ?
    ");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($complaint = $result->fetch_assoc()) {
        echo json_encode([
            'success' => true,
            'complaint' => $complaint
        ]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Complaint not found']);
    }
}

function handleUpdateStatus($input) {
    global $conn;
    
    $complaint_id = $input['complaint_id'] ?? 0;
    $status = $input['status'] ?? '';
    
    if (!$complaint_id) {
        echo json_encode(['success' => false, 'message' => 'Invalid complaint ID']);
        return;
    }
    
    if (!in_array($status, ['open', 'pending', 'resolved'])) {
        echo json_encode(['success' => false, 'message' => 'Invalid status']);
        return;
    }
    
    $stmt = $conn->prepare("UPDATE user_complaints SET status = ? WHERE id = ?");
    $stmt->bind_param("si", $status, $complaint_id);
    
    if ($stmt->execute()) {
        if ($stmt->affected_rows > 0) {
            echo json_encode(['success' => true, 'message' => 'Status updated successfully']);
        } else {
            echo json_encode(['success' => false, 'message' => 'No changes made or complaint not found']);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'Failed to update status']);
    }
}

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
?>
