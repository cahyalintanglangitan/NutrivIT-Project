// AI Analysis JavaScript

// Sample AI responses for different question types
const aiResponses = {
  trend: [
    "Berdasarkan analisis data minggu ini, terdapat beberapa tren menarik:\n\n1. **Kekurangan Vitamin D** meningkat 35% di kalangan pekerja WFH\n2. **Protein nabati** menjadi trending dengan peningkatan 42% di usia 25-35\n3. **Konsultasi diet keto** naik 65% bulan ini\n4. **Suplemen imunitas** diprediksi naik 28% bulan depan\n\nRekomendasi: Fokus pada pengembangan produk Vitamin D dan protein plant-based untuk segmen millennials.",
    "Analisis trend terbaru menunjukkan:\n\n• **Pola konsumsi berubah** - 67% pengguna lebih memilih suplemen natural\n• **Keluhan pencernaan** meningkat 23% pasca pandemi\n• **Minat pada probiotik** naik 156% dalam 3 bulan terakhir\n\nSaran strategis: Pertimbangkan ekspansi ke kategori probiotik dan digestive health."
  ],
  product: [
    "Berdasarkan gap analysis dan trend pasar, berikut rekomendasi produk baru:\n\n**Prioritas Tinggi:**\n1. **Vitamin D3 + K2 Premium** - ROI proyeksi 142%\n2. **Plant Protein Powder** (Pea + Hemp) - Target millennials\n3. **Immune Booster Complex** - Zinc + Vitamin C + Echinacea\n\n**Prioritas Sedang:**\n4. **Keto Support Bundle** - MCT Oil + Electrolytes\n5. **Women's Health Package** - Iron + Folate + B-Complex\n\nAnalisis kompetitor menunjukkan peluang market share 15-20% untuk produk #1 dan #2.",
    "Peluang produk inovatif berdasarkan data pengguna:\n\n🎯 **Personalized Vitamin Pack** - Berdasarkan profil defisiensi individual\n💪 **Post-Workout Recovery** - BCAA + Glutamine + Creatine\n🌱 **Organic Kids Multivitamin** - Gummy format, no artificial colors\n\nMarket size analysis menunjukkan kategori personalized nutrition tumbuh 45% YoY."
  ],
  strategy: [
    "Strategi peluncuran produk yang direkomendasikan:\n\n**Phase 1 (Bulan 1-2): Soft Launch**\n• Target 100 early adopters\n• A/B testing packaging & pricing\n• Influencer partnership (health & fitness)\n\n**Phase 2 (Bulan 3-4): Market Expansion**\n• Digital marketing campaign\n• Pharmacy partnership\n• Customer referral program\n\n**Phase 3 (Bulan 5-6): Scale Up**\n• National distribution\n• TV/Radio advertising\n• International expansion preparation\n\nBudget estimasi: Rp 2.4M dengan break-even di bulan 8.",
    "Roadmap strategis berdasarkan analisis kompetitor:\n\n🚀 **Go-to-Market Strategy:**\n1. Direct-to-consumer online (70% focus)\n2. Selective retail partnerships (30%)\n3. Subscription model untuk repeat purchase\n\n📊 **Pricing Strategy:**\n• Premium positioning (20% above competitor)\n• Bundle discounts untuk cross-selling\n• Loyalty program dengan tier benefits\n\n📈 **Growth Projections:**\n• Month 1-3: 500 customers\n• Month 4-6: 2,000 customers\n• Month 7-12: 10,000+ customers"
  ],
  market: [
    "Analisis pasar suplemen Indonesia 2025:\n\n**Market Size:** Rp 8.2 Triliun (+12% YoY)\n**Key Segments:**\n• Vitamin & Minerals: 45% market share\n• Protein supplements: 23%\n• Herbal/Traditional: 18%\n• Sports nutrition: 14%\n\n**Consumer Insights:**\n• 73% prefer trusted local brands\n• 68% influenced by doctor recommendations\n• 45% purchase online regularly\n\n**Competitive Landscape:**\n• Top 3 players control 60% market\n• 200+ local brands competing\n• Import brands growing 25% annually\n\nOpportunity: Focus pada niche segments dengan differentiated value proposition.",
    "Deep dive analisis segmentasi pasar:\n\n👥 **Target Demographics:**\n• Primary: Urban millennials (25-40)\n• Secondary: Health-conscious Gen X (40-55)\n• Emerging: Gen Z fitness enthusiasts (18-25)\n\n💰 **Spending Patterns:**\n• Average monthly spend: Rp 350K\n• Premium segment: Rp 800K+\n• Price-sensitive: <Rp 200K\n\n🏆 **Success Factors:**\n1. Product efficacy & quality\n2. Brand trust & credibility\n3. Convenient purchasing experience\n4. Community & education\n\nRekomendasi: Target premium segment dengan focus pada quality & education."
  ]
};

// Quick question templates
const quickQuestions = {
  trend: "Analisis tren keluhan gizi dan kebutuhan nutrisi pengguna terbaru. Apa insight yang bisa digunakan untuk pengembangan produk?",
  product: "Berikan rekomendasi produk kesehatan baru berdasarkan gap analysis dan data pengguna. Sertakan proyeksi ROI.",
  strategy: "Susun strategi peluncuran produk yang optimal berdasarkan analisis pasar dan kompetitor saat ini.",
  market: "Lakukan analisis mendalam tentang kondisi pasar suplemen kesehatan Indonesia dan peluang bisnis."
};

// Chat state
let isTyping = false;
let chatHistory = [];

// Initialize page
document.addEventListener('DOMContentLoaded', function() {
  // Set current date
  document.getElementById('current-date').textContent = new Date().toLocaleDateString('id-ID', {
    weekday: 'long',
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  });

  // Set welcome message time
  document.getElementById('welcome-time').textContent = new Date().toLocaleTimeString('id-ID', {
    hour: '2-digit',
    minute: '2-digit'
  });

  // Check authentication
  if (!localStorage.getItem('auth')) {
    window.location.href = 'login.html';
  }

  // Setup input handlers
  setupInputHandlers();
  
  // Update last update time
  updateLastUpdateTime();
});

// Setup input event handlers
function setupInputHandlers() {
  const textarea = document.getElementById('user-input');
  const sendBtn = document.getElementById('send-btn');

  // Auto-resize textarea
  textarea.addEventListener('input', function() {
    this.style.height = 'auto';
    this.style.height = Math.min(this.scrollHeight, 150) + 'px';
    
    // Enable/disable send button
    sendBtn.disabled = this.value.trim() === '';
  });

  // Send on Enter (but not Shift+Enter)
  textarea.addEventListener('keydown', function(e) {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      sendMessage();
    }
  });
}

// Send message function
function sendMessage() {
  const textarea = document.getElementById('user-input');
  const message = textarea.value.trim();
  
  if (!message || isTyping) return;
  
  // Add user message to chat
  addMessage(message, 'user');
  
  // Clear input
  textarea.value = '';
  textarea.style.height = 'auto';
  document.getElementById('send-btn').disabled = true;
  
  // Show typing indicator and get AI response
  showTypingIndicator();
  
  // Simulate AI processing time
  setTimeout(() => {
    const response = generateAIResponse(message);
    hideTypingIndicator();
    addMessage(response, 'ai');
  }, 2000 + Math.random() * 2000); // 2-4 seconds delay
}

// Quick question handler
function askQuickQuestion(type) {
  const question = quickQuestions[type];
  document.getElementById('user-input').value = question;
  sendMessage();
}

// Add message to chat
function addMessage(text, sender) {
  const messagesContainer = document.getElementById('chat-messages');
  const messageTime = new Date().toLocaleTimeString('id-ID', {
    hour: '2-digit',
    minute: '2-digit'
  });
  
  const messageDiv = document.createElement('div');
  messageDiv.className = `message ${sender}-message new`;
  
  messageDiv.innerHTML = `
    <div class="message-avatar">
      <i class="fas fa-${sender === 'ai' ? 'robot' : 'user'}"></i>
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
    timestamp: new Date()
  });
  
  // Remove 'new' class after animation
  setTimeout(() => {
    messageDiv.classList.remove('new');
  }, 300);
}

// Format message text (simple markdown-like formatting)
function formatMessage(text) {
  return text
    .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
    .replace(/\*(.*?)\*/g, '<em>$1</em>')
    .replace(/\n/g, '<br>')
    .replace(/•/g, '•')
    .replace(/(\d+\.)/g, '<strong>$1</strong>');
}

// Generate AI response based on message content
function generateAIResponse(message) {
  const lowerMessage = message.toLowerCase();
  
  // Determine response type based on keywords
  if (lowerMessage.includes('trend') || lowerMessage.includes('tren')) {
    return getRandomResponse('trend');
  } else if (lowerMessage.includes('produk') || lowerMessage.includes('product') || lowerMessage.includes('rekomendasi')) {
    return getRandomResponse('product');
  } else if (lowerMessage.includes('strategi') || lowerMessage.includes('strategy') || lowerMessage.includes('peluncuran')) {
    return getRandomResponse('strategy');
  } else if (lowerMessage.includes('pasar') || lowerMessage.includes('market') || lowerMessage.includes('kompetitor')) {
    return getRandomResponse('market');
  } else {
    // General response
    return generateGeneralResponse(message);
  }
}

// Get random response from category
function getRandomResponse(category) {
  const responses = aiResponses[category];
  return responses[Math.floor(Math.random() * responses.length)];
}

// Generate general AI response
function generateGeneralResponse(message) {
  const generalResponses = [
    `Terima kasih atas pertanyaan Anda tentang "${message}". Berdasarkan analisis data terkini, saya dapat memberikan insight berikut:\n\n• Data menunjukkan trend positif dalam kategori yang Anda tanyakan\n• Rekomendasi: Perlu analisis lebih mendalam untuk memberikan saran spesifik\n• Saran: Coba gunakan pertanyaan yang lebih spesifik tentang trend, produk, strategi, atau analisis pasar\n\nApakah ada aspek tertentu yang ingin Anda dalami lebih lanjut?`,
    
    `Pertanyaan yang menarik! Untuk memberikan analisis yang lebih akurat tentang "${message}", saya memerlukan konteks yang lebih spesifik.\n\n**Yang bisa saya bantu:**\n• Analisis trend gizi dan keluhan pengguna\n• Rekomendasi pengembangan produk baru\n• Strategi peluncuran dan go-to-market\n• Analisis kompetitor dan peluang pasar\n\nSilakan gunakan tombol pertanyaan cepat di bawah atau ajukan pertanyaan yang lebih spesifik!`,
    
    `Saya memahami Anda menanyakan tentang "${message}". Sebagai AI Assistant NutrivIT, saya dioptimalkan untuk memberikan insight strategis tentang:\n\n🔍 **Analisis Data**\n• Trend keluhan gizi pengguna\n• Pola konsumsi dan preferensi\n• Performance produk existing\n\n💡 **Rekomendasi Bisnis**\n• Peluang produk baru\n• Strategi pricing dan positioning\n• Channel distribution optimal\n\nBagaimana saya dapat membantu Anda lebih spesifik hari ini?`
  ];
  
  return generalResponses[Math.floor(Math.random() * generalResponses.length)];
}

// Show typing indicator
function showTypingIndicator() {
  if (isTyping) return;
  
  isTyping = true;
  const messagesContainer = document.getElementById('chat-messages');
  
  const typingDiv = document.createElement('div');
  typingDiv.className = 'typing-indicator';
  typingDiv.id = 'typing-indicator';
  
  typingDiv.innerHTML = `
    <div class="message-avatar">
      <i class="fas fa-robot"></i>
    </div>
    <div class="typing-content">
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
  const typingIndicator = document.getElementById('typing-indicator');
  if (typingIndicator) {
    typingIndicator.remove();
  }
  isTyping = false;
}

// Clear chat function
function clearChat() {
  if (confirm('Apakah Anda yakin ingin menghapus semua percakapan?')) {
    const messagesContainer = document.getElementById('chat-messages');
    
    // Keep only the welcome message
    const welcomeMessage = messagesContainer.querySelector('.ai-message');
    messagesContainer.innerHTML = '';
    messagesContainer.appendChild(welcomeMessage);
    
    // Clear chat history
    chatHistory = [];
    
    // Show success message
    showAlert('Chat berhasil dibersihkan!', 'success');
  }
}

// Export chat function
function exportChat() {
  if (chatHistory.length === 0) {
    showAlert('Tidak ada percakapan untuk diekspor.', 'info');
    return;
  }
  
  const exportData = {
    exportDate: new Date().toISOString(),
    totalMessages: chatHistory.length,
    conversations: chatHistory.map(msg => ({
      sender: msg.sender,
      message: msg.text,
      timestamp: msg.timestamp.toISOString()
    }))
  };
  
  const blob = new Blob([JSON.stringify(exportData, null, 2)], {
    type: 'application/json'
  });
  
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = `nutrivit-ai-chat-${new Date().toISOString().split('T')[0]}.json`;
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  URL.revokeObjectURL(url);
  
  showAlert('Chat berhasil diekspor!', 'success');
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
    showAlert('Rekomendasi berhasil diperbarui berdasarkan data terbaru!', 'success');
    
    // Update last update time
    updateLastUpdateTime();
  }, 2000);
}

// Accept recommendation
function acceptRecommendation(id) {
  const recommendationItem = event.target.closest('.recommendation-item');
  
  if (confirm('Apakah Anda yakin ingin menerima rekomendasi ini?')) {
    recommendationItem.classList.add('accepted');
    
    // Disable buttons
    const buttons = recommendationItem.querySelectorAll('.action-btn');
    buttons.forEach(btn => {
      btn.disabled = true;
      if (btn.classList.contains('accept')) {
        btn.innerHTML = '<i class="fas fa-check"></i> Diterima';
        btn.style.background = '#6b7280';
      }
    });
    
    showAlert('Rekomendasi berhasil diterima dan akan diproses lebih lanjut.', 'success');
  }
}

// Show recommendation details
function showRecommendationDetails(id) {
  const details = {
    1: {
      title: 'Detail Suplemen Vitamin D Premium',
      content: `
        <strong>Market Analysis:</strong><br>
        • Target market: 2.3M pekerja WFH di Indonesia<br>
        • Market penetration: 8% (current) → 15% (target)<br>
        • Price point: Rp 180,000 - 250,000<br><br>
        
        <strong>Product Specifications:</strong><br>
        • Vitamin D3 2000 IU + K2 MK-7 100mcg<br>
        • Soft gel capsules, 60 count<br>
        • Premium packaging dengan UV protection<br><br>
        
        <strong>Financial Projections:</strong><br>
        • Development cost: Rp 450M<br>
        • Break-even: 8 months<br>
        • ROI: 142% in 12 months<br>
        • Revenue projection: Rp 2.1B (Year 1)
      `
    },
    2: {
      title: 'Detail Protein Nabati Expansion',
      content: `
        <strong>Market Opportunity:</strong><br>
        • Plant-based protein market growth: 42% YoY<br>
        • Target demographic: Millennials 25-35 years<br>
        • Health-conscious consumers: 67% willing to pay premium<br><br>
        
        <strong>Product Portfolio:</strong><br>
        • Pea protein isolate blend<br>
        • Hemp + Chia seed variants<br>
        • Flavor profiles: Vanilla, Chocolate, Berry<br><br>
        
        <strong>Investment Required:</strong><br>
        • R&D: Rp 280M<br>
        • Marketing: Rp 520M<br>
        • Production setup: Rp 1.1B<br>
        • Expected ROI: 89% in 18 months
      `
    },
    3: {
      title: 'Detail Eco-friendly Packaging',
      content: `
        <strong>Sustainability Initiative:</strong><br>
        • Consumer demand: 23% prefer eco-packaging<br>
        • Regulatory compliance: Upcoming plastic regulations<br>
        • Brand positioning: Premium sustainable health<br><br>
        
        <strong>Implementation Plan:</strong><br>
        • Phase 1: Top 5 products (3 months)<br>
        • Phase 2: All vitamin products (6 months)<br>
        • Phase 3: Complete portfolio (12 months)<br><br>
        
        <strong>Cost Analysis:</strong><br>
        • Additional cost: +12% per unit<br>
        • Price increase potential: +8%<br>
        • Marketing value: Premium positioning<br>
        • Long-term savings: Reduced regulatory risks
      `
    }
  };
  
  const detail = details[id];
  if (detail) {
    showAlert(`<strong>${detail.title}</strong><br><br>${detail.content}`, 'info');
  }
}

// Show alert message
function showAlert(message, type = 'info') {
  // Remove existing alerts
  const existingAlert = document.querySelector('.alert');
  if (existingAlert) {
    existingAlert.remove();
  }
  
  const alertDiv = document.createElement('div');
  alertDiv.className = `alert ${type}`;
  
  const icon = type === 'success' ? 'check-circle' : 
               type === 'error' ? 'exclamation-triangle' : 
               'info-circle';
  
  alertDiv.innerHTML = `
    <i class="fas fa-${icon}"></i>
    <span>${message}</span>
  `;
  
  // Insert at the top of content
  const contentSection = document.querySelector('.content-section');
  contentSection.insertBefore(alertDiv, contentSection.firstChild);
  
  // Auto remove after 5 seconds
  setTimeout(() => {
    alertDiv.remove();
  }, 5000);
}

// Update last update time
function updateLastUpdateTime() {
  document.getElementById('last-update').textContent = 'Baru saja';
  
  // Update to relative time after 1 minute
  setTimeout(() => {
    document.getElementById('last-update').textContent = '1 menit yang lalu';
  }, 60000);
}

// Logout functionality
function handleLogout() {
  if (confirm('Apakah Anda yakin ingin keluar?')) {
    localStorage.removeItem('auth');
    window.location.href = 'login.html';
  }
}

// Auto-update insights periodically
setInterval(() => {
  // Simulate real-time data updates
  const insights = document.querySelectorAll('.insight-card');
  insights.forEach(card => {
    // Add subtle animation to show data refresh
    card.style.transform = 'scale(1.02)';
    setTimeout(() => {
      card.style.transform = 'scale(1)';
    }, 200);
  });
}, 300000); // Every 5 minutes

// Simulate real-time data source updates
function updateDataSources() {
  const sources = [
    { selector: '.source-item:nth-child(1) p', values: ['1,234 pengguna aktif', '1,245 pengguna aktif', '1,238 pengguna aktif'] },
    { selector: '.source-item:nth-child(2) p', values: ['892 laporan minggu ini', '897 laporan minggu ini', '885 laporan minggu ini'] },
    { selector: '.source-item:nth-child(3) p', values: ['567 transaksi', '572 transaksi', '563 transaksi'] },
    { selector: '.source-item:nth-child(4) p', values: ['89 sesi aktif', '92 sesi aktif', '87 sesi aktif'] },
    { selector: '.source-item:nth-child(5) p', values: ['156 review baru', '159 review baru', '153 review baru'] }
  ];
  
  sources.forEach(source => {
    const element = document.querySelector(source.selector);
    if (element) {
      const randomValue = source.values[Math.floor(Math.random() * source.values.length)];
      element.textContent = randomValue;
    }
  });
}

// Update data sources every 2 minutes
setInterval(updateDataSources, 120000);

// Enhanced message formatting with better markdown support
function formatMessage(text) {
  return text
    // Bold text
    .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
    // Italic text
    .replace(/\*(.*?)\*/g, '<em>$1</em>')
    // Line breaks
    .replace(/\n/g, '<br>')
    // Bullet points
    .replace(/^• /gm, '<span style="color: #08A55A; font-weight: bold;">•</span> ')
    // Numbered lists
    .replace(/^(\d+\.) /gm, '<strong style="color: #08A55A;">$1</strong> ')
    // Emojis/icons
    .replace(/🎯/g, '<i class="fas fa-bullseye" style="color: #f59e0b;"></i>')
    .replace(/💪/g, '<i class="fas fa-dumbbell" style="color: #06b6d4;"></i>')
    .replace(/🌱/g, '<i class="fas fa-seedling" style="color: #10b981;"></i>')
    .replace(/🚀/g, '<i class="fas fa-rocket" style="color: #8b5cf6;"></i>')
    .replace(/📊/g, '<i class="fas fa-chart-bar" style="color: #3b82f6;"></i>')
    .replace(/📈/g, '<i class="fas fa-chart-line" style="color: #10b981;"></i>')
    .replace(/👥/g, '<i class="fas fa-users" style="color: #6366f1;"></i>')
    .replace(/💰/g, '<i class="fas fa-money-bill-wave" style="color: #f59e0b;"></i>')
    .replace(/🏆/g, '<i class="fas fa-trophy" style="color: #eab308;"></i>')
    .replace(/🔍/g, '<i class="fas fa-search" style="color: #64748b;"></i>')
    .replace(/💡/g, '<i class="fas fa-lightbulb" style="color: #f59e0b;"></i>')
    // Headers
    .replace(/^### (.*$)/gm, '<h4 style="color: #333; margin: 10px 0 5px 0;">$1</h4>')
    .replace(/^## (.*$)/gm, '<h3 style="color: #333; margin: 15px 0 8px 0;">$1</h3>')
    // Code blocks
    .replace(/`(.*?)`/g, '<code style="background: #f3f4f6; padding: 2px 6px; border-radius: 4px; font-family: monospace;">$1</code>');
}

// Advanced AI response generation with context awareness
function generateContextualResponse(message) {
  const context = analyzeMessageContext(message);
  
  if (context.isGreeting) {
    return "Halo! Senang berbicara dengan Anda lagi. Saya siap membantu dengan analisis bisnis dan rekomendasi strategis. Apa yang ingin kita bahas hari ini?";
  }
  
  if (context.isQuestion) {
    return generateQuestionResponse(message, context);
  }
  
  if (context.isRequest) {
    return generateRequestResponse(message, context);
  }
  
  return generateGeneralResponse(message);
}

// Analyze message context
function analyzeMessageContext(message) {
  const lowerMessage = message.toLowerCase();
  
  return {
    isGreeting: /^(hai|halo|hi|hello|selamat|good)/i.test(message),
    isQuestion: /\?|bagaimana|apa|kapan|dimana|mengapa|kenapa|berapa/i.test(message),
    isRequest: /tolong|minta|bisa|dapat|bantu|buatkan|analisis|rekomen/i.test(message),
    hasNumbers: /\d+/.test(message),
    isUrgent: /urgent|penting|segera|cepat|prioritas/i.test(message),
    topic: determineMainTopic(lowerMessage)
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
    finance: /keuangan|finance|budget|biaya|cost|harga/
  };
  
  for (const [topic, regex] of Object.entries(topics)) {
    if (regex.test(message)) {
      return topic;
    }
  }
  
  return 'general';
}

// Generate question-specific responses
function generateQuestionResponse(message, context) {
  const responses = {
    product: "Berdasarkan data terbaru, saya dapat menganalisis performa produk dan memberikan rekomendasi pengembangan. Produk mana yang ingin Anda fokuskan?",
    market: "Analisis pasar menunjukkan dinamika yang menarik. Apakah Anda ingin fokus pada analisis kompetitor, segmentasi pasar, atau peluang ekspansi?",
    sales: "Data penjualan menunjukkan tren positif. Saya dapat memberikan breakdown per kategori, analisis seasonality, atau proyeksi pertumbuhan.",
    customer: "Insight pelanggan sangat valuable untuk strategi. Apakah Anda tertarik dengan analisis demografi, behavior patterns, atau satisfaction metrics?",
    strategy: "Untuk rekomendasi strategis yang optimal, saya perlu memahami timeframe dan objectives Anda. Apakah ini untuk jangka pendek atau long-term planning?",
    trend: "Tren terbaru menunjukkan shift yang signifikan dalam consumer behavior. Mari kita deep dive ke specific trends yang paling relevan untuk bisnis Anda.",
    finance: "Analisis finansial memerlukan context yang tepat. Apakah Anda fokus pada profitability analysis, cost optimization, atau investment planning?"
  };
  
  return responses[context.topic] || generateGeneralResponse(message);
}

// Generate request-specific responses
function generateRequestResponse(message, context) {
  if (context.isUrgent) {
    return "Saya memahami ini adalah prioritas tinggi. Berdasarkan data real-time, berikut analisis cepat yang dapat membantu pengambilan keputusan segera:\n\n• Current performance metrics menunjukkan stabilitas\n• Risk factors dalam batas normal\n• Recommended immediate actions tersedia\n\nApakah Anda perlu detail spesifik untuk area tertentu?";
  }
  
  const requestResponses = {
    product: "Saya akan menganalisis portfolio produk dan memberikan rekomendasi berdasarkan:\n\n• Performance metrics existing products\n• Market gap analysis\n• Consumer demand patterns\n• Competitive positioning\n\nMohon tunggu sebentar untuk analisis komprehensif...",
    market: "Memproses analisis pasar dengan parameter:\n\n• Market size & growth rate\n• Competitive landscape\n• Consumer behavior shifts\n• Regulatory environment\n• Technology disruptions\n\nAnalisis akan mencakup actionable insights untuk strategic planning.",
    strategy: "Developing strategic recommendations berdasarkan:\n\n• Current business position\n• Market opportunities\n• Resource capabilities\n• Risk assessment\n• Timeline considerations\n\nStrategi akan disesuaikan dengan business objectives Anda."
  };
  
  return requestResponses[context.topic] || "Saya akan memproses permintaan Anda dan memberikan analisis yang komprehensif. Mohon tunggu sebentar...";
}

// Enhanced export functionality with more formats
function exportChat() {
  if (chatHistory.length === 0) {
    showAlert('Tidak ada percakapan untuk diekspor.', 'info');
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
  
  showAlert(`Pilih format export:<br>${exportMenu}`, 'info');
}

// Export as JSON
function exportAsJSON() {
  const exportData = {
    exportDate: new Date().toISOString(),
    session: {
      totalMessages: chatHistory.length,
      duration: chatHistory.length > 0 ? 
        new Date(chatHistory[chatHistory.length - 1].timestamp) - new Date(chatHistory[0].timestamp) : 0
    },
    conversations: chatHistory.map(msg => ({
      sender: msg.sender,
      message: msg.text,
      timestamp: msg.timestamp.toISOString()
    })),
    metadata: {
      platform: 'NutrivIT AI Analysis',
      version: '1.0.0',
      exportedBy: 'Manager'
    }
  };
  
  const blob = new Blob([JSON.stringify(exportData, null, 2)], {
    type: 'application/json'
  });
  
  downloadFile(blob, `nutrivit-ai-chat-${getCurrentDate()}.json`);
}

// Export as text
function exportAsText() {
  const textContent = chatHistory.map(msg => {
    const time = msg.timestamp.toLocaleString('id-ID');
    const sender = msg.sender === 'ai' ? 'AI Assistant' : 'Manager';
    return `[${time}] ${sender}:\n${msg.text}\n`;
  }).join('\n');
  
  const header = `NutrivIT AI Analysis Chat Export
Generated: ${new Date().toLocaleString('id-ID')}
Total Messages: ${chatHistory.length}
\n${'='.repeat(50)}\n\n`;
  
  const blob = new Blob([header + textContent], {
    type: 'text/plain'
  });
  
  downloadFile(blob, `nutrivit-ai-chat-${getCurrentDate()}.txt`);
}

// Simulate PDF export (in real implementation, you'd use a PDF library)
function exportAsPDF() {
  showAlert('PDF export feature coming soon! Untuk saat ini, gunakan format Text atau JSON.', 'info');
}

// Helper function to download file
function downloadFile(blob, filename) {
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = filename;
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  URL.revokeObjectURL(url);
  
  showAlert('File berhasil diunduh!', 'success');
}

// Get current date string
function getCurrentDate() {
  return new Date().toISOString().split('T')[0];
}

// Keyboard shortcuts
document.addEventListener('keydown', function(e) {
  // Ctrl+Enter to send message
  if (e.ctrlKey && e.key === 'Enter') {
    sendMessage();
  }
  
  // Ctrl+K to clear chat
  if (e.ctrlKey && e.key === 'k') {
    e.preventDefault();
    clearChat();
  }
  
  // Ctrl+E to export
  if (e.ctrlKey && e.key === 'e') {
    e.preventDefault();
    exportChat();
  }
});

// Voice input support (basic implementation)
function startVoiceInput() {
  if ('webkitSpeechRecognition' in window) {
    const recognition = new webkitSpeechRecognition();
    recognition.lang = 'id-ID';
    recognition.continuous = false;
    recognition.interimResults = false;
    
    recognition.onstart = function() {
      showAlert('Listening... Silakan berbicara.', 'info');
    };
    
    recognition.onresult = function(event) {
      const transcript = event.results[0][0].transcript;
      document.getElementById('user-input').value = transcript;
      showAlert('Pesan berhasil direkam!', 'success');
    };
    
    recognition.onerror = function(event) {
      showAlert('Error dalam speech recognition: ' + event.error, 'error');
    };
    
    recognition.start();
  } else {
    showAlert('Browser Anda tidak mendukung speech recognition.', 'error');
  }
}

// Initialize tooltips for buttons
function initializeTooltips() {
  const buttons = document.querySelectorAll('[title]');
  buttons.forEach(button => {
    button.addEventListener('mouseenter', function() {
      const tooltip = document.createElement('div');
      tooltip.className = 'tooltip';
      tooltip.textContent = this.getAttribute('title');
      tooltip.style.position = 'absolute';
      tooltip.style.background = '#333';
      tooltip.style.color = 'white';
      tooltip.style.padding = '5px 8px';
      tooltip.style.borderRadius = '4px';
      tooltip.style.fontSize = '12px';
      tooltip.style.zIndex = '1000';
      
      document.body.appendChild(tooltip);
      
      const rect = this.getBoundingClientRect();
      tooltip.style.left = rect.left + 'px';
      tooltip.style.top = (rect.top - tooltip.offsetHeight - 5) + 'px';
      
      this.addEventListener('mouseleave', function() {
        tooltip.remove();
      }, { once: true });
    });
  });
}

// Call initialization functions
document.addEventListener('DOMContentLoaded', function() {
  initializeTooltips();
});