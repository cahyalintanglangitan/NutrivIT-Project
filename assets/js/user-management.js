document.addEventListener("DOMContentLoaded", function () {
  let users = window.usersData || [];
  let filteredUsers = [...users];
  let currentFilter = 'all';
  const tbody = document.getElementById("users-tbody");

// Set current date
document.getElementById("current-date").textContent =
  new Date().toLocaleDateString("id-ID", {
    weekday: "long",
    year: "numeric",
    month: "long",
    day: "numeric",
  });

  function getStatusText(status) {
    if (status === "active") return "Aktif";
    if (status === "inactive") return "Tidak Aktif";
    return "Menunggu";
  }

 function generateActionButtons(userId) {
  return `
    <button class="btn-small" onclick="event.stopPropagation(); window.openUserDetail('${userId}')">
      <i class="fas fa-eye"></i> Lihat Detail
    </button>
    
  `;
}




  function renderUsersTable(data) {
    tbody.innerHTML = '';
    if (!data.length) {
      tbody.innerHTML = `
        <tr>
          <td colspan="7" style="text-align:center; color:#999; font-style:italic;">
            <i class="fas fa-info-circle"></i> Tidak ada pengguna ditemukan.
          </td>
        </tr>`;
      return;
    }
    tbody.innerHTML = data.map(user => `
      <tr onclick="window.openUserDetail('${user.id}')">
        <td>
          <div class="user-cell">
            <div class="user-avatar-small">
              ${user.name.split(" ").map(n => n[0]).join("")}
            </div>
            <span>${user.name}</span>
          </div>
        </td>
        <td>${user.email}</td>
        <td>${new Date(user.joining_date).toLocaleDateString("id-ID", { year: 'numeric', month: 'short', day: 'numeric' })}</td>
        <td>
          <span class="status ${user.status}">
            <i class="fas fa-circle"></i>
            ${getStatusText(user.status)}
          </span>
        </td>
        <td>
          <div class="nutrition-progress">
            <div class="nutrition-bar">
              <div class="nutrition-fill" style="width: ${Math.round(user.nutritionProgress || 0)}%"></div>
            </div>
            ${Math.round(user.nutritionProgress || 0)}%
          </div>
        </td>
        <td>
          <span class="consultation-badge ${user.consultationStatus}">
            ${getStatusText(user.consultationStatus)}
          </span>
        </td>
        <td>
          ${generateActionButtons(user.id)}
        </td>
      </tr>
    `).join("");
  }

  function filterUsers(type = 'all') {
    document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
    const btn = document.getElementById(`filter-${type}`);
    if (btn) btn.classList.add('active');
    currentFilter = type;

    // Jika ingin ambil dari server, uncomment kode di bawah:

    // Filter lokal
    const filterMap = {
      active: u => u.status === 'active',
      consultation: u => u.consultationStatus === 'active',
      premium: u => (u.member_type ?? '') === 'Premium'
    };
    filteredUsers = filterMap[type] ? users.filter(filterMap[type]) : [...users];
    renderUsersTable(filteredUsers);
  }

  function searchUsers(keyword) {
    const lower = keyword.toLowerCase();
    const result = filteredUsers.filter(u =>
      u.name.toLowerCase().includes(lower) ||
      u.email.toLowerCase().includes(lower)
    );
    renderUsersTable(result);
  }

  function openUserDetail(id) {
    const user = users.find(u => u.id == id);
    if (!user) return;

    setText("user-name", user.name);
    setText("user-email", user.email);
    setText("user-phone", user.phone);
    setText("user-age", user.age);
    setText("user-gender", user.gender);
    setText("user-height", user.height ? `${user.height} cm` : "-");
    setText("user-weight", user.weight ? `${user.weight} kg` : "-");
    setText("user-type", user.member_type);

    const bmi = user.height && user.weight ? Math.round(user.weight / ((user.height / 100) ** 2)) : "-";
    setText("user-bmi", bmi);

    setText("daily-calories", user.daily_calories ? `${Math.round(user.daily_calories)} kkal` : "-");
    setText("hydration", "85%");
    setText("activity", "Sedang");

    ["protein", "carbs", "fat", "vitamin"].forEach(nutrient => {
      const percent = Math.round(user[`${nutrient}_percent`] ?? 0);
      document.getElementById(`${nutrient}-bar`).style.width = `${percent}%`;
      setText(`${nutrient}-val`, `${percent}%`);
    });

    const complaintsEl = document.getElementById("complaints-container");
    complaintsEl.innerHTML = "<h4>Keluhan Gizi Terkini</h4>";
    (user.last_complaints ?? []).forEach((item, i) => {
      complaintsEl.innerHTML += `
        <div class="complaint-item">
          <i class="${i === 0 ? "fas fa-exclamation-triangle" : "fas fa-info-circle"}"></i>
          <div>
            <span class="complaint-title">${item.title}</span>
            <span class="complaint-date">${item.date}</span>
            <p class="complaint-description">${item.description}</p>
          </div>
        </div>`;
    });
    if (!user.last_complaints?.length) {
      complaintsEl.innerHTML += "<p>Tidak ada keluhan terkini.</p>";
    }

    const stats = user.consultations ?? [];
    const total = stats.length;
    const avgDuration = total ? Math.round(stats.reduce((a, b) => a + (parseInt(b.duration) || 0), 0) / total) : 0;
    const avgRating = total ? Math.round(stats.reduce((a, b) => a + (parseFloat(b.rating) || 0), 0) / total) : 0;

    setText("consult-total", total);
    setText("consult-duration", `${avgDuration} menit`);
    setText("consult-rating", `${avgRating}/5`);

    const consultList = document.getElementById("consultation-history-list");
    consultList.innerHTML = total
      ? stats.map(c => `
          <div class="consult-item">
            <div class="consult-header">
              <span class="consult-topic">${c.topic}</span>
              <span class="consult-date">${c.date}</span>
            </div>
            <p class="consult-summary">${c.summary}</p>
            <div class="consult-rating">
              ${generateStarRating(Math.round(c.rating))}
              <span>${Math.round(c.rating)}</span>
            </div>
          </div>
        `).join("")
      : "<p>Tidak ada konsultasi terbaru.</p>";

    const purchases = user.orders ?? [];
    const summary = user.purchase_summary ?? {};

    setText("purchase-total", summary.total_amount || "Rp 0");
    setText("purchase-items", `${Math.round(summary.total_items || 0)} item`);
    setText("purchase-last", summary.last_purchase || "-");

    const purchaseList = document.getElementById("purchase-history-list");
    purchaseList.innerHTML = purchases.length
      ? purchases.map(p => `
          <div class="purchase-item">
            <div class="purchase-info">
              <span class="product-name">${p.product}</span>
              <span class="purchase-date">${p.date}</span>
            </div>
            <div class="purchase-details">
              <span class="quantity">${Math.round(p.quantity)}x</span>
              <span class="price">${p.price}</span>
            </div>
          </div>
        `).join("")
      : "<p>Tidak ada riwayat pembelian.</p>";

    document.getElementById("userModal").style.display = "block";
  }

  function generateStarRating(rating) {
    return [...Array(5)].map((_, i) =>
      `<i class="${i < rating ? 'fas' : 'far'} fa-star"></i>`
    ).join("");
  }

  function setText(id, value) {
    const el = document.getElementById(id);
    if (el) el.textContent = value ?? "-";
  }

  function closeUserModal() {
    document.getElementById("userModal").style.display = "none";
  }

  function showTab(tabName) {
    document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
    document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
    document.getElementById(`${tabName}-tab`)?.classList.add('active');
    document.querySelector(`.tab-btn[onclick="showTab('${tabName}')"]`)?.classList.add('active');
  }

  // Registrasi global ke window agar bisa dipanggil dari HTML
  window.openUserDetail = openUserDetail;
  window.editUser = function(id) {
    alert("Edit user: " + id);
  };
  window.deleteUser = function(id) {
    if (confirm("Yakin ingin menghapus user ini?")) {
      alert("User " + id + " dihapus.");
    }
  };
  window.filterUsers = filterUsers;
  window.searchUsers = searchUsers;
  window.closeUserModal = closeUserModal;
  window.showTab = showTab;

  // Render awal
  renderUsersTable(users);
});
