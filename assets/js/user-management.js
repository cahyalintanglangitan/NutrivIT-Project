// User Management JavaScript

// Sample user data
const usersData = [
  {
    id: 1,
    name: "John Doe",
    email: "john@email.com",
    phone: "+62 812-3456-7890",
    address: "Jl. Sudirman No. 123, Jakarta",
    age: 28,
    gender: "Laki-laki",
    height: "175 cm",
    weight: "70 kg",
    bmi: "22.9 (Normal)",
    type: "Premium",
    joinDate: "15 Jan 2024",
    status: "active",
    nutritionProgress: 85,
    consultationStatus: "active",
    dailyCalories: "1,850 kkal",
    hydration: "85%",
    activity: "Sedang",
    totalConsultations: 24,
    avgDuration: "15 menit",
    satisfactionRating: 4.8,
    totalPurchases: "Rp 2.450.000",
    productsBought: 18,
    lastPurchase: "3 hari lalu",
    avgRating: 4.6,
    totalReviews: 12
  },
  {
    id: 2,
    name: "Jane Smith",
    email: "jane@email.com",
    phone: "+62 812-9876-5432",
    address: "Jl. Gatot Subroto No. 456, Jakarta",
    age: 32,
    gender: "Perempuan",
    height: "165 cm",
    weight: "58 kg",
    bmi: "21.3 (Normal)",
    type: "Basic",
    joinDate: "10 Jan 2024",
    status: "active",
    nutritionProgress: 78,
    consultationStatus: "inactive",
    dailyCalories: "1,650 kkal",
    hydration: "75%",
    activity: "Tinggi",
    totalConsultations: 18,
    avgDuration: "12 menit",
    satisfactionRating: 4.5,
    totalPurchases: "Rp 1.200.000",
    productsBought: 8,
    lastPurchase: "1 minggu lalu",
    avgRating: 4.2,
    totalReviews: 6
  },
  {
    id: 3,
    name: "Ahmad Rahman",
    email: "ahmad@email.com",
    phone: "+62 813-1111-2222",
    address: "Jl. Thamrin No. 789, Jakarta",
    age: 35,
    gender: "Laki-laki",
    height: "168 cm",
    weight: "75 kg",
    bmi: "26.6 (Overweight)",
    type: "Premium",
    joinDate: "05 Feb 2024",
    status: "active",
    nutritionProgress: 65,
    consultationStatus: "active",
    dailyCalories: "2,100 kkal",
    hydration: "60%",
    activity: "Rendah",
    totalConsultations: 31,
    avgDuration: "20 menit",
    satisfactionRating: 4.9,
    totalPurchases: "Rp 3.800.000",
    productsBought: 25,
    lastPurchase: "1 hari lalu",
    avgRating: 4.8,
    totalReviews: 20
  },
  {
    id: 4,
    name: "Sari Dewi",
    email: "sari@email.com",
    phone: "+62 814-3333-4444",
    address: "Jl. Kuningan No. 321, Jakarta",
    age: 29,
    gender: "Perempuan",
    height: "160 cm",
    weight: "52 kg",
    bmi: "20.3 (Normal)",
    type: "Basic",
    joinDate: "20 Feb 2024",
    status: "active",
    nutritionProgress: 92,
    consultationStatus: "active",
    dailyCalories: "1,550 kkal",
    hydration: "90%",
    activity: "Sedang",
    totalConsultations: 15,
    avgDuration: "18 menit",
    satisfactionRating: 4.7,
    totalPurchases: "Rp 950.000",
    productsBought: 12,
    lastPurchase: "5 hari lalu",
    avgRating: 4.5,
    totalReviews: 9
  },
  {
    id: 5,
    name: "Budi Santoso",
    email: "budi@email.com",
    phone: "+62 815-5555-6666",
    address: "Jl. Casablanca No. 654, Jakarta",
    age: 42,
    gender: "Laki-laki",
    height: "172 cm",
    weight: "80 kg",
    bmi: "27.1 (Overweight)",
    type: "Premium",
    joinDate: "01 Mar 2024",
    status: "inactive",
    nutritionProgress: 55,
    consultationStatus: "inactive",
    dailyCalories: "2,200 kkal",
    hydration: "50%",
    activity: "Rendah",
    totalConsultations: 8,
    avgDuration: "10 menit",
    satisfactionRating: 3.8,
    totalPurchases: "Rp 450.000",
    productsBought: 5,
    lastPurchase: "2 minggu lalu",
    avgRating: 3.9,
    totalReviews: 3
  }
];

let currentFilter = 'all';
let currentUser = null;

// Initialize page
document.addEventListener('DOMContentLoaded', function() {
  // Set current date
  document.getElementById('current-date').textContent = new Date().toLocaleDateString('id-ID', {
    weekday: 'long',
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  });

  // Check authentication
  if (!localStorage.getItem('auth')) {
    window.location.href = 'login.html';
  }

  // Load users data
  loadUsersTable();
  
  // Setup search functionality
  document.getElementById('user-search').addEventListener('input', handleSearch);
});

// Load users table
function loadUsersTable() {
  const tbody = document.getElementById('users-tbody');
  let filteredUsers = usersData;

  // Apply filter
  if (currentFilter !== 'all') {
    filteredUsers = usersData.filter(user => {
      switch(currentFilter) {
        case 'active':
          return user.status === 'active';
        case 'consultation':
          return user.consultationStatus === 'active';
        case 'premium':
          return user.type === 'Premium';
        default:
          return true;
      }
    });
  }

  // Apply search
  const searchTerm = document.getElementById('user-search').value.toLowerCase();
  if (searchTerm) {
    filteredUsers = filteredUsers.filter(user => 
      user.name.toLowerCase().includes(searchTerm) ||
      user.email.toLowerCase().includes(searchTerm)
    );
  }

  // Generate table rows
  tbody.innerHTML = filteredUsers.map(user => `
    <tr onclick="openUserDetail(${user.id})">
      <td>
        <div class="user-cell">
          <div class="user-avatar-small">${user.name.split(' ').map(n => n[0]).join('')}</div>
          <span>${user.name}</span>
        </div>
      </td>
      <td>${user.email}</td>
      <td>${user.joinDate}</td>
      <td>
        <span class="status ${user.status}">
          <i class="fas fa-circle"></i> 
          ${user.status === 'active' ? 'Aktif' : 'Nonaktif'}
        </span>
      </td>
      <td>
        <div class="nutrition-progress">
          <div class="nutrition-bar">
            <div class="nutrition-fill" style="width: ${user.nutritionProgress}%"></div>
          </div>
          ${user.nutritionProgress}%
        </div>
      </td>
      <td>
        <span class="consultation-badge ${user.consultationStatus}">
          ${user.consultationStatus === 'active' ? 'Aktif' : 'Nonaktif'}
        </span>
      </td>
      <td>
        <button class="btn-small" onclick="event.stopPropagation(); openUserDetail(${user.id})">
          <i class="fas fa-eye"></i>
        </button>
        <button class="btn-small" onclick="event.stopPropagation(); editUser(${user.id})">
          <i class="fas fa-edit"></i>
        </button>
        <button class="btn-small btn-danger" onclick="event.stopPropagation(); deleteUser(${user.id})">
          <i class="fas fa-trash"></i>
        </button>
      </td>
    </tr>
  `).join('');
}

// Filter users
function filterUsers(filter) {
  currentFilter = filter;
  
  // Update active filter button
  document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
  event.target.classList.add('active');
  
  loadUsersTable();
}

// Handle search
function handleSearch() {
  loadUsersTable();
}

// Open user detail modal
function openUserDetail(userId) {
  currentUser = usersData.find(user => user.id === userId);
  if (!currentUser) return;

  // Show modal
  document.getElementById('userModal').style.display = 'block';
  
  // Update modal title
  document.getElementById('modal-title').textContent = `Detail Pengguna - ${currentUser.name}`;
  
  // Load profile data
  loadProfileTab();
  
  // Show profile tab by default
  showTab('profile');
}

// Close user modal
function closeUserModal() {
  document.getElementById('userModal').style.display = 'none';
  currentUser = null;
}

// Open user modal for new user
function openUserModal() {
  // This would open a form for adding new user
  alert('Fitur tambah user baru akan segera hadir!');
}

// Show specific tab
function showTab(tabName) {
  // Hide all tab contents
  document.querySelectorAll('.tab-content').forEach(content => {
    content.classList.remove('active');
  });
  
  // Remove active class from all tab buttons
  document.querySelectorAll('.tab-btn').forEach(btn => {
    btn.classList.remove('active');
  });
  
  // Show selected tab content
  document.getElementById(`${tabName}-tab`).classList.add('active');
  
  // Add active class to clicked tab button
  event.target.classList.add('active');
  
  // Load tab-specific data
  switch(tabName) {
    case 'profile':
      loadProfileTab();
      break;
    case 'health':
      loadHealthTab();
      break;
    case 'consultation':
      loadConsultationTab();
      break;
    case 'purchases':
      loadPurchasesTab();
      break;
    case 'reviews':
      loadReviewsTab();
      break;
  }
}

// Load profile tab data
function loadProfileTab() {
  if (!currentUser) return;
  
  document.getElementById('user-name').textContent = currentUser.name;
  document.getElementById('user-email').textContent = currentUser.email;
  document.getElementById('user-phone').textContent = currentUser.phone;
  document.getElementById('user-address').textContent = currentUser.address;
  document.getElementById('user-age').textContent = currentUser.age + ' tahun';
  document.getElementById('user-gender').textContent = currentUser.gender;
  document.getElementById('user-height').textContent = currentUser.height;
  document.getElementById('user-weight').textContent = currentUser.weight;
  document.getElementById('user-bmi').textContent = currentUser.bmi;
  document.getElementById('user-type').textContent = currentUser.type;
}

// Load health tab data
function loadHealthTab() {
  if (!currentUser) return;
  
  document.getElementById('daily-calories').textContent = currentUser.dailyCalories;
  document.getElementById('hydration').textContent = currentUser.hydration;
  document.getElementById('activity').textContent = currentUser.activity;
}

// Load consultation tab data
function loadConsultationTab() {
  if (!currentUser) return;
  
  // Update consultation stats
  document.querySelector('.consult-stat:nth-child(1) .stat-value').textContent = currentUser.totalConsultations;
  document.querySelector('.consult-stat:nth-child(2) .stat-value').textContent = currentUser.avgDuration;
  document.querySelector('.consult-stat:nth-child(3) .stat-value').textContent = currentUser.satisfactionRating + '/5';
}

// Load purchases tab data
function loadPurchasesTab() {
  if (!currentUser) return;
  
  // Update purchase stats
  document.querySelector('.purchase-stat:nth-child(1) .stat-value').textContent = currentUser.totalPurchases;
  document.querySelector('.purchase-stat:nth-child(2) .stat-value').textContent = currentUser.productsBought + ' item';
  document.querySelector('.purchase-stat:nth-child(3) .stat-value').textContent = currentUser.lastPurchase;
}

// Load reviews tab data
function loadReviewsTab() {
  if (!currentUser) return;
  
  // Update review stats
  document.querySelector('.review-stat:nth-child(1) .stat-value').textContent = currentUser.avgRating + '/5';
  document.querySelector('.review-stat:nth-child(2) .stat-value').textContent = currentUser.totalReviews;
}

// Edit user
function editUser(userId) {
  alert(`Edit user dengan ID: ${userId}\nFitur edit akan segera hadir!`);
}

// Delete user
function deleteUser(userId) {
  if (confirm('Apakah Anda yakin ingin menghapus user ini?')) {
    alert(`User dengan ID ${userId} telah dihapus!\n(Simulasi - data tidak benar-benar dihapus)`);
  }
}

// Logout functionality
function handleLogout() {
  if (confirm('Apakah Anda yakin ingin keluar?')) {
    localStorage.removeItem('auth');
    window.location.href = 'login.html';
  }
}

// Close modal when clicking outside
window.onclick = function(event) {
  const modal = document.getElementById('userModal');
  if (event.target === modal) {
    closeUserModal();
  }
}