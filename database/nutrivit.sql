-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 08, 2025 at 11:47 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nutrivit`
--

-- --------------------------------------------------------

--
-- Table structure for table `ai_consultations`
--

CREATE TABLE `ai_consultations` (
  `id` int(11) NOT NULL,
  `user_id` varchar(10) DEFAULT NULL,
  `consultation_type` enum('nutrition','fitness','supplement','general') DEFAULT 'general',
  `question` text NOT NULL,
  `ai_response` text DEFAULT NULL,
  `consultation_duration` int(255) NOT NULL,
  `satisfaction_rating` decimal(2,1) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ai_consultations`
--

INSERT INTO `ai_consultations` (`id`, `user_id`, `consultation_type`, `question`, `ai_response`, `consultation_duration`, `satisfaction_rating`, `created_at`) VALUES
(1, 'USR001', 'nutrition', 'Bagaimana cara meningkatkan protein intake?', 'Anda bisa menambah konsumsi daging tanpa lemak, telur, dan whey protein. Target 1.6-2.2g protein per kg berat badan.', 0, 4.5, '2025-06-24 17:18:32'),
(2, 'USR002', 'fitness', 'Program latihan untuk pemula?', 'Mulai dengan 3x seminggu, kombinasi cardio dan strength training. Fokus pada form yang benar.', 0, 4.8, '2025-06-24 17:18:32'),
(3, 'USR004', 'supplement', 'Suplemen apa yang cocok untuk pencernaan?', 'Probiotik dan digestive enzymes bisa membantu. Konsultasikan dengan dokter jika masalah berlanjut.', 0, 4.2, '2025-06-24 17:18:32'),
(4, 'USR005', 'nutrition', 'Meal prep untuk bulking?', 'Siapkan makanan tinggi kalori: nasi, ayam, sayuran, dan protein shake. Makan setiap 3 jam.', 0, 4.6, '2025-06-24 17:18:32'),
(5, 'USR001', 'general', 'Tips menjaga konsistensi diet?', 'Buat jadwal makan teratur, meal prep di weekend, dan track progress harian.', 0, 4.3, '2025-06-24 17:18:32');

-- --------------------------------------------------------

--
-- Table structure for table `nutrition_achievements`
--

CREATE TABLE `nutrition_achievements` (
  `id` int(11) NOT NULL,
  `user_id` varchar(10) DEFAULT NULL,
  `date` date NOT NULL,
  `calories_target` int(11) DEFAULT 2000,
  `calories_achieved` int(11) DEFAULT 0,
  `protein_target` decimal(5,2) DEFAULT 50.00,
  `protein_achieved` decimal(5,2) DEFAULT 0.00,
  `carbs_target` decimal(5,2) DEFAULT 250.00,
  `carbs_achieved` decimal(5,2) DEFAULT 0.00,
  `fat_target` decimal(5,2) DEFAULT 70.00,
  `fat_achieved` decimal(5,2) DEFAULT 0.00,
  `percentage_achieved` decimal(5,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nutrition_achievements`
--

INSERT INTO `nutrition_achievements` (`id`, `user_id`, `date`, `calories_target`, `calories_achieved`, `protein_target`, `protein_achieved`, `carbs_target`, `carbs_achieved`, `fat_target`, `fat_achieved`, `percentage_achieved`, `created_at`) VALUES
(1, 'USR001', '2024-06-24', 2200, 2150, 120.00, 115.00, 220.00, 210.00, 75.00, 70.00, 85.20, '2025-06-24 17:18:32'),
(2, 'USR001', '2024-06-23', 2200, 1980, 120.00, 110.00, 220.00, 200.00, 75.00, 65.00, 78.50, '2025-06-24 17:18:32'),
(3, 'USR002', '2024-06-24', 1800, 1750, 80.00, 85.00, 180.00, 175.00, 60.00, 58.00, 92.10, '2025-06-24 17:18:32'),
(4, 'USR002', '2024-06-23', 1800, 1620, 80.00, 75.00, 180.00, 160.00, 60.00, 55.00, 86.70, '2025-06-24 17:18:32'),
(5, 'USR004', '2024-06-24', 1900, 1456, 90.00, 68.00, 190.00, 145.00, 65.00, 48.00, 67.80, '2025-06-24 17:18:32'),
(6, 'USR005', '2024-06-24', 2400, 2280, 140.00, 138.00, 240.00, 235.00, 80.00, 78.00, 89.30, '2025-06-24 17:18:32'),
(7, 'USR001', '2025-01-10', 2200, 2100, 120.00, 110.00, 220.00, 205.00, 75.00, 70.00, 80.50, '2025-07-08 07:57:31'),
(8, 'USR002', '2025-01-15', 1800, 1700, 80.00, 76.00, 180.00, 168.00, 60.00, 57.00, 82.10, '2025-07-08 07:57:31'),
(9, 'USR001', '2025-02-12', 2200, 2150, 120.00, 115.00, 220.00, 210.00, 75.00, 72.00, 86.00, '2025-07-08 07:57:31'),
(10, 'USR002', '2025-02-18', 1800, 1720, 80.00, 78.00, 180.00, 174.00, 60.00, 59.00, 88.20, '2025-07-08 07:57:31'),
(11, 'USR001', '2025-03-08', 2200, 2180, 120.00, 118.00, 220.00, 215.00, 75.00, 74.00, 89.30, '2025-07-08 07:57:31'),
(12, 'USR002', '2025-03-22', 1800, 1780, 80.00, 80.00, 180.00, 179.00, 60.00, 60.00, 91.80, '2025-07-08 07:57:31'),
(13, 'USR001', '2025-04-05', 2200, 2080, 120.00, 109.00, 220.00, 200.00, 75.00, 68.00, 81.60, '2025-07-08 07:57:31'),
(14, 'USR002', '2025-04-28', 1800, 1700, 80.00, 74.00, 180.00, 165.00, 60.00, 55.00, 79.40, '2025-07-08 07:57:31'),
(15, 'USR001', '2025-05-03', 2200, 2120, 120.00, 113.00, 220.00, 208.00, 75.00, 71.00, 84.70, '2025-07-08 07:57:31'),
(16, 'USR002', '2025-05-25', 1800, 1750, 80.00, 78.00, 180.00, 172.00, 60.00, 58.00, 87.90, '2025-07-08 07:57:31');

-- --------------------------------------------------------

--
-- Table structure for table `nutrition_needs`
--

CREATE TABLE `nutrition_needs` (
  `id` int(11) NOT NULL,
  `month` varchar(10) NOT NULL,
  `protein_kg` decimal(10,2) DEFAULT 0.00,
  `carbs_kg` decimal(10,2) DEFAULT 0.00,
  `fat_kg` decimal(10,2) DEFAULT 0.00,
  `vitamin_iu` decimal(10,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nutrition_needs`
--

INSERT INTO `nutrition_needs` (`id`, `month`, `protein_kg`, `carbs_kg`, `fat_kg`, `vitamin_iu`, `created_at`) VALUES
(1, 'Jan', 480.00, 375.00, 570.00, 525.00, '2025-07-08 08:00:03'),
(2, 'Feb', 450.00, 330.00, 525.00, 480.00, '2025-07-08 08:00:03'),
(3, 'Mar', 405.00, 300.00, 480.00, 450.00, '2025-07-08 08:00:03'),
(4, 'Apr', 375.00, 270.00, 450.00, 420.00, '2025-07-08 08:00:03'),
(5, 'May', 330.00, 225.00, 405.00, 375.00, '2025-07-08 08:00:03'),
(6, 'Jun', 300.00, 195.00, 375.00, 345.00, '2025-07-08 08:00:03');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `order_number` varchar(20) NOT NULL,
  `user_id` varchar(10) DEFAULT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `status` enum('pending','paid','shipped','delivered','cancelled') DEFAULT 'pending',
  `payment_method` varchar(50) DEFAULT NULL,
  `shipping_address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `order_number`, `user_id`, `total_amount`, `status`, `payment_method`, `shipping_address`, `created_at`) VALUES
(1, 'ORD20240624001', 'USR001', 424000.00, 'delivered', 'credit_card', NULL, '2025-06-24 17:18:32'),
(2, 'ORD20240624002', 'USR002', 250000.00, 'delivered', 'bank_transfer', NULL, '2025-06-24 17:18:32'),
(3, 'ORD20240623001', 'USR001', 185000.00, 'delivered', 'e_wallet', NULL, '2025-06-24 17:18:32'),
(4, 'ORD20240623002', 'USR004', 370000.00, 'shipped', 'credit_card', NULL, '2025-06-24 17:18:32'),
(5, 'ORD20240622001', 'USR005', 299000.00, 'delivered', 'bank_transfer', NULL, '2025-06-24 17:18:32'),
(6, 'ORD20240622002', 'USR002', 125000.00, 'delivered', 'e_wallet', NULL, '2025-06-24 17:18:32');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` varchar(10) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `total_price` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `unit_price`, `total_price`) VALUES
(1, 1, 'PRD001', 1, 299000.00, 299000.00),
(2, 1, 'PRD002', 1, 125000.00, 125000.00),
(3, 2, 'PRD004', 2, 75000.00, 150000.00),
(4, 2, 'PRD005', 1, 95000.00, 95000.00),
(5, 3, 'PRD003', 1, 185000.00, 185000.00),
(6, 4, 'PRD001', 1, 299000.00, 299000.00),
(7, 4, 'PRD006', 1, 150000.00, 150000.00),
(8, 5, 'PRD001', 1, 299000.00, 299000.00),
(9, 6, 'PRD002', 1, 125000.00, 125000.00),
(10, 2, 'PRD002', 2, 125000.00, 250000.00),
(11, 2, 'PRD005', 1, 95000.00, 95000.00),
(12, 4, 'PRD006', 1, 150000.00, 150000.00),
(13, 4, 'PRD003', 1, 185000.00, 185000.00),
(14, 5, 'PRD007', 2, 220000.00, 440000.00),
(15, 6, 'PRD004', 3, 75000.00, 225000.00),
(16, 6, 'PRD008', 2, 180000.00, 360000.00);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` varchar(10) NOT NULL,
  `name` varchar(200) NOT NULL,
  `category` enum('supplement','protein','vitamin','herbal','organic') NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(12,2) NOT NULL,
  `stock` int(11) DEFAULT 0,
  `image_url` varchar(500) DEFAULT NULL,
  `product_status` enum('Active','Inactive') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `category`, `description`, `price`, `stock`, `image_url`, `product_status`, `created_at`, `updated_at`) VALUES
('PRD001', 'Whey Protein Premium', 'protein', 'High-quality whey protein for muscle building', 299000.00, 45, NULL, 'Active', '2025-06-24 17:18:32', '2025-06-24 17:18:32'),
('PRD002', 'Vitamin C 1000mg', 'vitamin', 'Immune system booster vitamin C tablets', 125000.00, 18, NULL, 'Active', '2025-06-24 17:18:32', '2025-07-03 19:18:09'),
('PRD003', 'Omega-3 Fish Oil', 'supplement', 'Pure fish oil for heart and brain health', 185000.00, 32, NULL, 'Active', '2025-06-24 17:18:32', '2025-06-24 17:18:32'),
('PRD004', 'Multivitamin Complex', 'vitamin', 'Complete daily vitamin and mineral supplement', 75000.00, 67, NULL, 'Active', '2025-06-24 17:18:32', '2025-06-24 17:18:32'),
('PRD005', 'Herbal Detox Tea', 'herbal', 'Natural detox tea blend for cleansing', 95000.00, 89, NULL, 'Active', '2025-06-24 17:18:32', '2025-06-24 17:18:32'),
('PRD006', 'Creatine Monohydrate', 'supplement', 'Pure creatine for strength and power', 150000.00, 56, NULL, 'Active', '2025-06-24 17:18:32', '2025-06-24 17:18:32'),
('PRD007', 'Collagen Peptides', 'supplement', 'Anti-aging collagen supplement', 220000.00, 34, NULL, 'Active', '2025-06-24 17:18:32', '2025-06-24 17:18:32'),
('PRD008', 'Organic Spirulina', 'organic', 'Superfood spirulina powder', 180000.00, 42, NULL, 'Active', '2025-06-24 17:18:32', '2025-06-24 17:18:32');

-- --------------------------------------------------------

--
-- Table structure for table `product_reviews`
--

CREATE TABLE `product_reviews` (
  `id` int(11) NOT NULL,
  `user_id` varchar(10) DEFAULT NULL,
  `product_id` varchar(10) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `rating` decimal(2,1) DEFAULT NULL CHECK (`rating` >= 1.0 and `rating` <= 5.0),
  `review_text` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_reviews`
--

INSERT INTO `product_reviews` (`id`, `user_id`, `product_id`, `order_id`, `rating`, `review_text`, `created_at`) VALUES
(1, 'USR001', 'PRD001', 1, 4.5, 'Protein yang bagus, mudah larut dan rasanya enak', '2025-06-24 17:18:32'),
(2, 'USR001', 'PRD002', 1, 4.8, 'Vitamin C terbaik yang pernah saya coba', '2025-06-24 17:18:32'),
(3, 'USR002', 'PRD004', 2, 4.2, 'Multivitamin lengkap, cocok untuk daily supplement', '2025-06-24 17:18:32'),
(4, 'USR002', 'PRD005', 2, 4.0, 'Teh detox yang menyegarkan', '2025-06-24 17:18:32'),
(5, 'USR001', 'PRD003', 3, 4.7, 'Omega-3 berkualitas tinggi', '2025-06-24 17:18:32'),
(6, 'USR005', 'PRD001', 5, 4.9, 'Hasil terbaik untuk muscle building', '2025-06-24 17:18:32');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(11) NOT NULL,
  `product_id` varchar(30) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `total_price` decimal(12,2) DEFAULT NULL,
  `sale_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `product_id`, `quantity`, `total_price`, `sale_date`) VALUES
(13, 'NUV-C-1000', 20, 2500000.00, '2025-01-05'),
(14, 'NUV-WHY-1KG', 8, 2720000.00, '2025-01-18'),
(15, 'NUV-MUL-90', 15, 2475000.00, '2025-02-11'),
(16, 'NUV-OMG-500', 12, 2160000.00, '2025-02-27'),
(17, 'NUV-CUR-250', 25, 2375000.00, '2025-03-09'),
(18, 'NUV-C-1000', 18, 2250000.00, '2025-03-19'),
(19, 'NUV-MUL-90', 30, 4950000.00, '2025-04-02'),
(20, 'NUV-WHY-1KG', 10, 3400000.00, '2025-04-22'),
(21, 'NUV-OMG-500', 20, 3600000.00, '2025-05-08'),
(22, 'NUV-CUR-250', 18, 1710000.00, '2025-05-25'),
(23, 'NUV-C-1000', 22, 2750000.00, '2025-06-04'),
(24, 'NUV-MUL-90', 35, 5775000.00, '2025-06-29');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `gender` enum('male','female') DEFAULT 'male',
  `age` int(11) DEFAULT NULL,
  `weight` decimal(5,2) DEFAULT NULL,
  `height` decimal(5,2) DEFAULT NULL,
  `member_type` enum('Premium','Reguler') NOT NULL,
  `status` enum('active','inactive','pending') DEFAULT 'active',
  `konsultasi_status` enum('active','inactive','pending') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `joining_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `phone`, `gender`, `age`, `weight`, `height`, `member_type`, `status`, `konsultasi_status`, `created_at`, `joining_date`) VALUES
('USR001', 'Andi Pratama', 'andi@email.com', '', '081234567801', 'male', 28, 70.50, 175.00, 'Premium', 'active', 'active', '2025-06-24 17:18:32', '2025-07-04 13:01:57'),
('USR002', 'Sari Dewi', 'sari@email.com', '', '081234567802', 'female', 25, 55.00, 160.00, 'Premium', 'active', 'inactive', '2025-06-24 17:18:32', '2025-07-04 13:01:57'),
('USR003', 'Budi Santoso', 'budi@email.com', '', '081234567803', 'male', 35, 80.00, 170.00, 'Premium', 'inactive', 'active', '2025-06-24 17:18:32', '2025-07-04 13:01:57'),
('USR004', 'Maya Lestari', 'maya@email.com', '', '081234567804', 'female', 30, 60.00, 165.00, 'Premium', 'active', 'pending', '2025-06-24 17:18:32', '2025-06-24 17:18:32'),
('USR005', 'Rudi Hermawan', 'rudi@email.com', '', '081234567805', 'male', 32, 75.00, 178.00, 'Premium', 'active', 'active', '2025-06-24 17:18:32', '2025-07-04 13:01:57'),
('USR006', 'Lila Sari', 'lila@email.com', '', '081234567806', 'female', 27, 52.00, 158.00, 'Premium', 'active', 'inactive', '2025-06-24 17:18:32', '2025-07-04 13:01:57'),
('USR007', 'Ahmad Fauzi', 'ahmad@email.com', '', '081234567807', 'male', 29, 68.00, 172.00, 'Premium', 'active', 'pending', '2025-06-24 17:18:32', '2025-06-24 17:18:32'),
('USR008', 'Rina Wati', 'rina@email.com', '', '081234567808', 'female', 26, 58.00, 162.00, 'Premium', 'pending', 'pending', '2025-06-24 17:18:32', '2025-06-24 17:18:32');

-- --------------------------------------------------------

--
-- Table structure for table `user_complaints`
--

CREATE TABLE `user_complaints` (
  `id` int(11) NOT NULL,
  `user_id` varchar(10) DEFAULT NULL,
  `complaint_type` enum('energy','weight','digestion','immunity','sleep','other') NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('open','resolved','pending') DEFAULT 'open',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_complaints`
--

INSERT INTO `user_complaints` (`id`, `user_id`, `complaint_type`, `description`, `status`, `created_at`) VALUES
(1, 'USR001', 'energy', 'Merasa lelah setelah workout', 'resolved', '2025-06-24 17:18:32'),
(2, 'USR001', 'weight', 'Sulit menurunkan berat badan', 'open', '2025-06-24 17:18:32'),
(3, 'USR002', 'immunity', 'Sering sakit flu', 'resolved', '2025-06-24 17:18:32'),
(4, 'USR004', 'digestion', 'Masalah pencernaan setelah makan', 'pending', '2025-06-24 17:18:32'),
(5, 'USR004', 'sleep', 'Susah tidur malam hari', 'open', '2025-06-24 17:18:32'),
(6, 'USR004', 'energy', 'Energi drop di sore hari', 'resolved', '2025-06-24 17:18:32'),
(7, 'USR005', 'weight', 'Ingin menambah massa otot', 'open', '2025-06-24 17:18:32');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ai_consultations`
--
ALTER TABLE `ai_consultations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_consultations_user` (`user_id`);

--
-- Indexes for table `nutrition_achievements`
--
ALTER TABLE `nutrition_achievements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_date` (`user_id`,`date`),
  ADD KEY `idx_nutrition_user_date` (`user_id`,`date`);

--
-- Indexes for table `nutrition_needs`
--
ALTER TABLE `nutrition_needs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `idx_orders_user_status` (`user_id`,`status`),
  ADD KEY `idx_orders_created_at` (`created_at`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_products_category` (`category`);

--
-- Indexes for table `product_reviews`
--
ALTER TABLE `product_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `idx_reviews_product` (`product_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_users_status` (`status`),
  ADD KEY `idx_users_created_at` (`created_at`);

--
-- Indexes for table `user_complaints`
--
ALTER TABLE `user_complaints`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_complaints_user_status` (`user_id`,`status`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ai_consultations`
--
ALTER TABLE `ai_consultations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `nutrition_achievements`
--
ALTER TABLE `nutrition_achievements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `nutrition_needs`
--
ALTER TABLE `nutrition_needs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `product_reviews`
--
ALTER TABLE `product_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `user_complaints`
--
ALTER TABLE `user_complaints`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ai_consultations`
--
ALTER TABLE `ai_consultations`
  ADD CONSTRAINT `ai_consultations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `nutrition_achievements`
--
ALTER TABLE `nutrition_achievements`
  ADD CONSTRAINT `nutrition_achievements_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_reviews`
--
ALTER TABLE `product_reviews`
  ADD CONSTRAINT `product_reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_reviews_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_reviews_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_complaints`
--
ALTER TABLE `user_complaints`
  ADD CONSTRAINT `user_complaints_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
