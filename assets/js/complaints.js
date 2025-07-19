import { Chart } from "@/components/ui/chart"
// Complaints Management JavaScript
// Complaints Management JavaScript
// Global variables
let typeChart = null
let statusChart = null

document.addEventListener("DOMContentLoaded", () => {
  console.log("DOM loaded, initializing...")

  // Set current date
  setCurrentDate()

  // Initialize charts
  initializeCharts()

  // Initialize event listeners
  initializeEventListeners()

  console.log("Initialization complete")
})

function setCurrentDate() {
  try {
    const now = new Date()
    const options = {
      weekday: "long",
      year: "numeric",
      month: "long",
      day: "numeric",
    }

    const dateString = now.toLocaleDateString("id-ID", options)
    const dateElement = document.getElementById("current-date")

    if (dateElement) {
      dateElement.textContent = dateString
      console.log("Date set:", dateString)
    } else {
      console.error("Date element not found")
    }
  } catch (error) {
    console.error("Error setting date:", error)
    const dateElement = document.getElementById("current-date")
    if (dateElement) {
      dateElement.textContent = new Date().toLocaleDateString()
    }
  }
}

function initializeEventListeners() {
  console.log("Initializing event listeners...")

  // Filter event listeners
  const statusFilter = document.getElementById("statusFilter")
  const typeFilter = document.getElementById("typeFilter")
  const refreshBtn = document.getElementById("refreshBtn")

  if (statusFilter) {
    statusFilter.addEventListener("change", filterComplaints)
    console.log("Status filter listener added")
  }

  if (typeFilter) {
    typeFilter.addEventListener("change", filterComplaints)
    console.log("Type filter listener added")
  }

  if (refreshBtn) {
    refreshBtn.addEventListener("click", refreshData)
    console.log("Refresh button listener added")
  }

  // Status form submission
  const statusForm = document.getElementById("statusForm")
  if (statusForm) {
    statusForm.addEventListener("submit", updateComplaintStatus)
    console.log("Status form listener added")
  }

  // Modal close events
  window.addEventListener("click", (event) => {
    const complaintModal = document.getElementById("complaintModal")
    const statusModal = document.getElementById("statusModal")

    if (event.target === complaintModal) {
      complaintModal.style.display = "none"
    }
    if (event.target === statusModal) {
      statusModal.style.display = "none"
    }
  })
}

function initializeCharts() {
  console.log("Initializing charts...")

  if (typeof window.complaintsData === "undefined") {
    console.error("Complaints data not found")
    return
  }

  const typeData = window.complaintsData.typeData
  const statusData = window.complaintsData.statusData

  console.log("Type data:", typeData)
  console.log("Status data:", statusData)

  // Initialize Type Chart
  initializeTypeChart(typeData)

  // Initialize Status Chart
  initializeStatusChart(statusData)
}

function initializeTypeChart(typeData) {
  const ctx = document.getElementById("complaintsTypeChart")
  if (!ctx) {
    console.error("Type chart canvas not found")
    return
  }

  try {
    // Destroy existing chart if it exists
    if (typeChart) {
      typeChart.destroy()
    }

    const labels = Object.keys(typeData)
    const data = Object.values(typeData)
    const colors = ["#FF6384", "#36A2EB", "#FFCE56", "#4BC0C0", "#9966FF", "#FF9F40"]

    console.log("Creating type chart with labels:", labels, "data:", data)

    typeChart = new Chart(ctx, {
      type: "doughnut",
      data: {
        labels: labels.map((label) => label.charAt(0).toUpperCase() + label.slice(1)),
        datasets: [
          {
            data: data,
            backgroundColor: colors.slice(0, labels.length),
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
              font: {
                size: 12,
              },
            },
          },
          tooltip: {
            callbacks: {
              label: (context) => {
                const label = context.label || ""
                const value = context.parsed || 0
                const total = context.dataset.data.reduce((a, b) => a + b, 0)
                const percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0
                return label + ": " + value + " (" + percentage + "%)"
              },
            },
          },
        },
      },
    })

    console.log("Type chart created successfully")
  } catch (error) {
    console.error("Error creating type chart:", error)
  }
}

function initializeStatusChart(statusData) {
  const ctx = document.getElementById("statusChart")
  if (!ctx) {
    console.error("Status chart canvas not found")
    return
  }

  try {
    // Destroy existing chart if it exists
    if (statusChart) {
      statusChart.destroy()
    }

    const labels = Object.keys(statusData)
    const data = Object.values(statusData)
    const colors = {
      open: "#dc3545",
      pending: "#ffc107",
      resolved: "#28a745",
    }

    console.log("Creating status chart with labels:", labels, "data:", data)

    statusChart = new Chart(ctx, {
      type: "bar",
      data: {
        labels: labels.map((label) => label.charAt(0).toUpperCase() + label.slice(1)),
        datasets: [
          {
            label: "Complaints",
            data: data,
            backgroundColor: labels.map((label) => colors[label] || "#6c757d"),
            borderColor: labels.map((label) => colors[label] || "#6c757d"),
            borderWidth: 1,
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
          tooltip: {
            callbacks: {
              label: (context) => context.label + ": " + context.parsed.y + " complaints",
            },
          },
        },
        scales: {
          y: {
            beginAtZero: true,
            ticks: {
              stepSize: 1,
              font: {
                size: 12,
              },
            },
            grid: {
              color: "#e9ecef",
            },
          },
          x: {
            ticks: {
              font: {
                size: 12,
              },
            },
            grid: {
              display: false,
            },
          },
        },
      },
    })

    console.log("Status chart created successfully")
  } catch (error) {
    console.error("Error creating status chart:", error)
  }
}

function filterComplaints() {
  console.log("Filtering complaints...")

  const status = document.getElementById("statusFilter").value
  const type = document.getElementById("typeFilter").value

  console.log("Filter values - Status:", status, "Type:", type)

  // Show loading state
  showLoading()

  // Make AJAX request to filter complaints
  fetch("get_complaints.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      status: status,
      type: type,
      action: "filter",
    }),
  })
    .then((response) => {
      console.log("Filter response status:", response.status)
      return response.json()
    })
    .then((data) => {
      console.log("Filter response data:", data)
      if (data.success) {
        updateTable(data.complaints)
        updateStats(data.stats)
      } else {
        showError("Error filtering complaints: " + data.message)
      }
    })
    .catch((error) => {
      console.error("Filter error:", error)
      showError("Error filtering complaints")
    })
    .finally(() => {
      hideLoading()
    })
}

function updateTable(complaints) {
  console.log("Updating table with", complaints.length, "complaints")

  const tbody = document.getElementById("complaintsTableBody")
  tbody.innerHTML = ""

  complaints.forEach((complaint) => {
    const row = createTableRow(complaint)
    tbody.appendChild(row)
  })

  // Update showing count
  document.getElementById("showingCount").textContent = complaints.length
}

function createTableRow(complaint) {
  const row = document.createElement("tr")
  row.setAttribute("data-id", complaint.id)

  const description =
    complaint.description.length > 80 ? complaint.description.substring(0, 80) + "..." : complaint.description

  const typeIcons = {
    energy: "bolt",
    weight: "weight",
    digestion: "utensils",
    immunity: "shield-alt",
    sleep: "bed",
    other: "question-circle",
  }

  const statusIcons = {
    open: "exclamation-circle",
    pending: "clock",
    resolved: "check-circle",
  }

  row.innerHTML = `
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
                <i class="fas fa-${typeIcons[complaint.complaint_type] || "question-circle"}"></i>
                ${capitalizeFirst(complaint.complaint_type)}
            </span>
        </td>
        <td class="description">
            <div class="description-text" title="${escapeHtml(complaint.description)}">
                ${escapeHtml(description)}
                ${complaint.description.length > 80 ? '<span class="read-more">... <small>(klik untuk detail)</small></span>' : ""}
            </div>
        </td>
        <td class="status-cell">
            <span class="status-badge status-${complaint.status}">
                <i class="fas fa-${statusIcons[complaint.status] || "question-circle"}"></i>
                ${capitalizeFirst(complaint.status)}
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
    `

  return row
}

function viewComplaint(id) {
  console.log("Viewing complaint:", id)

  // Show loading in modal
  document.getElementById("modalBody").innerHTML =
    '<div class="loading"><i class="fas fa-spinner fa-spin"></i> Loading...</div>'
  document.getElementById("complaintModal").style.display = "block"

  // Fetch complaint details
  fetch("get_complaints.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      id: id,
      action: "get_detail",
    }),
  })
    .then((response) => response.json())
    .then((data) => {
      console.log("Complaint detail response:", data)
      if (data.success) {
        displayComplaintDetails(data.complaint)
      } else {
        document.getElementById("modalBody").innerHTML = '<div class="error">Error loading complaint details</div>'
      }
    })
    .catch((error) => {
      console.error("Error loading complaint details:", error)
      document.getElementById("modalBody").innerHTML = '<div class="error">Error loading complaint details</div>'
    })
}

function displayComplaintDetails(complaint) {
  const modalBody = document.getElementById("modalBody")

  const typeIcons = {
    energy: "bolt",
    weight: "weight",
    digestion: "utensils",
    immunity: "shield-alt",
    sleep: "bed",
    other: "question-circle",
  }

  const statusIcons = {
    open: "exclamation-circle",
    pending: "clock",
    resolved: "check-circle",
  }

  modalBody.innerHTML = `
        <div class="complaint-details">
            <div class="detail-row">
                <label>Complaint ID:</label>
                <span class="id-badge">#${String(complaint.id).padStart(4, "0")}</span>
            </div>
            <div class="detail-row">
                <label>User:</label>
                <span>${escapeHtml(complaint.user_name)} (${escapeHtml(complaint.user_email)})</span>
            </div>
            <div class="detail-row">
                <label>Phone:</label>
                <span>${escapeHtml(complaint.phone || "N/A")}</span>
            </div>
            <div class="detail-row">
                <label>Type:</label>
                <span class="type-badge type-${complaint.complaint_type}">
                    <i class="fas fa-${typeIcons[complaint.complaint_type] || "question-circle"}"></i>
                    ${capitalizeFirst(complaint.complaint_type)}
                </span>
            </div>
            <div class="detail-row">
                <label>Status:</label>
                <span class="status-badge status-${complaint.status}">
                    <i class="fas fa-${statusIcons[complaint.status] || "question-circle"}"></i>
                    ${capitalizeFirst(complaint.status)}
                </span>
            </div>
            <div class="detail-row">
                <label>Created:</label>
                <span>${formatDate(complaint.created_at)} ${formatTime(complaint.created_at)}</span>
            </div>
            <div class="detail-row full-width">
                <label>Description:</label>
                <div class="description-full">
                    ${escapeHtml(complaint.description)}
                </div>
            </div>
        </div>
        <div class="modal-actions">
            <button class="btn-action btn-edit" onclick="editStatus(${complaint.id}, '${complaint.status}')">
                <i class="fas fa-edit"></i> Update Status
            </button>
        </div>
    `
}

function editStatus(id, currentStatus) {
  console.log("Editing status for complaint:", id, "current status:", currentStatus)

  document.getElementById("complaintId").value = id
  document.getElementById("newStatus").value = currentStatus
  document.getElementById("statusModal").style.display = "block"

  // Close complaint modal if open
  document.getElementById("complaintModal").style.display = "none"
}

function updateComplaintStatus(event) {
  event.preventDefault()
  console.log("Updating complaint status...")

  const formData = new FormData(event.target)
  const data = {
    complaint_id: formData.get("complaint_id"),
    status: formData.get("status"),
    action: "update_status",
  }

  console.log("Update data:", data)

  fetch("get_complaints.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(data),
  })
    .then((response) => response.json())
    .then((data) => {
      console.log("Update response:", data)
      if (data.success) {
        showSuccess("Status updated successfully")
        closeStatusModal()
        refreshData()
      } else {
        showError("Error updating status: " + data.message)
      }
    })
    .catch((error) => {
      console.error("Update error:", error)
      showError("Error updating status")
    })
}

function refreshData() {
  console.log("Refreshing data...")

  // Reset filters
  document.getElementById("statusFilter").value = ""
  document.getElementById("typeFilter").value = ""

  // Reload page to get fresh data
  window.location.reload()
}

function updateStats(stats) {
  // Update charts with new data
  if (typeChart && stats.by_type) {
    typeChart.data.datasets[0].data = Object.values(stats.by_type)
    typeChart.update()
  }

  if (statusChart && stats.by_status) {
    statusChart.data.datasets[0].data = Object.values(stats.by_status)
    statusChart.update()
  }
}

function closeModal() {
  document.getElementById("complaintModal").style.display = "none"
}

function closeStatusModal() {
  document.getElementById("statusModal").style.display = "none"
}

function showLoading() {
  const tbody = document.getElementById("complaintsTableBody")
  tbody.innerHTML =
    '<tr><td colspan="7" class="loading-row"><i class="fas fa-spinner fa-spin"></i> Loading...</td></tr>'
}

function hideLoading() {
  // Loading will be hidden when table is updated
}

function showSuccess(message) {
  alert("Success: " + message)
}

function showError(message) {
  alert("Error: " + message)
}

// Utility functions
function escapeHtml(text) {
  const div = document.createElement("div")
  div.textContent = text
  return div.innerHTML
}

function capitalizeFirst(str) {
  return str.charAt(0).toUpperCase() + str.slice(1)
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
