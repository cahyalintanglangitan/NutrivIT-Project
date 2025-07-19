// Enhanced AI Analysis JavaScript with Database-Only Focus

// Quick question templates based on actual database queries
const quickQuestions = {
  "revenue-analysis":
    "Berikan analisis lengkap revenue NutrivIT tahun 2025. Bagaimana tren bulanan, total pendapatan, dan average order value? Apa insight strategis dari data penjualan?",

  "top-products":
    "Analisis produk terlaris NutrivIT berdasarkan data penjualan. Produk mana yang paling sukses? Berapa unit terjual dan revenue masing-masing? Apa strategi untuk produk underperform?",

  "user-complaints":
    "Apa keluhan pengguna terbanyak di NutrivIT? Berikan breakdown berdasarkan kategori dan status. Bagaimana ini mempengaruhi bisnis dan apa solusi yang direkomendasikan?",

  "user-demographics":
    "Analisis demografi pengguna NutrivIT. Bagaimana distribusi berdasarkan gender, usia, member type? Apa insight untuk targeting dan segmentasi yang lebih baik?",

  "nutrition-insights":
    "Bagaimana pencapaian nutrisi pengguna NutrivIT? Berapa rata-rata achievement rate? Area mana yang perlu improvement dan bagaimana produk bisa membantu?",

  "business-opportunities":
    "Berdasarkan semua data NutrivIT, apa peluang bisnis terbesar? Produk apa yang harus dikembangkan? Segmen mana yang potensial untuk ekspansi?",
}

// Chat state
const isTyping = false
let chatHistory = []

// Initialize page
document.addEventListener("DOMContentLoaded", () => {
  // Set current date
  document.getElementById("current-date").textContent = new Date().toLocaleDateString("id-ID", {
    weekday: "long",
    year: "numeric",
    month: "long",
    day: "numeric",
  })

  // Set welcome message time
  document.getElementById("welcome-time").textContent = new Date().toLocaleTimeString("id-ID", {
    hour: "2-digit",
    minute: "2-digit",
  })

  // Setup input handlers
  setupInputHandlers()

  // Add click handlers for insight cards
  setupInsightCardHandlers()
})

// Setup input event handlers
function setupInputHandlers() {
  const textarea = document.getElementById("user-input")
  const sendBtn = document.getElementById("send-btn")

  // Auto-resize textarea
  textarea.addEventListener("input", function () {
    this.style.height = "auto"
    this.style.height = Math.min(this.scrollHeight, 150) + "px"

    // Enable/disable send button
    sendBtn.disabled = this.value.trim() === ""
  })

  // Send on Enter (but not Shift+Enter)
  textarea.addEventListener("keydown", (e) => {
    if (e.key === "Enter" && !e.shiftKey) {
      e.preventDefault()
      sendMessage()
    }
  })
}

// Setup insight card click handlers
function setupInsightCardHandlers() {
  const insightCards = document.querySelectorAll(".insight-card")

  insightCards.forEach((card) => {
    card.addEventListener("click", function () {
      const actionText = this.querySelector(".insight-action").textContent

      let question = ""
      if (actionText.includes("revenue")) {
        question = quickQuestions["revenue-analysis"]
      } else if (actionText.includes("produk")) {
        question = quickQuestions["top-products"]
      } else if (actionText.includes("keluhan")) {
        question = quickQuestions["user-complaints"]
      } else if (actionText.includes("pengguna")) {
        question = quickQuestions["user-demographics"]
      }

      if (question) {
        document.getElementById("user-input").value = question
        sendMessage()
      }
    })
  })
}

// Send message function
function sendMessage() {
  const textarea = document.getElementById("user-input")
  const message = textarea.value.trim()

  // Exit if no message or currently typing
  const typingIndicator = document.getElementById("typing-indicator")
  if (!message || typingIndicator) return

  // Add user message to chat
  addMessage(message, "user")

  // Clear input and disable send button
  textarea.value = ""
  textarea.style.height = "auto"
  document.getElementById("send-btn").disabled = true

  // Show typing indicator
  showTypingIndicator()

  // Send to enhanced API
  fetch("api_chat.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Accept: "application/json",
    },
    body: JSON.stringify({ prompt: message }),
  })
    .then((response) => {
      if (!response.ok) {
        return response.json().then((err) => {
          throw new Error(err.error || `HTTP error! status: ${response.status}`)
        })
      }
      return response.json()
    })
    .then((data) => {
      hideTypingIndicator()

      if (data.reply) {
        addMessage(data.reply, "ai")
      } else {
        const errorMessage = data.error || "Terjadi kesalahan yang tidak diketahui."
        addMessage(`⚠️ **Error:** ${errorMessage}`, "ai")
      }
    })
    .catch((error) => {
      console.error("Fetch Error:", error)
      hideTypingIndicator()
      addMessage(
        `⚠️ **Koneksi Error:** Tidak dapat terhubung ke AI Business Analyst. Pastikan server dan database berjalan normal. (${error.message})`,
        "ai",
      )
    })
}

// Quick question handler
function askQuickQuestion(type) {
  const question = quickQuestions[type]
  if (question) {
    document.getElementById("user-input").value = question
    sendMessage()
  }
}

// Add message to chat
function addMessage(text, sender) {
  const messagesContainer = document.getElementById("chat-messages")
  const messageTime = new Date().toLocaleTimeString("id-ID", {
    hour: "2-digit",
    minute: "2-digit",
  })

  const messageDiv = document.createElement("div")
  messageDiv.className = `message ${sender}-message new`

  messageDiv.innerHTML = `
    <div class="message-avatar">
      <i class="fas fa-${sender === "ai" ? "robot" : "user"}"></i>
    </div>
    <div class="message-content">
      <div class="message-text">${formatMessage(text)}</div>
      <div class="message-time">${messageTime}</div>
    </div>
  `

  messagesContainer.appendChild(messageDiv)
  messagesContainer.scrollTop = messagesContainer.scrollHeight

  // Store in chat history
  chatHistory.push({
    text: text,
    sender: sender,
    timestamp: new Date(),
  })

  // Remove 'new' class after animation
  setTimeout(() => {
    messageDiv.classList.remove("new")
  }, 300)
}

// Enhanced message formatting
function formatMessage(text) {
  return text
    .replace(/\*\*(.*?)\*\*/g, "<strong>$1</strong>")
    .replace(/\*(.*?)\*/g, "<em>$1</em>")
    .replace(/\n/g, "<br>")
    .replace(/•/g, "•")
    .replace(/(\d+\.)/g, "<strong>$1</strong>")
    .replace(/Rp\s*([\d,.]+)/g, '<span style="color: #10b981; font-weight: 600;">Rp $1</span>')
    .replace(/(\d+)%/g, '<span style="color: #3b82f6; font-weight: 600;">$1%</span>')
    .replace(/(#\d+)/g, '<span style="color: #8b5cf6; font-weight: 600;">$1</span>')
}

// Show typing indicator
function showTypingIndicator() {
  const messagesContainer = document.getElementById("chat-messages")
  const typingDiv = document.createElement("div")
  typingDiv.className = "typing-indicator"
  typingDiv.id = "typing-indicator"

  typingDiv.innerHTML = `
    <div class="message-avatar">
      <i class="fas fa-robot"></i>
    </div>
    <div class="typing-content">
      <div class="typing-text">AI sedang menganalisis data database...</div>
      <div class="typing-dots">
        <div class="dot"></div>
        <div class="dot"></div>
        <div class="dot"></div>
      </div>
    </div>
  `

  messagesContainer.appendChild(typingDiv)
  messagesContainer.scrollTop = messagesContainer.scrollHeight
}

// Hide typing indicator
function hideTypingIndicator() {
  const typingIndicator = document.getElementById("typing-indicator")
  if (typingIndicator) {
    typingIndicator.remove()
  }
}

// Clear chat function
function clearChat() {
  if (confirm("Apakah Anda yakin ingin menghapus semua percakapan?")) {
    const messagesContainer = document.getElementById("chat-messages")

    // Keep only the welcome message
    const welcomeMessage = messagesContainer.querySelector(".ai-message")
    messagesContainer.innerHTML = ""
    messagesContainer.appendChild(welcomeMessage)

    // Clear chat history
    chatHistory = []

    showAlert("Chat berhasil dibersihkan!", "success")
  }
}

// Export chat function
function exportChat() {
  if (chatHistory.length === 0) {
    showAlert("Tidak ada percakapan untuk diekspor.", "info")
    return
  }

  const exportData = {
    exportDate: new Date().toISOString(),
    company: "NutrivIT",
    sessionType: "AI Business Analysis",
    totalMessages: chatHistory.length,
    conversations: chatHistory.map((msg) => ({
      sender: msg.sender === "ai" ? "AI Business Analyst" : "Manager",
      message: msg.text,
      timestamp: msg.timestamp.toISOString(),
    })),
  }

  const blob = new Blob([JSON.stringify(exportData, null, 2)], {
    type: "application/json",
  })

  const url = URL.createObjectURL(blob)
  const a = document.createElement("a")
  a.href = url
  a.download = `nutrivit-ai-business-analysis-${new Date().toISOString().split("T")[0]}.json`
  document.body.appendChild(a)
  a.click()
  document.body.removeChild(a)
  URL.revokeObjectURL(url)

  showAlert("Analisis berhasil diekspor!", "success")
}

// Show alert message
function showAlert(message, type = "info") {
  // Remove existing alerts
  const existingAlert = document.querySelector(".alert")
  if (existingAlert) {
    existingAlert.remove()
  }

  const alertDiv = document.createElement("div")
  alertDiv.className = `alert ${type}`

  const icon = type === "success" ? "check-circle" : type === "error" ? "exclamation-triangle" : "info-circle"

  alertDiv.innerHTML = `
    <i class="fas fa-${icon}"></i>
    <span>${message}</span>
  `

  // Insert at the top of content
  const contentSection = document.querySelector(".content-section")
  contentSection.insertBefore(alertDiv, contentSection.firstChild)

  // Auto remove after 5 seconds
  setTimeout(() => {
    alertDiv.remove()
  }, 5000)
}

// Keyboard shortcuts
document.addEventListener("keydown", (e) => {
  // Ctrl+Enter to send message
  if (e.ctrlKey && e.key === "Enter") {
    sendMessage()
  }

  // Ctrl+K to clear chat
  if (e.ctrlKey && e.key === "k") {
    e.preventDefault()
    clearChat()
  }

  // Ctrl+E to export
  if (e.ctrlKey && e.key === "e") {
    e.preventDefault()
    exportChat()
  }
})

// Auto-update data source indicators
function updateDataSourceStatus() {
  const statusElements = document.querySelectorAll(".source-status.active")
  statusElements.forEach((status) => {
    // Add pulse animation to show live status
    status.style.animation = "pulse 2s infinite"
  })
}

// Initialize data source status updates
setInterval(updateDataSourceStatus, 5000)

// Initialize tooltips and other UI enhancements
document.addEventListener("DOMContentLoaded", () => {
  // Add hover effects to insight cards
  const insightCards = document.querySelectorAll(".insight-card")
  insightCards.forEach((card) => {
    card.style.cursor = "pointer"
    card.title = "Klik untuk menganalisis topik ini"
  })

  // Update data source status
  updateDataSourceStatus()
})
