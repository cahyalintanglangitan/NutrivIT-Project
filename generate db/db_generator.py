from faker import Faker
import random
import pandas as pd
from datetime import timedelta, datetime

fake = Faker('id_ID')
Faker.seed(42)

# ------------- 1. Users Table (500 Users) -------------

genders = ['laki-laki', 'perempuan']
kota_provinsi = [
    ('Jakarta', 'DKI Jakarta'), ('Surabaya', 'Jawa Timur'), ('Bandung', 'Jawa Barat'),
    ('Medan', 'Sumatera Utara'), ('Bekasi', 'Jawa Barat'), ('Tangerang', 'Banten'),
    ('Depok', 'Jawa Barat'), ('Semarang', 'Jawa Tengah'), ('Palembang', 'Sumatera Selatan'),
    ('Makassar', 'Sulawesi Selatan'), ('Bogor', 'Jawa Barat'), ('Batam', 'Kepulauan Riau'),
    ('Pekanbaru', 'Riau'), ('Padang', 'Sumatera Barat'), ('Malang', 'Jawa Timur'),
    ('Denpasar', 'Bali'), ('Samarinda', 'Kalimantan Timur'), ('Banjarmasin', 'Kalimantan Selatan'),
    ('Pontianak', 'Kalimantan Barat'), ('Yogyakarta', 'DI Yogyakarta')
]

users = []
for i in range(1, 50):
    gender = random.choice(genders)
    nama = fake.name_male() if gender == 'laki-laki' else fake.name_female()
    nama_depan = nama.split()[0].lower().replace("'", "").replace(".", "")
    username = f"{nama_depan}{random.randint(10, 99)}"
    email = f"{username}@example.com"
    password = fake.password(length=10)
    tinggi = random.randint(160, 185) if gender == 'laki-laki' else random.randint(150, 170)
    berat = random.randint(55, 90) if gender == 'laki-laki' else random.randint(45, 75)
    telepon = fake.msisdn()
    jalan = fake.street_address()
    kota, provinsi = random.choice(kota_provinsi)
    alamat = f"{jalan}, {kota}, {provinsi}"
    foto = f"user{i}.jpg"

    users.append([i, username, password, email, nama, gender, tinggi, berat, telepon, alamat, foto])

df_users = pd.DataFrame(users, columns=[
    'user_id', 'username', 'password', 'email', 'nama_lengkap', 'gender',
    'tinggi_badan', 'berat_badan', 'nomor_telepon', 'alamat', 'foto_profile'
])

# ------------- 2. Diet Plans Table -------------

diet_plan_names = [
    ("Bulking", "Program untuk menambah massa otot dengan surplus kalori."),
    ("Cutting", "Program penurunan lemak tubuh dengan defisit kalori."),
    ("Maintenance", "Menjaga berat badan stabil."),
    ("Weight Loss", "Menurunkan berat badan secara bertahap dan sehat."),
    ("Muscle Gain", "Meningkatkan massa otot melalui pola makan tinggi protein."),
    ("High Protein", "Konsumsi protein tinggi untuk pemulihan otot."),
    ("Low Carb", "Rendah karbohidrat, cocok untuk diet keto."),
    ("Intermittent Fasting", "Puasa berkala untuk metabolisme."),
    ("Vegan Plan", "Polanya bebas produk hewani."),
    ("Keto Plan", "Tinggi lemak, sangat rendah karbohidrat.")
]

diet_plans = []
for i, (name, desc) in enumerate(diet_plan_names, 1):
    target_cal = random.randint(1400, 3000)
    duration = random.randint(14, 90)
    diet_plans.append([i, name, desc, target_cal, duration])

df_diet_plans = pd.DataFrame(diet_plans, columns=[
    'plan_id', 'nama_plan', 'deskripsi', 'target_kalori', 'durasi'
])

# ------------- 3. User Diet Plans Table -------------

user_diet_plans = []
plan_user_id_counter = 1

for user_id in range(1, 501):
    for _ in range(random.randint(1, 3)):
        plan_id = random.randint(1, 10)
        start_date = fake.date_between(start_date='-2y', end_date='today')
        durasi = df_diet_plans[df_diet_plans['plan_id'] == plan_id]['durasi'].values[0]
        end_date = datetime.strptime(str(start_date), "%Y-%m-%d") + timedelta(days=int(durasi))
        user_diet_plans.append([
            plan_user_id_counter, user_id, plan_id,
            start_date.strftime('%Y-%m-%d'), end_date.strftime('%Y-%m-%d')
        ])
        plan_user_id_counter += 1

df_user_diet_plans = pd.DataFrame(user_diet_plans, columns=[
    'plan_user_id', 'user_id', 'plan_id', 'tanggal_mulai', 'tanggal_selesai'
])

# ------------- 4. User Diet Plans Table -------------
chatbot_logs = []
id_konsultasi_counter = 1
conversation_ids = list(range(1001, 1101))  # 100 sesi percakapan acak

for user_id in range(1, 501):
    num_messages = random.randint(2, 8)  # pesan per user
    convo_id = random.choice(conversation_ids)
    waktu_awal = fake.date_time_between(start_date='-1y', end_date='now')
    for i in range(num_messages):
        is_bot = random.choice([True, False])
        pesan = fake.sentence(nb_words=8 if not is_bot else 12)
        waktu = waktu_awal + timedelta(minutes=i * random.randint(1, 5))
        chatbot_logs.append([
            id_konsultasi_counter,
            user_id,
            pesan,
            waktu.strftime('%Y-%m-%d %H:%M:%S'),
            int(is_bot),
            convo_id
        ])
        id_konsultasi_counter += 1

df_konsultasi = pd.DataFrame(chatbot_logs, columns=[
    'id_konsultasi', 'user_id', 'message_konsultasi', 'waktu', 'is_bot_message', 'id_conversation'
])

# ------------- 5. Food items -------------
makanan_list = [
    "Nasi Putih", "Ayam Panggang", "Tahu Goreng", "Tempe Bacem", "Ikan Bakar",
    "Sate Ayam", "Soto Ayam", "Bakso", "Rendang", "Telur Rebus", "Roti Tawar",
    "Mie Goreng", "Bubur Ayam", "Sayur Asem", "Capcay", "Gado-gado", "Gudeg",
    "Karedok", "Sup Daging", "Salad Buah", "Kentang Rebus", "Kacang Merah",
    "Kacang Hijau", "Oatmeal", "Granola", "Smoothie Pisang", "Yogurt", "Susu Full Cream",
    "Susu Skim", "Air Kelapa", "Teh Manis", "Kopi Susu", "Jus Jeruk", "Jus Alpukat",
    "Es Coklat", "Coklat Batangan", "Keripik Kentang", "Nugget", "Sosis Goreng",
    "Burger", "Pizza", "Kebab", "Pasta Carbonara", "Spaghetti Bolognese", "Nasi Goreng",
    "Martabak Telur", "Martabak Manis", "Bakwan", "Pisang Goreng", "Donat"
]

food_items = []
for i, nama in enumerate(makanan_list, 1):
    kalori = random.randint(50, 700)
    karbo = round(random.uniform(5, 80), 1)
    lemak = round(random.uniform(1, 30), 1)
    protein = round(random.uniform(1, 40), 1)
    food_items.append([i, nama, kalori, karbo, lemak, protein])

df_food_items = pd.DataFrame(food_items, columns=[
    'food_id', 'nama_makanan', 'kalori', 'karbohidrat', 'lemak', 'protein'
])

# ------------- 6. Diet Logs -------------
meal_types = ['sarapan', 'makan siang', 'makan malam', 'snack']
diet_logs = []
log_id_counter = 1

for user_id in range(1, 501):
    for _ in range(random.randint(2, 6)):  # 2-6 log per user
        food_id = random.randint(1, len(makanan_list))
        log_date = fake.date_between(start_date='-6M', end_date='today')
        meal_type = random.choice(meal_types)
        kuantitas = round(random.uniform(0.5, 2.5), 1)
        catatan = fake.sentence(nb_words=6)
        diet_logs.append([
            log_id_counter, user_id, food_id, log_date,
            meal_type, kuantitas, catatan
        ])
        log_id_counter += 1

df_diet_logs = pd.DataFrame(diet_logs, columns=[
    'logs_id', 'user_id', 'food_id', 'log_date', 'meal_type', 'kuantitas', 'catatan'
])

# ------------- 6. Product -------------
kategori_list = ['Whey Protein', 'Creatine', 'Vitamin', 'Snack Sehat', 'Suplemen Diet']

products = []
for i in range(1, 31):
    nama = f"{random.choice(kategori_list)} {fake.word().capitalize()}"
    deskripsi = fake.sentence(nb_words=10)
    harga = random.randint(25000, 400000)
    kategori = random.choice(kategori_list)
    stok = random.randint(0, 200)
    gambar = f"produk{i}.jpg"
    products.append([i, nama, deskripsi, harga, kategori, stok, gambar])

df_products = pd.DataFrame(products, columns=[
    'product_id', 'nama_produk', 'deskripsi', 'harga', 'kategori', 'stok', 'gambar'
])

# ------------- 7. Order & Order Items  -------------
status_pembayaran = ['Belum Dibayar', 'Sudah Dibayar', 'Dibatalkan']
orders = []
order_items = []
order_id_counter = 1
order_item_id_counter = 1

for user_id in range(1, 501):
    for _ in range(random.randint(1, 3)):  # 1-3 order per user
        tanggal_order = fake.date_between(start_date='-6M', end_date='today')
        status = random.choice(status_pembayaran)
        alamat_kirim = fake.address().replace('\n', ', ')
        jumlah_item = random.randint(1, 4)
        total = 0
        this_order_id = order_id_counter

        # Buat items untuk order ini
        for _ in range(jumlah_item):
            produk_id = random.randint(1, 30)
            harga_satuan = df_products[df_products['product_id'] == produk_id]['harga'].values[0]
            qty = random.randint(1, 5)
            total += harga_satuan * qty
            order_items.append([
                order_item_id_counter, this_order_id, produk_id, qty, harga_satuan
            ])
            order_item_id_counter += 1

        orders.append([
            this_order_id, user_id, tanggal_order, status, total, alamat_kirim
        ])
        order_id_counter += 1

df_orders = pd.DataFrame(orders, columns=[
    'order_id', 'user_id', 'order_date', 'status_pembayaran', 'total_pembayaran', 'alamat_pengiriman'
])

df_order_items = pd.DataFrame(order_items, columns=[
    'order_items_id', 'order_id', 'product_id', 'jumlah', 'harga_satuan'
])

# ------------- 8. Admin Users  -------------
admin_users = []
for i in range(1, 11):
    username = f"admin{i}"
    email = f"{username}@nutriv.ai"
    password = "admin123"  # plaintext sesuai instruksi awal
    admin_users.append([i, username, email, password])

df_admins = pd.DataFrame(admin_users, columns=[ 
    'admin_id', 'username', 'email', 'password'
])

# ------------- 8. Users Analytics  -------------
metric_types = ['total_login', 'kalori_terbakar', 'jumlah_konsultasi', 'waktu_diet', 'produk_dibeli']
analytics_data = []
analytics_id_counter = 1

for user_id in range(1, 501):
    for _ in range(random.randint(2, 5)):
        tanggal = fake.date_between(start_date='-3M', end_date='today')
        metric = random.choice(metric_types)
        value = round(random.uniform(1, 100), 2)
        deskripsi = fake.sentence(nb_words=6)
        admin_id = random.randint(1, 10)
        analytics_data.append([
            analytics_id_counter, user_id, admin_id, tanggal, metric, value, deskripsi
        ])
        analytics_id_counter += 1

df_analytics = pd.DataFrame(analytics_data, columns=[
    'analytics_id', 'user_id', 'admin_id', 'tanggal', 'metric_type', 'metric_value', 'deskripsi'
])


# ------------- SQL Table FULL -------------

sql_create_users = """
CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    nama_lengkap VARCHAR(100) NOT NULL,
    gender ENUM('laki-laki', 'perempuan') NOT NULL,
    tinggi_badan INT,
    berat_badan INT,
    nomor_telepon VARCHAR(20),
    alamat TEXT,
    foto_profile VARCHAR(255)
);
"""

sql_create_diet_plans = """
CREATE TABLE IF NOT EXISTS diet_plans (
    plan_id INT AUTO_INCREMENT PRIMARY KEY,
    nama_plan VARCHAR(100),
    deskripsi TEXT,
    target_kalori INT,
    durasi INT
);
"""

sql_create_user_diet_plans = """
CREATE TABLE IF NOT EXISTS user_diet_plans (
    plan_user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    plan_id INT NOT NULL,
    tanggal_mulai DATE,
    tanggal_selesai DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (plan_id) REFERENCES diet_plans(plan_id)
);
"""

sql_create_konsultasi = """
CREATE TABLE IF NOT EXISTS konsultasi_chatbot (
    id_konsultasi INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    message_konsultasi TEXT,
    waktu DATETIME,
    is_bot_message BOOLEAN,
    id_conversation INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
"""

sql_create_food_items = """
CREATE TABLE IF NOT EXISTS food_items (
    food_id INT AUTO_INCREMENT PRIMARY KEY,
    nama_makanan VARCHAR(100),
    kalori INT,
    karbohidrat FLOAT,
    lemak FLOAT,
    protein FLOAT
);
"""

sql_create_diet_logs = """
CREATE TABLE IF NOT EXISTS diet_logs (
    logs_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    food_id INT NOT NULL,
    log_date DATE,
    meal_type VARCHAR(50),
    kuantitas FLOAT,
    catatan TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (food_id) REFERENCES food_items(food_id)
);
"""
sql_create_products = """
CREATE TABLE IF NOT EXISTS product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    nama_produk VARCHAR(100),
    deskripsi TEXT,
    harga INT,
    kategori VARCHAR(100),
    stok INT,
    gambar VARCHAR(255)
);
"""

sql_create_orders = """
CREATE TABLE IF NOT EXISTS `order` (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATE,
    status_pembayaran VARCHAR(50),
    total_pembayaran INT,
    alamat_pengiriman TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
"""

sql_create_order_items = """
CREATE TABLE IF NOT EXISTS order_items (
    order_items_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    jumlah INT,
    harga_satuan INT,
    FOREIGN KEY (order_id) REFERENCES `order`(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);
"""

sql_create_admin_users = """
CREATE TABLE IF NOT EXISTS admin_users (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100),
    email VARCHAR(150),
    password VARCHAR(100)
);
"""

sql_create_user_analytics = """
CREATE TABLE IF NOT EXISTS user_analytics (
    analytics_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    admin_id INT NOT NULL,
    tanggal DATE,
    metric_type VARCHAR(100),
    metric_value FLOAT,
    deskripsi TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (admin_id) REFERENCES admin_users(admin_id)
);
"""

# Insert Users
sql_insert_users = "\n".join([
    f"INSERT INTO Users VALUES ({', '.join(repr(str(v).replace('\'', '\'\'') if v else '') for v in row)});"
    for row in df_users.values
])

# Insert Diet Plans
sql_insert_diet_plans = "\n".join([
    f"INSERT INTO diet_plans VALUES ({', '.join(repr(str(v).replace('\'', '\'\'') if v else '') for v in row)});"
    for row in df_diet_plans.values
])

# Insert User Diet Plans
sql_insert_user_diet_plans = "\n".join([
    f"INSERT INTO user_diet_plans VALUES ({', '.join(repr(str(v)) for v in row)});"
    for row in df_user_diet_plans.values
])

# Insert Konsultasi Chatbot
sql_insert_konsultasi = "\n".join([
    f"INSERT INTO konsultasi_chatbot VALUES ({', '.join(repr(str(v).replace('\'', '\'\'') if v else '') for v in row)});"
    for row in df_konsultasi.values
])

# Insert Food Items
sql_insert_food_items = "\n".join([
    f"INSERT INTO food_items VALUES ({', '.join(repr(str(v).replace('\'', '\'\'') if v else '') for v in row)});"
    for row in df_food_items.values
])

# Insert Diet Logs
sql_insert_diet_logs = "\n".join([
    f"INSERT INTO diet_logs VALUES ({', '.join(repr(str(v).replace('\'', '\'\'') if v else '') for v in row)});"
    for row in df_diet_logs.values
])

# Insert Product
sql_insert_products = "\n".join([
    f"INSERT INTO product VALUES ({', '.join(repr(str(v).replace('\'', '\'\'') if v else '') for v in row)});"
    for row in df_products.values
])

# Insert Orders
sql_insert_orders = "\n".join([
    f"INSERT INTO `order` VALUES ({', '.join(repr(str(v)) for v in row)});"
    for row in df_orders.values
])

# Insert Orders Items
sql_insert_order_items = "\n".join([
    f"INSERT INTO order_items VALUES ({', '.join(repr(str(v)) for v in row)});"
    for row in df_order_items.values
])

# Insert Users admin 
sql_insert_admin_users = "\n".join([
    f"INSERT INTO admin_users VALUES ({', '.join(repr(str(v)) for v in row)});"
    for row in df_admins.values
])

# Insert Users analytics
sql_insert_user_analytics = "\n".join([
    f"INSERT INTO user_analytics VALUES ({', '.join(repr(str(v)) for v in row)});"
    for row in df_analytics.values
])


# Combine All SQL
full_sql = (
    sql_create_users + "\n" +
    sql_create_diet_plans + "\n" +
    sql_create_user_diet_plans + "\n" +
    sql_create_konsultasi + "\n" +
    sql_create_food_items + "\n" +
    sql_create_diet_logs + "\n" +
    sql_create_products + "\n" +
    sql_create_orders + "\n" +
    sql_create_order_items + "\n" +
    sql_create_admin_users + "\n" +
    sql_create_user_analytics + "\n\n" +

    sql_insert_users + "\n\n" +
    sql_insert_diet_plans + "\n\n" +
    sql_insert_user_diet_plans + "\n\n" +
    sql_insert_konsultasi + "\n\n" +
    sql_insert_food_items + "\n\n" +
    sql_insert_diet_logs + "\n\n" +
    sql_insert_products + "\n\n" +
    sql_insert_orders + "\n\n" +
    sql_insert_order_items + "\n\n" +
    sql_insert_admin_users + "\n\n" +
    sql_insert_user_analytics
)

# Save to .sql file
output_path = "db_nutrivit.sql"
with open(output_path, "w", encoding="utf-8") as f:
    f.write(full_sql)

print("Berhasil dibuat: db_nutrivit.sql")