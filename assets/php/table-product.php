<?php
include 'koneksi.php';


$query = "
    SELECT 
        p.id,
        p.name,
        p.category,
        p.price,
        p.stock,
        p.product_status,
        p.description,
        ROUND(AVG(r.rating), 1) AS avg_rating
    FROM products p
    LEFT JOIN product_reviews r ON p.id = r.product_id
    GROUP BY p.id
    ORDER BY p.created_at DESC
";

$result = $conn->query($query);

if ($result && $result->num_rows > 0):
    while ($row = $result->fetch_assoc()):
        // Proses data
        $id = htmlspecialchars($row['id']);
        $name = htmlspecialchars($row['name']);
        $category = htmlspecialchars($row['category']);
        $categoryLabel = ucfirst(str_replace('_', ' ', $category));
        $price = number_format($row['price'], 0, ',', '.');
        $stock = (int)$row['stock'];
        $stockLevel = $stock > 200 ? 'high' : ($stock > 100 ? 'medium' : 'low');
        $status = $row['product_status'] === 'Active' ? 'active' : 'inactive';
        $statusIcon = $status === 'active' ? 'check-circle' : 'times-circle';
        $description = htmlspecialchars($row['description']);
        $rating = $row['avg_rating'] !== null ? $row['avg_rating'] . ' ★' : '-';
?>
<tr>
    <td>
        <div class="product-cell">
            <div class="product-placeholder"><i class="fas fa-image"></i></div>
            <div class="product-info">
                <div class="product-name"><?= $name ?></div>
                <div class="product-sku">ID: <?= $id ?></div>
            </div>
        </div>
    </td>
    <td><span class="category-badge category-<?= $category ?>"><?= $categoryLabel ?></span></td>
    <td class="price-cell">Rp <?= $price ?></td>
    <td><span class="stock-indicator stock-<?= $stockLevel ?>"><?= $stock ?></span></td>
    <td><?= $rating ?></td>
    <td>
        <span class="status-badge <?= $status ?>">
            <i class="fas fa-<?= $statusIcon ?>"></i> <?= ucfirst($status) ?>
        </span>
    </td>
    <td>
        <div class="action-buttons">
            <button class="btn-small btn-view" onclick="viewProductDetail(
                '<?= addslashes($name) ?>',
                '<?= $id ?>',
                '<?= $category ?>',
                'Rp <?= $price ?>',
                '<?= $stock ?>',
                '<?= $rating ?>',
                '<?= ucfirst($status) ?>',
                '<?= addslashes($description) ?>')">
                <i class="fas fa-eye"></i> Lihat Detail
            </button>
        </div>
    </td>
</tr>
<?php
    endwhile;
else:
?>
<script>document.getElementById('noDataMessage').style.display = 'table-row';</script>
<?php endif; ?>
