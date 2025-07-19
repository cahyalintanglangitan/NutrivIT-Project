
// Complaints Management JavaScript - Fixed for traditional script loading
// No ES6 modules - using global variables and functions

// Global variables
let currentPage = 1
const currentFilters = {
  status: "",
  type: "",
}
const complaintsData = window.complaintsData || { typeData: {}, statusData: {} }

// Initialize when DOM is loaded
document.addEventListener("DOMContentLoaded", () => {
  initializeComplaints()
})

function initializeComplaints() {
  // Set current date
  updateCurrentDate()

  // Initialize charts
  initializeCharts()

  // Setup event listeners
  setupEventListeners()

  // Setup notification system
  setupNotifications()

  console.log("Complaints system initialized")
}

function updateCurrentDate() {
  const dateElement = document.getElementById("current-date")
  if (dateElement) {
    const now = new Date()
    const options = {
      weekday: "long",
      year: "numeric",
      month: "long",
      day: "numeric",
    }
    dateElement.textContent = now.toLocaleDateString("id-ID", options)
  }
}

function initializeCharts() {
  // Initialize complaints by type chart
  const typeCtx = document.getElementById("complaintsTypeChart")
  if (typeCtx && complaintsData.typeData) {
    new Chart(typeCtx, {
      type: "doughnut",
      data: {
        labels: Object.keys(complaintsData.typeData).map((key) => key.charAt(0).toUpperCase() + key.slice(1)),
        datasets: [
          {
            data: Object.values(complaintsData.typeData),
            backgroundColor: ["#667eea", "#f093fb", "#4facfe", "#43e97b", "#38f9d7", "#ffeaa7"],
            borderWidth: 2,
            borderColor: "#fff",
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            position: "bottom",
            labels: {
              padding: 20,
              usePointStyle: true,
            },
          },
        },
      },
    })
  }

  // Initialize status distribution chart
  const statusCtx = document.getElementById("statusChart")
  if (statusCtx && complaintsData.statusData) {
    new Chart(statusCtx, {
      type: "bar",
      data: {
        labels: Object.keys(complaintsData.statusData).map((key) => key.charAt(0).toUpperCase() + key.slice(1)),
        datasets: [
          {
            label: "Complaints",
            data: Object.values(complaintsData.statusData),
            backgroundColor: ["#dc3545", "#ffc107", "#28a745"],
            borderRadius: 8,
            borderSkipped: false,
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
            ticks: {
              stepSize: 1,
            },
          },
        },
      },
    })
  }
}

function setupEventListeners() {
  // Filter event listeners
  const statusFilter = document.getElementById("statusFilter")
  const typeFilter = document.getElementById("typeFilter")
  const refreshBtn = document.getElementById("refreshBtn")

  if (statusFilter) {
    statusFilter.addEventListener("change", handleFilterChange)
  }

  if (typeFilter) {
    typeFilter.addEventListener("change", handleFilterChange)
  }

  if (refreshBtn) {
    refreshBtn.addEventListener("click", handleRefresh)
  }

  // Pagination event listeners
  const prevPage = document.getElementById("prevPage")
  const nextPage = document.getElementById("nextPage")

  if (prevPage) {
    prevPage.addEventListener("click", () => changePage(currentPage - 1))
  }

  if (nextPage) {
    nextPage.addEventListener("click", () => changePage(currentPage + 1))
  }

  // Modal event listeners
  setupModalListeners()
}

function setupModalListeners() {
  // Close modal when clicking outside
  window.addEventListener("click", (event) => {
    const complaintModal = document.getElementById("complaintModal")
    const statusModal = document.getElementById("statusModal")

    if (event.target === complaintModal) {
      closeModal()
    }
    if (event.target === statusModal) {
      closeStatusModal()
    }
  })

  // Status form submission
  const statusForm = document.getElementById("statusForm")
  if (statusForm) {
    statusForm.addEventListener("submit", handleStatusUpdate)
  }
}

function handleFilterChange() {
  const statusFilter = document.getElementById("statusFilter")
  const typeFilter = document.getElementById("typeFilter")

  currentFilters.status = statusFilter ? statusFilter.value : ""
  currentFilters.type = typeFilter ? typeFilter.value : ""
  currentPage = 1

  loadComplaints()
}

function handleRefresh() {
  const refreshBtn = document.getElementById("refreshBtn")
  if (refreshBtn) {
    const icon = refreshBtn.querySelector("i")
    if (icon) {
      icon.classList.add("fa-spin")
    }

    setTimeout(() => {
      if (icon) {
        icon.classList.remove("fa-spin")
      }
    }, 1000)
  }

  loadComplaints()
}

function loadComplaints() {
  const tableBody = document.getElementById("complaintsTableBody")
  if (!tableBody) return

  // Show loading state
  tableBody.innerHTML =
    '<tr class="loading-row"><td colspan="7"><i class="fas fa-spinner fa-spin"></i> Loading complaints...</td></tr>'

  // Prepare request data
  const requestData = {
    action: "filter",
    status: currentFilters.status,
    type: currentFilters.type,
    limit: 50,
    offset: (currentPage - 1) * 50,
  }

  // Make AJAX request
  fetch("get_complaints.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(requestData),
  })
    .then((response) => response.json())
    .then((data) => {
      if (data.success) {
        updateComplaintsTable(data.complaints)
        updateStats(data.stats)
      } else {
        showError("Failed to load complaints: " + data.message)
      }
    })
    .catch((error) => {
      console.error("Error:", error)
      showError("Network error occurred while loading complaints")
    })
}

function updateComplaintsTable(complaints) {
  const tableBody = document.getElementById("complaintsTableBody")
  if (!tableBody) return

  if (complaints.length === 0) {
    tableBody.innerHTML = '<tr class="loading-row"><td colspan="7">No complaints found</td></tr>'
    return
  }

  tableBody.innerHTML = complaints
    .map(
      (complaint) => `
        <tr data-id="${complaint.id}">
            <td class="complaint-id">
                <span class="id-badge">#${String(complaint.id).padStart(4, "0")}</span>
            </td>
            <td class="user-info">
                <div class="user-details">
                    <div class="user-name">${escapeHtml(complaint.user_name)}</div>
                    <div class="user-email">${escapeHtml(complaint.user_email)}</div>
                </div>
            </td>
            <td class="type-cell">
                <span class="type-badge type-${complaint.complaint_type}">
                    <i class="fas fa-${getTypeIcon(complaint.complaint_type)}"></i>
                    ${complaint.complaint_type.charAt(0).toUpperCase() + complaint.complaint_type.slice(1)}
                </span>
            </td>
            <td class="description">
                <div class="description-text" title="${escapeHtml(complaint.description)}" onclick="viewComplaint(${complaint.id})">
                    ${escapeHtml(complaint.description.substring(0, 80))}
                    ${complaint.description.length > 80 ? '<span class="read-more">... <small>(klik untuk detail)</small></span>' : ""}
                </div>
            </td>
            <td class="status-cell">
                <span class="status-badge status-${complaint.status}">
                    <i class="fas fa-${getStatusIcon(complaint.status)}"></i>
                    ${complaint.status.charAt(0).toUpperCase() + complaint.status.slice(1)}
                </span>
            </td>
            <td class="created-date">
                <div class="date-info">
                    <div class="date">${formatDate(complaint.created_at)}</div>
                    <div class="time">${formatTime(complaint.created_at)}</div>
                </div>
            </td>
            <td class="actions">
                <div class="action-buttons">
                    <button class="btn-action btn-view" onclick="viewComplaint(${complaint.id})" title="View Details">
                        <i class="fas fa-eye"></i>
                    </button>
                    <button class="btn-action btn-edit" onclick="editStatus(${complaint.id}, '${complaint.status}')" title="Edit Status">
                        <i class="fas fa-edit"></i>
                    </button>
                </div>
            </td>
        </tr>
    `,
    )
    .join("")

  // Update showing count
  const showingCount = document.getElementById("showingCount")
  if (showingCount) {
    showingCount.textContent = complaints.length
  }
}

function updateStats(stats) {
  // Update stat numbers
  const statNumbers = document.querySelectorAll(".stat-number")
  if (statNumbers.length >= 4 && stats) {
    statNumbers[0].textContent = stats.total || 0
    statNumbers[1].textContent = stats.by_status?.open || 0
    statNumbers[2].textContent = stats.by_status?.pending || 0
    statNumbers[3].textContent = stats.by_status?.resolved || 0
  }

  // Update total count
  const totalCount = document.getElementById("totalCount")
  if (totalCount && stats) {
    totalCount.textContent = stats.total || 0
  }
}

function changePage(page) {
  if (page < 1) return

  currentPage = page
  loadComplaints()

  // Update pagination buttons
  const prevPage = document.getElementById("prevPage")
  const nextPage = document.getElementById("nextPage")

  if (prevPage) {
    prevPage.disabled = currentPage <= 1
  }

  // Update page number display
  const pageNumbers = document.querySelector(".page-numbers")
  if (pageNumbers) {
    pageNumbers.innerHTML = `<button class="btn-page active">${currentPage}</button>`
  }
}

// Global functions for onclick handlers
function viewComplaint(id) {
  const modal = document.getElementById("complaintModal")
  const modalBody = document.getElementById("modalBody")

  if (!modal || !modalBody) return

  // Show loading
  modalBody.innerHTML = '<div class="loading"><i class="fas fa-spinner fa-spin"></i> Loading complaint details...</div>'
  modal.style.display = "block"

  // Fetch complaint details
  fetch("get_complaints.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      action: "get_detail",
      id: id,
    }),
  })
    .then((response) => response.json())
    .then((data) => {
      if (data.success) {
        displayComplaintDetails(data.complaint)
      } else {
        modalBody.innerHTML = '<div class="error">Failed to load complaint details</div>'
      }
    })
    .catch((error) => {
      console.error("Error:", error)
      modalBody.innerHTML = '<div class="error">Network error occurred</div>'
    })
}

function displayComplaintDetails(complaint) {
  const modalBody = document.getElementById("modalBody")
  if (!modalBody) return

  modalBody.innerHTML = `
        <div class="complaint-details">
            <div class="detail-row">
                <label>Complaint ID:</label>
                <span>#${String(complaint.id).padStart(4, "0")}</span>
            </div>
            <div class="detail-row">
                <label>User:</label>
                <div>
                    <strong>${escapeHtml(complaint.user_name)}</strong><br>
                    <small>${escapeHtml(complaint.user_email)}</small>
                    ${complaint.phone ? `<br><small>${escapeHtml(complaint.phone)}</small>` : ""}
                </div>
            </div>
            <div class="detail-row">
                <label>Type:</label>
                <span class="type-badge type-${complaint.complaint_type}">
                    <i class="fas fa-${getTypeIcon(complaint.complaint_type)}"></i>
                    ${complaint.complaint_type.charAt(0).toUpperCase() + complaint.complaint_type.slice(1)}
                </span>
            </div>
            <div class="detail-row">
                <label>Status:</label>
                <span class="status-badge status-${complaint.status}">
                    <i class="fas fa-${getStatusIcon(complaint.status)}"></i>
                    ${complaint.status.charAt(0).toUpperCase() + complaint.status.slice(1)}
                </span>
            </div>
            <div class="detail-row">
                <label>Created:</label>
                <span>${formatDateTime(complaint.created_at)}</span>
            </div>
            <div class="detail-row full-width">
                <label>Description:</label>
                <div class="description-full">${escapeHtml(complaint.description)}</div>
            </div>
        </div>
        <div class="modal-actions">
            <button class="btn-edit" onclick="editStatus(${complaint.id}, '${complaint.status}'); closeModal();">
                <i class="fas fa-edit"></i> Update Status
            </button>
        </div>
    `
}

function editStatus(id, currentStatus) {
  const modal = document.getElementById("statusModal")
  const complaintIdInput = document.getElementById("complaintId")
  const statusSelect = document.getElementById("newStatus")

  if (!modal || !complaintIdInput || !statusSelect) return

  complaintIdInput.value = id
  statusSelect.value = currentStatus
  modal.style.display = "block"
}

function handleStatusUpdate(event) {
  event.preventDefault()

  const form = event.target
  const formData = new FormData(form)

  const requestData = {
    action: "update_status",
    complaint_id: Number.parseInt(formData.get("complaint_id")),
    status: formData.get("status"),
  }

  fetch("get_complaints.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(requestData),
  })
    .then((response) => response.json())
    .then((data) => {
      if (data.success) {
        closeStatusModal()
        loadComplaints() // Reload the table
        showNotification("Status updated successfully", "success")
      } else {
        showNotification("Failed to update status: " + data.message, "error")
      }
    })
    .catch((error) => {
      console.error("Error:", error)
      showNotification("Network error occurred", "error")
    })
}

function closeModal() {
  const modal = document.getElementById("complaintModal")
  if (modal) {
    modal.style.display = "none"
  }
}

function closeStatusModal() {
  const modal = document.getElementById("statusModal")
  if (modal) {
    modal.style.display = "none"
  }
}

// Utility functions
function escapeHtml(text) {
  const div = document.createElement("div")
  div.textContent = text
  return div.innerHTML
}

function getTypeIcon(type) {
  const icons = {
    energy: "bolt",
    weight: "weight",
    digestion: "utensils",
    immunity: "shield-alt",
    sleep: "bed",
    other: "question-circle",
  }
  return icons[type] || "question-circle"
}

function getStatusIcon(status) {
  const icons = {
    open: "exclamation-circle",
    pending: "clock",
    resolved: "check-circle",
  }
  return icons[status] || "question-circle"
}

function formatDate(dateString) {
  const date = new Date(dateString)
  return date.toLocaleDateString("id-ID", {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
  })
}

function formatTime(dateString) {
  const date = new Date(dateString)
  return date.toLocaleTimeString("id-ID", {
    hour: "2-digit",
    minute: "2-digit",
  })
}

function formatDateTime(dateString) {
  const date = new Date(dateString)
  return date.toLocaleString("id-ID", {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
    hour: "2-digit",
    minute: "2-digit",
  })
}

function showError(message) {
  const tableBody = document.getElementById("complaintsTableBody")
  if (tableBody) {
    tableBody.innerHTML = `<tr class="loading-row"><td colspan="7" class="error">${message}</td></tr>`
  }
}

function showNotification(message, type = "info") {
  // Create notification element
  const notification = document.createElement("div")
  notification.className = `notification notification-${type}`
  notification.innerHTML = `
        <i class="fas fa-${type === "success" ? "check-circle" : type === "error" ? "exclamation-circle" : "info-circle"}"></i>
        <span>${message}</span>
    `

  // Add styles
  notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: ${type === "success" ? "#d4edda" : type === "error" ? "#f8d7da" : "#d1ecf1"};
        color: ${type === "success" ? "#155724" : type === "error" ? "#721c24" : "#0c5460"};
        padding: 15px 20px;
        border-radius: 10px;
        border: 1px solid ${type === "success" ? "#c3e6cb" : type === "error" ? "#f5c6cb" : "#bee5eb"};
        z-index: 1001;
        display: flex;
        align-items: center;
        gap: 10px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        animation: slideInRight 0.3s ease;
    `

  document.body.appendChild(notification)

  // Remove after 3 seconds
  setTimeout(() => {
    notification.style.animation = "slideOutRight 0.3s ease"
    setTimeout(() => {
      if (notification.parentNode) {
        notification.parentNode.removeChild(notification)
      }
    }, 300)
  }, 3000)
}

function setupNotifications() {
  // Add CSS for notification animations
  const style = document.createElement("style")
  style.textContent = `
        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
        
        @keyframes slideOutRight {
            from {
                transform: translateX(0);
                opacity: 1;
            }
            to {
                transform: translateX(100%);
                opacity: 0;
            }
        }
    `
  document.head.appendChild(style)
}
