// --- Core Script for Complaints & Review Management ---

document.addEventListener("DOMContentLoaded", () => {
    // Secara default, muat data untuk tab pertama (complaints)
    switchTab(null, 'complaints');
});

/**
 * Fungsi utama untuk beralih antar tab (Complaints, Reviews, Analytics).
 * @param {Event} event - Objek event dari klik mouse.
 * @param {string} tabName - Nama tab yang akan diaktifkan ('complaints', 'reviews', 'analytics').
 */
function switchTab(event, tabName) {
    // Menghapus kelas 'active' dari semua konten dan tombol tab
    document.querySelectorAll(".tab-content").forEach(tab => tab.classList.remove("active"));
    document.querySelectorAll(".tab-btn").forEach(btn => btn.classList.remove("active"));

    // Menambahkan kelas 'active' ke tab dan tombol yang dipilih
    document.getElementById(`${tabName}-tab`).classList.add("active");
    // Menggunakan event.currentTarget jika event ada, jika tidak, cari tombol berdasarkan tabName
    const activeButton = event ? event.currentTarget : document.querySelector(`.tab-btn[onclick*="'${tabName}'"]`);
    if (activeButton) {
        activeButton.classList.add("active");
    }

    // Memuat data sesuai dengan tab yang aktif
    if (tabName === "complaints") {
        loadComplaints();
    } else if (tabName === "reviews") {
        loadReviews();
    }
}

// =================================================================================
// KELUHAN (COMPLAINTS)
// =================================================================================

/** Mengambil dan menampilkan data keluhan dari server */
async function loadComplaints() {
    const container = document.getElementById("complaints-list");
    container.innerHTML = `<div class="loading">Memuat Keluhan...</div>`;

    const filters = {
        status: document.getElementById("complaint-status-filter")?.value || "all",
        type: document.getElementById("complaint-type-filter")?.value || "all",
        period: document.getElementById("complaint-period-filter")?.value || "all",
        search: document.getElementById("complaint-search")?.value || "",
    };
    const queryString = new URLSearchParams(filters).toString();
    
    try {
        const response = await fetch(`complaints_review.php?action=get_complaints&${queryString}`);
        const complaints = await response.json();
        displayComplaints(complaints);
    } catch (error) {
        console.error("API Error:", error);
        container.innerHTML = `<div class="error">Gagal memuat data.</div>`;
    }
}

/** Menampilkan keluhan yang diterima dari server ke dalam DOM */
function displayComplaints(complaints) {
    const container = document.getElementById("complaints-list");
    container.innerHTML = "";

    if (!complaints || complaints.length === 0) {
        container.innerHTML = `<div class="no-data"><i class="fas fa-inbox"></i><p>Tidak ada keluhan ditemukan.</p></div>`;
        return;
    }

    complaints.forEach(complaint => {
        const div = document.createElement("div");
        div.className = "complaint-item";
        
        // **PERBAIKAN**: Menggunakan `complaint.name` sesuai data dari PHP
        const userName = complaint.name || 'Pengguna Anonim';
        const statusLabel = getStatusLabel(complaint.status);

        div.innerHTML = `
            <div class="complaint-header">
                <div class="user-info">
                    <i class="fas fa-user-circle"></i>
                    <span class="user-name">${userName}</span>
                </div>
                <div class="complaint-status">
                    <span class="status-badge status-${complaint.status}">${statusLabel}</span>
                </div>
            </div>
            <div class="complaint-body">
                <p class="complaint-description">${complaint.description}</p>
            </div>
            <div class="complaint-footer">
                <span class="complaint-meta"><i class="fas fa-tags"></i> Tipe: ${complaint.complaint_type}</span>
                <span class="complaint-meta"><i class="fas fa-calendar-alt"></i> ${new Date(complaint.created_at).toLocaleDateString('id-ID')}</span>
                <div class="complaint-actions">
                    <button class="btn-action-detail" onclick="showComplaintDetail(${JSON.stringify(complaint).replace(/"/g, "&quot;")})">
                        <i class="fas fa-eye"></i> Detail
                    </button>
                </div>
            </div>
        `;
        container.appendChild(div);
    });
}

/** Mengupdate status keluhan (open, pending, resolved) */
async function updateComplaintStatus(complaintId, newStatus) {
    const formData = new FormData();
    formData.append("complaint_id", complaintId);
    formData.append("status", newStatus);

    try {
        const response = await fetch("complaints_review.php?action=update_complaint_status", { method: "POST", body: formData });
        const result = await response.json();
        
        if (result && result.success) {
            showNotification(`Status keluhan #${complaintId} diubah menjadi ${newStatus}.`, 'success');
            loadComplaints();
        } else {
            showNotification(result?.message || "Gagal mengupdate status.", "error");
        }
    } catch (error) {
        console.error("Update Error:", error);
        showNotification("Gagal terhubung ke server.", "error");
    }
}

// =================================================================================
// ULASAN (REVIEWS)
// =================================================================================

/** Mengambil dan menampilkan data ulasan dari server */
async function loadReviews() {
    const container = document.getElementById("reviews-list");
    container.innerHTML = `<div class="loading">Memuat Ulasan...</div>`;

    const filters = {
        rating: document.getElementById("review-rating-filter")?.value || "all",
        product: document.getElementById("review-product-filter")?.value || "all",
        period: document.getElementById("review-period-filter")?.value || "all",
        search: document.getElementById("review-search")?.value || "",
    };
    const queryString = new URLSearchParams(filters).toString();

    try {
        const response = await fetch(`complaints_review.php?action=get_reviews&${queryString}`);
        const reviews = await response.json();
        displayReviews(reviews);
    } catch (error) {
        console.error("API Error:", error);
        container.innerHTML = `<div class="error">Gagal memuat data.</div>`;
    }
}

/** Menampilkan ulasan yang diterima dari server ke dalam DOM */
function displayReviews(reviews) {
    const container = document.getElementById("reviews-list");
    container.innerHTML = "";

    if (!reviews || reviews.length === 0) {
        container.innerHTML = `<div class="no-data"><i class="fas fa-comment-slash"></i><p>Tidak ada ulasan ditemukan.</p></div>`;
        return;
    }

    reviews.forEach(review => {
        const div = document.createElement("div");
        div.className = "review-item";
        const stars = generateStars(review.rating);
        // **PERBAIKAN**: Menggunakan `review.name` sesuai data dari PHP
        const userName = review.name || 'Pengguna Anonim';

        div.innerHTML = `
            <div class="review-header">
                <h4>${review.product_name || 'Produk Tidak Dikenal'}</h4>
                <div class="rating-stars">${stars} <span class="rating-number">${review.rating}/5</span></div>
            </div>
            <div class="review-body">
                <p class="review-text">${review.review_text}</p>
            </div>
            <div class="review-footer">
                <span><i class="fas fa-user"></i> ${userName}</span>
                <span><i class="fas fa-calendar-alt"></i> ${new Date(review.created_at).toLocaleDateString('id-ID')}</span>
            </div>
        `;
        container.appendChild(div);
    });
}

// =================================================================================
// FUNGSI PEMBANTU (UTILITIES)
// =================================================================================

/** Menampilkan notifikasi sementara di pojok kanan atas */
function showNotification(message, type = "info") {
    const notification = document.createElement("div");
    const icons = { success: "check-circle", error: "times-circle", info: "info-circle" };
    const colors = { success: "#28a745", error: "#dc3545", info: "#17a2b8" };
    
    notification.className = `notification notification-${type}`;
    notification.innerHTML = `<i class="fas fa-${icons[type]}"></i> ${message}`;
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        notification.classList.add('show');
    }, 10);
    
    setTimeout(() => {
        notification.classList.remove('show');
        setTimeout(() => {
            notification.remove();
        }, 500);
    }, 3000);
}

/** Membuat bintang rating berdasarkan nilai */
function generateStars(rating) {
    let stars = "";
    for (let i = 1; i <= 5; i++) {
        if (i <= rating) {
            stars += '<i class="fas fa-star filled"></i>';
        } else {
            stars += '<i class="fas fa-star empty"></i>';
        }
    }
    return stars;
}

function getStatusLabel(status) {
    const labels = { open: "Open", pending: "Pending", resolved: "Resolved" };
    return labels[status] || "Unknown";
}


// =================================================================================
// MODAL (DETAIL)
// =================================================================================

/** Menampilkan modal dengan detail keluhan */
function showComplaintDetail(complaint) {
    const modal = document.getElementById("complaintModal");
    const modalBody = document.getElementById("complaintModalBody");

    modalBody.innerHTML = `
        <div class="detail-info">
            <p><strong>User:</strong> ${complaint.name || 'N/A'}</p>
            <p><strong>Email:</strong> ${complaint.email || 'N/A'}</p>
            <p><strong>Tipe:</strong> ${complaint.complaint_type}</p>
            <p><strong>Tanggal:</strong> ${new Date(complaint.created_at).toLocaleString('id-ID')}</p>
            <p><strong>Status:</strong> <span class="status-badge status-${complaint.status}">${getStatusLabel(complaint.status)}</span></p>
        </div>
        <div class="detail-description">
            <label>Deskripsi Keluhan:</label>
            <p>${complaint.description}</p>
        </div>
        <div class="detail-actions">
            <button class="btn-primary" onclick="updateComplaintStatus(${complaint.id}, 'pending'); closeModal('complaintModal')">Set Pending</button>
            <button class="btn-primary" onclick="updateComplaintStatus(${complaint.id}, 'resolved'); closeModal('complaintModal')">Resolve</button>
        </div>
    `;
    modal.style.display = 'block';
}

/** Menutup modal yang sedang aktif */
function closeModal(modalId) {
    document.getElementById(modalId).style.display = 'none';
}

// Menutup modal jika user menekan tombol Escape
document.addEventListener("keydown", (event) => {
    if (event.key === "Escape") {
        closeModal("complaintModal");
        closeModal("reviewModal");
    }
});

// Menutup modal jika user klik di luar area konten modal
window.onclick = function(event) {
    const complaintModal = document.getElementById('complaintModal');
    const reviewModal = document.getElementById('reviewModal');
    if (event.target == complaintModal) {
        complaintModal.style.display = "none";
    }
    if (event.target == reviewModal) {
        reviewModal.style.display = "none";
    }
}


// =================================================================================
// EVENT LISTENERS UNTUK FILTER
// =================================================================================

// Variabel untuk debounce (menunda eksekusi fungsi agar tidak berjalan terlalu sering)
let searchTimeout;

// Fungsi untuk filter dan search keluhan
function filterComplaints() { loadComplaints(); }
function searchComplaints() {
    clearTimeout(searchTimeout);
    searchTimeout = setTimeout(() => loadComplaints(), 500);
}

// Fungsi untuk filter dan search ulasan
function filterReviews() { loadReviews(); }
function searchReviews() {
    clearTimeout(searchTimeout);
    searchTimeout = setTimeout(() => loadReviews(), 500);
}