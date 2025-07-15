document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('current-date').textContent = new Date().toLocaleDateString('id-ID', {
        weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'
    });

    loadComplaints();
    loadReviews();
    renderCharts();
});

// === TAB SWITCHING ===
function switchTab(tabName) {
    document.querySelectorAll('.tab-content').forEach(tab => tab.classList.remove('active'));
    document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
    document.getElementById(`${tabName}-tab`).classList.add('active');
    document.querySelector(`.tab-btn[onclick="switchTab('${tabName}')"]`).classList.add('active');
}

// === COMPLAINTS ===
function loadComplaints(filters = {}) {
    fetch(`complaints_review.php?action=get_complaints&${new URLSearchParams(filters)}`)
        .then(res => res.json())
        .then(data => {
            const container = document.getElementById('complaints-list');
            container.innerHTML = '';

            if (data.length === 0) {
                container.innerHTML = '<p class="empty-msg">No complaints found.</p>';
                return;
            }

            data.forEach(item => {
                const complaintHTML = `
                    <div class="complaint-item">
                        <div class="complaint-header">
                            <strong>${item.name || 'Anonim'}</strong> (${item.email})
                            <span class="status ${item.status}">${item.status}</span>
                        </div>
                        <div class="complaint-body">
                            <p><strong>Type:</strong> ${item.complaint_type}</p>
                            <p>${item.description}</p>
                            <button class="btn-small" onclick="showComplaintModal(${item.id}, '${item.status}')">Detail</button>
                        </div>
                    </div>
                `;
                container.innerHTML += complaintHTML;
            });
        });
}

function filterComplaints() {
    const status = document.getElementById('complaint-status-filter').value;
    const type = document.getElementById('complaint-type-filter').value;
    const period = document.getElementById('complaint-period-filter').value;
    const search = document.getElementById('complaint-search').value;

    loadComplaints({ status, type, period, search });
}

function searchComplaints() {
    filterComplaints();
}

function showComplaintModal(id, currentStatus) {
    // Open modal
    document.getElementById('complaintModal').style.display = 'flex';

    const modalBody = document.getElementById('complaintModalBody');
    modalBody.innerHTML = `<p>Loading...</p>`;

    fetch(`complaints_review.php?action=get_complaints`)
        .then(res => res.json())
        .then(data => {
            const complaint = data.find(c => c.id == id);
            if (!complaint) return;

            modalBody.innerHTML = `
                <p><strong>Name:</strong> ${complaint.name}</p>
                <p><strong>Email:</strong> ${complaint.email}</p>
                <p><strong>Type:</strong> ${complaint.complaint_type}</p>
                <p><strong>Description:</strong></p>
                <p>${complaint.description}</p>
                <p><strong>Status:</strong></p>
                <select id="update-status">
                    <option value="open" ${complaint.status === 'open' ? 'selected' : ''}>Open</option>
                    <option value="pending" ${complaint.status === 'pending' ? 'selected' : ''}>Pending</option>
                    <option value="resolved" ${complaint.status === 'resolved' ? 'selected' : ''}>Resolved</option>
                </select>
                <br><br>
                <button class="btn-primary" onclick="updateComplaintStatus(${id})">Update Status</button>
            `;
        });
}

function updateComplaintStatus(id) {
    const newStatus = document.getElementById('update-status').value;

    const formData = new FormData();
    formData.append('complaint_id', id);
    formData.append('status', newStatus);

    fetch(`complaints_review.php?action=update_complaint_status`, {
        method: 'POST',
        body: formData
    }).then(res => res.json())
      .then(response => {
          alert(response.message);
          closeModal('complaintModal');
          filterComplaints();
      });
}

// === REVIEWS ===
function loadReviews(filters = {}) {
    fetch(`complaints_review.php?action=get_reviews&${new URLSearchParams(filters)}`)
        .then(res => res.json())
        .then(data => {
            const container = document.getElementById('reviews-list');
            container.innerHTML = '';

            if (data.length === 0) {
                container.innerHTML = '<p class="empty-msg">No reviews found.</p>';
                return;
            }

            data.forEach(item => {
                const reviewHTML = `
                    <div class="review-item">
                        <div class="review-header">
                            <strong>${item.username || 'Anonim'}</strong> reviewed <em>${item.product_name}</em>
                            <span class="rating">${'★'.repeat(Math.round(item.rating))}</span>
                        </div>
                        <div class="review-body">
                            <p>${item.review_text}</p>
                            <button class="btn-small" onclick="showReviewModal(${item.id})">Detail</button>
                        </div>
                    </div>
                `;
                container.innerHTML += reviewHTML;
            });
        });
}

function filterReviews() {
    const rating = document.getElementById('review-rating-filter').value;
    const product = document.getElementById('review-product-filter').value;
    const period = document.getElementById('review-period-filter').value;
    const search = document.getElementById('review-search').value;

    loadReviews({ rating, product, period, search });
}

function searchReviews() {
    filterReviews();
}

function showReviewModal(id) {
    document.getElementById('reviewModal').style.display = 'flex';

    const modalBody = document.getElementById('reviewModalBody');
    modalBody.innerHTML = `<p>Loading...</p>`;

    fetch(`complaints_review.php?action=get_reviews`)
        .then(res => res.json())
        .then(data => {
            const review = data.find(r => r.id == id);
            if (!review) return;

            modalBody.innerHTML = `
                <p><strong>User:</strong> ${review.username}</p>
                <p><strong>Email:</strong> ${review.email}</p>
                <p><strong>Product:</strong> ${review.product_name}</p>
                <p><strong>Rating:</strong> ${review.rating}</p>
                <p><strong>Review:</strong></p>
                <p>${review.review_text}</p>
            `;
        });
}

// === CHARTS & ANALYTICS ===
function renderCharts() {
    const ctxTrend = document.getElementById('complaintTrendsChart').getContext('2d');
    const ctxTypes = document.getElementById('complaintTypesChart').getContext('2d');
    const ctxRatings = document.getElementById('ratingDistributionChart').getContext('2d');

    // Complaint Trends
    new Chart(ctxTrend, {
        type: 'line',
        data: {
            labels: analyticsData.complaint_trends.map(row => row.month),
            datasets: [{
                label: 'Complaints',
                data: analyticsData.complaint_trends.map(row => row.count),
                borderColor: '#e74c3c',
                backgroundColor: 'rgba(231, 76, 60, 0.2)',
                tension: 0.3,
                fill: true
            }]
        }
    });

    // Complaint Types Pie
    new Chart(ctxTypes, {
        type: 'pie',
        data: {
            labels: analyticsData.complaint_types.map(row => row.complaint_type),
            datasets: [{
                data: analyticsData.complaint_types.map(row => row.count),
                backgroundColor: ['#f39c12', '#2ecc71', '#3498db', '#9b59b6', '#34495e', '#95a5a6']
            }]
        }
    });

    // Rating Distribution
    new Chart(ctxRatings, {
        type: 'bar',
        data: {
            labels: analyticsData.rating_distribution.map(r => `${r.rating_floor} Stars`),
            datasets: [{
                label: 'Reviews',
                data: analyticsData.rating_distribution.map(r => r.count),
                backgroundColor: '#f1c40f'
            }]
        }
    });
}

// === MODAL ===
function closeModal(id) {
    document.getElementById(id).style.display = 'none';
}
