// AI Analysis JavaScript

// NutrivIT Dashboard Data Integration
const dashboardData = {
  h1_2025: {
    revenue: "19.45B",
    revenue_juni: "3.25B",
    revenue_growth: "+15%",
    total_users: 1234,
    user_growth: "+12%",
    products: 8,
    keluhan_juni: 1044,
  },
  nutrition_gaps: {
    biggest_gap: "Lemak Sehat (kurang 30%)",
    protein_gap: "Protein kurang 20% di Juni",
    vitamin_gap: "Vitamin kurang 23%",
    achievement_rate: "72.3% (rata-rata 6 bulan)",
  },
  top_complaints: {
    juni: "Kelelahan (28.7% user)",
    pattern: "Sering muncul 4 dari 6 bulan",
    root_cause: "Kurang lemak sehat & protein",
  },
  best_sellers_h1: {
    rank1: "NuVit-Multi Core (16,650 unit)",
    rank2: "NuVit-Green Detox (15,830 unit)",
    rank3: "NuVit-Whey Muscle (14,720 unit)",
    rank4: "NuVit-C Boost (14,230 unit)",
    total_sales: "108,070 unit",
  },
  market_insights: {
    multi_success: "Solusi lengkap untuk masalah lelah",
    detox_surprise: "Feb-Mar spike untuk pencernaan & obesitas",
    protein_consistent: "Stabil terus, masih ada gap",
    omega_opportunity: "Lemak defisit = peluang besar",
  },
};

// Quick question templates
const quickQuestions = {
  "gap-analysis":
    "Tolong jelaskan kekurangan nutrisi terbesar berdasarkan data Juni. Apa artinya lemak sehat kurang 30% dan protein kurang 20%? Bagaimana ini bisa jadi peluang bisnis?",
  "product-strategy":
    "Multi Core jual 16,650 botol jadi juara. Green Detox juga bagus 15,830 botol. Apa strategi lanjutan untuk H2 2025? Produk mana yang harus dikembangkan?",
  "launch-plan":
    "Berdasarkan data dashboard, bagaimana rencana launching produk baru? Prioritas mana yang harus didahulukan untuk atasi masalah lelah dan kekurangan nutrisi?",
  "market-opportunity":
    "Dengan 1,234 user dan pendapatan Rp 19.45B di H1, apa peluang pasar terbesar untuk H2? Bagaimana cara maksimalkan potensi yang ada?",
};

// Chat state
let isTyping = false;
let chatHistory = [];

// Initialize page
document.addEventListener("DOMContentLoaded", function () {
  // Set current date
  document.getElementById("current-date").textContent =
    new Date().toLocaleDateString("id-ID", {
      weekday: "long",
      year: "numeric",
      month: "long",
      day: "numeric",
    });

  // Set welcome message time
  document.getElementById("welcome-time").textContent =
    new Date().toLocaleTimeString("id-ID", {
      hour: "2-digit",
      minute: "2-digit",
    });

  // Check authentication
  if (!localStorage.getItem("auth")) {
    window.location.href = "login.php";
  }

  // Setup input handlers
  setupInputHandlers();

  // Update last update time
  updateLastUpdateTime();
});

// Setup input event handlers
function setupInputHandlers() {
  const textarea = document.getElementById("user-input");
  const sendBtn = document.getElementById("send-btn");

  // Auto-resize textarea
  textarea.addEventListener("input", function () {
    this.style.height = "auto";
    this.style.height = Math.min(this.scrollHeight, 150) + "px";

    // Enable/disable send button
    sendBtn.disabled = this.value.trim() === "";
  });

  // Send on Enter (but not Shift+Enter)
  textarea.addEventListener("keydown", function (e) {
    if (e.key === "Enter" && !e.shiftKey) {
      e.preventDefault();
      sendMessage();
    }
  });
}

// Send message function
function sendMessage() {
  const textarea = document.getElementById("user-input");
  const message = textarea.value.trim();

  // Keluar jika tidak ada pesan atau sedang "mengetik"
  const typingIndicator = document.getElementById("typing-indicator");
  if (!message || typingIndicator) return;

  // Tambahkan pesan pengguna ke tampilan chat
  addMessage(message, "user");

  // Kosongkan input dan nonaktifkan tombol kirim
  textarea.value = "";
  textarea.style.height = "auto";
  document.getElementById("send-btn").disabled = true;

  // Tampilkan indikator "sedang mengetik"
  showTypingIndicator();

  // Kirim pesan ke backend (api_chat.php) yang sudah diperbarui
  fetch('api_chat.php', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    },
    body: JSON.stringify({ prompt: message })
  })
  .then(response => {
    if (!response.ok) {
      // Jika server merespons dengan error (misal: 500, 404)
      // coba untuk membaca body error jika ada
      return response.json().then(err => { throw new Error(err.error || `HTTP error! status: ${response.status}`) });
    }
    return response.json();
  })
  .then(data => {
    hideTypingIndicator();

    if (data.reply) {
      // Tampilkan balasan dari AI
      addMessage(data.reply, "ai");
    } else {
      // Tampilkan pesan error dari backend jika ada
      const errorMessage = data.error || 'Terjadi kesalahan yang tidak diketahui.';
      addMessage(`⚠️ **Error:** ${errorMessage}`, "ai");
    }
  })
  .catch(error => {
    console.error('Fetch Error:', error);
    hideTypingIndicator();
    // Tampilkan pesan error di chat untuk masalah koneksi atau parsing
    addMessage(`⚠️ **Error:** Tidak dapat terhubung ke server AI. Pastikan server berjalan dan database terhubung. (${error.message})`, "ai");
  });
}


// Quick question handler
function askQuickQuestion(type) {
  const question = quickQuestions[type];
  document.getElementById("user-input").value = question;
  sendMessage();
}

// Add message to chat
function addMessage(text, sender) {
  const messagesContainer = document.getElementById("chat-messages");
  const messageTime = new Date().toLocaleTimeString("id-ID", {
    hour: "2-digit",
    minute: "2-digit",
  });

  const messageDiv = document.createElement("div");
  messageDiv.className = `message ${sender}-message new`;

  messageDiv.innerHTML = `
    <div class="message-avatar">
      <i class="fas fa-${sender === "ai" ? "robot" : "user"}"></i>
    </div>
    <div class="message-content">
      <div class="message-text">${formatMessage(text)}</div>
      <div class="message-time">${messageTime}</div>
    </div>
  `;

  messagesContainer.appendChild(messageDiv);
  messagesContainer.scrollTop = messagesContainer.scrollHeight;

  // Store in chat history
  chatHistory.push({
    text: text,
    sender: sender,
    timestamp: new Date(),
  });

  // Remove 'new' class after animation
  setTimeout(() => {
    messageDiv.classList.remove("new");
  }, 300);
}

// Format message text (simple markdown-like formatting)
function formatMessage(text) {
  return text
    .replace(/\*\*(.*?)\*\*/g, "<strong>$1</strong>")
    .replace(/\*(.*?)\*/g, "<em>$1</em>")
    .replace(/\n/g, "<br>")
    .replace(/•/g, "•")
    .replace(/(\d+\.)/g, "<strong>$1</strong>");
}


// Show typing indicator
function showTypingIndicator() {
  const messagesContainer = document.getElementById("chat-messages");
  const typingDiv = document.createElement("div");
  typingDiv.className = "typing-indicator";
  typingDiv.id = "typing-indicator";

  typingDiv.innerHTML = `
    <div class="message-avatar">
      <i class="fas fa-robot"></i>
    </div>
    <div class="typing-content">
      <div class="typing-text">AI sedang analisis data...</div>
      <div class="typing-dots">
        <div class="dot"></div>
        <div class="dot"></div>
        <div class="dot"></div>
      </div>
    </div>
  `;

  messagesContainer.appendChild(typingDiv);
  messagesContainer.scrollTop = messagesContainer.scrollHeight;
}

// Hide typing indicator
function hideTypingIndicator() {
  const typingIndicator = document.getElementById("typing-indicator");
  if (typingIndicator) {
    typingIndicator.remove();
  }
}

// Clear chat function
function clearChat() {
  if (confirm("Apakah Anda yakin ingin menghapus semua percakapan?")) {
    const messagesContainer = document.getElementById("chat-messages");

    // Keep only the welcome message
    const welcomeMessage = messagesContainer.querySelector(".ai-message");
    messagesContainer.innerHTML = "";
    messagesContainer.appendChild(welcomeMessage);

    // Clear chat history
    chatHistory = [];

    // Show success message
    showAlert("Chat berhasil dibersihkan!", "success");
  }
}

// Export chat function
function exportChat() {
  if (chatHistory.length === 0) {
    showAlert("Tidak ada percakapan untuk diekspor.", "info");
    return;
  }

  const exportData = {
    exportDate: new Date().toISOString(),
    totalMessages: chatHistory.length,
    conversations: chatHistory.map((msg) => ({
      sender: msg.sender,
      message: msg.text,
      timestamp: msg.timestamp.toISOString(),
    })),
  };

  const blob = new Blob([JSON.stringify(exportData, null, 2)], {
    type: "application/json",
  });

  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = `nutrivit-ai-chat-${
    new Date().toISOString().split("T")[0]
  }.json`;
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  URL.revokeObjectURL(url);

  showAlert("Chat berhasil diekspor!", "success");
}

// Generate new recommendations
function generateRecommendations() {
  const button = event.target;
  const originalText = button.innerHTML;

  // Show loading state
  button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Memperbarui...';
  button.disabled = true;

  setTimeout(() => {
    // Restore button
    button.innerHTML = originalText;
    button.disabled = false;

    // Show success message
    showAlert(
      "Rekomendasi berhasil diperbarui berdasarkan data terbaru!",
      "success"
    );

    // Update last update time
    updateLastUpdateTime();
  }, 2000);
}

// Accept recommendation
function acceptRecommendation(id) {
  const recommendationItem = event.target.closest(".recommendation-item");

  if (confirm("Apakah Anda yakin ingin menerima rekomendasi ini?")) {
    recommendationItem.classList.add("accepted");

    // Disable buttons
    const buttons = recommendationItem.querySelectorAll(".action-btn");
    buttons.forEach((btn) => {
      btn.disabled = true;
      if (btn.classList.contains("accept")) {
        btn.innerHTML = '<i class="fas fa-check"></i> Diterima';
        btn.style.background = "#6b7280";
      }
    });

    showAlert(
      "Rekomendasi berhasil diterima dan akan diproses lebih lanjut.",
      "success"
    );
  }
}

// Show recommendation details
function showRecommendationDetails(id) {
  const details = {
    1: {
      title: "Detail Lengkap: Ekspansi Portfolio Lemak Sehat",
      content: `
        <strong>Situasi saat ini:</strong><br>
        • Gap lemak sehat:  30% kekurangan konsisten 6 bulan (570kg Jan → 375kg Jun)<br>
        • Dampak ke User: 8% (current) → 15% (target)<br>
        • Produk Existing: NuVit-Omega cuma 11,890 botol (underperform vs potensi)<br>
        • Root Cause: Positioning "brain health" bukan "anti lelah"<br><br>
        
       <strong>Solusi: NuVit-Omega Premium</strong><br>
        • Formula baru: EPA 800mg + DHA 400mg (rasio 2:1 khusus energi)<br>
        • Tambahan: CoQ10 + Vitamin E untuk absorpsi maksimal<br>
        • Kemasan: 90 softgels (3 bulan) vs sekarang 60<br>
        • Positioning: "Solusi Lengkap Anti Lelah" bukan brain health<br><br>
        
        <strong>Proyeksi Finansial (12 Bulan):</strong><br>
        • Investasi Awal: Rp 2.5B (pengembangan + marketing + stock)<br>
        • Harga jual: Rp 250k vs NuVit-Omega lama Rp 180k (+39%)<br>
        • Target jual: Q3: 2,000 botol | Q4: 3,500 botol | 2025: 5,000/tahun<br>
        • Revenue 12 Bulan: Rp 2.625B<br>
        • ROI: 180% dalam 12 bulan<br>
        • Break-even: Bulan ke-6

        <strong>Kenapa Ini Peluang Emas:</strong><br>
        • Market gap 30% lemak = 354+ user immediate target<br>
        • Premium pricing justified (user mau bayar untuk solusi efektif)<br>
        • First-mover advantage di segment omega premium Indonesia<br>
        • Cross-selling potential: 40% bundle dengan Multi Core<br><br>
      `,
    },
    2: {
      title: "Detail Bundle Strategy Energy Booster Pack",
      content: `
        <strong>Data Pendukung dari Dashboard:</strong><br>
        • NuVit-Multi core: Leader dengan 16,650 botol H1 (proven success)<br>
        • Nuvit-Whey Muscle: 14,720 botol (protein gap 20% masih ada)<br>
        • Customer Behavior: 65% user lelah juga beli NuVit-Whey Muscle<br>
        • Cross-selling Rate: 58% user beli 2+ produk (bisa ditingkatkan)<br><br>

        
        <strong>Konsep Bundle Energy Booster Pack:</strong><br>
        • Isi paket: NuVit-Multi Core (90 caps) + NuVit-Whey Muscle (1kg) + NuVit-Omega Premium (90 caps)<br>
        • Harga individual: Rp 595k total<br>
        • Harga bundle: Rp 505k (hemat Rp 90k = diskon 15%)<br>
        • Supply duration: 75 hari (compliance period optimal)<br>
        • Target market: 354 user kelelahan + 200 prevention-focused<br><br>
        
        <strong">Business Case:</strong><br>
        • Target Take Rate: 25% dari user eligible = 139 bundle/bulan<br>
        • Revenue Contribution: Rp 70M monthly dari bundle sales<br>
        • Average Order Value: Naik +65% vs single product<br>
        • Customer Lifetime Value: +40% dengan multi-product engagement<br>
        • Cross-selling Rate: Target naik dari 58% ke 70%<br><br>
        
        <strong> Strategi Marketing Bundle:</strong><br>
        • Scientific Messaging: "3 Nutrisi Utama Anti Lelah dalam 1 Paket"<br>
        • Value Proposition: Hemat Rp 90k + solusi lengkap<br>
        • Target Customer: User Multi Core yang sering komplain lelah<br>
        • Education Focus: Kenapa butuh vitamin + protein + lemak sehat together<br><br>
        
        <strong> Implementation Timeline:</strong><br>
        • Week 1-2: Bundle packaging design + pricing strategy finalization<br>
        • Week 3-4: Soft launch dengan 50 high-value customers<br>
        • Week 5-6: Full launch + email campaign 15,000 existing users<br>
        • Week 7-8: Performance monitoring + optimization berdasarkan take rate<br><br>
        
        <strong>Risiko & Mitigasi:</strong><br>
        • Risiko: Take rate rendah (<15%)<br>
        • Mitigasi: Extended trial period 30 hari + money-back guarantee<br>
        • Risiko: Margin pressure dari discount<br>
        • Mitigasi: Volume economics + customer retention benefits
      `,
    },
    3: {
      title: "Detail NuVit-Green Detox Marketing Boost Campaign",
      content: `
        <strong> Performance Analysis Green Detox H1:</strong><br>
        • Total Sales: 15,830 botol (rank #2 - surprise performer!)<br>
        • Peak Months: February (obesitas trend) + March (detox awareness)<br>
        • Growth Pattern: +42% YoY dalam kategori detox<br>
        • Customer Profile: Health-conscious 25-40 tahun dengan disposable income<br>
        • Seasonal Correlation: Strong performance saat health-focus periods<br><br>
        
        <strong> Summer Detox Challenge Campaign:</strong><br>
        • Campaign Theme: "21-Day Summer Body Detox Challenge"<br>
        • Community Approach: WhatsApp groups untuk peer support<br>
        • Content Strategy: Daily tips + before/after transformations<br>
        • Influencer Partnership: 10 health influencers dengan authentic engagement<br>
        • Educational Focus: Scientific backing + healthy lifestyle integration<br><br>
        
        <strong> Investment & ROI Analysis:</strong><br>
        • Total Campaign Budget: Rp 450M<br>
        • Breakdown: Digital ads (60%) + Influencer (25%) + Content creation (15%)<br>
        • Target Additional Sales: 3,000 botol Q3 (+19% vs baseline)<br>
        • Direct Revenue Uplift: Rp 225M dari incremental sales<br>
        • Campaign ROI: 150% dalam 3 bulan<br>
        • Long-term Value: Template untuk seasonal campaigns recurring<br><br>
        
        <strong>Digital Campaign Strategy:</strong><br>
        • Social Media:Instagram + TikTok dengan hashtag #SummerDetoxChallenge<br>
        • Content Pillars: Education (40%) + Transformation (35%) + Community (25%)<br>
        • Engagement Tactics: Daily challenges + weekly prizes + expert Q&A<br>
        • User Generated Content: Before/after photos + testimonials<br><br>
        
        <strong>Success Metrics & KPIs:</strong><br>
        • Campaign Engagement:</strong> Target 15% social media engagement rate<br>
        • Conversion Rate:</strong> 8% dari campaign traffic ke sales<br>
        • Community Building:</strong> 500+ active challenge participants<br>
        • Brand Awareness:</strong> +60% mention dalam health conversations<br>
        • Customer Acquisition:</strong> 800+ new customers via campaign attribution<br><br>
        
        <strong>Execution Timeline:</strong><br>
        • Pre-Launch (2 weeks): Content creation + influencer onboarding<br>
        • Launch Week: Massive social media push + PR outreach<br>
        • Challenge Period (21 days): Daily engagement + community management<br>
        • Post-Campaign (1 week): Results compilation + testimonial gathering<br><br>
        
        <strong >Long-term Strategic Value:</strong><br>
        • Establish Green Detox sebagai seasonal champion product<br>
        • Build community database untuk future campaigns<br>
        • Create content library untuk year-round marketing<br>
        • Position NutrivIT sebagai lifestyle brand vs supplement seller
      `,
    },
  };

  const detail = details[id];
  if (detail) {
    showAlert(
      `<strong>${detail.title}</strong><br><br>${detail.content}`,
      "info"
    );
  }
}

// Show alert message
function showAlert(message, type = "info") {
  // Remove existing alerts
  const existingAlert = document.querySelector(".alert");
  if (existingAlert) {
    existingAlert.remove();
  }

  const alertDiv = document.createElement("div");
  alertDiv.className = `alert ${type}`;

  const icon =
    type === "success"
      ? "check-circle"
      : type === "error"
      ? "exclamation-triangle"
      : "info-circle";

  alertDiv.innerHTML = `
    <i class="fas fa-${icon}"></i>
    <span>${message}</span>
  `;

  // Insert at the top of content
  const contentSection = document.querySelector(".content-section");
  contentSection.insertBefore(alertDiv, contentSection.firstChild);

  // Auto remove after 5 seconds
  setTimeout(() => {
    alertDiv.remove();
  }, 5000);
}

// Update last update time
function updateLastUpdateTime() {
  document.getElementById("last-update").textContent = "Baru saja";

  // Update to relative time after 1 minute
  setTimeout(() => {
    document.getElementById("last-update").textContent = "1 menit yang lalu";
  }, 60000);
}

// Logout functionality
function handleLogout() {
  if (confirm("Apakah Anda yakin ingin keluar?")) {
    localStorage.removeItem("auth");
    window.location.href = "login.php";
  }
}

// Auto-update insights periodically
setInterval(() => {
  // Simulate real-time data updates
  const insights = document.querySelectorAll(".insight-card");
  insights.forEach((card) => {
    // Add subtle animation to show data refresh
    card.style.transform = "scale(1.02)";
    setTimeout(() => {
      card.style.transform = "scale(1)";
    }, 200);
  });
}, 300000); // Every 5 minutes

// Simulate real-time data source updates
function updateDataSources() {
  const sources = [
    {
      selector: ".source-item:nth-child(1) p",
      values: [
        "1,234 pengguna aktif",
        "1,245 pengguna aktif",
        "1,238 pengguna aktif",
      ],
    },
    {
      selector: ".source-item:nth-child(2) p",
      values: [
        "892 laporan minggu ini",
        "897 laporan minggu ini",
        "885 laporan minggu ini",
      ],
    },
    {
      selector: ".source-item:nth-child(3) p",
      values: ["567 transaksi", "572 transaksi", "563 transaksi"],
    },
    {
      selector: ".source-item:nth-child(4) p",
      values: ["89 sesi aktif", "92 sesi aktif", "87 sesi aktif"],
    },
    {
      selector: ".source-item:nth-child(5) p",
      values: ["156 review baru", "159 review baru", "153 review baru"],
    },
  ];

  sources.forEach((source) => {
    const element = document.querySelector(source.selector);
    if (element) {
      const randomValue =
        source.values[Math.floor(Math.random() * source.values.length)];
      element.textContent = randomValue;
    }
  });
}

// Update data sources every 2 minutes
setInterval(updateDataSources, 120000);

// Enhanced message formatting with better markdown support
function formatMessage(text) {
  return (
    text
      // Bold text
      .replace(/\*\*(.*?)\*\*/g, "<strong>$1</strong>")
      // Italic text
      .replace(/\*(.*?)\*/g, "<em>$1</em>")
      // Line breaks
      .replace(/\n/g, "<br>")
      // Bullet points
      .replace(
        /^• /gm,
        '<span style="color: #08A55A; font-weight: bold;">•</span> '
      )
      // Numbered lists
      .replace(/^(\d+\.) /gm, '<strong style="color: #08A55A;">$1</strong> ')
      // Emojis/icons
      .replace(/🎯/g, '<i class="fas fa-bullseye" style="color: #f59e0b;"></i>')
      .replace(/💪/g, '<i class="fas fa-dumbbell" style="color: #06b6d4;"></i>')
      .replace(/🌱/g, '<i class="fas fa-seedling" style="color: #10b981;"></i>')
      .replace(/🚀/g, '<i class="fas fa-rocket" style="color: #8b5cf6;"></i>')
      .replace(
        /📊/g,
        '<i class="fas fa-chart-bar" style="color: #3b82f6;"></i>'
      )
      .replace(
        /📈/g,
        '<i class="fas fa-chart-line" style="color: #10b981;"></i>'
      )
      .replace(/👥/g, '<i class="fas fa-users" style="color: #6366f1;"></i>')
      .replace(
        /💰/g,
        '<i class="fas fa-money-bill-wave" style="color: #f59e0b;"></i>'
      )
      .replace(/🏆/g, '<i class="fas fa-trophy" style="color: #eab308;"></i>')
      .replace(/🔍/g, '<i class="fas fa-search" style="color: #64748b;"></i>')
      .replace(
        /💡/g,
        '<i class="fas fa-lightbulb" style="color: #f59e0b;"></i>'
      )
      // Headers
      .replace(
        /^### (.*$)/gm,
        '<h4 style="color: #333; margin: 10px 0 5px 0;">$1</h4>'
      )
      .replace(
        /^## (.*$)/gm,
        '<h3 style="color: #333; margin: 15px 0 8px 0;">$1</h3>'
      )
      // Code blocks
      .replace(
        /`(.*?)`/g,
        '<code style="background: #f3f4f6; padding: 2px 6px; border-radius: 4px; font-family: monospace;">$1</code>'
      )
  );
}

// Analyze message context
function analyzeMessageContext(message) {
  const lowerMessage = message.toLowerCase();

  return {
    isGreeting: /^(hai|halo|hi|hello|selamat|good)/i.test(message),
    isQuestion: /\?|bagaimana|apa|kapan|dimana|mengapa|kenapa|berapa/i.test(
      message
    ),
    isRequest: /tolong|minta|bisa|dapat|bantu|buatkan|analisis|rekomen/i.test(
      message
    ),
    hasNumbers: /\d+/.test(message),
    isUrgent: /urgent|penting|segera|cepat|prioritas/i.test(message),
    topic: determineMainTopic(lowerMessage),
  };
}

// Determine main topic from message
function determineMainTopic(message) {
  const topics = {
    product: /produk|product|supplement|vitamin|protein|obat/,
    market: /pasar|market|kompetitor|competitor|industri|segmen/,
    sales: /penjualan|sales|revenue|omzet|keuntungan|profit/,
    customer: /pelanggan|customer|user|pengguna|konsumen/,
    strategy: /strategi|strategy|rencana|planning|bisnis/,
    trend: /trend|tren|pola|pattern|analisis|data/,
    finance: /keuangan|finance|budget|biaya|cost|harga/,
  };

  for (const [topic, regex] of Object.entries(topics)) {
    if (regex.test(message)) {
      return topic;
    }
  }

  return "general";
}


// Generate request-specific responses
function generateRequestResponse(message, context) {
  if (context.isUrgent) {
    return "Saya memahami ini adalah prioritas tinggi. Berdasarkan data real-time, berikut analisis cepat yang dapat membantu pengambilan keputusan segera:\n\n• Current performance metrics menunjukkan stabilitas\n• Risk factors dalam batas normal\n• Recommended immediate actions tersedia\n\nApakah Anda perlu detail spesifik untuk area tertentu?";
  }

  const requestResponses = {
    product:
      "Saya akan menganalisis portfolio produk dan memberikan rekomendasi berdasarkan:\n\n• Performance metrics existing products\n• Market gap analysis\n• Consumer demand patterns\n• Competitive positioning\n\nMohon tunggu sebentar untuk analisis komprehensif...",
    market:
      "Memproses analisis pasar dengan parameter:\n\n• Market size & growth rate\n• Competitive landscape\n• Consumer behavior shifts\n• Regulatory environment\n• Technology disruptions\n\nAnalisis akan mencakup actionable insights untuk strategic planning.",
    strategy:
      "Developing strategic recommendations berdasarkan:\n\n• Current business position\n• Market opportunities\n• Resource capabilities\n• Risk assessment\n• Timeline considerations\n\nStrategi akan disesuaikan dengan business objectives Anda.",
  };

  return (
    requestResponses[context.topic] ||
    "Saya akan memproses permintaan Anda dan memberikan analisis yang komprehensif. Mohon tunggu sebentar..."
  );
}

// Enhanced export functionality with more formats
function exportChat() {
  if (chatHistory.length === 0) {
    showAlert("Tidak ada percakapan untuk diekspor.", "info");
    return;
  }

  // Create export menu
  const exportMenu = `
    <div style="margin: 10px 0;">
      <button onclick="exportAsJSON()" class="action-btn details" style="margin-right: 10px;">
        <i class="fas fa-file-code"></i> JSON
      </button>
      <button onclick="exportAsText()" class="action-btn details" style="margin-right: 10px;">
        <i class="fas fa-file-text"></i> Text
      </button>
      <button onclick="exportAsPDF()" class="action-btn details">
        <i class="fas fa-file-pdf"></i> PDF Report
      </button>
    </div>
  `;

  showAlert(`Pilih format export:<br>${exportMenu}`, "info");
}

// Export as JSON
function exportAsJSON() {
  const exportData = {
    exportDate: new Date().toISOString(),
    session: {
      totalMessages: chatHistory.length,
      duration:
        chatHistory.length > 0
          ? new Date(chatHistory[chatHistory.length - 1].timestamp) -
            new Date(chatHistory[0].timestamp)
          : 0,
    },
    conversations: chatHistory.map((msg) => ({
      sender: msg.sender,
      message: msg.text,
      timestamp: msg.timestamp.toISOString(),
    })),
    metadata: {
      platform: "NutriVit AI Analysis",
      version: "1.0.0",
      exportedBy: "Manager",
    },
  };

  const blob = new Blob([JSON.stringify(exportData, null, 2)], {
    type: "application/json",
  });

  downloadFile(blob, `nutrivit-ai-chat-${getCurrentDate()}.json`);
}

// Export as text
function exportAsText() {
  const textContent = chatHistory
    .map((msg) => {
      const time = msg.timestamp.toLocaleString("id-ID");
      const sender = msg.sender === "ai" ? "AI Assistant" : "Manager";
      return `[${time}] ${sender}:\n${msg.text}\n`;
    })
    .join("\n");

  const header = `NutriVit AI Analysis Chat Export
Generated: ${new Date().toLocaleString("id-ID")}
Total Messages: ${chatHistory.length}
\n${"=".repeat(50)}\n\n`;

  const blob = new Blob([header + textContent], {
    type: "text/plain",
  });

  downloadFile(blob, `nutrivit-ai-chat-${getCurrentDate()}.txt`);
}

// Simulate PDF export (in real implementation, you'd use a PDF library)
function exportAsPDF() {
  showAlert(
    "PDF export feature coming soon! Untuk saat ini, gunakan format Text atau JSON.",
    "info"
  );
}

// Helper function to download file
function downloadFile(blob, filename) {
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = filename;
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  URL.revokeObjectURL(url);

  showAlert("File berhasil diunduh!", "success");
}

// Get current date string
function getCurrentDate() {
  return new Date().toISOString().split("T")[0];
}

// Keyboard shortcuts
document.addEventListener("keydown", function (e) {
  // Ctrl+Enter to send message
  if (e.ctrlKey && e.key === "Enter") {
    sendMessage();
  }

  // Ctrl+K to clear chat
  if (e.ctrlKey && e.key === "k") {
    e.preventDefault();
    clearChat();
  }

  // Ctrl+E to export
  if (e.ctrlKey && e.key === "e") {
    e.preventDefault();
    exportChat();
  }
});

// Voice input support (basic implementation)
function startVoiceInput() {
  if ("webkitSpeechRecognition" in window) {
    const recognition = new webkitSpeechRecognition();
    recognition.lang = "id-ID";
    recognition.continuous = false;
    recognition.interimResults = false;

    recognition.onstart = function () {
      showAlert("Listening... Silakan berbicara.", "info");
    };

    recognition.onresult = function (event) {
      const transcript = event.results[0][0].transcript;
      document.getElementById("user-input").value = transcript;
      showAlert("Pesan berhasil direkam!", "success");
    };

    recognition.onerror = function (event) {
      showAlert("Error dalam speech recognition: " + event.error, "error");
    };

    recognition.start();
  } else {
    showAlert("Browser Anda tidak mendukung speech recognition.", "error");
  }
}

// Initialize tooltips for buttons
function initializeTooltips() {
  const buttons = document.querySelectorAll("[title]");
  buttons.forEach((button) => {
    button.addEventListener("mouseenter", function () {
      const tooltip = document.createElement("div");
      tooltip.className = "tooltip";
      tooltip.textContent = this.getAttribute("title");
      tooltip.style.position = "absolute";
      tooltip.style.background = "#333";
      tooltip.style.color = "white";
      tooltip.style.padding = "5px 8px";
      tooltip.style.borderRadius = "4px";
      tooltip.style.fontSize = "12px";
      tooltip.style.zIndex = "1000";

      document.body.appendChild(tooltip);

      const rect = this.getBoundingClientRect();
      tooltip.style.left = rect.left + "px";
      tooltip.style.top = rect.top - tooltip.offsetHeight - 5 + "px";

      this.addEventListener(
        "mouseleave",
        function () {
          tooltip.remove();
        },
        { once: true }
      );
    });
  });
}

// Call initialization functions
document.addEventListener("DOMContentLoaded", function () {
  initializeTooltips();
});
