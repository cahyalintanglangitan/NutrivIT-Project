// Product Management JavaScript

// Global variables
let products = [];
let filteredProducts = [];
let currentFilter = 'all';
let currentCategory = '';
let currentEditingProduct = null;

// Charts instances
let salesChart = null;
let categoryChart = null;

// Sample product data
const sampleProducts = [
    {
        id: 1,
        name: "NuVit-C Boost",
        description: "High potency vitamin C supplement for immunity boost",
        category: "Vitamin & Suplemen",
        price: 125000,
        stock: 850,
        sales: 2500,
        rating: 4.8,
        status: "active",
        image: "https://images.unsplash.com/photo-1550572017-edd951b55104?w=100&h=100&fit=crop",
        sku: "NUV-C-1000"
    },
    {
        id: 2,
        name: "NuVit-Multi Core",
        description: "Complete daily vitamin & mineral supplement",
        category: "Vitamin & Suplemen",
        price: 165000,
        stock: 234,
        sales: 1400,
        rating: 4.5,
        status: "active",
        image: "https://images.unsplash.com/photo-1550572017-edd951b55104?w=100&h=100&fit=crop",
        sku: "NUV-MUL-90"
    },
    {
        id: 3,
        name: "NuVit-Omega Brain",
        description: "Premium omega-3 for brain & heart health",
        category: "Vitamin & Suplemen",
        price: 180000,
        stock: 145,
        sales: 1650,
        rating: 4.6,
        status: "active",
        image: "https://images.unsplash.com/photo-1584017911766-d451b3d0e843?w=100&h=100&fit=crop",
        sku: "NUV-OMG-500"
    },
    {
        id: 4,
        name: "NuVit-Curcuma Gold",
        description: "Natural anti-inflammatory turmeric extract",
        category: "Herbal & Natural",
        price: 95000,
        stock: 186,
        sales: 1000,
        rating: 4.7,
        status: "active",
        image: "https://images.unsplash.com/photo-1559181567-c3190ca9959b?w=100&h=100&fit=crop",
        sku: "NUV-CUR-250"
    },
    {
        id: 5,
        name: "NuVit-Honey Natural",
        description: "Pure natural honey for energy & wellness",
        category: "Herbal & Natural",
        price: 85000,
        stock: 92,
        sales: 850,
        rating: 4.4,
        status: "active",
        image: "https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=100&h=100&fit=crop",
        sku: "NUV-HON-500"
    },
    {
        id: 6,
        name: "NuVit-Green Detox",
        description: "Organic green tea extract for detox & metabolism",
        category: "Herbal & Natural",
        price: 75000,
        stock: 67,
        sales: 700,
        rating: 4.2,
        status: "active",
        image: "https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=100&h=100&fit=crop",
        sku: "NUV-GRN-60"
    },
    {
        id: 7,
        name: "NuVit-Whey Muscle",
        description: "Premium whey protein isolate for muscle building",
        category: "Fitness & Protein",
        price: 340000,
        stock: 89,
        sales: 1900,
        rating: 4.7,
        status: "active",
        image: "https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=100&h=100&fit=crop",
        sku: "NUV-WHY-1KG"
    },
    {
        id: 8,
        name: "NuVit-BCAA Recovery",
        description: "Advanced BCAA complex for workout recovery",
        category: "Fitness & Protein",
        price: 225000,
        stock: 124,
        sales: 1200,
        rating: 4.5,
        status: "active",
        image: "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=100&h=100&fit=crop",
        sku: "NUV-BCA-300"
    }
];
// Initialize the application
document.addEventListener('DOMContentLoaded', function() {
    products = [...sampleProducts];
    filteredProducts = [...products];
    
    updateCurrentDate();
    updateStatistics();
    displayProducts();
    setupEventListeners();
    
    // Initialize charts after a short delay to ensure DOM is ready
    setTimeout(() => {
        initializeCharts();
    }, 100);
});

// Set current date
function updateCurrentDate() {
    const dateElement = document.getElementById('current-date');
    if (dateElement) {
        const now = new Date();
        const options = { 
            weekday: 'long', 
            year: 'numeric', 
            month: 'long', 
            day: 'numeric' 
        };
        dateElement.textContent = now.toLocaleDateString('id-ID', options);
    }
}

// Setup event listeners
function setupEventListeners() {
    // Search functionality
    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        searchInput.addEventListener('input', function() {
            filterProducts(this.value);
        });
    }
    
    // Category filter
    const categoryFilter = document.getElementById('categoryFilter');
    if (categoryFilter) {
        categoryFilter.addEventListener('change', function() {
            filterByCategory(this.value);
        });
    }
}

// Initialize charts
function initializeCharts() {
    console.log('Initializing charts...');
    
    // Check if Chart.js is loaded
    if (typeof Chart === 'undefined') {
        console.error('Chart.js is not loaded');
        showChartFallback('salesPerformanceChart', 'Chart library not loaded');
        showChartFallback('categoryChart', 'Chart library not loaded');
        return;
    }
    
    // Clear any existing error messages
    const salesContainer = document.querySelector('#salesPerformanceChart').parentElement;
    const categoryContainer = document.querySelector('#categoryChart').parentElement;
    
    if (salesContainer && !document.getElementById('salesPerformanceChart')) {
        salesContainer.innerHTML = '<canvas id="salesPerformanceChart"></canvas>';
    }
    
    if (categoryContainer && !document.getElementById('categoryChart')) {
        categoryContainer.innerHTML = '<canvas id="categoryChart"></canvas>';
    }
    
    // Initialize with a small delay
    setTimeout(() => {
        try {
            initSalesChart();
        } catch (error) {
            console.error('Failed to initialize sales chart:', error);
            showChartFallback('salesPerformanceChart', 'Failed to load Sales Chart');
        }
        
        try {
            initCategoryChart();
        } catch (error) {
            console.error('Failed to initialize category chart:', error);
            showChartFallback('categoryChart', 'Failed to load Category Chart');
        }
    }, 300);
}

// Initialize sales performance chart
function initSalesChart() {
    const ctx = document.getElementById('salesPerformanceChart');
    if (!ctx) {
        console.error('Sales chart canvas not found');
        return;
    }
    
    // Destroy existing chart if it exists
    if (salesChart) {
        salesChart.destroy();
    }
    
    const salesData = {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
        datasets: [{
            label: 'Sales (Rp Million)',
            data: [1.8, 2.1, 1.9, 2.4, 2.2, 2.6],
            borderColor: '#08A55A',
            backgroundColor: 'rgba(8, 165, 90, 0.1)',
            tension: 0.4,
            fill: true,
            pointBackgroundColor: '#08A55A',
            pointBorderColor: '#fff',
            pointBorderWidth: 2,
            pointRadius: 6
        }, {
            label: 'Orders',
            data: [145, 178, 162, 198, 185, 215],
            borderColor: '#3FCAEA',
            backgroundColor: 'rgba(63, 202, 234, 0.1)',
            tension: 0.4,
            fill: true,
            yAxisID: 'y1',
            pointBackgroundColor: '#3FCAEA',
            pointBorderColor: '#fff',
            pointBorderWidth: 2,
            pointRadius: 6
        }]
    };
    
    try {
        salesChart = new Chart(ctx, {
            type: 'line',
            data: salesData,
            options: {
                responsive: true,
                maintainAspectRatio: false,
                interaction: {
                    intersect: false,
                    mode: 'index'
                },
                plugins: {
                    legend: {
                        position: 'top',
                        labels: {
                            usePointStyle: true,
                            padding: 20
                        }
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0,0,0,0.8)',
                        titleColor: '#fff',
                        bodyColor: '#fff',
                        borderColor: '#ddd',
                        borderWidth: 1
                    }
                },
                scales: {
                    x: {
                        grid: {
                            display: false
                        },
                        ticks: {
                            color: '#666'
                        }
                    },
                    y: {
                        type: 'linear',
                        display: true,
                        position: 'left',
                        title: {
                            display: true,
                            text: 'Revenue (Rp Million)',
                            color: '#666'
                        },
                        grid: {
                            color: 'rgba(0,0,0,0.1)'
                        },
                        ticks: {
                            color: '#666'
                        }
                    },
                    y1: {
                        type: 'linear',
                        display: true,
                        position: 'right',
                        title: {
                            display: true,
                            text: 'Number of Orders',
                            color: '#666'
                        },
                        grid: {
                            drawOnChartArea: false,
                        },
                        ticks: {
                            color: '#666'
                        }
                    }
                }
            }
        });
        console.log('Sales chart initialized successfully');
    } catch (error) {
        console.error('Error initializing sales chart:', error);
    }
}

// Initialize category distribution chart
function initCategoryChart() {
    const ctx = document.getElementById('categoryChart');
    if (!ctx) {
        console.error('Category chart canvas not found');
        return;
    }
    
    // Destroy existing chart if it exists
    if (categoryChart) {
        categoryChart.destroy();
    }
    
    const categoryData = getCategoryDistribution();
    
    try {
        categoryChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: categoryData.labels,
                datasets: [{
                    data: categoryData.data,
                    backgroundColor: [
                        '#667eea',
                        '#43e97b',
                        '#f093fb',
                        '#ffeaa7'
                    ],
                    borderWidth: 3,
                    borderColor: '#fff',
                    hoverBorderWidth: 4,
                    hoverBorderColor: '#fff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '60%',
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding: 20,
                            usePointStyle: true,
                            font: {
                                size: 12
                            }
                        }
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0,0,0,0.8)',
                        titleColor: '#fff',
                        bodyColor: '#fff',
                        borderColor: '#ddd',
                        borderWidth: 1,
                        callbacks: {
                            label: function(context) {
                                const label = context.label || '';
                                const value = context.parsed;
                                const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                const percentage = ((value / total) * 100).toFixed(1);
                                return `${label}: ${value} produk (${percentage}%)`;
                            }
                        }
                    }
                },
                animation: {
                    animateRotate: true,
                    animateScale: true
                }
            }
        });
        console.log('Category chart initialized successfully');
    } catch (error) {
        console.error('Error initializing category chart:', error);
    }
}

// Get category distribution data
function getCategoryDistribution() {
    const categories = {};
    
    // Make sure we have products to analyze
    if (!products || products.length === 0) {
        return {
            labels: ['Vitamin & Suplemen', 'Herbal & Natural', 'Fitness & Protein'],
            data: [2, 2, 1] // Default data
        };
    }
    
    products.forEach(product => {
        if (product.category) {
            categories[product.category] = (categories[product.category] || 0) + 1;
        }
    });
    
    // If no categories found, use default
    if (Object.keys(categories).length === 0) {
        return {
            labels: ['Vitamin & Suplemen', 'Herbal & Natural', 'Fitness & Protein'],
            data: [2, 2, 1]
        };
    }
    
    return {
        labels: Object.keys(categories),
        data: Object.values(categories)
    };
}

// Add fallback chart display
function showChartFallback(chartId, message) {
    const container = document.querySelector(`#${chartId}`).parentElement;
    if (container) {
        container.innerHTML = `
            <div style="
                display: flex;
                align-items: center;
                justify-content: center;
                height: 300px;
                background: #f8f9fa;
                border-radius: 8px;
                color: #666;
                text-align: center;
                flex-direction: column;
                gap: 10px;
            ">
                <i class="fas fa-chart-line" style="font-size: 48px; opacity: 0.3;"></i>
                <div>${message}</div>
                <button onclick="initializeCharts()" style="
                    padding: 8px 16px;
                    background: #08A55A;
                    color: white;
                    border: none;
                    border-radius: 4px;
                    cursor: pointer;
                ">Retry</button>
            </div>
        `;
    }
}

// Update statistics
function updateStatistics() {
    const totalProducts = products.length;
    const totalRevenue = products.reduce((sum, product) => sum + (product.price * product.sales), 0);
    const bestSeller = products.reduce((best, product) => 
        product.sales > best.sales ? product : best, products[0]);
    const lowStockItems = products.filter(product => product.stock < 50).length;
    
    // Update DOM elements
    document.getElementById('totalProducts').textContent = totalProducts.toLocaleString();
    document.getElementById('totalRevenue').textContent = `Rp ${(totalRevenue / 1000000).toFixed(1)}M`;
    document.getElementById('bestSeller').textContent = bestSeller ? bestSeller.name : '-';
    document.getElementById('lowStockItems').textContent = lowStockItems;
    
    // Update filter button counts
    updateFilterCounts();
}

// Update filter button counts
function updateFilterCounts() {
    const inStockCount = products.filter(p => p.stock > 50).length;
    const lowStockCount = products.filter(p => p.stock > 0 && p.stock <= 50).length;
    const outOfStockCount = products.filter(p => p.stock === 0).length;
    
    document.getElementById('filterAll').textContent = `Semua (${products.length})`;
    document.getElementById('filterInStock').textContent = `Tersedia (${inStockCount})`;
    document.getElementById('filterLowStock').textContent = `Stok Rendah (${lowStockCount})`;
    document.getElementById('filterOutStock').textContent = `Habis (${outOfStockCount})`;
}

// Display products in table
function displayProducts() {
    const tbody = document.getElementById('productTableBody');
    if (!tbody) return;
    
    if (filteredProducts.length === 0) {
        tbody.innerHTML = `
            <tr>
                <td colspan="8" class="text-center">
                    <div class="empty-state">
                        <i class="fas fa-boxes"></i>
                        <h3>Tidak ada produk ditemukan</h3>
                        <p>Coba ubah filter atau kata kunci pencarian</p>
                    </div>
                </td>
            </tr>
        `;
        return;
    }
    
    tbody.innerHTML = filteredProducts.map(product => `
        <tr>
            <td>
                <div class="product-cell">
                    ${product.image ? 
                        `<img src="${product.image}" alt="${product.name}" class="product-image">` :
                        `<div class="product-placeholder"><i class="fas fa-image"></i></div>`
                    }
                    <div class="product-info">
                        <div class="product-name">${product.name}</div>
                        <div class="product-description">${product.description}</div>
                    </div>
                </div>
            </td>
            <td>
                <span class="category-badge category-${product.category.toLowerCase()}">
                    ${product.category}
                </span>
            </td>
            <td class="price-cell">Rp ${product.price.toLocaleString()}</td>
            <td>
                <span class="stock-indicator ${getStockClass(product.stock)}">
                    ${product.stock}
                </span>
            </td>
            <td>
                <div class="sales-cell">
                    <div class="sales-number">${product.sales.toLocaleString()}</div>
                    <div class="sales-trend">terjual</div>
                </div>
            </td>
            <td>
                <div class="rating-cell">
                    <div class="rating-stars">
                        ${generateStars(product.rating)}
                    </div>
                    <div class="rating-value">${product.rating}</div>
                </div>
            </td>
            <td>
                <span class="status-badge ${product.status}">
                    <i class="fas fa-${product.status === 'active' ? 'check-circle' : 'times-circle'}"></i>
                    ${product.status === 'active' ? 'Active' : 'Inactive'}
                </span>
            </td>
            <td>
                <div class="action-buttons">
                    <button class="btn-small btn-view" onclick="viewProduct(${product.id})">
                        <i class="fas fa-eye"></i>
                    </button>
                    <button class="btn-small btn-edit" onclick="editProduct(${product.id})">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn-small btn-delete" onclick="deleteProduct(${product.id})">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </td>
        </tr>
    `).join('');
}

// Get stock status class
function getStockClass(stock) {
    if (stock === 0) return 'stock-out';
    if (stock <= 20) return 'stock-low';
    if (stock <= 50) return 'stock-medium';
    return 'stock-high';
}

// Generate star rating HTML
function generateStars(rating) {
    const fullStars = Math.floor(rating);
    const hasHalfStar = rating % 1 !== 0;
    const emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
    
    let stars = '';
    
    // Full stars
    for (let i = 0; i < fullStars; i++) {
        stars += '<i class="fas fa-star"></i>';
    }
    
    // Half star
    if (hasHalfStar) {
        stars += '<i class="fas fa-star-half-alt"></i>';
    }
    
    // Empty stars
    for (let i = 0; i < emptyStars; i++) {
        stars += '<i class="far fa-star"></i>';
    }
    
    return stars;
}

// Filter products by search term
function filterProducts(searchTerm) {
    const term = searchTerm.toLowerCase();
    filteredProducts = products.filter(product => {
        const matchesSearch = !term || 
            product.name.toLowerCase().includes(term) ||
            product.description.toLowerCase().includes(term) ||
            product.category.toLowerCase().includes(term) ||
            product.sku.toLowerCase().includes(term);
        
        const matchesCategory = !currentCategory || product.category === currentCategory;
        const matchesStock = matchesStockFilter(product);
        
        return matchesSearch && matchesCategory && matchesStock;
    });
    
    displayProducts();
}

// Filter products by category
function filterByCategory(category) {
    currentCategory = category;
    const searchTerm = document.getElementById('searchInput').value;
    filterProducts(searchTerm);
}

// Filter products by stock status
function filterByStock(status) {
    currentFilter = status;
    
    // Update active filter button
    document.querySelectorAll('.filter-btn').forEach(btn => {
        btn.classList.remove('active');
    });
    event.target.classList.add('active');
    
    const searchTerm = document.getElementById('searchInput').value;
    filterProducts(searchTerm);
}

// Check if product matches current stock filter
function matchesStockFilter(product) {
    switch (currentFilter) {
        case 'in-stock':
            return product.stock > 50;
        case 'low-stock':
            return product.stock > 0 && product.stock <= 50;
        case 'out-of-stock':
            return product.stock === 0;
        default:
            return true;
    }
}

// Show add product modal
function showAddProductModal() {
    currentEditingProduct = null;
    document.getElementById('productModalTitle').innerHTML = '<i class="fas fa-plus"></i> Add New Product';
    document.getElementById('productForm').reset();
    document.getElementById('productModal').style.display = 'flex';
}

// View product details
function viewProduct(productId) {
    const product = products.find(p => p.id === productId);
    if (!product) return;
    
    const content = `
        <div class="product-detail">
            <div class="product-detail-header">
                ${product.image ? 
                    `<img src="${product.image}" alt="${product.name}" style="width: 120px; height: 120px; object-fit: cover; border-radius: 12px;">` :
                    `<div class="product-placeholder" style="width: 120px; height: 120px;"><i class="fas fa-image"></i></div>`
                }
                <div class="product-detail-info">
                    <h3>${product.name}</h3>
                    <p class="product-sku">SKU: ${product.sku}</p>
                    <span class="category-badge category-${product.category.toLowerCase()}">${product.category}</span>
                </div>
            </div>
            
            <div class="product-detail-stats">
                <div class="detail-stat">
                    <strong>Harga:</strong> Rp ${product.price.toLocaleString()}
                </div>
                <div class="detail-stat">
                    <strong>Stok:</strong> <span class="stock-indicator ${getStockClass(product.stock)}">${product.stock}</span>
                </div>
                <div class="detail-stat">
                    <strong>Penjualan:</strong> ${product.sales.toLocaleString()} unit
                </div>
                <div class="detail-stat">
                    <strong>Rating:</strong> 
                    <div class="rating-cell">
                        <span class="rating-stars">${generateStars(product.rating)}</span>
                        <span class="rating-value">${product.rating}</span>
                    </div>
                </div>
                <div class="detail-stat">
                    <strong>Status:</strong> 
                    <span class="status-badge ${product.status}">
                        <i class="fas fa-${product.status === 'active' ? 'check-circle' : 'times-circle'}"></i>
                        ${product.status === 'active' ? 'Active' : 'Inactive'}
                    </span>
                </div>
            </div>
            
            <div class="product-description-full">
                <strong>Deskripsi:</strong>
                <p>${product.description}</p>
            </div>
        </div>
        
        <style>
            .product-detail-header {
                display: flex;
                gap: 20px;
                margin-bottom: 20px;
                align-items: center;
            }
            
            .product-detail-info h3 {
                margin-bottom: 8px;
                color: #333;
            }
            
            .product-sku {
                color: #666;
                font-family: monospace;
                margin-bottom: 10px;
            }
            
            .product-detail-stats {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 15px;
                margin-bottom: 20px;
            }
            
            .detail-stat {
                padding: 10px;
                background: #f8f9fa;
                border-radius: 8px;
                display: flex;
                align-items: center;
                gap: 10px;
            }
            
            .product-description-full {
                padding: 15px;
                background: #f8f9fa;
                border-radius: 8px;
            }
        </style>
    `;
    
    document.getElementById('productDetailContent').innerHTML = content;
    document.getElementById('productDetailModal').style.display = 'flex';
}

// Edit product
function editProduct(productId) {
    const product = products.find(p => p.id === productId);
    if (!product) return;
    
    currentEditingProduct = product;
    document.getElementById('productModalTitle').innerHTML = '<i class="fas fa-edit"></i> Edit Product';
    
    // Fill form with product data
    document.getElementById('product-name').value = product.name;
    document.getElementById('product-category').value = product.category;
    document.getElementById('product-price').value = product.price;
    document.getElementById('product-stock').value = product.stock;
    document.getElementById('product-description').value = product.description;
    document.getElementById('product-image').value = product.image || '';
    
    document.getElementById('productModal').style.display = 'flex';
}

// Delete product
function deleteProduct(productId) {
    const product = products.find(p => p.id === productId);
    if (!product) return;
    
    if (confirm(`Apakah Anda yakin ingin menghapus produk "${product.name}"?`)) {
        products = products.filter(p => p.id !== productId);
        filteredProducts = filteredProducts.filter(p => p.id !== productId);
        
        updateStatistics();
        displayProducts();
        updateCharts();
        
        showNotification('Produk berhasil dihapus', 'success');
    }
}

// Save product (add or edit)
function saveProduct() {
    const form = document.getElementById('productForm');
    const formData = new FormData(form);
    
    const productData = {
        name: document.getElementById('product-name').value.trim(),
        category: document.getElementById('product-category').value,
        price: parseInt(document.getElementById('product-price').value),
        stock: parseInt(document.getElementById('product-stock').value),
        description: document.getElementById('product-description').value.trim(),
        image: document.getElementById('product-image').value.trim()
    };
    
    // Validation
    if (!productData.name || !productData.category || !productData.price || productData.stock < 0) {
        showNotification('Mohon lengkapi semua field yang wajib diisi', 'error');
        return;
    }
    
    if (currentEditingProduct) {
        // Edit existing product
        const index = products.findIndex(p => p.id === currentEditingProduct.id);
        if (index !== -1) {
            products[index] = {
                ...currentEditingProduct,
                ...productData,
                status: productData.stock > 0 ? 'active' : 'inactive'
            };
            showNotification('Produk berhasil diperbarui', 'success');
        }
    } else {
        // Add new product
        const newProduct = {
            id: Date.now(),
            ...productData,
            sales: 0,
            rating: 0,
            status: productData.stock > 0 ? 'active' : 'inactive',
            sku: generateSKU(productData.name, productData.category)
        };
        products.push(newProduct);
        showNotification('Produk berhasil ditambahkan', 'success');
    }
    
    // Update filtered products
    const searchTerm = document.getElementById('searchInput').value;
    filterProducts(searchTerm);
    
    updateStatistics();
    updateCharts();
    closeProductModal();
}

// Generate SKU
function generateSKU(name, category) {
    const namePrefix = name.substring(0, 3).toUpperCase();
    const categoryPrefix = category.substring(0, 3).toUpperCase();
    const randomNum = Math.floor(Math.random() * 1000).toString().padStart(3, '0');
    return `${namePrefix}-${categoryPrefix}-${randomNum}`;
}

// Close product modal
function closeProductModal() {
    document.getElementById('productModal').style.display = 'none';
    document.getElementById('productForm').reset();
    currentEditingProduct = null;
}

// Close product detail modal
function closeProductDetailModal() {
    document.getElementById('productDetailModal').style.display = 'none';
}

// Refresh product data
function refreshProductData() {
    showNotification('Data produk sedang dimuat ulang...', 'info');
    
    // Simulate loading
    setTimeout(() => {
        updateStatistics();
        displayProducts();
        updateCharts();
        showNotification('Data produk berhasil dimuat ulang', 'success');
    }, 1000);
}

// Update charts with current data
function updateCharts() {
    console.log('Updating charts...');
    
    // Update category chart
    if (categoryChart) {
        const categoryData = getCategoryDistribution();
        categoryChart.data.labels = categoryData.labels;
        categoryChart.data.datasets[0].data = categoryData.data;
        categoryChart.update('none'); // Update without animation
        console.log('Category chart updated');
    } else {
        console.warn('Category chart not initialized, reinitializing...');
        initCategoryChart();
    }
    
    // Sales chart can be updated with real data if needed
    if (salesChart) {
        console.log('Sales chart is ready');
    } else {
        console.warn('Sales chart not initialized, reinitializing...');
        initSalesChart();
    }
}

// Add window load event as backup
window.addEventListener('load', function() {
    console.log('Window loaded, checking charts...');
    
    // Double-check charts are initialized
    setTimeout(() => {
        if (!salesChart || !categoryChart) {
            console.log('Reinitializing charts after window load...');
            initializeCharts();
        }
    }, 500);
});

// Export data
function exportData(format) {
    if (format === 'excel') {
        exportToExcel();
    } else if (format === 'pdf') {
        exportToPDF();
    }
}

// Export to Excel (simulated)
function exportToExcel() {
    showNotification('Exporting to Excel...', 'info');
    
    // In a real application, you would use a library like SheetJS
    setTimeout(() => {
        showNotification('Data berhasil diekspor ke Excel', 'success');
    }, 1500);
}

// Export to PDF (simulated)
function exportToPDF() {
    showNotification('Exporting to PDF...', 'info');
    
    // In a real application, you would use a library like jsPDF
    setTimeout(() => {
        showNotification('Data berhasil diekspor ke PDF', 'success');
    }, 1500);
}

// Show notification
function showNotification(message, type = 'info') {
    // Create notification element
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.innerHTML = `
        <div class="notification-content">
            <i class="fas fa-${getNotificationIcon(type)}"></i>
            <span>${message}</span>
        </div>
    `;
    
    // Add styles
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: ${getNotificationColor(type)};
        color: white;
        padding: 15px 20px;
        border-radius: 8px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        z-index: 9999;
        min-width: 300px;
        transform: translateX(100%);
        transition: transform 0.3s ease;
    `;
    
    document.body.appendChild(notification);
    
    // Animate in
    setTimeout(() => {
        notification.style.transform = 'translateX(0)';
    }, 100);
    
    // Remove after 3 seconds
    setTimeout(() => {
        notification.style.transform = 'translateX(100%)';
        setTimeout(() => {
            if (notification.parentNode) {
                notification.parentNode.removeChild(notification);
            }
        }, 300);
    }, 3000);
}

// Get notification icon
function getNotificationIcon(type) {
    switch (type) {
        case 'success': return 'check-circle';
        case 'error': return 'exclamation-triangle';
        case 'warning': return 'exclamation-circle';
        default: return 'info-circle';
    }
}

// Get notification color
function getNotificationColor(type) {
    switch (type) {
        case 'success': return '#10b981';
        case 'error': return '#ef4444';
        case 'warning': return '#f59e0b';
        default: return '#3b82f6';
    }
}

// Handle logout
function handleLogout() {
    if (confirm('Apakah Anda yakin ingin keluar?')) {
        showNotification('Logging out...', 'info');
        
        setTimeout(() => {
            // In a real application, you would redirect to login page
            window.location.href = 'login.html';
        }, 1000);
    }
}

// Close modals when clicking outside
window.addEventListener('click', function(event) {
    const productModal = document.getElementById('productModal');
    const productDetailModal = document.getElementById('productDetailModal');
    
    if (event.target === productModal) {
        closeProductModal();
    }
    
    if (event.target === productDetailModal) {
        closeProductDetailModal();
    }
});

// Handle escape key to close modals
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeProductModal();
        closeProductDetailModal();
    }
});

// Auto-refresh statistics every 30 seconds (optional)
setInterval(() => {
    // In a real application, you might fetch new data from the server
    updateStatistics();
}, 30000);