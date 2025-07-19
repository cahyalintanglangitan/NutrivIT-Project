// UI Components for NutrivIT - Traditional JavaScript approach
// This file provides reusable UI components without ES6 modules

// Global UI utilities object
window.NutrivitUI = {
  // Modal utilities
  modal: {
    show: (modalId) => {
      const modal = document.getElementById(modalId)
      if (modal) {
        modal.style.display = "block"
        document.body.style.overflow = "hidden"
      }
    },

    hide: (modalId) => {
      const modal = document.getElementById(modalId)
      if (modal) {
        modal.style.display = "none"
        document.body.style.overflow = "auto"
      }
    },

    create: (options) => {
      const modal = document.createElement("div")
      modal.className = "modal"
      modal.id = options.id || "dynamicModal"

      modal.innerHTML = `
                <div class="modal-content">
                    <div class="modal-header">
                        <h3>${options.title || "Modal"}</h3>
                        <button class="modal-close" onclick="NutrivitUI.modal.hide('${modal.id}')">&times;</button>
                    </div>
                    <div class="modal-body">
                        ${options.content || ""}
                    </div>
                    ${options.footer ? `<div class="modal-footer">${options.footer}</div>` : ""}
                </div>
            `

      document.body.appendChild(modal)
      return modal
    },
  },

  // Loading utilities
  loading: {
    show: (element, message = "Loading...") => {
      if (typeof element === "string") {
        element = document.getElementById(element)
      }
      if (element) {
        element.innerHTML = `
                    <div class="loading">
                        <i class="fas fa-spinner fa-spin"></i>
                        <span>${message}</span>
                    </div>
                `
      }
    },

    hide: (element) => {
      if (typeof element === "string") {
        element = document.getElementById(element)
      }
      if (element) {
        const loading = element.querySelector(".loading")
        if (loading) {
          loading.remove()
        }
      }
    },
  },

  // Toast notifications
  toast: {
    show: function (message, type = "info", duration = 3000) {
      const toast = document.createElement("div")
      toast.className = `toast toast-${type}`

      const icons = {
        success: "check-circle",
        error: "exclamation-circle",
        warning: "exclamation-triangle",
        info: "info-circle",
      }

      toast.innerHTML = `
                <i class="fas fa-${icons[type] || "info-circle"}"></i>
                <span>${message}</span>
                <button class="toast-close" onclick="this.parentElement.remove()">&times;</button>
            `

      // Add styles
      toast.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                background: white;
                color: #333;
                padding: 15px 20px;
                border-radius: 10px;
                border-left: 4px solid ${this.getTypeColor(type)};
                z-index: 1001;
                display: flex;
                align-items: center;
                gap: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                animation: slideInRight 0.3s ease;
                min-width: 300px;
            `

      document.body.appendChild(toast)

      // Auto remove
      if (duration > 0) {
        setTimeout(() => {
          if (toast.parentNode) {
            toast.style.animation = "slideOutRight 0.3s ease"
            setTimeout(() => {
              if (toast.parentNode) {
                toast.parentNode.removeChild(toast)
              }
            }, 300)
          }
        }, duration)
      }

      return toast
    },

    getTypeColor: (type) => {
      const colors = {
        success: "#28a745",
        error: "#dc3545",
        warning: "#ffc107",
        info: "#17a2b8",
      }
      return colors[type] || colors.info
    },
  },

  // Form utilities
  form: {
    serialize: (form) => {
      const formData = new FormData(form)
      const data = {}
      for (const [key, value] of formData.entries()) {
        data[key] = value
      }
      return data
    },

    validate: function (form, rules) {
      const errors = []
      const data = this.serialize(form)

      for (const field in rules) {
        const rule = rules[field]
        const value = data[field]

        if (rule.required && (!value || value.trim() === "")) {
          errors.push(`${rule.label || field} is required`)
        }

        if (value && rule.minLength && value.length < rule.minLength) {
          errors.push(`${rule.label || field} must be at least ${rule.minLength} characters`)
        }

        if (value && rule.maxLength && value.length > rule.maxLength) {
          errors.push(`${rule.label || field} must not exceed ${rule.maxLength} characters`)
        }

        if (value && rule.pattern && !rule.pattern.test(value)) {
          errors.push(`${rule.label || field} format is invalid`)
        }
      }

      return {
        isValid: errors.length === 0,
        errors: errors,
      }
    },
  },

  // Table utilities
  table: {
    updateRow: (tableId, rowId, data) => {
      const table = document.getElementById(tableId)
      if (!table) return

      const row = table.querySelector(`tr[data-id="${rowId}"]`)
      if (row) {
        // Update row data based on provided data object
        Object.keys(data).forEach((key) => {
          const cell = row.querySelector(`[data-field="${key}"]`)
          if (cell) {
            cell.textContent = data[key]
          }
        })
      }
    },

    addRow: (tableId, rowData, position = "append") => {
      const table = document.getElementById(tableId)
      if (!table) return

      const tbody = table.querySelector("tbody")
      if (!tbody) return

      const row = document.createElement("tr")
      row.innerHTML = rowData

      if (position === "prepend") {
        tbody.insertBefore(row, tbody.firstChild)
      } else {
        tbody.appendChild(row)
      }

      return row
    },

    removeRow: (tableId, rowId) => {
      const table = document.getElementById(tableId)
      if (!table) return

      const row = table.querySelector(`tr[data-id="${rowId}"]`)
      if (row) {
        row.remove()
      }
    },
  },

  // Animation utilities
  animate: {
    fadeIn: (element, duration = 300) => {
      if (typeof element === "string") {
        element = document.getElementById(element)
      }
      if (element) {
        element.style.opacity = "0"
        element.style.display = "block"

        let start = null
        function step(timestamp) {
          if (!start) start = timestamp
          const progress = timestamp - start
          const opacity = Math.min(progress / duration, 1)

          element.style.opacity = opacity

          if (progress < duration) {
            requestAnimationFrame(step)
          }
        }
        requestAnimationFrame(step)
      }
    },

    fadeOut: (element, duration = 300, callback) => {
      if (typeof element === "string") {
        element = document.getElementById(element)
      }
      if (element) {
        let start = null
        function step(timestamp) {
          if (!start) start = timestamp
          const progress = timestamp - start
          const opacity = Math.max(1 - progress / duration, 0)

          element.style.opacity = opacity

          if (progress < duration) {
            requestAnimationFrame(step)
          } else {
            element.style.display = "none"
            if (callback) callback()
          }
        }
        requestAnimationFrame(step)
      }
    },
  },

  // Utility functions
  utils: {
    debounce: (func, wait) => {
      let timeout
      return function executedFunction(...args) {
        const later = () => {
          clearTimeout(timeout)
          func(...args)
        }
        clearTimeout(timeout)
        timeout = setTimeout(later, wait)
      }
    },

    throttle: (func, limit) => {
      let inThrottle
      return function () {
        const args = arguments
        
        if (!inThrottle) {
          func.apply(this, args)
          inThrottle = true
          setTimeout(() => (inThrottle = false), limit)
        }
      }
    },

    formatCurrency: (amount, currency = "IDR") =>
      new Intl.NumberFormat("id-ID", {
        style: "currency",
        currency: currency,
      }).format(amount),

    formatDate: (date, options = {}) => {
      const defaultOptions = {
        year: "numeric",
        month: "long",
        day: "numeric",
      }
      return new Date(date).toLocaleDateString("id-ID", { ...defaultOptions, ...options })
    },

    escapeHtml: (text) => {
      const div = document.createElement("div")
      div.textContent = text
      return div.innerHTML
    },
  },
}

// Initialize UI components when DOM is loaded
document.addEventListener("DOMContentLoaded", () => {
  // Add global styles for UI components
  const style = document.createElement("style")
  style.textContent = `
        .loading {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            padding: 20px;
            color: #666;
            font-style: italic;
        }
        
        .toast {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1001;
            animation: slideInRight 0.3s ease;
        }
        
        .toast-close {
            background: none;
            border: none;
            font-size: 18px;
            cursor: pointer;
            color: #999;
            margin-left: auto;
        }
        
        .toast-close:hover {
            color: #333;
        }
        
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

  console.log("NutrivIT UI components loaded and ready")
})
