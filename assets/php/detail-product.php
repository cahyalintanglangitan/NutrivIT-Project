<?php
require_once 'koneksi.php';
header('Content-Type: application/json');

// Validasi parameter
if (!isset($_GET['id'])) {
    http_response_code(400);
    echo json_encode(['error' => 'ID produk diperlukan']);
    exit;
}

$id = $_GET['id'];

// Query detail produk
$query = "
    SELECT 
        p.id,
        p.name,
        p.category,
        p.description,
        p.price,
        p.stock,
        p.image_url,
        p.product_status,
        IFNULL(SUM(oi.quantity), 0) AS total_sold,
        ROUND(AVG(pr.rating), 1) AS avg_rating
    FROM products p
    LEFT JOIN order_items oi ON p.id = oi.product_id
    LEFT JOIN product_reviews pr ON p.id = pr.product_id
    WHERE p.id = ?
    GROUP BY 
        p.id, p.name, p.category, p.description, p.price, 
        p.stock, p.image_url, p.product_status
";

$stmt = $conn->prepare($query);
$stmt->bind_param("s", $id);
$stmt->execute();
$result = $stmt->get_result();

if ($product = $result->fetch_assoc()) {
    echo json_encode([
        'id'             => $product['id'],
        'name'           => $product['name'],
        'category'       => $product['category'],
        'description'    => $product['description'] ?? '-',
        'price'          => (float)$product['price'],
        'stock'          => (int)$product['stock'],
        'image_url'      => $product['image_url'] ?? '',
        'product_status' => $product['product_status'],
        'total_sold'     => (int)$product['total_sold'],
        'rating'         => $product['avg_rating'] !== null ? (float)$product['avg_rating'] : '-'
    ]);
} else {
    http_response_code(404);
    echo json_encode(['error' => 'Produk tidak ditemukan']);
}
?>
