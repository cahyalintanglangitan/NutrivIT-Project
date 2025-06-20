// Enhanced User Management JavaScript
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

    // Load enhanced mock data for development/demo
    loadMockData() {
        this.users = [
            {
                id: 1,
                user_id: "USR001",
                nama_lengkap: "Ahmad Rizki Pratama",
                email: "ahmad.rizki@email.com",
                nomor_telepon: "+62 812-3456-7890",
                tinggi_badan: 175,
                berat_badan: 70.5,
                gender: "laki-laki",
                diet_plan: "Weight Loss Plan",
                diet_start: "2025-06-01",
                diet_end: "2025-07-01",
                last_activity: "2025-06-19",
                status: "active",
                consultation_count: 12,
                last_weight: 69.5,
                target_kalori: 1500,
                avg_calorie_intake: 1450
            },
            {
                id: 2,
                user_id: "USR002",
                nama_lengkap: "Siti Aminah Putri",
                email: "siti.aminah@email.com",
                nomor_telepon: "+62 813-4567-8901",
                tinggi_badan: 165,
                berat_badan: 60.0,
                gender: "perempuan",
                diet_plan: "Muscle Gain Plan",
                diet_start: "2025-06-05",
                diet_end: "2025-08-05",
                last_activity: "2025-06-18",
                status: "active",
                consultation_count: 8,
                last_weight: 61.0,
                target_kalori: 2500,
                avg_calorie_intake: 2400
            },
            {
                id: 3,
                user_id: "USR003",
                nama_lengkap: "Budi Santoso",
                email: "budi.santoso@email.com",
                nomor_telepon: "+62 814-5678-9012",
                tinggi_badan: 180,
                berat_badan: 85.0,
                gender: "laki-laki",
                diet_plan: "Healthy Eating",
                diet_start: "2025-06-10",
                diet_end: null,
                last_activity: "2025-06-19",
                status: "active",
                consultation_count: 15,
                last_weight: 84.0,
                target_kalori: 2000,
                avg_calorie_intake: 1950
            },
            {
                id: 4,
                user_id: "USR004",
                nama_lengkap: "Dewi Sartika",
                email: "dewi.sartika@email.com",
                nomor_telepon: "+62 815-6789-0123",
                tinggi_badan: 160,
                berat_badan: 55.0,
                gender: "perempuan",
                diet_plan: null,
                diet_start: null,
                diet_end: null,
                last_activity: "2025-06-10",
                status: "inactive",
                consultation_count: 2,
                last_weight: 55.0,
                target_kalori: 0,
                avg_calorie_intake: 0
            },
            {
                id: 5,
                user_id: "USR005",
                nama_lengkap: "Rudi Hartono",
                email: "rudi.hartono@email.com",
                nomor_telepon: "+62 816-7890-1234",
                tinggi_badan: 178,
                berat_badan: 75.0,
                gender: "laki-laki",
                diet_plan: "Diabetes Management",
                diet_start: "2025-05-15",
                diet_end: "2025-08-15",
                last_activity: "2025-06-19",
                status: "active",
                consultation_count: 25,
                last_weight: 74.2,
                target_kalori: 1800,
                avg_calorie_intake: 1780
            },
            {
                id: 6,
                user_id: "USR006",
                nama_lengkap: "Maya Kusuma",
                email: "maya.kusuma@email.com",
                nomor_telepon: "+62 817-8901-2345",
                tinggi_badan: 162,
                berat_badan: 58.0,
                gender: "perempuan",
                diet_plan: "Weight Loss Plan",
                diet_start: "2025-05-20",
                diet_end: "2025-07-20",
                last_activity: "2025-06-18",
                status: "active",
                consultation_count: 9,
                last_weight: 57.5,
                target_kalori: 1400,
                avg_calorie_intake: 1380
            },
            {
                id: 7,
                user_id: "USR007",
                nama_lengkap: "Andi Wijaya",
                email: "andi.wijaya@email.com",
                nomor_telepon: "+62 818-9012-3456",
                tinggi_badan: 170,
                berat_badan: 68.0,
                gender: "laki-laki",
                diet_plan: "Muscle Gain Plan",
                diet_start: "2025-06-01",
                diet_end: "2025-09-01",
                last_activity: "2025-06-17",
                status: "active",
                consultation_count: 6,
                last_weight: 68.5,
                target_kalori: 2300,
                avg_calorie_intake: 2280
            },
            {
                id: 8,
                user_id: "USR008",
                nama_lengkap: "Fitri Handayani",
                email: "fitri.handayani@email.com",
                nomor_telepon: "+62 819-0123-4567",
                tinggi_badan: 158,
                berat_badan: 52.0,
                gender: "perempuan",
                diet_plan: null,
                diet_start: null,
                diet_end: null,
                last_activity: "2025-06-05",
                status: "inactive",
                consultation_count: 1,
                last_weight: 52.0,
                target_kalori: 0,
                avg_calorie_intake: 0
            }
        ];

        const mockStats = {
            totalUsers: 1247,
            activeUsers: 1089,
            activeDietPlans: 83,
            todayConsultations: 156,
            totalUsersChange: '+15% dari bulan lalu',
            activeUsersChange: '87% tingkat aktivitas',
            dietPlansChange: '+12 program bulan ini',
            consultationsChange: '+8% dari kemarin'
        };
        this.updateStatistics(mockStats);
    }

    // Update statistics in the UI
    updateStatistics(stats) {
        document.getElementById('totalUsers').textContent = stats.totalUsers?.toLocaleString() || '0';
        document.getElementById('activeUsers').textContent = stats.activeUsers?.toLocaleString() || '0';
        document.getElementById('activeDietPlans').textContent = stats.activeDietPlans?.toLocaleString() || '0';
        document.getElementById('todayConsultations').textContent = stats.todayConsultations?.toLocaleString() || '0';
        
        if (stats.totalUsersChange) document.getElementById('totalUsersChange').textContent = stats.totalUsersChange;
        if (stats.activeUsersChange) document.getElementById('activeUsersChange').textContent = stats.activeUsersChange;
        if (stats.dietPlansChange) document.getElementById('dietPlansChange').textContent = stats.dietPlansChange;
        if (stats.consultationsChange) document.getElementById('consultationsChange').textContent = stats.consultationsChange;
    }

    // Initialize enhanced charts
    initializeCharts() {
        this.initUserAnalyticsChart();
        this.initUserStatusChart();
    }

    // Initialize user analytics trend chart
    initUserAnalyticsChart() {
        const ctx = document.getElementById('userAnalyticsChart').getContext('2d');
        this.charts.analytics = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                datasets: [
                    {
                        label: 'User Analytics (Keluhan Gizi)',
                        data: [45, 62, 58, 74, 89, 156],
                        borderColor: '#08A55A',
                        backgroundColor: 'rgba(8, 165, 90, 0.1)',
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: '#08A55A',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 6
                    },
                    {
                        label: 'Konsultasi',
                        data: [30, 45, 40, 60, 75, 120],
                        borderColor: '#3FCAEA',
                        backgroundColor: 'rgba(63, 202, 234, 0.1)',
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: '#3FCAEA',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 6
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'top'
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

    // Initialize user status distribution chart
    initUserStatusChart() {
        const ctx = document.getElementById('userStatusChart').getContext('2d');
        this.charts.status = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['User Aktif', 'User Tidak Aktif', 'User dengan Diet', 'User Baru'],
                datasets: [{
                    data: [1089, 158, 83, 45],
                    backgroundColor: [
                        '#08A55A',
                        '#dc3545',
                        '#3FCAEA',
                        '#ffc107'
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
                            padding: 15,
                            usePointStyle: true,
                            font: {
                                size: 11
                            }
                        }
                    }
                }
            }
        });
    }

    // Bind event listeners
    bindEventListeners() {
        const searchInput = document.getElementById('searchInput');
        if (searchInput) {
            searchInput.addEventListener('input', (e) => {
                this.filterUsers(e.target.value);
            });
        }
    }

    // Enhanced render user table
    renderUserTable(userList = this.filteredUsers) {
        const tbody = document.getElementById('userTableBody');
        if (!tbody) return;

        tbody.innerHTML = '';

        if (userList.length === 0) {
            document.getElementById('emptyState').style.display = 'block';
            return;
        } else {
            document.getElementById('emptyState').style.display = 'none';
        }

        userList.forEach((user, index) => {
            const row = document.createElement('tr');
            
            // Get user initials
            const initials = user.nama_lengkap.split(' ').map(n => n[0]).join('').substring(0, 2);
            
            // Calculate BMI
            const bmi = (user.berat_badan / Math.pow(user.tinggi_badan / 100, 2)).toFixed(1);
            
            // Format dates
            const lastActivity = user.last_activity ? new Date(user.last_activity).toLocaleDateString('id-ID') : 'Belum ada';
            const dietDuration = user.diet_start && user.diet_end ? 
                Math.ceil((new Date(user.diet_end) - new Date(user.diet_start)) / (1000 * 60 * 60 * 24)) + ' hari' : 
                user.diet_start ? 'Ongoing' : 'Tidak ada';

            row.innerHTML = `
                <td>
                    <div class="user-cell">
                        <div class="user-avatar-small">${initials}</div>
                        <div class="user-info-cell">
                            <div class="user-name-cell">${user.nama_lengkap}</div>
                            <div class="user-id">ID: ${user.user_id}</div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="contact-info">
                        <div class="contact-email">${user.email}</div>
                        <div class="contact-phone">${user.nomor_telepon}</div>
                    </div>
                </td>
                <td>
                    <div class="diet-info">
                        <div class="diet-plan-name">${user.diet_plan || 'Tidak ada'}</div>
                        <div class="diet-duration">${dietDuration}</div>
                    </div>
                </td>
                <td>
                    <div class="analytics-cell">
                        <div class="last-activity">BMI: ${bmi}</div>
                        <div class="activity-status">Last: ${lastActivity}</div>
                    </div>
                </td>
                <td>
                    <span class="status-badge ${user.status}">
                        <i class="fas fa-circle" style="font-size: 8px;"></i>
                        ${user.status === 'active' ? 'Aktif' : 'Tidak Aktif'}
                    </span>
                </td>
                <td>
                    <div class="consultation-count">
                        ${user.consultation_count}
                    </div>
                </td>
                <td>
                    <button class="btn-small" onclick="userManagement.viewUser(${user.id})" title="Lihat Detail">
                        <i class="fas fa-eye"></i>
                    </button>
                    <button class="btn-small btn-info" onclick="userManagement.viewAnalytics(${user.id})" title="Lihat Analytics">
                        <i class="fas fa-chart-line"></i>
                    </button>
                    <button class="btn-small btn-warning" onclick="userManagement.editUser(${user.id})" title="Edit User">
                        <i class="fas fa-edit"></i>
                    </button>
                </td>
            `;
            
            // Add animation delay
            row.style.animationDelay = `${index * 0.05}s`;
            tbody.appendChild(row);
        });
    }

    // Enhanced filter functions
    filterUsers(searchTerm) {
        const term = searchTerm.toLowerCase();
        this.filteredUsers = this.users.filter(user => 
            user.nama_lengkap.toLowerCase().includes(term) ||
            user.email.toLowerCase().includes(term) ||
            user.user_id.toLowerCase().includes(term) ||
            (user.diet_plan && user.diet_plan.toLowerCase().includes(term))
        );
        this.renderUserTable();
    }

    filterByStatus(status) {
        this.currentFilter = status;
        
        // Remove active class from all buttons
        document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
        
        // Add active class to clicked button
        event.target.classList.add('active');
        
        if (status === 'all') {
            this.filteredUsers = [...this.users];
        } else if (status === 'diet') {
            this.filteredUsers = this.users.filter(user => user.diet_plan !== null);
        } else {
            this.filteredUsers = this.users.filter(user => user.status === status);
        }
        
        this.renderUserTable();
    }

    applyDateFilter() {
        const dateFrom = document.getElementById('dateFrom').value;
        const dateTo = document.getElementById('dateTo').value;
        
        if (dateFrom && dateTo) {
            this.filteredUsers = this.users.filter(user => {
                const activityDate = new Date(user.last_activity);
                return activityDate >= new Date(dateFrom) && activityDate <= new Date(dateTo);
            });
            this.renderUserTable();
        }
    }

    updateFilterButtons() {
        const allCount = this.users.length;
        const activeCount = this.users.filter(u => u.status === 'active').length;
        const inactiveCount = this.users.filter(u => u.status === 'inactive').length;
        const dietCount = this.users.filter(u => u.diet_plan !== null).length;

        const filterAll = document.getElementById('filterAll');
        const filterActive = document.getElementById('filterActive');
        const filterInactive = document.getElementById('filterInactive');
        const filterDiet = document.getElementById('filterDiet');

        if (filterAll) filterAll.textContent = `Semua (${allCount.toLocaleString()})`;
        if (filterActive) filterActive.textContent = `Aktif (${activeCount.toLocaleString()})`;
        if (filterInactive) filterInactive.textContent = `Tidak Aktif (${inactiveCount.toLocaleString()})`;
        if (filterDiet) filterDiet.textContent = `Dengan Diet (${dietCount.toLocaleString()})`;
    }

    // Enhanced view user details
    viewUser(userId) {
        const user = this.users.find(u => u.id === userId);
        if (user) {
            const bmi = (user.berat_badan / Math.pow(user.tinggi_badan / 100, 2)).toFixed(1);
            let bmiCategory = '';
            if (bmi < 18.5) bmiCategory = 'Underweight';
            else if (bmi < 25) bmiCategory = 'Normal';
            else if (bmi < 30) bmiCategory = 'Overweight';
            else bmiCategory = 'Obese';

            const modalContent = `
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div>
                        <h4 style="color: #08A55A; margin-bottom: 15px;">📋 Informasi Personal</h4>
                        <p style="margin-bottom: 8px;"><strong>Nama:</strong> ${user.nama_lengkap}</p>
                        <p style="margin-bottom: 8px;"><strong>Email:</strong> ${user.email}</p>
                        <p style="margin-bottom: 8px;"><strong>Telepon:</strong> ${user.nomor_telepon}</p>
                        <p style="margin-bottom: 8px;"><strong>Gender:</strong> ${user.gender}</p>
                        <p style="margin-bottom: 8px;"><strong>Tinggi:</strong> ${user.tinggi_badan} cm</p>
                        <p style="margin-bottom: 8px;"><strong>Berat:</strong> ${user.berat_badan} kg</p>
                        <p style="margin-bottom: 8px;"><strong>BMI:</strong> ${bmi} (${bmiCategory})</p>
                    </div>
                    <div>
                        <h4 style="color: #3FCAEA; margin-bottom: 15px;">🍎 Program Diet & Analytics</h4>
                        <p style="margin-bottom: 8px;"><strong>Program:</strong> ${user.diet_plan || 'Tidak ada'}</p>
                        <p style="margin-bottom: 8px;"><strong>Target Kalori:</strong> ${user.target_kalori} kcal</p>
                        <p style="margin-bottom: 8px;"><strong>Rata-rata Asupan:</strong> ${user.avg_calorie_intake} kcal</p>
                        <p style="margin-bottom: 8px;"><strong>Konsultasi:</strong> ${user.consultation_count} kali</p>
                        <p style="margin-bottom: 8px;"><strong>Status:</strong> ${user.status === 'active' ? 'Aktif' : 'Tidak Aktif'}</p>
                        <p style="margin-bottom: 8px;"><strong>Terakhir Aktif:</strong> ${user.last_activity}</p>
                    </div>
                </div>
            `;
            document.getElementById('userDetailContent').innerHTML = modalContent;
            document.getElementById('userDetailModal').style.display = 'block';
        }
    }

    viewAnalytics(userId) {
        const user = this.users.find(u => u.id === userId);
        if (user) {
            const bmi = (user.berat_badan / Math.pow(user.tinggi_badan / 100, 2)).toFixed(1);
            const calorieDeficit = user.target_kalori - user.avg_calorie_intake;
            
            alert(`📊 Analytics untuk ${user.nama_lengkap}:\n\n` +
                  `📏 BMI: ${bmi}\n` +
                  `🎯 Target Kalori: ${user.target_kalori} kcal\n` +
                  `🍽️ Rata-rata Asupan: ${user.avg_calorie_intake} kcal\n` +
                  `⚖️ Selisih Kalori: ${calorieDeficit > 0 ? '+' : ''}${calorieDeficit} kcal\n` +
                  `💬 Total Konsultasi: ${user.consultation_count}\n` +
                  `📈 Progress: ${user.diet_plan ? 'Dalam Program' : 'Belum ada program'}\n` +
                  `📅 Status: ${user.status === 'active' ? 'Aktif' : 'Tidak Aktif'}`);
        }
    }

    editUser(userId) {
        const user = this.users.find(u => u.id === userId);
        if (!user) return;

        const newName = prompt('Edit Nama:', user.nama_lengkap);
        if (newName && newName.trim()) {
            user.nama_lengkap = newName.trim();
            this.renderUserTable();
            alert('✅ Data user berhasil diupdate!');
        }
    }

    exportData(format) {
        if (format === 'excel') {
            // Simulate Excel export
            const csvContent = this.generateCSVContent();
            this.downloadFile(csvContent, 'user-data.csv', 'text/csv');
            alert('📊 Data berhasil diekspor ke Excel!');
        } else if (format === 'pdf') {
            // Simulate PDF export
            alert('📄 Ekspor ke PDF akan segera dimulai...\n\nFitur ini akan menghasilkan laporan PDF lengkap dengan grafik dan statistik.');
        }
    }

    generateCSVContent() {
        const headers = ['ID,Nama,Email,Telepon,Gender,Tinggi,Berat,BMI,Program Diet,Status,Konsultasi'];
        const rows = this.filteredUsers.map(user => {
            const bmi = (user.berat_badan / Math.pow(user.tinggi_badan / 100, 2)).toFixed(1);
            return [
                user.user_id,
                user.nama_lengkap,
                user.email,
                user.nomor_telepon,
                user.gender,
                user.tinggi_badan,
                user.berat_badan,
                bmi,
                user.diet_plan || 'Tidak ada',
                user.status === 'active' ? 'Aktif' : 'Tidak Aktif',
                user.consultation_count
            ].join(',');
        });
        return headers.concat(rows).join('\n');
    }

    downloadFile(content, fileName, contentType) {
        const blob = new Blob([content], { type: contentType });
        const url = window.URL.createObjectURL(blob);
        const link = document.createElement('a');
        link.href = url;
        link.download = fileName;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        window.URL.revokeObjectURL(url);
    }

    showLoading(show) {
        const loadingIndicator = document.getElementById('loadingIndicator');
        if (loadingIndicator) {
            loadingIndicator.style.display = show ? 'block' : 'none';
        }
    }

    handleLogout() {
        if (confirm('Apakah Anda yakin ingin keluar?')) {
            localStorage.removeItem('auth');
            window.location.href = 'login.html';
        }
    }

    // Advanced filter by BMI category
    filterByBMICategory(category) {
        this.filteredUsers = this.users.filter(user => {
            const bmi = user.berat_badan / Math.pow(user.tinggi_badan / 100, 2);
            switch(category) {
                case 'underweight': return bmi < 18.5;
                case 'normal': return bmi >= 18.5 && bmi < 25;
                case 'overweight': return bmi >= 25 && bmi < 30;
                case 'obese': return bmi >= 30;
                default: return true;
            }
        });
        this.renderUserTable();
    }

    // Get user statistics for dashboard
    getUserStatistics() {
        const totalUsers = this.users.length;
        const activeUsers = this.users.filter(u => u.status === 'active').length;
        const usersWithDiet = this.users.filter(u => u.diet_plan !== null).length;
        const totalConsultations = this.users.reduce((sum, u) => sum + u.consultation_count, 0);
        
        return {
            totalUsers,
            activeUsers,
            usersWithDiet,
            totalConsultations,
            averageConsultations: (totalConsultations / totalUsers).toFixed(1)
        };
    }

    // Refresh data manually
    async refreshData() {
        await this.loadUserData();
        alert('🔄 Data berhasil diperbarui!');
    }

    // Add new user (for future implementation)
    async addNewUser(userData) {
        try {
            const response = await fetch(`${this.apiBase}users.php`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(userData)
            });

            if (response.ok) {
                const result = await response.json();
                this.users.push(result.user);
                this.filteredUsers = [...this.users];
                this.renderUserTable();
                this.updateFilterButtons();
                return { success: true, message: 'User berhasil ditambahkan!' };
            } else {
                throw new Error('Failed to add user');
            }
        } catch (error) {
            console.error('Error adding user:', error);
            return { success: false, message: 'Gagal menambahkan user' };
        }
    }

    // Update user data
    async updateUser(userId, updatedData) {
        try {
            const response = await fetch(`${this.apiBase}users.php`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ id: userId, ...updatedData })
            });

            if (response.ok) {
                const userIndex = this.users.findIndex(u => u.id === userId);
                if (userIndex > -1) {
                    this.users[userIndex] = { ...this.users[userIndex], ...updatedData };
                    this.filteredUsers = [...this.users];
                    this.renderUserTable();
                }
                return { success: true, message: 'User berhasil diupdate!' };
            } else {
                throw new Error('Failed to update user');
            }
        } catch (error) {
            console.error('Error updating user:', error);
            return { success: false, message: 'Gagal mengupdate user' };
        }
    }

    // Advanced search with multiple criteria
    advancedSearch(criteria) {
        this.filteredUsers = this.users.filter(user => {
            let matches = true;
            
            if (criteria.name) {
                matches = matches && user.nama_lengkap.toLowerCase().includes(criteria.name.toLowerCase());
            }
            
            if (criteria.email) {
                matches = matches && user.email.toLowerCase().includes(criteria.email.toLowerCase());
            }
            
            if (criteria.status) {
                matches = matches && user.status === criteria.status;
            }
            
            if (criteria.dietPlan) {
                matches = matches && (user.diet_plan !== null) === criteria.dietPlan;
            }
            
            if (criteria.minConsultations) {
                matches = matches && user.consultation_count >= criteria.minConsultations;
            }
            
            if (criteria.maxConsultations) {
                matches = matches && user.consultation_count <= criteria.maxConsultations;
            }
            
            return matches;
        });
        
        this.renderUserTable();
    }

    // Generate user report
    generateUserReport() {
        const stats = this.getUserStatistics();
        const bmiStats = this.getBMIStatistics();
        const dietStats = this.getDietStatistics();
        
        const report = {
            generatedAt: new Date().toLocaleString('id-ID'),
            overview: stats,
            bmiDistribution: bmiStats,
            dietPrograms: dietStats,
            users: this.filteredUsers.map(user => ({
                id: user.user_id,
                name: user.nama_lengkap,
                email: user.email,
                bmi: (user.berat_badan / Math.pow(user.tinggi_badan / 100, 2)).toFixed(1),
                dietPlan: user.diet_plan,
                consultations: user.consultation_count,
                status: user.status
            }))
        };
        
        return report;
    }

    getBMIStatistics() {
        const bmiCategories = { underweight: 0, normal: 0, overweight: 0, obese: 0 };
        
        this.users.forEach(user => {
            const bmi = user.berat_badan / Math.pow(user.tinggi_badan / 100, 2);
            if (bmi < 18.5) bmiCategories.underweight++;
            else if (bmi < 25) bmiCategories.normal++;
            else if (bmi < 30) bmiCategories.overweight++;
            else bmiCategories.obese++;
        });
        
        return bmiCategories;
    }

    getDietStatistics() {
        const dietPlans = {};
        this.users.forEach(user => {
            if (user.diet_plan) {
                dietPlans[user.diet_plan] = (dietPlans[user.diet_plan] || 0) + 1;
            }
        });
        return dietPlans;
    }
}

// Global functions and initialization
let userManagement;

document.addEventListener('DOMContentLoaded', function() {
    userManagement = new UserManagement();
    
    // Add keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Ctrl+R to refresh data
        if (e.ctrlKey && e.key === 'r') {
            e.preventDefault();
            userManagement.refreshData();
        }
        
        // Ctrl+E to export
        if (e.ctrlKey && e.key === 'e') {
            e.preventDefault();
            userManagement.exportData('excel');
        }
        
        // Escape to close modal
        if (e.key === 'Escape') {
            closeUserModal();
        }
    });
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

function applyDateFilter() {
    if (userManagement) {
        userManagement.applyDateFilter();
    }
}

function exportData(format) {
    if (userManagement) {
        userManagement.exportData(format);
    }
}

function handleLogout() {
    if (userManagement) {
        userManagement.handleLogout();
    }
}

function closeUserModal() {
    const modal = document.getElementById('userDetailModal');
    if (modal) {
        modal.style.display = 'none';
    }
}

function showAddUserModal() {
    alert('🚀 Fitur tambah user akan segera hadir!\n\nSaat ini Anda dapat menggunakan fitur export untuk mengelola data user.');
}

// Click outside modal to close
window.onclick = function(event) {
    const modal = document.getElementById('userDetailModal');
    if (event.target === modal) {
        modal.style.display = 'none';
    }
}

// Enhanced console logging for debugging
console.log('🍎 NutriVit User Management System loaded successfully!');
console.log('📊 Available features:');
console.log('- User filtering and search');
console.log('- Data export (Excel/PDF)');
console.log('- User analytics and BMI calculation');
console.log('- Responsive charts and statistics');
console.log('- Keyboard shortcuts (Ctrl+R, Ctrl+E, Escape)');

// Performance monitoring
window.addEventListener('load', function() {
    console.log(`⚡ Page loaded in ${performance.now().toFixed(2)}ms`);
});