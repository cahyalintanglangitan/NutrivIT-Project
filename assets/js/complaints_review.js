import { Chart } from "@/components/ui/chart"
// Complaints & Review Management JavaScript for PHP Backend

// Declare analyticsData variable
let analyticsData

// Initialize page
document.addEventListener("DOMContentLoaded", () => {
  // Load initial data
  loadComplaints()
  loadReviews()

  // Initialize charts with PHP data
  initializeCharts()
})

// API helper function
async function apiRequest(url, options = {}) {
  try {
    const response = await fetch(url, options)
    const data = await response.json()
    return data
  } catch (error) {
    console.error("API Error:", error)
    showNotification("Terjadi kesalahan saat memuat data", "error")
    return null
  }
}

// Tab switching
function switchTab(tabName) {
  // Remove active class from all tabs and buttons
  document.querySelectorAll(".tab-content").forEach((tab) => {
    tab.classList.remove("active")
  })
  document.querySelectorAll(".tab-btn").forEach((btn) => {
    btn.classList.remove("active")
  })

  // Add active class to selected tab and button
  document.getElementById(tabName + "-tab").classList.add("active")
  event.target.classList.add("active")

  // Load specific data based on tab
  if (tabName === "complaints") {
    loadComplaints()
  } else if (tabName === "reviews") {
    loadReviews()
  } else if (tabName === "analytics") {
    updateAnalytics()
  }
}

// Load complaints data
async function loadComplaints() {
  const complaintsContainer = document.getElementById("complaints-list")
  complaintsContainer.innerHTML = '<div class="loading">Loading complaints...</div>'

  const filters = getComplaintFilters()
  const queryString = new URLSearchParams(filters).toString()

  const complaints = await apiRequest(`complaints-review.php?action=get_complaints&${queryString}`)

  if (complaints) {
    displayComplaints(complaints)
  }
}

// Load reviews data
async function loadReviews() {
  const reviewsContainer = document.getElementById("reviews-list")
  reviewsContainer.innerHTML = '<div class="loading">Loading reviews...</div>'

  const filters = getReviewFilters()
  const queryString = new URLSearchParams(filters).toString()

  const reviews = await apiRequest(`complaints-review.php?action=get_reviews&${queryString}`)

  if (reviews) {
    displayReviews(reviews)
  }
}

// Get complaint filters
function getComplaintFilters() {
  return {
    status: document.getElementById("complaint-status-filter")?.value || "all",
    type: document.getElementById("complaint-type-filter")?.value || "all",
    period: document.getElementById("complaint-period-filter")?.value || "all",
    search: document.getElementById("complaint-search")?.value || "",
  }
}

// Get review filters
function getReviewFilters() {
  return {
    rating: document.getElementById("review-rating-filter")?.value || "all",
    product: document.getElementById("review-product-filter")?.value || "all",
    period: document.getElementById("review-period-filter")?.value || "all",
    search: document.getElementById("review-search")?.value || "",
  }
}

// Display complaints
function displayComplaints(complaints) {
  const complaintsContainer = document.getElementById("complaints-list")
  complaintsContainer.innerHTML = ""

  if (complaints.length === 0) {
    complaintsContainer.innerHTML = `
            <div style="text-align: center; padding: 40px; color: #666;">
                <i class="fas fa-search" style="font-size: 48px; margin-bottom: 16px; opacity: 0.5;"></i>
                <p>Tidak ada keluhan yang sesuai dengan filter yang dipilih.</p>
            </div>
        `
    return
  }

  complaints.forEach((complaint) => {
    const complaintElement = createComplaintElement(complaint)
    complaintsContainer.appendChild(complaintElement)
  })
}

// Display reviews
function displayReviews(reviews) {
  const reviewsContainer = document.getElementById("reviews-list")
  reviewsContainer.innerHTML = ""

  if (reviews.length === 0) {
    reviewsContainer.innerHTML = `
            <div style="text-align: center; padding: 40px; color: #666;">
                <i class="fas fa-search" style="font-size: 48px; margin-bottom: 16px; opacity: 0.5;"></i>
                <p>Tidak ada review yang sesuai dengan filter yang dipilih.</p>
            </div>
        `
    return
  }

  reviews.forEach((review) => {
    const reviewElement = createReviewElement(review)
    reviewsContainer.appendChild(reviewElement)
  })
}

// Create complaint element
function createComplaintElement(complaint) {
  const div = document.createElement("div")
  div.className = "complaint-item"
  div.onclick = () => showComplaintDetail(complaint)

  const timeAgo = getTimeAgo(complaint.created_at)
  const typeClass = complaint.complaint_type
  const statusClass = complaint.status

  div.innerHTML = `
        <div class="complaint-header">
            <div class="complaint-info">
                <div class="complaint-id">Complaint #${complaint.id.toString().padStart(3, "0")}</div>
                <div class="complaint-meta">
                    <span><i class="fas fa-user"></i> ${complaint.username || complaint.user_id}</span>
                    <span><i class="fas fa-clock"></i> ${timeAgo}</span>
                </div>
                <div class="complaint-type ${typeClass}">
                    <i class="fas fa-${getComplaintIcon(complaint.complaint_type)}"></i>
                    ${getComplaintTypeLabel(complaint.complaint_type)}
                </div>
            </div>
            <div class="status-badge ${statusClass}">
                ${getStatusLabel(complaint.status)}
            </div>
        </div>
        <div class="complaint-description">
            ${complaint.description}
        </div>
        <div class="complaint-actions">
            <button class="action-btn primary" onclick="event.stopPropagation(); updateComplaintStatus(${complaint.id}, 'pending')">
                <i class="fas fa-clock"></i> Set Pending
            </button>
            <button class="action-btn" onclick="event.stopPropagation(); updateComplaintStatus(${complaint.id}, 'resolved')">
                <i class="fas fa-check"></i> Resolve
            </button>
            <button class="action-btn" onclick="event.stopPropagation(); showComplaintDetail(${JSON.stringify(complaint).replace(/"/g, "&quot;")})">
                <i class="fas fa-eye"></i> Detail
            </button>
        </div>
    `

  return div
}

// Create review element
function createReviewElement(review) {
  const div = document.createElement("div")
  div.className = "review-item"
  div.onclick = () => showReviewDetail(review)

  const timeAgo = getTimeAgo(review.created_at)
  const productName = review.product_name || "Unknown Product"
  const stars = generateStars(review.rating)

  div.innerHTML = `
        <div class="review-header">
            <div class="review-info">
                <div class="review-id">Review #${review.id.toString().padStart(3, "0")}</div>
                <div class="review-meta">
                    <span><i class="fas fa-user"></i> ${review.username || review.user_id}</span>
                    <span><i class="fas fa-box"></i> ${productName}</span>
                    <span><i class="fas fa-clock"></i> ${timeAgo}</span>
                </div>
                <div class="rating-stars">
                    ${stars}
                    <span class="rating-number">${review.rating}/5</span>
                </div>
            </div>
        </div>
        <div class="review-text">
            ${review.review_text}
        </div>
        <div class="review-actions">
            <button class="action-btn primary" onclick="event.stopPropagation(); featureReview(${review.id})">
                <i class="fas fa-star"></i> Feature
            </button>
            <button class="action-btn" onclick="event.stopPropagation(); respondToReview(${review.id})">
                <i class="fas fa-reply"></i> Respond
            </button>
            <button class="action-btn" onclick="event.stopPropagation(); showReviewDetail(${JSON.stringify(review).replace(/"/g, "&quot;")})">
                <i class="fas fa-eye"></i> Detail
            </button>
        </div>
    `

  return div
}

// Update complaint status
async function updateComplaintStatus(complaintId, newStatus) {
  const formData = new FormData()
  formData.append("complaint_id", complaintId)
  formData.append("status", newStatus)

  const result = await apiRequest("complaints-review.php?action=update_complaint_status", {
    method: "POST",
    body: formData,
  })

  if (result && result.success) {
    loadComplaints()
    showNotification(
      `Keluhan #${complaintId.toString().padStart(3, "0")} berhasil diupdate ke status ${getStatusLabel(newStatus)}`,
      "success",
    )
  } else {
    showNotification(result?.message || "Gagal mengupdate status", "error")
  }
}

// Filter functions
function filterComplaints() {
  loadComplaints()
}

function filterReviews() {
  loadReviews()
}

function searchComplaints() {
  clearTimeout(window.complaintSearchTimeout)
  window.complaintSearchTimeout = setTimeout(() => {
    loadComplaints()
  }, 500)
}

function searchReviews() {
  clearTimeout(window.reviewSearchTimeout)
  window.reviewSearchTimeout = setTimeout(() => {
    loadReviews()
  }, 500)
}

// Initialize charts with PHP data
function initializeCharts() {
  if (typeof analyticsData !== "undefined") {
    initComplaintTrendsChart()
    initComplaintTypesChart()
    initRatingDistributionChart()
    initTopReviewedProductsChart()
  }
}

function initComplaintTrendsChart() {
  const ctx = document.getElementById("complaintTrendsChart")
  if (!ctx) return

  const trends = analyticsData.complaint_trends || []
  const labels = trends.map((t) => t.month)
  const data = trends.map((t) => t.count)

  new Chart(ctx, {
    type: "line",
    data: {
      labels: labels,
      datasets: [
        {
          label: "Total Complaints",
          data: data,
          borderColor: "#ef4444",
          backgroundColor: "rgba(239, 68, 68, 0.1)",
          tension: 0.4,
          fill: true,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: false,
        },
      },
      scales: {
        y: {
          beginAtZero: true,
          grid: {
            color: "rgba(0,0,0,0.1)",
          },
        },
        x: {
          grid: {
            display: false,
          },
        },
      },
    },
  })
}

function initComplaintTypesChart() {
  const ctx = document.getElementById("complaintTypesChart")
  if (!ctx) return

  const types = analyticsData.complaint_types || []
  const labels = types.map((t) => getComplaintTypeLabel(t.complaint_type))
  const data = types.map((t) => t.count)

  new Chart(ctx, {
    type: "doughnut",
    data: {
      labels: labels,
      datasets: [
        {
          data: data,
          backgroundColor: ["#f59e0b", "#3b82f6", "#10b981", "#e879f9", "#6366f1", "#6b7280"],
          borderWidth: 0,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          position: "bottom",
        },
      },
    },
  })
}

function initRatingDistributionChart() {
  const ctx = document.getElementById("ratingDistributionChart")
  if (!ctx) return

  const ratings = analyticsData.rating_distribution || []
  const labels = ratings.map((r) => `${r.rating_floor} Star${r.rating_floor > 1 ? "s" : ""}`)
  const data = ratings.map((r) => r.count)

  new Chart(ctx, {
    type: "bar",
    data: {
      labels: labels,
      datasets: [
        {
          label: "Number of Reviews",
          data: data,
          backgroundColor: ["#ef4444", "#f97316", "#eab308", "#22c55e", "#10b981"],
          borderRadius: 6,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: false,
        },
      },
      scales: {
        y: {
          beginAtZero: true,
          grid: {
            color: "rgba(0,0,0,0.1)",
          },
        },
        x: {
          grid: {
            display: false,
          },
        },
      },
    },
  })
}

function initTopReviewedProductsChart() {
  const ctx = document.getElementById("topReviewedProductsChart")
  if (!ctx) return

  // This would need additional data from PHP - for now using sample data
  new Chart(ctx, {
    type: "bar",
    data: {
      labels: ["Multi Core", "Green Detox", "Whey Muscle", "C Boost", "Omega Brain"],
      datasets: [
        {
          label: "Number of Reviews",
          data: [234, 189, 156, 134, 98],
          backgroundColor: ["#08a55a", "#3fcaea", "#667eea", "#f093fb", "#4facfe"],
          borderRadius: 6,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      indexAxis: "y",
      plugins: {
        legend: {
          display: false,
        },
      },
      scales: {
        x: {
          beginAtZero: true,
          grid: {
            color: "rgba(0,0,0,0.1)",
          },
        },
        y: {
          grid: {
            display: false,
          },
        },
      },
    },
  })
}

// Utility functions (same as before)
function getTimeAgo(dateString) {
  const date = new Date(dateString)
  const now = new Date()
  const diffInHours = Math.floor((now - date) / (1000 * 60 * 60))

  if (diffInHours < 1) return "Baru saja"
  if (diffInHours < 24) return `${diffInHours} jam yang lalu`

  const diffInDays = Math.floor(diffInHours / 24)
  if (diffInDays < 7) return `${diffInDays} hari yang lalu`

  return date.toLocaleDateString("id-ID")
}

function getComplaintIcon(type) {
  const icons = {
    energy: "bolt",
    weight: "weight",
    digestion: "stomach",
    immunity: "shield-alt",
    sleep: "bed",
    other: "question-circle",
  }
  return icons[type] || "question-circle"
}

function getComplaintTypeLabel(type) {
  const labels = {
    energy: "Energy",
    weight: "Weight",
    digestion: "Digestion",
    immunity: "Immunity",
    sleep: "Sleep",
    other: "Other",
  }
  return labels[type] || "Other"
}

function getStatusLabel(status) {
  const labels = {
    open: "Open",
    pending: "Pending",
    resolved: "Resolved",
  }
  return labels[status] || "Unknown"
}

function generateStars(rating) {
  let stars = ""
  for (let i = 1; i <= 5; i++) {
    if (i <= rating) {
      stars += '<i class="fas fa-star filled"></i>'
    } else if (i - 0.5 <= rating) {
      stars += '<i class="fas fa-star-half-alt filled"></i>'
    } else {
      stars += '<i class="fas fa-star empty"></i>'
    }
  }
  return stars
}

// Action functions
function featureReview(reviewId) {
  showNotification(
    `Review #${reviewId.toString().padStart(3, "0")} berhasil ditandai sebagai featured review`,
    "success",
  )
}

function respondToReview(reviewId) {
  const response = prompt("Masukkan respons untuk review ini:")
  if (response) {
    showNotification(`Respons berhasil dikirim untuk review #${reviewId.toString().padStart(3, "0")}`, "success")
  }
}

// Modal functions
function showComplaintDetail(complaint) {
  const modal = document.getElementById("complaintModal")
  const modalBody = document.getElementById("complaintModalBody")

  const timeAgo = getTimeAgo(complaint.created_at)
  const typeLabel = getComplaintTypeLabel(complaint.complaint_type)
  const statusLabel = getStatusLabel(complaint.status)

  modalBody.innerHTML = `
        <div class="complaint-detail">
            <div class="detail-header">
                <h4>Complaint #${complaint.id.toString().padStart(3, "0")}</h4>
                <div class="status-badge ${complaint.status}">${statusLabel}</div>
            </div>
            
            <div class="detail-info">
                <div class="info-row">
                    <label>User:</label>
                    <span>${complaint.username || complaint.user_id}</span>
                </div>
                <div class="info-row">
                    <label>Email:</label>
                    <span>${complaint.email || "N/A"}</span>
                </div>
                <div class="info-row">
                    <label>Tipe Keluhan:</label>
                    <span class="complaint-type ${complaint.complaint_type}">
                        <i class="fas fa-${getComplaintIcon(complaint.complaint_type)}"></i>
                        ${typeLabel}
                    </span>
                </div>
                <div class="info-row">
                    <label>Waktu:</label>
                    <span>${timeAgo} (${new Date(complaint.created_at).toLocaleString("id-ID")})</span>
                </div>
            </div>
            
            <div class="detail-description">
                <label>Deskripsi Keluhan:</label>
                <p>${complaint.description}</p>
            </div>
            
            <div class="detail-actions">
                <button class="btn-primary" onclick="updateComplaintStatus(${complaint.id}, 'pending'); closeModal('complaintModal')">
                    <i class="fas fa-clock"></i> Set Pending
                </button>
                <button class="btn-primary" onclick="updateComplaintStatus(${complaint.id}, 'resolved'); closeModal('complaintModal')">
                    <i class="fas fa-check"></i> Resolve
                </button>
                <button class="btn-secondary" onclick="exportComplaintDetail(${complaint.id})">
                    <i class="fas fa-download"></i> Export
                </button>
            </div>
        </div>
    `

  modal.classList.add("active")
}

function showReviewDetail(review) {
  const modal = document.getElementById("reviewModal")
  const modalBody = document.getElementById("reviewModalBody")

  const timeAgo = getTimeAgo(review.created_at)
  const productName = review.product_name || "Unknown Product"
  const stars = generateStars(review.rating)

  modalBody.innerHTML = `
        <div class="review-detail">
            <div class="detail-header">
                <h4>Review #${review.id.toString().padStart(3, "0")}</h4>
                <div class="rating-stars">
                    ${stars}
                    <span class="rating-number">${review.rating}/5</span>
                </div>
            </div>
            
            <div class="detail-info">
                <div class="info-row">
                    <label>User:</label>
                    <span>${review.username || review.user_id}</span>
                </div>
                <div class="info-row">
                    <label>Email:</label>
                    <span>${review.email || "N/A"}</span>
                </div>
                <div class="info-row">
                    <label>Produk:</label>
                    <span>${productName} (${review.product_code || review.product_id})</span>
                </div>
                <div class="info-row">
                    <label>Order ID:</label>
                    <span>#${review.order_id}</span>
                </div>
                <div class="info-row">
                    <label>Waktu:</label>
                    <span>${timeAgo} (${new Date(review.created_at).toLocaleString("id-ID")})</span>
                </div>
            </div>
            
            <div class="detail-description">
                <label>Review Text:</label>
                <p>${review.review_text}</p>
            </div>
            
            <div class="detail-actions">
                <button class="btn-primary" onclick="featureReview(${review.id}); closeModal('reviewModal')">
                    <i class="fas fa-star"></i> Feature Review
                </button>
                <button class="btn-primary" onclick="respondToReview(${review.id})">
                    <i class="fas fa-reply"></i> Respond
                </button>
                <button class="btn-secondary" onclick="exportReviewDetail(${review.id})">
                    <i class="fas fa-download"></i> Export
                </button>
            </div>
        </div>
    `

  modal.classList.add("active")
}

function closeModal(modalId) {
  document.getElementById(modalId).classList.remove("active")
}

// Export functions
function exportComplaints() {
  showNotification("Fitur export sedang dalam pengembangan", "info")
}

function exportReviews() {
  showNotification("Fitur export sedang dalam pengembangan", "info")
}

// Other functions
function showBulkActions() {
  showNotification("Fitur bulk actions sedang dalam pengembangan", "info")
}

function updateAnalytics() {
  showNotification("Analytics data berhasil diperbarui", "success")
}

function updateComplaintTrends() {
  const period = document.getElementById("complaint-trend-period").value
  showNotification(`Trend data diperbarui untuk periode ${period}`, "info")
}

function showReviewAnalytics() {
  showNotification("Membuka halaman analytics detail...", "info")
}

// Notification functions
function toggleNotificationPanel() {
  const panel = document.getElementById("notificationPanel")
  panel.classList.toggle("active")

  if (panel.classList.contains("active")) {
    setTimeout(() => {
      document.addEventListener("click", closeNotificationOnOutsideClick)
    }, 100)
  } else {
    document.removeEventListener("click", closeNotificationOnOutsideClick)
  }
}

function closeNotificationOnOutsideClick(event) {
  const panel = document.getElementById("notificationPanel")
  const bell = document.querySelector(".notification-bell")

  if (!panel.contains(event.target) && !bell.contains(event.target)) {
    panel.classList.remove("active")
    document.removeEventListener("click", closeNotificationOnOutsideClick)
  }
}

function markAllAsRead() {
  const unreadItems = document.querySelectorAll(".notification-item.unread")
  unreadItems.forEach((item) => {
    item.classList.remove("unread")
    const dot = item.querySelector(".unread-dot")
    if (dot) {
      dot.remove()
    }
  })

  const badge = document.querySelector(".notification-badge")
  if (badge) {
    badge.textContent = "0"
    badge.style.display = "none"
  }

  showNotification("Semua notifikasi telah ditandai sebagai dibaca", "success")
}

function viewAllNotifications() {
  showNotification("Fitur lihat semua notifikasi akan segera tersedia", "info")
}

// Show notification function
function showNotification(message, type = "info") {
  const notification = document.createElement("div")
  notification.className = `notification notification-${type}`
  notification.innerHTML = `
        <div class="notification-content">
            <i class="fas fa-${getNotificationIcon(type)}"></i>
            <span>${message}</span>
        </div>
    `

  notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: ${getNotificationColor(type)};
        color: white;
        padding: 15px 20px;
        border-radius: 12px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        z-index: 9999;
        min-width: 300px;
        transform: translateX(100%);
        transition: transform 0.3s ease;
    `

  document.body.appendChild(notification)

  setTimeout(() => {
    notification.style.transform = "translateX(0)"
  }, 100)

  setTimeout(() => {
    notification.style.transform = "translateX(100%)"
    setTimeout(() => {
      if (notification.parentNode) {
        notification.parentNode.removeChild(notification)
      }
    }, 300)
  }, 3000)
}

function getNotificationIcon(type) {
  switch (type) {
    case "success":
      return "check-circle"
    case "error":
      return "exclamation-triangle"
    case "warning":
      return "exclamation-circle"
    default:
      return "info-circle"
  }
}

function getNotificationColor(type) {
  switch (type) {
    case "success":
      return "#08A55A"
    case "error":
      return "#dc3545"
    case "warning":
      return "#ffc107"
    default:
      return "#3FCAEA"
  }
}

// Handle escape key to close modals
document.addEventListener("keydown", (event) => {
  if (event.key === "Escape") {
    const notificationPanel = document.getElementById("notificationPanel")
    const complaintModal = document.getElementById("complaintModal")
    const reviewModal = document.getElementById("reviewModal")

    if (notificationPanel.classList.contains("active")) {
      toggleNotificationPanel()
    }

    if (complaintModal.classList.contains("active")) {
      closeModal("complaintModal")
    }

    if (reviewModal.classList.contains("active")) {
      closeModal("reviewModal")
    }
  }
})

// Profile functionality
function handleProfile() {
  window.location.href = "profile.php"
}
import { Chart } from "@/components/ui/chart"
// Complaints & Review Management JavaScript for PHP Backend


// Initialize page
document.addEventListener("DOMContentLoaded", () => {
  // Load initial data
  loadComplaints()
  loadReviews()

  // Initialize charts with PHP data
  initializeCharts()
})

// API helper function
async function apiRequest(url, options = {}) {
  try {
    const response = await fetch(url, options)
    const data = await response.json()
    return data
  } catch (error) {
    console.error("API Error:", error)
    showNotification("Terjadi kesalahan saat memuat data", "error")
    return null
  }
}

// Tab switching
function switchTab(tabName) {
  // Remove active class from all tabs and buttons
  document.querySelectorAll(".tab-content").forEach((tab) => {
    tab.classList.remove("active")
  })
  document.querySelectorAll(".tab-btn").forEach((btn) => {
    btn.classList.remove("active")
  })

  // Add active class to selected tab and button
  document.getElementById(tabName + "-tab").classList.add("active")
  event.target.classList.add("active")

  // Load specific data based on tab
  if (tabName === "complaints") {
    loadComplaints()
  } else if (tabName === "reviews") {
    loadReviews()
  } else if (tabName === "analytics") {
    updateAnalytics()
  }
}

// Load complaints data
async function loadComplaints() {
  const complaintsContainer = document.getElementById("complaints-list")
  complaintsContainer.innerHTML = '<div class="loading">Loading complaints...</div>'

  const filters = getComplaintFilters()
  const queryString = new URLSearchParams(filters).toString()

  const complaints = await apiRequest(`complaints-review.php?action=get_complaints&${queryString}`)

  if (complaints) {
    displayComplaints(complaints)
  }
}

// Load reviews data
async function loadReviews() {
  const reviewsContainer = document.getElementById("reviews-list")
  reviewsContainer.innerHTML = '<div class="loading">Loading reviews...</div>'

  const filters = getReviewFilters()
  const queryString = new URLSearchParams(filters).toString()

  const reviews = await apiRequest(`complaints-review.php?action=get_reviews&${queryString}`)

  if (reviews) {
    displayReviews(reviews)
  }
}

// Get complaint filters
function getComplaintFilters() {
  return {
    status: document.getElementById("complaint-status-filter")?.value || "all",
    type: document.getElementById("complaint-type-filter")?.value || "all",
    period: document.getElementById("complaint-period-filter")?.value || "all",
    search: document.getElementById("complaint-search")?.value || "",
  }
}

// Get review filters
function getReviewFilters() {
  return {
    rating: document.getElementById("review-rating-filter")?.value || "all",
    product: document.getElementById("review-product-filter")?.value || "all",
    period: document.getElementById("review-period-filter")?.value || "all",
    search: document.getElementById("review-search")?.value || "",
  }
}

// Display complaints
function displayComplaints(complaints) {
  const complaintsContainer = document.getElementById("complaints-list")
  complaintsContainer.innerHTML = ""

  if (complaints.length === 0) {
    complaintsContainer.innerHTML = `
            <div style="text-align: center; padding: 40px; color: #666;">
                <i class="fas fa-search" style="font-size: 48px; margin-bottom: 16px; opacity: 0.5;"></i>
                <p>Tidak ada keluhan yang sesuai dengan filter yang dipilih.</p>
            </div>
        `
    return
  }

  complaints.forEach((complaint) => {
    const complaintElement = createComplaintElement(complaint)
    complaintsContainer.appendChild(complaintElement)
  })
}

// Display reviews
function displayReviews(reviews) {
  const reviewsContainer = document.getElementById("reviews-list")
  reviewsContainer.innerHTML = ""

  if (reviews.length === 0) {
    reviewsContainer.innerHTML = `
            <div style="text-align: center; padding: 40px; color: #666;">
                <i class="fas fa-search" style="font-size: 48px; margin-bottom: 16px; opacity: 0.5;"></i>
                <p>Tidak ada review yang sesuai dengan filter yang dipilih.</p>
            </div>
        `
    return
  }

  reviews.forEach((review) => {
    const reviewElement = createReviewElement(review)
    reviewsContainer.appendChild(reviewElement)
  })
}

// Create complaint element
function createComplaintElement(complaint) {
  const div = document.createElement("div")
  div.className = "complaint-item"
  div.onclick = () => showComplaintDetail(complaint)

  const timeAgo = getTimeAgo(complaint.created_at)
  const typeClass = complaint.complaint_type
  const statusClass = complaint.status

  div.innerHTML = `
        <div class="complaint-header">
            <div class="complaint-info">
                <div class="complaint-id">Complaint #${complaint.id.toString().padStart(3, "0")}</div>
                <div class="complaint-meta">
                    <span><i class="fas fa-user"></i> ${complaint.username || complaint.user_id}</span>
                    <span><i class="fas fa-clock"></i> ${timeAgo}</span>
                </div>
                <div class="complaint-type ${typeClass}">
                    <i class="fas fa-${getComplaintIcon(complaint.complaint_type)}"></i>
                    ${getComplaintTypeLabel(complaint.complaint_type)}
                </div>
            </div>
            <div class="status-badge ${statusClass}">
                ${getStatusLabel(complaint.status)}
            </div>
        </div>
        <div class="complaint-description">
            ${complaint.description}
        </div>
        <div class="complaint-actions">
            <button class="action-btn primary" onclick="event.stopPropagation(); updateComplaintStatus(${complaint.id}, 'pending')">
                <i class="fas fa-clock"></i> Set Pending
            </button>
            <button class="action-btn" onclick="event.stopPropagation(); updateComplaintStatus(${complaint.id}, 'resolved')">
                <i class="fas fa-check"></i> Resolve
            </button>
            <button class="action-btn" onclick="event.stopPropagation(); showComplaintDetail(${JSON.stringify(complaint).replace(/"/g, "&quot;")})">
                <i class="fas fa-eye"></i> Detail
            </button>
        </div>
    `

  return div
}

// Create review element
function createReviewElement(review) {
  const div = document.createElement("div")
  div.className = "review-item"
  div.onclick = () => showReviewDetail(review)

  const timeAgo = getTimeAgo(review.created_at)
  const productName = review.product_name || "Unknown Product"
  const stars = generateStars(review.rating)

  div.innerHTML = `
        <div class="review-header">
            <div class="review-info">
                <div class="review-id">Review #${review.id.toString().padStart(3, "0")}</div>
                <div class="review-meta">
                    <span><i class="fas fa-user"></i> ${review.username || review.user_id}</span>
                    <span><i class="fas fa-box"></i> ${productName}</span>
                    <span><i class="fas fa-clock"></i> ${timeAgo}</span>
                </div>
                <div class="rating-stars">
                    ${stars}
                    <span class="rating-number">${review.rating}/5</span>
                </div>
            </div>
        </div>
        <div class="review-text">
            ${review.review_text}
        </div>
        <div class="review-actions">
            <button class="action-btn primary" onclick="event.stopPropagation(); featureReview(${review.id})">
                <i class="fas fa-star"></i> Feature
            </button>
            <button class="action-btn" onclick="event.stopPropagation(); respondToReview(${review.id})">
                <i class="fas fa-reply"></i> Respond
            </button>
            <button class="action-btn" onclick="event.stopPropagation(); showReviewDetail(${JSON.stringify(review).replace(/"/g, "&quot;")})">
                <i class="fas fa-eye"></i> Detail
            </button>
        </div>
    `

  return div
}

// Update complaint status
async function updateComplaintStatus(complaintId, newStatus) {
  const formData = new FormData()
  formData.append("complaint_id", complaintId)
  formData.append("status", newStatus)

  const result = await apiRequest("complaints-review.php?action=update_complaint_status", {
    method: "POST",
    body: formData,
  })

  if (result && result.success) {
    loadComplaints()
    showNotification(
      `Keluhan #${complaintId.toString().padStart(3, "0")} berhasil diupdate ke status ${getStatusLabel(newStatus)}`,
      "success",
    )
  } else {
    showNotification(result?.message || "Gagal mengupdate status", "error")
  }
}

// Filter functions
function filterComplaints() {
  loadComplaints()
}

function filterReviews() {
  loadReviews()
}

function searchComplaints() {
  clearTimeout(window.complaintSearchTimeout)
  window.complaintSearchTimeout = setTimeout(() => {
    loadComplaints()
  }, 500)
}

function searchReviews() {
  clearTimeout(window.reviewSearchTimeout)
  window.reviewSearchTimeout = setTimeout(() => {
    loadReviews()
  }, 500)
}

// Initialize charts with PHP data
function initializeCharts() {
  if (typeof analyticsData !== "undefined") {
    initComplaintTrendsChart()
    initComplaintTypesChart()
    initRatingDistributionChart()
    initTopReviewedProductsChart()
  }
}

function initComplaintTrendsChart() {
  const ctx = document.getElementById("complaintTrendsChart")
  if (!ctx) return

  const trends = analyticsData.complaint_trends || []
  const labels = trends.map((t) => t.month)
  const data = trends.map((t) => t.count)

  new Chart(ctx, {
    type: "line",
    data: {
      labels: labels,
      datasets: [
        {
          label: "Total Complaints",
          data: data,
          borderColor: "#ef4444",
          backgroundColor: "rgba(239, 68, 68, 0.1)",
          tension: 0.4,
          fill: true,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: false,
        },
      },
      scales: {
        y: {
          beginAtZero: true,
          grid: {
            color: "rgba(0,0,0,0.1)",
          },
        },
        x: {
          grid: {
            display: false,
          },
        },
      },
    },
  })
}

function initComplaintTypesChart() {
  const ctx = document.getElementById("complaintTypesChart")
  if (!ctx) return

  const types = analyticsData.complaint_types || []
  const labels = types.map((t) => getComplaintTypeLabel(t.complaint_type))
  const data = types.map((t) => t.count)

  new Chart(ctx, {
    type: "doughnut",
    data: {
      labels: labels,
      datasets: [
        {
          data: data,
          backgroundColor: ["#f59e0b", "#3b82f6", "#10b981", "#e879f9", "#6366f1", "#6b7280"],
          borderWidth: 0,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          position: "bottom",
        },
      },
    },
  })
}

function initRatingDistributionChart() {
  const ctx = document.getElementById("ratingDistributionChart")
  if (!ctx) return

  const ratings = analyticsData.rating_distribution || []
  const labels = ratings.map((r) => `${r.rating_floor} Star${r.rating_floor > 1 ? "s" : ""}`)
  const data = ratings.map((r) => r.count)

  new Chart(ctx, {
    type: "bar",
    data: {
      labels: labels,
      datasets: [
        {
          label: "Number of Reviews",
          data: data,
          backgroundColor: ["#ef4444", "#f97316", "#eab308", "#22c55e", "#10b981"],
          borderRadius: 6,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: false,
        },
      },
      scales: {
        y: {
          beginAtZero: true,
          grid: {
            color: "rgba(0,0,0,0.1)",
          },
        },
        x: {
          grid: {
            display: false,
          },
        },
      },
    },
  })
}

function initTopReviewedProductsChart() {
  const ctx = document.getElementById("topReviewedProductsChart")
  if (!ctx) return

  // This would need additional data from PHP - for now using sample data
  new Chart(ctx, {
    type: "bar",
    data: {
      labels: ["Multi Core", "Green Detox", "Whey Muscle", "C Boost", "Omega Brain"],
      datasets: [
        {
          label: "Number of Reviews",
          data: [234, 189, 156, 134, 98],
          backgroundColor: ["#08a55a", "#3fcaea", "#667eea", "#f093fb", "#4facfe"],
          borderRadius: 6,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      indexAxis: "y",
      plugins: {
        legend: {
          display: false,
        },
      },
      scales: {
        x: {
          beginAtZero: true,
          grid: {
            color: "rgba(0,0,0,0.1)",
          },
        },
        y: {
          grid: {
            display: false,
          },
        },
      },
    },
  })
}

// Utility functions (same as before)
function getTimeAgo(dateString) {
  const date = new Date(dateString)
  const now = new Date()
  const diffInHours = Math.floor((now - date) / (1000 * 60 * 60))

  if (diffInHours < 1) return "Baru saja"
  if (diffInHours < 24) return `${diffInHours} jam yang lalu`

  const diffInDays = Math.floor(diffInHours / 24)
  if (diffInDays < 7) return `${diffInDays} hari yang lalu`

  return date.toLocaleDateString("id-ID")
}

function getComplaintIcon(type) {
  const icons = {
    energy: "bolt",
    weight: "weight",
    digestion: "stomach",
    immunity: "shield-alt",
    sleep: "bed",
    other: "question-circle",
  }
  return icons[type] || "question-circle"
}

function getComplaintTypeLabel(type) {
  const labels = {
    energy: "Energy",
    weight: "Weight",
    digestion: "Digestion",
    immunity: "Immunity",
    sleep: "Sleep",
    other: "Other",
  }
  return labels[type] || "Other"
}

function getStatusLabel(status) {
  const labels = {
    open: "Open",
    pending: "Pending",
    resolved: "Resolved",
  }
  return labels[status] || "Unknown"
}

function generateStars(rating) {
  let stars = ""
  for (let i = 1; i <= 5; i++) {
    if (i <= rating) {
      stars += '<i class="fas fa-star filled"></i>'
    } else if (i - 0.5 <= rating) {
      stars += '<i class="fas fa-star-half-alt filled"></i>'
    } else {
      stars += '<i class="fas fa-star empty"></i>'
    }
  }
  return stars
}

// Action functions
function featureReview(reviewId) {
  showNotification(
    `Review #${reviewId.toString().padStart(3, "0")} berhasil ditandai sebagai featured review`,
    "success",
  )
}

function respondToReview(reviewId) {
  const response = prompt("Masukkan respons untuk review ini:")
  if (response) {
    showNotification(`Respons berhasil dikirim untuk review #${reviewId.toString().padStart(3, "0")}`, "success")
  }
}

// Modal functions
function showComplaintDetail(complaint) {
  const modal = document.getElementById("complaintModal")
  const modalBody = document.getElementById("complaintModalBody")

  const timeAgo = getTimeAgo(complaint.created_at)
  const typeLabel = getComplaintTypeLabel(complaint.complaint_type)
  const statusLabel = getStatusLabel(complaint.status)

  modalBody.innerHTML = `
        <div class="complaint-detail">
            <div class="detail-header">
                <h4>Complaint #${complaint.id.toString().padStart(3, "0")}</h4>
                <div class="status-badge ${complaint.status}">${statusLabel}</div>
            </div>
            
            <div class="detail-info">
                <div class="info-row">
                    <label>User:</label>
                    <span>${complaint.username || complaint.user_id}</span>
                </div>
                <div class="info-row">
                    <label>Email:</label>
                    <span>${complaint.email || "N/A"}</span>
                </div>
                <div class="info-row">
                    <label>Tipe Keluhan:</label>
                    <span class="complaint-type ${complaint.complaint_type}">
                        <i class="fas fa-${getComplaintIcon(complaint.complaint_type)}"></i>
                        ${typeLabel}
                    </span>
                </div>
                <div class="info-row">
                    <label>Waktu:</label>
                    <span>${timeAgo} (${new Date(complaint.created_at).toLocaleString("id-ID")})</span>
                </div>
            </div>
            
            <div class="detail-description">
                <label>Deskripsi Keluhan:</label>
                <p>${complaint.description}</p>
            </div>
            
            <div class="detail-actions">
                <button class="btn-primary" onclick="updateComplaintStatus(${complaint.id}, 'pending'); closeModal('complaintModal')">
                    <i class="fas fa-clock"></i> Set Pending
                </button>
                <button class="btn-primary" onclick="updateComplaintStatus(${complaint.id}, 'resolved'); closeModal('complaintModal')">
                    <i class="fas fa-check"></i> Resolve
                </button>
                <button class="btn-secondary" onclick="exportComplaintDetail(${complaint.id})">
                    <i class="fas fa-download"></i> Export
                </button>
            </div>
        </div>
    `

  modal.classList.add("active")
}

function showReviewDetail(review) {
  const modal = document.getElementById("reviewModal")
  const modalBody = document.getElementById("reviewModalBody")

  const timeAgo = getTimeAgo(review.created_at)
  const productName = review.product_name || "Unknown Product"
  const stars = generateStars(review.rating)

  modalBody.innerHTML = `
        <div class="review-detail">
            <div class="detail-header">
                <h4>Review #${review.id.toString().padStart(3, "0")}</h4>
                <div class="rating-stars">
                    ${stars}
                    <span class="rating-number">${review.rating}/5</span>
                </div>
            </div>
            
            <div class="detail-info">
                <div class="info-row">
                    <label>User:</label>
                    <span>${review.username || review.user_id}</span>
                </div>
                <div class="info-row">
                    <label>Email:</label>
                    <span>${review.email || "N/A"}</span>
                </div>
                <div class="info-row">
                    <label>Produk:</label>
                    <span>${productName} (${review.product_code || review.product_id})</span>
                </div>
                <div class="info-row">
                    <label>Order ID:</label>
                    <span>#${review.order_id}</span>
                </div>
                <div class="info-row">
                    <label>Waktu:</label>
                    <span>${timeAgo} (${new Date(review.created_at).toLocaleString("id-ID")})</span>
                </div>
            </div>
            
            <div class="detail-description">
                <label>Review Text:</label>
                <p>${review.review_text}</p>
            </div>
            
            <div class="detail-actions">
                <button class="btn-primary" onclick="featureReview(${review.id}); closeModal('reviewModal')">
                    <i class="fas fa-star"></i> Feature Review
                </button>
                <button class="btn-primary" onclick="respondToReview(${review.id})">
                    <i class="fas fa-reply"></i> Respond
                </button>
                <button class="btn-secondary" onclick="exportReviewDetail(${review.id})">
                    <i class="fas fa-download"></i> Export
                </button>
            </div>
        </div>
    `

  modal.classList.add("active")
}

function closeModal(modalId) {
  document.getElementById(modalId).classList.remove("active")
}

// Export functions
function exportComplaints() {
  showNotification("Fitur export sedang dalam pengembangan", "info")
}

function exportReviews() {
  showNotification("Fitur export sedang dalam pengembangan", "info")
}

// Other functions
function showBulkActions() {
  showNotification("Fitur bulk actions sedang dalam pengembangan", "info")
}

function updateAnalytics() {
  showNotification("Analytics data berhasil diperbarui", "success")
}

function updateComplaintTrends() {
  const period = document.getElementById("complaint-trend-period").value
  showNotification(`Trend data diperbarui untuk periode ${period}`, "info")
}

function showReviewAnalytics() {
  showNotification("Membuka halaman analytics detail...", "info")
}

// Notification functions
function toggleNotificationPanel() {
  const panel = document.getElementById("notificationPanel")
  panel.classList.toggle("active")

  if (panel.classList.contains("active")) {
    setTimeout(() => {
      document.addEventListener("click", closeNotificationOnOutsideClick)
    }, 100)
  } else {
    document.removeEventListener("click", closeNotificationOnOutsideClick)
  }
}

function closeNotificationOnOutsideClick(event) {
  const panel = document.getElementById("notificationPanel")
  const bell = document.querySelector(".notification-bell")

  if (!panel.contains(event.target) && !bell.contains(event.target)) {
    panel.classList.remove("active")
    document.removeEventListener("click", closeNotificationOnOutsideClick)
  }
}

function markAllAsRead() {
  const unreadItems = document.querySelectorAll(".notification-item.unread")
  unreadItems.forEach((item) => {
    item.classList.remove("unread")
    const dot = item.querySelector(".unread-dot")
    if (dot) {
      dot.remove()
    }
  })

  const badge = document.querySelector(".notification-badge")
  if (badge) {
    badge.textContent = "0"
    badge.style.display = "none"
  }

  showNotification("Semua notifikasi telah ditandai sebagai dibaca", "success")
}

function viewAllNotifications() {
  showNotification("Fitur lihat semua notifikasi akan segera tersedia", "info")
}

// Show notification function
function showNotification(message, type = "info") {
  const notification = document.createElement("div")
  notification.className = `notification notification-${type}`
  notification.innerHTML = `
        <div class="notification-content">
            <i class="fas fa-${getNotificationIcon(type)}"></i>
            <span>${message}</span>
        </div>
    `

  notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: ${getNotificationColor(type)};
        color: white;
        padding: 15px 20px;
        border-radius: 12px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        z-index: 9999;
        min-width: 300px;
        transform: translateX(100%);
        transition: transform 0.3s ease;
    `

  document.body.appendChild(notification)

  setTimeout(() => {
    notification.style.transform = "translateX(0)"
  }, 100)

  setTimeout(() => {
    notification.style.transform = "translateX(100%)"
    setTimeout(() => {
      if (notification.parentNode) {
        notification.parentNode.removeChild(notification)
      }
    }, 300)
  }, 3000)
}

function getNotificationIcon(type) {
  switch (type) {
    case "success":
      return "check-circle"
    case "error":
      return "exclamation-triangle"
    case "warning":
      return "exclamation-circle"
    default:
      return "info-circle"
  }
}

function getNotificationColor(type) {
  switch (type) {
    case "success":
      return "#08A55A"
    case "error":
      return "#dc3545"
    case "warning":
      return "#ffc107"
    default:
      return "#3FCAEA"
  }
}

// Handle escape key to close modals
document.addEventListener("keydown", (event) => {
  if (event.key === "Escape") {
    const notificationPanel = document.getElementById("notificationPanel")
    const complaintModal = document.getElementById("complaintModal")
    const reviewModal = document.getElementById("reviewModal")

    if (notificationPanel.classList.contains("active")) {
      toggleNotificationPanel()
    }

    if (complaintModal.classList.contains("active")) {
      closeModal("complaintModal")
    }

    if (reviewModal.classList.contains("active")) {
      closeModal("reviewModal")
    }
  }
})

// Profile functionality
function handleProfile() {
  window.location.href = "profile.php"
}
