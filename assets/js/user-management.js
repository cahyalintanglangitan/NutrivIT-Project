// User Management JavaScript
class UserManagement {
    constructor() {
        this.users = [];
        this.filteredUsers = [];
        this.charts = {};
        this.apiBase = 'api/'; // Base URL untuk API endpoints
        this.currentFilter = 'all';
        this.init();
    }

    // Initialize the application
    init() {
        this.setCurrentDate();
        this.checkAuthentication();
        this.loadUserData();
        this.initializeCharts();
        this.bindEventListeners();
    }

    // Set current date in header
    setCurrentDate() {
        const currentDate = new Date().toLocaleDateString('id-ID', {
            weekday: 'long',
            year: 'numeric',
            month: 'long',
            day: 'numeric'
        });
        document.getElementById('current-date').textContent = currentDate;
    }

    // Check if user is authenticated
    checkAuthentication() {
        if (!localStorage.getItem('auth')) {
            // For demo purposes, set auth to true
            localStorage.setItem('auth', 'true');
        }
    }

    // Load user data from API or use mock data
    async loadUserData() {
        this.showLoading(true);
        
        try {
            // Try to fetch from API first
            const response = await fetch(`${this.apiBase}users.php`);
            
            if (response.ok) {
                const data = await response.json();
                this.users = data.users || [];
                this.updateStatistics(data.statistics || {});
            } else {
                // Fallback to mock data if API is not available
                this.loadMockData();
            }
        } catch (error) {
            console.log('API not available, using mock data');
            this.loadMockData();
        }
        
        this.filteredUsers = [...this.users];
        this.renderUserTable();
        this.updateFilterButtons();
        this.showLoading(false);
    }

    // Load mock data for development/demo
    loadMockData() {
        this.users = [
            {
                id: 1,
                name: "Ahmad Rizki Pratama",
                email: "ahmad.rizki@email.com",
                phone: "+62 812-3456-7890",
                location: "Jakarta, DKI Jakarta",
                joinDate: "2024-01-15",
                status: "active",
                complaints: 3,
                lastActive: "2025-06-19"
            },
            {
                id: 2,
                name: "Siti Aminah Putri",
                email: "siti.aminah@email.com",
                phone: "+62 813-4567-8901",
                location: "Bandung, Jawa Barat",
                joinDate: "2024-02-20",
                status: "active",
                complaints: 1,
                lastActive: "2025-06-18"
            },
            {
                id: 3,
                name: "Budi Santoso",
                email: "budi.santoso@email.com",
                phone: "+62 814-5678-9012",
                location: "Surabaya, Jawa Timur",
                joinDate: "2024-03-10",
                status: "active",
                complaints: 5,
                lastActive: "2025-06-19"
            },
            {
                id: 4,
                name: "Dewi Sartika",
                email: "dewi.sartika@email.com",
                phone: "+62 815-6789-0123",
                location: "Yogyakarta, DI Yogyakarta",
                joinDate: "2024-01-25",
                status: "inactive",
                complaints: 0,
                lastActive: "2025-06-10"
            },
            {
                id: 5,
                name: "Rudi Hartono",
                email: "rudi.hartono@email.com",
                phone: "+62 816-7890-1234",
                location: "Medan, Sumatera Utara",
                joinDate: "2024-02-14",
                status: "active",
                complaints: 2,
                lastActive: "2025-06-19"
            },
            {
                id: 6,
                name: "Maya Kusuma",
                email: "maya.kusuma@email.com",
                phone: "+62 817-8901-2345",
                location: "Makassar, Sulawesi Selatan",
                joinDate: "2024-03-22",
                status: "active",
                complaints: 4,
                lastActive: "2025-06-18"
            },
            {
                id: 7,
                name: "Andi Wijaya",
                email: "andi.wijaya@email.com",
                phone: "+62 818-9012-3456",
                location: "Denpasar, Bali",
                joinDate: "2024-04-10",
                status: "active",
                complaints: 1,
                lastActive: "2025-06-17"
            },
            {
                id: 8,
                name: "Fitri Handayani",
                email: "fitri.handayani@email.com",
                phone: "+62 819-0123-4567",
                location: "Palembang, Sumatera Selatan",
                joinDate: "2024-03-05",
                status: "inactive",
                complaints: 0,
                lastActive: "2025-06-05"
            }
        ];

        // Mock statistics
        const mockStats = {
            totalUsers: 1234,
            activeUsers: 892,
            newUsers: 156,
            totalComplaints: 2134,
            totalUsersChange: '+12%',
            activeUsersChange: '+8%',
            newUsersChange: '+25%',
            complaintsChange: '-5%'
        };
        this.updateStatistics(mockStats);
    }

    // Update statistics in the UI
    updateStatistics(stats) {
        document.getElementById('totalUsers').textContent = stats.totalUsers?.toLocaleString() || '0';
        document.getElementById('activeUsers').textContent = stats.activeUsers?.toLocaleString() || '0';
        document.getElementById('newUsers').textContent = stats.newUsers?.toLocaleString() || '0';
        document.getElementById('totalComplaints').textContent = stats.totalComplaints?.toLocaleString() || '0';
        
        if (stats.totalUsersChange) document.getElementById('totalUsersChange').textContent = stats.totalUsersChange;
        if (stats.activeUsersChange) document.getElementById('activeUsersChange').textContent = stats.activeUsersChange;
        if (stats.newUsersChange) document.getElementById('newUsersChange').textContent = stats.newUsersChange;
        if (stats.complaintsChange) document.getElementById('complaintsChange').textContent = stats.complaintsChange;
    }

    // Initialize charts
    initializeCharts() {
        this.initUserRegistrationChart();
        this.initComplaintsChart();
    }

    // Initialize user registration chart
    initUserRegistrationChart() {
        const ctx = document.getElementById('userRegistrationChart').getContext('2d');
        this.charts.registration = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                datasets: [{
                    label: 'Registrasi User',
                    data: [45, 62, 58, 74, 89, 156],
                    borderColor: '#08A55A',
                    backgroundColor: 'rgba(8, 165, 90, 0.1)',
                    tension: 0.4,
                    fill: true,
                    pointBackgroundColor: '#08A55A',
                    pointBorderColor: '#fff',
                    pointBorderWidth: 2,
                    pointRadius: 6
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(0,0,0,0.1)'
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        }
                    }
                }
            }
        });
    }

    // Initialize complaints distribution chart
    initComplaintsChart() {
        const ctx = document.getElementById('complaintsChart').getContext('2d');
        this.charts.complaints = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Kekurangan Vitamin D', 'Kelebihan Kalori', 'Kurang Protein', 'Kurang Serat', 'Anemia'],
                datasets: [{
                    data: [35, 25, 20, 12, 8],
                    backgroundColor: [
                        '#08A55A',
                        '#3FCAEA', 
                        '#667eea',
                        '#f093fb',
                        '#ffeaa7'
                    ],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding: 20,
                            usePointStyle: true,
                            font: {
                                size: 12
                            }
                        }
                    }
                }
            }
        });
    }

    // Bind event listeners
    bindEventListeners() {
        // Search input
        const searchInput = document.getElementById('searchInput');
        if (searchInput) {
            searchInput.addEventListener('input', (e) => {
                this.filterUsers(e.target.value);
            });
        }
    }

    // Render user table
    renderUserTable(userList = this.filteredUsers) {
        const tbody = document.getElementById('userTableBody');
        if (!tbody) return;

        tbody.innerHTML = '';

        userList.forEach((user, index) => {
            const row = document.createElement('tr');
            
            // Determine complaint badge class
            let complaintClass = 'low';
            if (user.complaints >= 4) complaintClass = 'high';
            else if (user.complaints >= 2) complaintClass = 'medium';

            // Get user initials
            const initials = user.name.split(' ').map(n => n[0]).join('').substring(0, 2);

            // Format join date
            const joinDate = new Date(user.joinDate).toLocaleDateString('id-ID');

            row.innerHTML = `
                <td>
                    <div class="user-cell">
                        <div class="user-avatar-small">${initials}</div>
                        <div class="user-info-cell">
                            <div class="user-name">${user.name}</div>
                            <div class="user-location">${user.phone}</div>
                        </div>
                    </div>
                </td>
                <td>
                    <div style="display: flex; flex-direction: column;">
                        <span style="margin-bottom: 4px;">${user.email}</span>
                        <small style="color: #666;">${user.phone}</small>
                    </div>
                </td>
                <td>
                    <div style="display: flex; align-items: center; gap: 6px;">
                        <i class="fas fa-map-marker-alt" style="color: #666; font-size: 12px;"></i>
                        ${user.location}
                    </div>
                </td>
                <td>${joinDate}</td>
                <td>
                    <span class="status-badge ${user.status}">
                        <i class="fas fa-circle" style="font-size: 8px;"></i>
                        ${user.status === 'active' ? 'Aktif' : 'Tidak Aktif'}
                    </span>
                </td>
                <td>
                    <div class="complaint-badge ${complaintClass}">
                        ${user.complaints}
                    </div>
                </td>
                <td>
                    <button class="btn-small" onclick="userManagement.viewUser(${user.id})" title="Lihat Detail">
                        <i class="fas fa-eye"></i>
                    </button>
                    <button class="btn-small btn-warning" onclick="userManagement.editUser(${user.id})" title="Edit User">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn-small btn-danger" onclick="userManagement.deleteUser(${user.id})" title="Hapus User">
                        <i class="fas fa-trash"></i>
                    </button>
                </td>
            `;
            
            // Add animation delay
            row.style.animationDelay = `${index * 0.05}s`;
            tbody.appendChild(row);
        });
    }

    // Filter users by search term
    filterUsers(searchTerm) {
        const term = searchTerm.toLowerCase();
        this.filteredUsers = this.users.filter(user => 
            user.name.toLowerCase().includes(term) ||
            user.email.toLowerCase().includes(term) ||
            user.location.toLowerCase().includes(term)
        );
        this.renderUserTable();
    }

    // Filter users by status
    filterByStatus(status) {
        this.currentFilter = status;
        
        // Remove active class from all buttons
        document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
        
        // Add active class to clicked button
        event.target.classList.add('active');
        
        if (status === 'all') {
            this.filteredUsers = [...this.users];
        } else if (status === 'new') {
            // Users joined in last 30 days
            const thirtyDaysAgo = new Date();
            thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
            this.filteredUsers = this.users.filter(user => new Date(user.joinDate) > thirtyDaysAgo);
        } else {
            this.filteredUsers = this.users.filter(user => user.status === status);
        }
        
        this.renderUserTable();
    }

    // Update filter button counts
    updateFilterButtons() {
        const allCount = this.users.length;
        const activeCount = this.users.filter(u => u.status === 'active').length;
        const inactiveCount = this.users.filter(u => u.status === 'inactive').length;
        const newCount = this.users.filter(u => {
            const thirtyDaysAgo = new Date();
            thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
            return new Date(u.joinDate) > thirtyDaysAgo;
        }).length;

        const filterAll = document.getElementById('filterAll');
        const filterActive = document.getElementById('filterActive');
        const filterInactive = document.getElementById('filterInactive');
        const filterNew = document.getElementById('filterNew');

        if (filterAll) filterAll.textContent = `Semua (${allCount})`;
        if (filterActive) filterActive.textContent = `Aktif (${activeCount})`;
        if (filterInactive) filterInactive.textContent = `Tidak Aktif (${inactiveCount})`;
        if (filterNew) filterNew.textContent = `Baru (${newCount})`;
    }

    // View user details
    viewUser(userId) {
        const user = this.users.find(u => u.id === userId);
        if (user) {
            alert(`Detail User:\n\nNama: ${user.name}\nEmail: ${user.email}\nTelepon: ${user.phone}\nLokasi: ${user.location}\nStatus: ${user.status === 'active' ? 'Aktif' : 'Tidak Aktif'}\nJumlah Keluhan: ${user.complaints}\nTerakhir Aktif: ${user.lastActive}`);
        }
    }

    // Edit user
    async editUser(userId) {
        const user = this.users.find(u => u.id === userId);
        if (!user) return;

        const newName = prompt('Edit Nama:', user.name);
        if (newName && newName.trim()) {
            try {
                // Try to update via API
                const response = await fetch(`${this.apiBase}users.php`, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        id: userId,
                        name: newName.trim()
                    })
                });

                if (response.ok) {
                    user.name = newName.trim();
                    this.renderUserTable();
                    alert('Data user berhasil diupdate!');
                } else {
                    throw new Error('API not available');
                }
            } catch (error) {
                // Fallback to local update
                user.name = newName.trim();
                this.renderUserTable();
                alert('Data user berhasil diupdate! (Local only - API not available)');
            }
        }
    }

    // Delete user
    async deleteUser(userId) {
        const user = this.users.find(u => u.id === userId);
        if (!user) return;

        if (confirm(`Apakah Anda yakin ingin menghapus user "${user.name}"?`)) {
            try {
                // Try to delete via API
                const response = await fetch(`${this.apiBase}users.php`, {
                    method: 'DELETE',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ id: userId })
                });

                if (response.ok) {
                    this.removeUserFromArray(userId);
                    alert('User berhasil dihapus!');
                } else {
                    throw new Error('API not available');
                }
            } catch (error) {
                // Fallback to local deletion
                this.removeUserFromArray(userId);
                alert('User berhasil dihapus! (Local only - API not available)');
            }
        }
    }

    // Remove user from local array
    removeUserFromArray(userId) {
        const index = this.users.findIndex(u => u.id === userId);
        if (index > -1) {
            this.users.splice(index, 1);
            this.filteredUsers = [...this.users];
            this.renderUserTable();
            this.updateFilterButtons();
        }
    }

    // Show add user modal
    async showAddUserModal() {
        const name = prompt('Nama User:');
        if (!name || !name.trim()) return;
        
        const email = prompt('Email User:');
        if (!email || !email.trim()) return;
        
        const phone = prompt('Nomor Telepon:');
        if (!phone || !phone.trim()) return;
        
        const location = prompt('Lokasi (Kota, Provinsi):');
        if (!location || !location.trim()) return;

        const newUser = {
            id: Math.max(...this.users.map(u => u.id)) + 1,
            name: name.trim(),
            email: email.trim(),
            phone: phone.trim(),
            location: location.trim(),
            joinDate: new Date().toISOString().split('T')[0],
            status: 'active',
            complaints: 0,
            lastActive: new Date().toISOString().split('T')[0]
        };

        try {
            // Try to add via API
            const response = await fetch(`${this.apiBase}users.php`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(newUser)
            });

            if (response.ok) {
                const result = await response.json();
                newUser.id = result.id || newUser.id;
                this.addUserToArray(newUser);
                alert('User baru berhasil ditambahkan!');
            } else {
                throw new Error('API not available');
            }
        } catch (error) {
            // Fallback to local addition
            this.addUserToArray(newUser);
            alert('User baru berhasil ditambahkan! (Local only - API not available)');
        }
    }

    // Add user to local array
    addUserToArray(user) {
        this.users.push(user);
        this.filteredUsers = [...this.users];
        this.renderUserTable();
        this.updateFilterButtons();
    }

    // Show/hide loading indicator
    showLoading(show) {
        const loadingIndicator = document.getElementById('loadingIndicator');
        if (loadingIndicator) {
            loadingIndicator.style.display = show ? 'block' : 'none';
        }
    }

    // Handle logout
    handleLogout() {
        if (confirm('Apakah Anda yakin ingin keluar?')) {
            localStorage.removeItem('auth');
            window.location.href = 'login.html';
        }
    }

    // Refresh data
    async refreshData() {
        await this.loadUserData();
    }
}

// Global functions for onclick handlers
let userManagement;

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    userManagement = new UserManagement();
});

// Global functions for HTML onclick handlers
function filterByStatus(status) {
    if (userManagement) {
        userManagement.filterByStatus(status);
    }
}

function filterUsers(searchTerm) {
    if (userManagement) {
        userManagement.filterUsers(searchTerm);
    }
}

function showAddUserModal() {
    if (userManagement) {
        userManagement.showAddUserModal();
    }
}

function handleLogout() {
    if (userManagement) {
        userManagement.handleLogout();
    }
}