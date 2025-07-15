<?php
session_start();
require_once '../database/koneksi.php';

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
        case 'get_complaint_detail':
            echo json_encode(getComplaintDetail($conn, $_GET['id']));
            break;
        default:
            echo json_encode(['error' => 'Invalid action']);
    }
    exit();
}

function getComplaints($conn, $filters = []) {
    $sql = "SELECT uc.*, u.name, u.email FROM user_complaints uc LEFT JOIN users u ON uc.user_id = u.id WHERE 1=1";
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

    if (!empty($filters['date_from'])) {
        $sql .= " AND DATE(uc.created_at) >= ?";
        $params[] = $filters['date_from'];
        $types .= "s";
    }

    if (!empty($filters['date_to'])) {
        $sql .= " AND DATE(uc.created_at) <= ?";
        $params[] = $filters['date_to'];
        $types .= "s";
    }

    $sql .= " ORDER BY uc.created_at DESC";
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

function getReviews($conn, $filters = []) {
    $sql = "SELECT r.*, u.name, u.email FROM reviews r LEFT JOIN users u ON r.user_id = u.id WHERE 1=1";
    $params = [];
    $types = "";

    if (!empty($filters['rating'])) {
        $sql .= " AND r.rating = ?";
        $params[] = $filters['rating'];
        $types .= "i";
    }

    if (!empty($filters['date_from'])) {
        $sql .= " AND DATE(r.created_at) >= ?";
        $params[] = $filters['date_from'];
        $types .= "s";
    }

    if (!empty($filters['date_to'])) {
        $sql .= " AND DATE(r.created_at) <= ?";
        $params[] = $filters['date_to'];
        $types .= "s";
    }

    $sql .= " ORDER BY r.created_at DESC";
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

function updateComplaintStatus($conn, $data) {
    $sql = "UPDATE user_complaints SET status = ?, admin_response = ?, updated_at = NOW() WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssi", $data['status'], $data['response'], $data['id']);
    if ($stmt->execute()) {
        return ['success' => true, 'message' => 'Status updated successfully'];
    } else {
        return ['success' => false, 'message' => 'Failed to update status'];
    }
}

function getAnalytics($conn) {
    $analytics = [];
    $result = $conn->query("SELECT COUNT(*) as total FROM user_complaints");
    $row = $result->fetch_assoc();
    $analytics['total_complaints'] = $row['total'];

    $result = $conn->query("SELECT status, COUNT(*) as count FROM user_complaints GROUP BY status");
    $analytics['complaints_by_status'] = [];
    while ($row = $result->fetch_assoc()) {
        $analytics['complaints_by_status'][$row['status']] = $row['count'];
    }

    $result = $conn->query("SELECT AVG(rating) as avg_rating FROM reviews");
    $row = $result->fetch_assoc();
    $analytics['average_rating'] = round($row['avg_rating'], 1);

    $result = $conn->query("SELECT rating, COUNT(*) as count FROM reviews GROUP BY rating ORDER BY rating");
    $analytics['reviews_by_rating'] = [];
    while ($row = $result->fetch_assoc()) {
        $analytics['reviews_by_rating'][$row['rating']] = $row['count'];
    }

    return $analytics;
}

function getComplaintDetail($conn, $id) {
    $stmt = $conn->prepare("SELECT uc.*, u.name, u.email FROM user_complaints uc LEFT JOIN users u ON uc.user_id = u.id WHERE uc.id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();
    return $result->fetch_assoc();
}
?>
