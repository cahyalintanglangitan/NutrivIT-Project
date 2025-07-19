-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 19, 2025 at 09:30 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

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
(0, 'USR193', '', 'Saya sering merasa grogi sebelum tampil. Adakah makanan yang bisa membantu menenangkan?', 'Makanan yang kaya magnesium seperti pisang dan dark chocolate dapat membantu menenangkan sistem saraf. Teh hijau mengandung L-theanine yang juga memiliki efek menenangkan tanpa menyebabkan kantuk.', 110, 4.9, '2025-07-20 04:30:00'),
(1, 'USR001', 'nutrition', 'Bagaimana cara meningkatkan protein intake?', 'Anda bisa menambah konsumsi daging tanpa lemak, telur, dan whey protein. Target 1.6-2.2g protein per kg berat badan.', 65, 4.5, '2025-06-24 17:18:32'),
(2, 'USR002', 'fitness', 'Program latihan untuk pemula?', 'Mulai dengan 3x seminggu, kombinasi cardio dan strength training. Fokus pada form yang benar.', 80, 4.8, '2025-06-24 18:20:11'),
(3, 'USR004', 'supplement', 'Suplemen apa yang cocok untuk pencernaan?', 'Probiotik dan digestive enzymes bisa membantu. Konsultasikan dengan dokter jika masalah berlanjut.', 58, 4.2, '2025-06-24 19:05:43'),
(4, 'USR005', 'nutrition', 'Meal prep untuk bulking?', 'Siapkan makanan tinggi kalori: nasi, ayam, sayuran, dan protein shake. Makan setiap 3 jam.', 95, 4.6, '2025-06-24 20:15:00'),
(5, 'USR001', 'general', 'Tips menjaga konsistensi diet?', 'Buat jadwal makan teratur, meal prep di weekend, dan track progress harian.', 72, 4.3, '2025-06-24 21:00:15'),
(6, 'USR007', 'fitness', 'Latihan apa yang aman untuk memperkuat lutut?', 'Fokus pada latihan low-impact seperti berenang, bersepeda, dan latihan penguatan paha seperti leg extensions dan wall sits. Hindari squat terlalu dalam.', 55, 4.7, '2025-06-25 10:00:00'),
(7, 'USR010', 'nutrition', 'Saya ingin menaikkan berat badan, makanan apa yang bagus?', 'Tingkatkan asupan kalori sehat. Konsumsi alpukat, kacang-kacangan, nasi merah, dan daging. Tambahkan 1-2 porsi camilan sehat di antara waktu makan.', 72, 4.9, '2025-06-26 11:30:00'),
(8, 'USR012', 'nutrition', 'Bagaimana cara mengatasi perut kembung?', 'Kurangi makanan yang menghasilkan gas seperti brokoli dan kacang-kacangan. Minum teh jahe dan pastikan Anda makan secara perlahan.', 60, 4.4, '2025-06-28 17:00:00'),
(9, 'USR015', 'general', 'Tips untuk tidur lebih nyenyak?', 'Ciptakan rutinitas tidur: hindari kafein di sore hari, matikan gadget 1 jam sebelum tidur, dan pastikan kamar Anda gelap dan sejuk.', 85, 4.8, '2025-07-01 22:30:00'),
(10, 'USR016', 'fitness', 'Program latihan untuk usia 40-an?', 'Fokus pada kombinasi latihan kardio (jalan cepat, jogging), latihan kekuatan 2-3x seminggu untuk menjaga massa otot, dan latihan fleksibilitas seperti yoga.', 95, 4.6, '2025-07-02 08:00:00'),
(11, 'USR022', 'fitness', 'Bagaimana cara menghilangkan lemak perut?', 'Tidak ada cara instan. Kombinasikan defisit kalori, latihan kardio (HIIT), dan latihan kekuatan yang menargetkan seluruh tubuh, bukan hanya perut.', 110, 4.5, '2025-07-08 16:00:00'),
(12, 'USR023', 'supplement', 'Apakah kolagen benar-benar efektif untuk kulit?', 'Kolagen dapat membantu meningkatkan hidrasi dan elastisitas kulit. Pilih suplemen kolagen terhidrolisis untuk penyerapan yang lebih baik.', 65, 4.1, '2025-07-09 11:00:00'),
(13, 'USR029', 'fitness', 'Jadwal latihan untuk orang yang sangat sibuk?', 'Coba metode 15-20 menit HIIT (High-Intensity Interval Training) 3-4 kali seminggu. Sangat efisien untuk membakar kalori dalam waktu singkat.', 78, 4.7, '2025-07-15 12:00:00'),
(14, 'USR032', 'nutrition', 'Resep sarapan sehat di bawah 5 menit?', 'Coba overnight oats (oat, susu, chia seed, buah), atau smoothie (bayam, pisang, protein powder, susu almond). Keduanya bisa disiapkan malam sebelumnya.', 88, 5.0, '2025-07-18 07:30:00'),
(15, 'USR036', 'general', 'Cara mengatasi keinginan makan makanan manis?', 'Coba ganti dengan buah-buahan, minum air putih yang cukup, atau konsumsi dark chocolate (min. 70%). Pastikan asupan protein Anda cukup agar kenyang lebih lama.', 93, 4.6, '2025-07-22 21:00:00'),
(16, 'USR039', 'supplement', 'Kapan waktu terbaik minum creatine?', 'Anda bisa meminumnya kapan saja, tetapi banyak yang memilih setelah latihan bersama protein shake untuk memaksimalkan penyerapan. Konsistensi setiap hari adalah kunci.', 45, 4.8, '2025-07-25 11:00:00'),
(17, 'USR043', 'fitness', 'Program bulking yang benar itu seperti apa?', 'Fokus pada surplus kalori (sekitar 300-500 kkal di atas kebutuhan harian), latihan angkat beban progresif dengan menargetkan semua grup otot besar, dan istirahat yang cukup.', 120, 4.9, '2025-07-29 10:00:00'),
(18, 'USR046', 'nutrition', 'Makanan apa yang bagus untuk kesehatan rambut?', 'Pastikan asupan Biotin (telur, kacang), Zat Besi (bayam, daging merah), dan Protein cukup. Salmon yang kaya Omega-3 juga sangat baik.', 70, 4.7, '2025-08-01 14:00:00'),
(19, 'USR051', 'general', 'Bagaimana cara mengurangi sakit pinggang karena kelamaan duduk?', 'Lakukan peregangan setiap jam, gunakan kursi yang ergonomis, dan perkuat otot inti (core) dengan latihan seperti plank dan bird-dog.', 80, 4.5, '2025-08-06 10:30:00'),
(20, 'USR056', 'fitness', 'Pemanasan sebelum lari yang efektif?', 'Lakukan dynamic stretching selama 5-10 menit. Contohnya: high knees, butt kicks, leg swings, dan torso twists. Hindari peregangan statis sebelum lari.', 62, 4.8, '2025-08-11 17:00:00'),
(21, 'USR063', 'nutrition', 'Perbedaan whey protein concentrate dan isolate?', 'Isolate memiliki kandungan protein lebih tinggi (>90%) dan lebih sedikit laktosa & lemak dibandingkan Concentrate. Isolate cocok untuk Anda yang intoleran laktosa.', 98, 4.9, '2025-08-18 12:30:00'),
(22, 'USR064', 'general', 'Bagaimana cara memulai kebiasaan meditasi?', 'Mulai dari 5 menit setiap hari. Gunakan aplikasi pemandu meditasi. Fokus pada napas Anda dan jangan khawatir jika pikiran Anda berkelana, itu normal.', 75, 4.6, '2025-08-19 08:00:00'),
(23, 'USR070', 'supplement', 'Apakah saya perlu BCAA?', 'BCAA dapat membantu mengurangi nyeri otot setelah latihan. Namun, jika asupan protein harian Anda sudah cukup dari makanan atau whey protein, manfaat tambahan BCAA mungkin tidak signifikan.', 81, 4.3, '2025-08-25 18:00:00'),
(24, 'USR073', 'nutrition', 'Minuman sehat pengganti kopi untuk energi pagi?', 'Coba teh hijau matcha, yang mengandung L-theanine untuk fokus tanpa gelisah. Air lemon hangat juga bisa membantu menyegarkan tubuh.', 68, 4.7, '2025-08-28 07:45:00'),
(25, 'USR080', 'fitness', 'Latihan untuk mengencangkan lengan tanpa membuatnya besar?', 'Gunakan beban ringan dengan repetisi tinggi (15-20 reps). Lakukan latihan seperti tricep dips, bicep curls, dan push-up. Fokus pada definisi otot, bukan massa.', 90, 4.8, '2025-09-04 11:00:00'),
(26, 'USR088', 'nutrition', 'Tips makan sehat dengan budget terbatas?', 'Beli bahan makanan lokal dan musiman, masak sendiri di rumah, manfaatkan protein nabati seperti tempe dan tahu, dan rencanakan menu mingguan untuk menghindari pemborosan.', 105, 4.9, '2025-09-12 10:00:00'),
(27, 'USR091', 'general', 'Cara mengukur progress selain dari timbangan?', 'Ukur lingkar tubuh (pinggang, pinggul, lengan), ambil foto progress setiap 2-4 minggu, perhatikan bagaimana pakaian Anda terasa lebih longgar, dan catat peningkatan kekuatan Anda di gym.', 115, 5.0, '2025-09-15 09:00:00'),
(28, 'USR097', 'fitness', 'Seberapa penting istirahat dalam program fitness?', 'Sangat penting. Istirahat adalah saat otot Anda memperbaiki diri dan tumbuh (recovery). Kurang istirahat dapat menyebabkan overtraining, cedera, dan penurunan performa.', 77, 4.8, '2025-09-21 14:30:00'),
(29, 'USR098', 'nutrition', 'Bagaimana diet yang aman setelah melahirkan?', 'Fokus pada makanan padat nutrisi, bukan pembatasan kalori yang ekstrem. Pastikan asupan zat besi, kalsium, dan protein cukup. Minum banyak air, terutama jika menyusui. Konsultasikan dengan dokter atau ahli gizi.', 125, 4.9, '2025-09-22 11:15:00'),
(30, 'USR100', 'general', 'Bagaimana cara tetap termotivasi untuk olahraga?', 'Cari teman olahraga, buat playlist musik yang membangkitkan semangat, tetapkan tujuan yang realistis, dan beri diri Anda hadiah kecil saat mencapai target. Ingat alasan Anda memulai!', 95, 4.7, '2025-09-24 13:30:00'),
(31, 'USR003', 'fitness', 'Latihan di rumah tanpa alat apa saja?', 'Anda bisa melakukan push-up, squat, lunges, plank, dan burpees. Variasikan intensitas dan repetisi untuk menantang diri sendiri.', 85, 4.5, '2025-09-25 19:00:00'),
(32, 'USR006', 'supplement', 'Suplemen untuk membantu tidur?', 'Melatonin adalah suplemen yang umum digunakan untuk mengatur siklus tidur. Magnesium dan teh chamomile juga dapat membantu relaksasi.', 65, 4.6, '2025-09-26 22:00:00'),
(33, 'USR008', 'nutrition', 'Makanan apa yang harus dihindari jika sering pusing?', 'Kurangi asupan kafein, alkohol, dan makanan tinggi garam (natrium). Pastikan Anda terhidrasi dengan baik sepanjang hari.', 70, 4.3, '2025-09-27 09:30:00'),
(34, 'USR011', 'general', 'Cara mengatasi nyeri otot setelah olahraga (DOMS)?', 'Lakukan peregangan ringan, mandi air hangat, pijat lembut, dan pastikan asupan protein cukup untuk membantu pemulihan otot. Istirahat yang cukup juga kunci.', 90, 4.8, '2025-09-28 10:00:00'),
(35, 'USR013', 'fitness', 'Berapa repetisi dan set yang ideal untuk membangun otot?', 'Umumnya, 3-5 set dengan 8-12 repetisi per latihan adalah rentang yang baik untuk hipertrofi (pembesaran otot). Pastikan Anda mencapai kegagalan otot pada set terakhir.', 100, 4.9, '2025-09-29 11:00:00'),
(36, 'USR014', 'nutrition', 'Apakah diet keto aman untuk jangka panjang?', 'Diet keto bisa efektif untuk penurunan berat badan jangka pendek. Untuk jangka panjang, ada beberapa kekhawatiran terkait kesehatan jantung dan ginjal. Sebaiknya dilakukan di bawah pengawasan ahli gizi.', 110, 4.1, '2025-09-30 12:00:00'),
(37, 'USR017', 'supplement', 'Vitamin apa yang penting untuk imunitas?', 'Vitamin C, Vitamin D, dan Zinc adalah tiga nutrisi kunci untuk mendukung sistem kekebalan tubuh. Anda bisa mendapatkannya dari makanan atau suplemen.', 60, 4.7, '2025-10-01 13:00:00'),
(38, 'USR018', 'general', 'Bagaimana cara mengurangi stres?', 'Coba teknik pernapasan dalam, olahraga teratur, meditasi, atau melakukan hobi yang Anda nikmati. Mengelola stres sama pentingnya dengan diet dan olahraga.', 88, 4.6, '2025-10-02 14:00:00'),
(39, 'USR019', 'fitness', 'Lebih baik kardio sebelum atau sesudah angkat beban?', 'Jika tujuan utama Anda adalah membangun kekuatan/otot, lakukan angkat beban terlebih dahulu saat energi Anda masih penuh. Lakukan kardio setelahnya.', 75, 4.8, '2025-10-03 15:00:00'),
(40, 'USR020', 'nutrition', 'Cara membaca label nutrisi pada kemasan makanan?', 'Perhatikan ukuran saji (serving size), jumlah kalori, dan makronutrien (lemak, karbohidrat, protein). Hindari produk dengan gula tambahan dan lemak trans yang tinggi.', 95, 4.9, '2025-10-04 16:00:00'),
(41, 'USR021', 'supplement', 'Apakah fat burner efektif?', 'Fat burner dapat sedikit meningkatkan metabolisme, tetapi tidak akan bekerja tanpa diimbangi dengan diet defisit kalori dan olahraga. Efeknya seringkali minimal.', 80, 3.9, '2025-10-05 17:00:00'),
(42, 'USR024', 'fitness', 'Seberapa sering saya harus mengganti program latihan?', 'Ganti program latihan Anda setiap 4-6 minggu untuk menghindari plateau dan memberikan stimulus baru bagi otot Anda.', 70, 4.5, '2025-10-06 18:00:00'),
(43, 'USR025', 'general', 'Bagaimana cara minum air yang cukup setiap hari?', 'Bawa botol minum ke mana pun Anda pergi, atur pengingat di ponsel, dan tambahkan irisan lemon atau mentimun untuk rasa.', 65, 4.6, '2025-10-07 19:00:00'),
(44, 'USR026', 'nutrition', 'Saya sering makan karena stres, bagaimana mengatasinya?', 'Kenali pemicu stres Anda. Saat keinginan makan muncul, coba alihkan dengan aktivitas lain seperti berjalan kaki, mendengarkan musik, atau berbicara dengan teman.', 92, 4.7, '2025-10-08 20:00:00'),
(45, 'USR027', 'fitness', 'Latihan terbaik untuk membentuk bokong?', 'Fokus pada latihan seperti hip thrust, glute bridge, Romanian deadlift, dan berbagai variasi squat dan lunges.', 85, 4.8, '2025-10-09 21:00:00'),
(46, 'USR028', 'supplement', 'Perlukah saya mengonsumsi multivitamin?', 'Jika diet Anda sudah seimbang dan beragam dengan banyak buah dan sayur, mungkin tidak perlu. Multivitamin bisa bermanfaat jika asupan nutrisi dari makanan kurang.', 78, 4.2, '2025-10-10 22:00:00'),
(47, 'USR030', 'nutrition', 'Tips diet untuk ibu menyusui?', 'Jangan mengurangi kalori secara drastis. Fokus pada makanan kaya nutrisi seperti ikan salmon, sayuran hijau, dan biji-bijian utuh untuk mendukung produksi ASI dan pemulihan Anda.', 115, 4.9, '2025-10-11 08:00:00'),
(48, 'USR031', 'general', 'Bagaimana cara membangun kebiasaan baik?', 'Mulai dari hal kecil (misal: olahraga 10 menit), lakukan secara konsisten setiap hari, dan kaitkan dengan kebiasaan yang sudah ada (misal: olahraga setelah sikat gigi pagi).', 90, 4.8, '2025-10-12 09:00:00'),
(49, 'USR033', 'fitness', 'Apa itu progressive overload?', 'Itu adalah prinsip dasar latihan kekuatan di mana Anda secara bertahap meningkatkan beban, repetisi, atau set dari waktu ke waktu untuk terus menantang otot dan mendorong pertumbuhan.', 105, 5.0, '2025-10-13 10:00:00'),
(50, 'USR034', 'nutrition', 'Apakah intermittent fasting cocok untuk semua orang?', 'Tidak. Intermittent fasting mungkin tidak cocok untuk orang dengan riwayat gangguan makan, ibu hamil/menyusui, atau penderita diabetes tipe 1. Sebaiknya konsultasi dengan profesional kesehatan.', 98, 4.4, '2025-10-14 11:00:00'),
(51, 'USR035', 'supplement', 'Apa fungsi Omega-3?', 'Omega-3 adalah lemak sehat yang penting untuk kesehatan otak, jantung, dan sendi. Sumber terbaiknya adalah ikan berlemak seperti salmon dan sarden, atau suplemen minyak ikan.', 77, 4.7, '2025-10-15 12:00:00'),
(52, 'USR037', 'general', 'Bagaimana cara mengatasi plateau penurunan berat badan?', 'Coba variasikan rutinitas olahraga Anda, hitung ulang kebutuhan kalori Anda (mungkin sudah menurun), atau coba metode refeed day untuk meningkatkan metabolisme sementara.', 102, 4.6, '2025-10-16 13:00:00'),
(53, 'USR038', 'fitness', 'Manfaat yoga untuk kebugaran?', 'Yoga meningkatkan fleksibilitas, keseimbangan, kekuatan inti, dan dapat membantu mengurangi stres. Ini adalah pelengkap yang bagus untuk program latihan lainnya.', 85, 4.8, '2025-10-17 14:00:00'),
(54, 'USR040', 'nutrition', 'Apakah karbohidrat di malam hari membuat gemuk?', 'Tidak secara langsung. Total asupan kalori harianlah yang menentukan kenaikan atau penurunan berat badan, bukan waktu Anda makan karbohidrat.', 91, 4.7, '2025-10-18 15:00:00'),
(55, 'USR041', 'fitness', 'Latihan dada terbaik di rumah?', 'Berbagai variasi push-up (incline, decline, wide, diamond) sangat efektif untuk melatih dada tanpa memerlukan alat.', 79, 4.5, '2025-10-19 16:00:00'),
(56, 'USR042', 'supplement', 'Kapan saya harus minum protein shake?', 'Waktu paling populer adalah dalam 30-60 menit setelah latihan untuk pemulihan. Namun, Anda juga bisa meminumnya sebagai camilan atau untuk memenuhi target protein harian kapan saja.', 73, 4.6, '2025-10-20 17:00:00'),
(57, 'USR044', 'general', 'Pentingnya hari istirahat (rest day)?', 'Rest day sangat krusial. Ini memberi tubuh waktu untuk pulih, memperbaiki otot, dan mencegah kelelahan serta cedera. Jadwalkan 1-2 rest day per minggu.', 84, 4.9, '2025-10-21 18:00:00'),
(58, 'USR045', 'nutrition', 'Sumber protein nabati terbaik?', 'Tahu, tempe, edamame, lentil, buncis, dan quinoa adalah sumber protein nabati yang sangat baik.', 76, 4.8, '2025-10-22 19:00:00'),
(59, 'USR047', 'fitness', 'Bagaimana cara memulai lari untuk pemula?', 'Mulai dengan program lari/jalan. Contoh: lari 1 menit, jalan 2 menit, ulangi 5-8 kali. Tingkatkan durasi lari secara bertahap setiap minggu.', 93, 4.7, '2025-10-23 20:00:00'),
(60, 'USR048', 'supplement', 'Apakah teh hijau bisa membantu menurunkan berat badan?', 'Teh hijau mengandung antioksidan dan dapat sedikit meningkatkan metabolisme. Namun, efeknya kecil dan harus dikombinasikan dengan gaya hidup sehat secara keseluruhan.', 71, 4.2, '2025-10-24 21:00:00'),
(61, 'USR049', 'general', 'Bagaimana cara agar tidak mudah menyerah?', 'Tetapkan tujuan yang realistis dan terukur. Rayakan pencapaian kecil. Cari komunitas atau teman yang mendukung. Ingat, progres tidak selalu linear.', 99, 4.8, '2025-10-25 08:00:00'),
(62, 'USR050', 'nutrition', 'Apakah semua lemak itu jahat?', 'Tidak. Lemak tak jenuh (ditemukan pada alpukat, kacang-kacangan, minyak zaitun) sangat baik untuk kesehatan jantung. Yang perlu dibatasi adalah lemak jenuh dan lemak trans.', 87, 4.9, '2025-10-26 09:00:00'),
(63, 'USR052', 'fitness', 'Latihan untuk memperbaiki postur tubuh bungkuk?', 'Perkuat otot punggung atas dengan latihan seperti face pulls dan rows. Lakukan juga peregangan untuk otot dada yang kaku.', 94, 4.7, '2025-10-27 10:00:00'),
(64, 'USR053', 'supplement', 'Apa itu Ashwagandha?', 'Ashwagandha adalah ramuan adaptogenik yang dapat membantu tubuh mengelola stres dan menurunkan kadar kortisol. Beberapa penelitian juga menunjukkan manfaat untuk kekuatan dan kebugaran.', 82, 4.5, '2025-10-28 11:00:00'),
(65, 'USR054', 'general', 'Bagaimana cara tidur cepat?', 'Coba teknik pernapasan 4-7-8, hindari layar biru dari gadget, dan dengarkan musik yang menenangkan atau white noise.', 78, 4.6, '2025-10-29 12:00:00'),
(66, 'USR055', 'nutrition', 'Ide camilan sehat rendah kalori?', 'Apel dengan selai kacang, yogurt Yunani, segenggam almond, irisan mentimun, atau telur rebus adalah pilihan yang bagus.', 74, 4.8, '2025-10-30 13:00:00'),
(67, 'USR057', 'fitness', 'Seberapa sering saya harus melakukan kardio?', 'Untuk kesehatan umum, targetkan 150 menit kardio intensitas sedang atau 75 menit intensitas tinggi per minggu. Sesuaikan berdasarkan tujuan Anda (penurunan berat badan, dll).', 89, 4.7, '2025-10-31 14:00:00'),
(68, 'USR058', 'supplement', 'Manfaat Vitamin D?', 'Vitamin D penting untuk kesehatan tulang (membantu penyerapan kalsium), fungsi kekebalan tubuh, dan suasana hati. Banyak orang kekurangan vitamin ini, terutama yang jarang terpapar sinar matahari.', 81, 4.8, '2025-11-01 15:00:00'),
(69, 'USR059', 'general', 'Saya merasa lelah sepanjang waktu, apa solusinya?', 'Pastikan Anda tidur cukup (7-9 jam), terhidrasi dengan baik, dan makan makanan bergizi. Jika kelelahan berlanjut, konsultasikan dengan dokter untuk menyingkirkan kondisi medis lain.', 101, 4.6, '2025-11-02 16:00:00'),
(70, 'USR060', 'nutrition', 'Apakah jus buah itu sehat?', 'Jus buah seringkali tinggi gula dan rendah serat dibandingkan buah utuh. Lebih baik makan buahnya langsung untuk mendapatkan manfaat serat yang membuat kenyang.', 86, 4.3, '2025-11-03 17:00:00'),
(71, 'USR061', 'fitness', 'Apa itu Tabata?', 'Tabata adalah bentuk HIIT yang terdiri dari 20 detik latihan super intens diikuti oleh 10 detik istirahat, diulang 8 kali (total 4 menit). Sangat menantang dan efektif.', 77, 4.9, '2025-11-04 18:00:00'),
(72, 'USR062', 'supplement', 'Apakah saya butuh elektrolit saat berolahraga?', 'Jika Anda berolahraga intens lebih dari 60-90 menit atau banyak berkeringat, minuman elektrolit dapat membantu menggantikan natrium dan kalium yang hilang.', 83, 4.5, '2025-11-05 19:00:00'),
(73, 'USR065', 'general', 'Bagaimana cara berhenti ngemil di malam hari?', 'Pastikan makan malam Anda cukup mengenyangkan dengan protein dan serat. Sikat gigi setelah makan malam untuk memberi sinyal bahwa waktu makan sudah selesai.', 90, 4.7, '2025-11-06 20:00:00'),
(74, 'USR066', 'nutrition', 'Makanan apa yang harus dihindari saat mencoba menurunkan berat badan?', 'Batasi minuman manis (soda, jus kemasan), makanan olahan, gorengan, dan makanan ringan tinggi kalori yang rendah nutrisi.', 88, 4.6, '2025-11-07 21:00:00'),
(75, 'USR067', 'fitness', 'Latihan untuk pemula di gym?', 'Mulai dengan mesin (machine-based exercises) karena lebih mudah dipelajari dan lebih aman. Contoh: leg press, chest press machine, lat pulldown. Minta bantuan personal trainer untuk form yang benar.', 105, 4.8, '2025-11-08 08:00:00'),
(76, 'USR068', 'supplement', 'Apa bedanya probiotik dan prebiotik?', 'Probiotik adalah bakteri baik hidup. Prebiotik adalah serat yang menjadi makanan bagi bakteri baik tersebut. Keduanya penting untuk kesehatan usus.', 92, 4.9, '2025-11-09 09:00:00'),
(77, 'USR069', 'general', 'Saya tidak punya waktu untuk sarapan, ada solusi?', 'Siapkan smoothie pack di freezer. Pagi hari, tinggal blender dengan cairan (susu/air). Atau siapkan overnight oats. Keduanya sangat cepat dan praktis.', 85, 4.7, '2025-11-10 10:00:00'),
(78, 'USR071', 'nutrition', 'Bagaimana cara mengurangi asupan gula?', 'Baca label makanan untuk menemukan gula tersembunyi, ganti minuman manis dengan air putih atau teh tawar, dan kurangi gula dalam kopi/teh Anda secara bertahap.', 96, 4.6, '2025-11-11 11:00:00'),
(79, 'USR072', 'fitness', 'Manfaat pendinginan (cool down) setelah olahraga?', 'Pendinginan membantu detak jantung dan pernapasan kembali normal secara bertahap, serta dapat membantu mengurangi nyeri otot dan meningkatkan fleksibilitas.', 79, 4.8, '2025-11-12 12:00:00'),
(80, 'USR074', 'supplement', 'Apakah kafein dalam suplemen aman?', 'Dalam dosis sedang (hingga 400mg per hari untuk kebanyakan orang dewasa), kafein aman. Namun, beberapa orang lebih sensitif. Hindari mengonsumsinya terlalu dekat dengan waktu tidur.', 84, 4.4, '2025-11-13 13:00:00'),
(81, 'USR075', 'general', 'Bagaimana cara melacak asupan makanan?', 'Gunakan aplikasi pelacak kalori seperti MyFitnessPal atau FatSecret. Jujur saat mencatat semua yang Anda makan dan minum untuk mendapatkan data yang akurat.', 88, 4.7, '2025-11-14 14:00:00'),
(82, 'USR076', 'nutrition', 'Apakah diet vegan bisa memenuhi kebutuhan protein?', 'Sangat bisa. Kombinasikan berbagai sumber protein nabati seperti kacang-kacangan, biji-bijian, tahu, tempe, dan seitan untuk memastikan Anda mendapatkan semua asam amino esensial.', 97, 4.8, '2025-11-15 15:00:00'),
(83, 'USR077', 'fitness', 'Latihan apa yang bisa dilakukan saat bepergian di kamar hotel?', 'Bodyweight circuit: jumping jacks, push-up, squat, lunges, plank, dan burpees. Anda hanya butuh sedikit ruang.', 81, 4.6, '2025-11-16 16:00:00'),
(84, 'USR078', 'supplement', 'Manfaat zat besi untuk tubuh?', 'Zat besi penting untuk membentuk hemoglobin, yang membawa oksigen dalam darah. Kekurangan zat besi dapat menyebabkan anemia, kelelahan, dan sesak napas.', 80, 4.7, '2025-11-17 17:00:00'),
(85, 'USR079', 'general', 'Bagaimana jika saya melewatkan satu hari latihan?', 'Jangan khawatir. Itu tidak akan merusak progres Anda. Cukup kembali ke jadwal latihan Anda pada hari berikutnya. Konsistensi jangka panjang lebih penting daripada kesempurnaan harian.', 75, 4.9, '2025-11-18 18:00:00'),
(86, 'USR081', 'nutrition', 'Apakah air kelapa bagus untuk hidrasi?', 'Ya, air kelapa mengandung elektrolit alami seperti kalium, membuatnya menjadi pilihan hidrasi yang baik, terutama setelah olahraga ringan hingga sedang.', 79, 4.5, '2025-11-19 19:00:00'),
(87, 'USR082', 'fitness', 'Bagaimana cara meningkatkan jumlah push-up saya?', 'Latih secara konsisten 3-4 kali seminggu. Lakukan beberapa set hingga mendekati kegagalan. Coba juga variasi yang lebih mudah seperti incline push-up untuk membangun kekuatan.', 91, 4.8, '2025-11-20 20:00:00'),
(88, 'USR083', 'supplement', 'Apa itu L-Carnitine?', 'L-Carnitine adalah senyawa yang membantu tubuh mengubah lemak menjadi energi. Beberapa orang menggunakannya dengan harapan dapat membantu pembakaran lemak, meskipun penelitian tentang efektivitasnya masih beragam.', 86, 4.1, '2025-11-21 21:00:00'),
(89, 'USR084', 'general', 'Bagaimana cara makan sehat saat makan di luar?', 'Pilih makanan yang dipanggang, direbus, atau dikukus, bukan digoreng. Minta saus atau dressing disajikan terpisah. Perbanyak porsi sayuran.', 102, 4.7, '2025-11-22 12:00:00'),
(90, 'USR085', 'nutrition', 'Apakah madu lebih baik dari gula?', 'Madu memiliki beberapa antioksidan dan sedikit lebih banyak nutrisi, tetapi tubuh Anda memprosesnya sama seperti gula. Gunakan secukupnya.', 80, 4.3, '2025-11-23 13:00:00'),
(91, 'USR086', 'fitness', 'Apakah jalan kaki termasuk olahraga yang bagus?', 'Tentu saja. Jalan cepat adalah bentuk kardio intensitas sedang yang sangat baik, mudah dilakukan, dan ramah untuk sendi. Ini bagus untuk kesehatan jantung dan pengelolaan berat badan.', 85, 4.9, '2025-11-24 14:00:00'),
(92, 'USR087', 'supplement', 'Suplemen untuk kesehatan sendi?', 'Glukosamin dan kondroitin adalah suplemen yang populer untuk kesehatan sendi. Beberapa orang merasa terbantu, meskipun bukti ilmiahnya masih diperdebatkan.', 88, 4.2, '2025-11-25 15:00:00'),
(93, 'USR089', 'general', 'Saya makan sehat dan olahraga, tapi berat badan tidak turun. Kenapa?', 'Anda mungkin mengonsumsi lebih banyak kalori dari yang Anda sadari. Coba lacak asupan Anda dengan jujur selama seminggu. Bisa juga karena retensi air atau Anda sedang membangun otot.', 118, 4.6, '2025-11-26 16:00:00'),
(94, 'USR090', 'nutrition', 'Cara memasak sayuran agar nutrisinya tidak hilang?', 'Mengukus (steaming) atau menumis cepat (stir-frying) adalah metode terbaik untuk mempertahankan nutrisi. Hindari merebus terlalu lama.', 83, 4.8, '2025-11-27 17:00:00'),
(95, 'USR092', 'fitness', 'Apakah saya harus merasakan sakit agar latihan dianggap efektif?', 'Tidak. Anda harus merasakan tantangan dan kelelahan otot, tetapi bukan rasa sakit yang tajam. Nyeri otot ringan (DOMS) setelahnya normal, tetapi sakit saat latihan bisa jadi tanda form yang salah atau cedera.', 99, 4.7, '2025-11-28 18:00:00'),
(96, 'USR093', 'supplement', 'Apakah ZMA membantu tidur dan pemulihan?', 'ZMA (Zinc, Magnesium Aspartate, Vitamin B6) diklaim dapat meningkatkan kualitas tidur dan pemulihan. Efeknya paling terasa pada orang yang kekurangan mineral ini.', 87, 4.4, '2025-11-29 19:00:00'),
(97, 'USR094', 'general', 'Bagaimana cara menghindari makan berlebihan saat pesta?', 'Makan camilan sehat sebelum pergi agar tidak terlalu lapar. Pilih piring yang lebih kecil, dan isi setengahnya dengan sayuran terlebih dahulu.', 95, 4.6, '2025-11-30 20:00:00'),
(98, 'USR095', 'nutrition', 'Apakah diet bebas gluten itu lebih sehat?', 'Hanya jika Anda menderita penyakit celiac atau sensitivitas gluten non-celiac. Bagi orang lain, tidak ada manfaat kesehatan yang melekat, dan banyak produk bebas gluten justru lebih tinggi gula dan kalori.', 104, 4.2, '2025-12-01 10:00:00'),
(99, 'USR096', 'fitness', 'Bagaimana cara agar tidak bosan dengan latihan kardio?', 'Variasikan jenisnya: coba lari, bersepeda, berenang, atau kelas menari. Dengarkan podcast atau audiobook saat berolahraga untuk mengalihkan perhatian.', 90, 4.7, '2025-12-02 11:00:00'),
(100, 'USR099', 'general', 'Saya ingin memulai gaya hidup sehat, harus mulai dari mana?', 'Mulai dari satu atau dua perubahan kecil. Misalnya, targetkan minum 8 gelas air sehari dan berjalan kaki 20 menit setiap hari. Setelah itu menjadi kebiasaan, tambahkan perubahan baru secara bertahap.', 120, 5.0, '2025-12-03 12:00:00'),
(101, 'USR101', 'general', 'Pola tidur saya sangat berantakan karena jadwal syuting. Bagaimana cara memperbaikinya?', 'Coba ciptakan rutinitas sebelum tidur yang konsisten, seperti membaca buku atau meditasi ringan selama 15 menit. Hindari layar gadget setidaknya satu jam sebelum tidur untuk membantu produksi melatonin.', 95, 4.8, '2025-07-15 07:05:00'),
(102, 'USR102', 'nutrition', 'Saya sering lemas saat diet untuk comeback. Makanan apa yang bisa menambah energi tanpa menaikkan berat badan secara drastis?', 'Fokus pada karbohidrat kompleks seperti ubi, nasi merah, dan oatmeal. Tambahkan juga camilan sehat kaya protein seperti yogurt Yunani atau segenggam almond di antara waktu makan.', 110, 4.9, '2025-07-15 07:10:00'),
(103, 'USR103', 'fitness', 'Bahu saya sering nyeri setelah adegan aksi. Adakah latihan peregangan yang bisa membantu?', 'Tentu. Lakukan peregangan pendulum dan peregangan lengan menyilang dada secara perlahan. Kompres dingin area yang nyeri selama 15 menit setelah latihan.', 80, 4.5, '2025-07-15 07:15:00'),
(104, 'USR104', 'general', 'Bagaimana cara mengatasi perut begah setelah makan malam?', 'Coba makan dengan porsi lebih kecil namun lebih sering. Hindari minum terlalu banyak saat makan dan kunyah makanan Anda secara perlahan untuk membantu proses pencernaan.', 75, 4.2, '2025-07-15 07:20:00'),
(105, 'USR105', 'supplement', 'Saya merasa akan flu. Suplemen apa yang bagus untuk meningkatkan imunitas dengan cepat?', 'Vitamin C 1000mg, Zinc, dan Ekstrak Echinacea dapat membantu meningkatkan sistem imun. Pastikan juga untuk cukup istirahat dan minum banyak air.', 90, 4.7, '2025-07-15 07:25:00'),
(106, 'USR106', 'nutrition', 'Saya kesulitan menaikkan berat badan. Makanan apa saja yang padat kalori tapi tetap sehat?', 'Fokus pada makanan seperti alpukat, selai kacang, minyak zaitun, dan kacang-kacangan. Anda juga bisa menambahkan kalori ekstra dengan membuat smoothie kaya protein.', 120, 4.8, '2025-07-15 07:30:00'),
(107, 'USR107', 'fitness', 'Bagaimana program latihan yang efektif untuk menambah massa otot 3 kg dalam 2 bulan?', 'Fokus pada latihan beban dengan prinsip progressive overload, 4-5 kali seminggu. Pastikan Anda surplus kalori sekitar 300-500 kkal per hari dengan asupan protein 1.6-2.2g per kg berat badan.', 150, 5.0, '2025-07-15 07:35:00'),
(108, 'USR108', 'nutrition', 'Apa saja camilan sehat yang bisa menjaga stamina saat latihan dance?', 'Pisang, apel dengan selai kacang, energy bar rendah gula, atau segenggam kecil kurma adalah pilihan yang bagus untuk energi cepat dan berkelanjutan.', 85, 4.6, '2025-07-15 07:40:00'),
(109, 'USR109', 'general', 'Tips mengatasi jet lag dan insomnia setelah penerbangan panjang?', 'Cobalah untuk terpapar sinar matahari pagi di tempat tujuan. Hindari tidur siang yang terlalu lama. Anda bisa mempertimbangkan suplemen melatonin dosis rendah 1-2 jam sebelum waktu tidur lokal.', 100, 4.7, '2025-07-15 07:45:00'),
(110, 'USR111', 'general', 'Kulit wajah saya terlihat kusam. Adakah saran nutrisi untuk mencerahkannya?', 'Perbanyak konsumsi makanan kaya antioksidan seperti buah beri, sayuran hijau gelap, dan tomat. Pastikan juga Anda terhidrasi dengan baik dengan minum setidaknya 8 gelas air per hari.', 95, 4.5, '2025-07-15 07:50:00'),
(111, 'USR112', 'fitness', 'Latihan apa yang efektif untuk mengencangkan otot perut dan pinggang?', 'Latihan seperti plank, Russian twists, dan leg raises sangat efektif. Kombinasikan dengan latihan kardio untuk membakar lemak secara keseluruhan.', 105, 4.8, '2025-07-15 07:55:00'),
(112, 'USR113', 'supplement', 'Suplemen atau teh herbal apa yang bagus untuk meredakan sakit tenggorokan?', 'Teh jahe dengan madu dan lemon sangat baik untuk meredakan iritasi. Lozenges yang mengandung Zinc juga dapat membantu mempercepat pemulihan.', 70, 4.4, '2025-07-15 08:00:00'),
(113, 'USR115', 'general', 'Saya sering terbangun tengah malam. Apa yang harus saya lakukan?', 'Hindari melihat jam. Coba lakukan teknik pernapasan dalam atau meditasi singkat. Jika tidak bisa tidur lagi setelah 20 menit, bangun dari tempat tidur dan lakukan aktivitas ringan hingga mengantuk.', 90, 4.3, '2025-07-15 08:05:00'),
(114, 'USR116', 'nutrition', 'Mengapa saya sering merasa pusing jika telat makan?', 'Pusing bisa menjadi tanda hipoglikemia atau gula darah rendah. Pastikan Anda makan secara teratur setiap 3-4 jam dan jangan melewatkan waktu makan, terutama sarapan.', 80, 4.9, '2025-07-15 08:10:00'),
(115, 'USR117', 'fitness', 'Bagaimana cara mengatasi nyeri lutut setelah berlari?', 'Lakukan kompres es selama 15 menit setelah berlari. Pastikan Anda melakukan pemanasan yang cukup dan peregangan otot paha. Pertimbangkan untuk mengganti sepatu lari Anda jika sudah lama dipakai.', 115, 4.6, '2025-07-15 08:15:00'),
(116, 'USR118', 'nutrition', 'Diet tinggi protein membuat saya sembelit. Bagaimana solusinya?', 'Tingkatkan asupan serat dari sayuran, buah-buahan, dan biji-bijian. Pastikan juga Anda minum air putih yang sangat cukup, minimal 2-3 liter per hari, untuk membantu melancarkan pencernaan.', 95, 4.7, '2025-07-15 08:20:00'),
(117, 'USR121', 'nutrition', 'Saya ingin menaikkan berat badan agar wajah tidak terlalu tirus. Makanan apa yang cocok?', 'Tambahkan lemak sehat ke dalam diet Anda, seperti alpukat, minyak zaitun, dan kacang-kacangan. Ini akan menambah kalori tanpa membuat Anda merasa terlalu kenyang.', 100, 4.8, '2025-07-15 08:25:00'),
(118, 'USR122', 'nutrition', 'Makanan apa yang baik untuk menjaga kesehatan pita suara?', 'Minum air hangat dengan madu dan lemon. Hindari makanan yang terlalu pedas atau berminyak. Buah-buahan seperti pir dan melon juga baik untuk menjaga hidrasi tenggorokan.', 85, 5.0, '2025-07-15 08:30:00'),
(119, 'USR123', 'fitness', 'Bagaimana cara mengurangi pegal di paha setelah latihan?', 'Lakukan peregangan paha (quad & hamstring stretch) setelah latihan. Mandi air hangat atau menggunakan foam roller juga bisa sangat membantu mengurangi nyeri otot.', 90, 4.5, '2025-07-15 08:35:00'),
(120, 'USR125', 'general', 'Sakit kepala karena kurang tidur sangat mengganggu. Apa pertolongan pertamanya?', 'Minum segelas air putih, lalu coba istirahat di ruangan yang gelap dan tenang selama 15-30 menit. Pijatan ringan di pelipis juga bisa membantu.', 75, 4.1, '2025-07-15 08:40:00'),
(121, 'USR128', 'fitness', 'Latihan apa yang fokus untuk menambah massa di paha dan pinggul?', 'Squats, lunges, dan hip thrusts adalah latihan terbaik. Pastikan Anda menggunakan beban yang menantang dan konsisten dalam latihan.', 110, 4.9, '2025-07-15 08:45:00'),
(122, 'USR130', 'nutrition', 'Kulit saya sangat kering. Makanan apa yang bisa membantu melembapkannya?', 'Tingkatkan asupan asam lemak omega-3 dari ikan salmon atau biji chia. Alpukat dan ubi jalar yang kaya vitamin A dan E juga sangat baik untuk kesehatan kulit.', 95, 4.7, '2025-07-15 08:50:00'),
(123, 'USR131', 'nutrition', 'Apa resep smoothie pemulihan energi yang cepat setelah workout?', 'Campurkan 1 pisang, 1 scoop whey protein rasa vanila, 1 sendok makan selai kacang, dan segelas susu almond. Blender hingga halus. Ini memberikan protein dan karbohidrat yang dibutuhkan.', 100, 5.0, '2025-07-15 08:55:00'),
(124, 'USR133', 'fitness', 'Saya sudah diet dan kardio, tapi lemak perut bawah tidak hilang. Apa yang salah?', 'Lemak perut bawah adalah yang terakhir hilang. Coba tambahkan latihan beban untuk meningkatkan metabolisme dan variasikan kardio Anda dengan HIIT (High-Intensity Interval Training).', 130, 4.6, '2025-07-15 09:00:00'),
(125, 'USR137', 'supplement', 'Suplemen apa yang bagus untuk daya tahan tubuh saat harus sering bepergian?', 'Selain Vitamin C dan Zinc, pertimbangkan untuk mengonsumsi probiotik untuk menjaga kesehatan usus, yang merupakan bagian penting dari sistem imun.', 85, 4.7, '2025-07-15 09:05:00'),
(126, 'USR138', 'general', 'Bagaimana cara menikmati kopi tanpa memicu asam lambung?', 'Pilih kopi dengan tingkat keasaman rendah (low-acid coffee). Hindari minum kopi saat perut kosong dan jangan meminumnya lebih dari 1-2 cangkir per hari.', 90, 4.3, '2025-07-15 09:10:00'),
(127, 'USR139', 'general', 'Bagaimana cara menenangkan pikiran yang terlalu aktif sebelum tidur?', 'Coba tulis semua pikiran Anda di jurnal sebelum tidur. Lakukan teknik pernapasan 4-7-8: tarik napas 4 detik, tahan 7 detik, hembuskan 8 detik. Ulangi beberapa kali.', 110, 4.8, '2025-07-15 09:15:00'),
(128, 'USR141', 'nutrition', 'Apakah melewatkan sarapan benar-benar buruk untuk energi?', 'Bagi sebagian besar orang, ya. Sarapan mengisi kembali glukosa setelah semalaman tidak makan. Jika tidak sarapan, tubuh bisa kekurangan energi. Coba sarapan ringan seperti buah atau smoothie.', 95, 4.5, '2025-07-15 09:20:00'),
(129, 'USR144', 'supplement', 'Rambut saya rapuh. Adakah suplemen yang bisa membantu?', 'Biotin dan Kolagen adalah suplemen yang populer untuk kesehatan rambut. Pastikan juga asupan zat besi dan protein Anda tercukupi dari makanan.', 80, 4.4, '2025-07-15 09:25:00'),
(130, 'USR147', 'general', 'Bagaimana cara agar tetap segar dengan tidur hanya 4-5 jam?', 'Meskipun tidak ideal, Anda bisa memaksimalkannya dengan menjaga kualitas tidur. Pastikan kamar sangat gelap, sejuk, dan tenang. Hindari kafein dan alkohol. Power nap 20 menit di siang hari bisa membantu.', 125, 4.7, '2025-07-15 09:30:00'),
(131, 'USR151', 'fitness', 'Saya baru selesai wamil dan stamina menurun. Bagaimana cara memulihkannya?', 'Mulai perlahan dengan kardio ringan seperti jogging 3 kali seminggu. Tingkatkan durasi dan intensitas secara bertahap. Latihan kekuatan juga penting untuk membangun kembali massa otot.', 140, 4.8, '2025-07-16 03:00:00'),
(132, 'USR152', 'nutrition', 'Setelah hiatus, berat badan saya mudah naik. Bagaimana cara mengontrolnya?', 'Fokus pada whole foods dan hindari makanan olahan. Perhatikan porsi makan dan pastikan Anda tetap aktif secara fisik. Jangan melakukan diet ekstrem, konsistensi adalah kunci.', 115, 4.6, '2025-07-16 03:10:00'),
(133, 'USR153', 'supplement', 'Tenggorokan saya sensitif dan mudah batuk. Ada suplemen yang direkomendasikan?', 'Madu Manuka memiliki sifat antibakteri yang baik untuk tenggorokan. Anda juga bisa mencoba teh licorice root atau suplemen yang mengandung Slippery Elm.', 85, 4.5, '2025-07-16 03:20:00'),
(134, 'USR157', 'nutrition', 'Makanan apa yang bagus dikonsumsi sebelum konser solo untuk menjaga stamina?', 'Sekitar 2-3 jam sebelum tampil, konsumsi makanan seimbang yang mengandung karbohidrat kompleks (nasi merah), protein tanpa lemak (dada ayam), dan sedikit lemak sehat (alpukat).', 130, 5.0, '2025-07-16 03:30:00'),
(135, 'USR159', 'fitness', 'Saya ingin membentuk otot dada dan bahu. Berapa set dan repetisi yang ideal?', 'Untuk hipertrofi, lakukan 3-4 set per latihan dengan 8-12 repetisi. Fokus pada gerakan seperti bench press, overhead press, dan lateral raises dengan form yang benar.', 120, 4.9, '2025-07-16 03:40:00'),
(136, 'USR160', 'nutrition', 'Kenapa saya merasa mual jika makan banyak sayuran hijau?', 'Ini bisa terjadi karena peningkatan serat yang tiba-tiba. Coba perkenalkan sayuran secara bertahap dan pastikan Anda memasaknya (misal: ditumis atau dikukus) untuk membuatnya lebih mudah dicerna.', 90, 4.2, '2025-07-16 03:50:00'),
(137, 'USR163', 'general', 'Sebagai leader, saya sering stres dan sulit tidur. Bagaimana mengatasinya?', 'Coba teknik relaksasi seperti progressive muscle relaxation sebelum tidur. Hindari membahas pekerjaan atau masalah berat menjelang waktu tidur. Meditasi terpandu juga bisa sangat membantu.', 110, 4.7, '2025-07-16 04:00:00'),
(138, 'USR165', 'general', 'Jerawat di punggung sering muncul. Apakah ada hubungannya dengan makanan?', 'Bisa jadi. Makanan tinggi gula dan produk susu terkadang bisa menjadi pemicu. Coba kurangi konsumsinya selama beberapa minggu dan lihat perbedaannya. Jaga juga kebersihan area punggung setelah berkeringat.', 105, 4.4, '2025-07-16 04:10:00'),
(139, 'USR167', 'nutrition', 'Nafsu makan saya sering hilang saat stres karena jadwal padat. Bagaimana solusinya?', 'Jangan memaksa makan dalam porsi besar. Coba makan porsi kecil tapi sering. Smoothie atau sup bisa menjadi pilihan yang baik karena lebih mudah dikonsumsi saat tidak nafsu makan.', 95, 4.6, '2025-07-16 04:20:00'),
(140, 'USR169', 'general', 'Meskipun suka membaca, kebiasaan ini membuat saya begadang. Bagaimana menyeimbangkannya?', 'Tetapkan batas waktu membaca, misalnya 30-45 menit sebelum waktu tidur yang Anda targetkan. Gunakan lampu baca yang redup agar tidak terlalu merangsang mata.', 80, 4.8, '2025-07-16 04:30:00'),
(141, 'USR171', 'fitness', 'Bagaimana cara bulking (menambah berat) tanpa membuat wajah jadi tembem?', 'Fokus pada clean bulking: surplus kalori dari sumber makanan sehat. Hindari makanan olahan dan tinggi garam yang bisa menyebabkan retensi air di wajah. Latihan beban akan membantu kalori tersebut menjadi otot, bukan hanya lemak.', 135, 4.9, '2025-07-16 04:40:00'),
(142, 'USR177', 'supplement', 'Saya alergi debu. Adakah suplemen yang bisa membantu mengurangi gejalanya?', 'Quercetin dan Bromelain adalah suplemen alami yang dapat bertindak sebagai antihistamin dan membantu mengurangi reaksi alergi. Vitamin C juga dapat membantu.', 88, 4.5, '2025-07-16 04:50:00'),
(143, 'USR181', 'nutrition', 'Badan saya sering pegal saat bangun tidur. Apa yang harus saya perbaiki dari pola makan?', 'Pastikan asupan magnesium Anda cukup. Magnesium membantu relaksasi otot. Sumber yang baik adalah kacang almond, bayam, dan dark chocolate. Dehidrasi juga bisa menjadi penyebab, jadi pastikan minum cukup.', 100, 4.7, '2025-07-16 05:00:00'),
(144, 'USR188', 'general', 'Bagaimana cara mengurangi lingkaran hitam di bawah mata melalui nutrisi?', 'Pastikan asupan zat besi Anda cukup untuk mencegah anemia. Makanan kaya Vitamin K seperti brokoli dan bayam juga dapat membantu. Kurangi asupan garam dan alkohol.', 110, 4.6, '2025-07-16 05:10:00'),
(145, 'USR192', 'general', 'Setelah memerankan karakter yang emosional, saya sering gelisah dan sulit tidur. Ada saran?', 'Coba lakukan aktivitas yang menenangkan untuk \"melepas\" karakter, seperti mendengarkan musik instrumental, mandi air hangat dengan aromaterapi lavender, atau melakukan peregangan ringan.', 120, 4.8, '2025-07-16 05:20:00'),
(146, 'USR197', 'supplement', 'Suplemen apa yang bagus untuk menjaga stamina saat menjadi host acara TV seharian?', 'Ginseng atau Rhodiola Rosea adalah adaptogen yang dapat membantu tubuh melawan kelelahan dan meningkatkan stamina mental. Coenzyme Q10 juga baik untuk produksi energi seluler.', 95, 4.9, '2025-07-16 05:30:00'),
(147, 'USR199', 'fitness', 'Perut saya cenderung buncit. Latihan apa yang paling efektif selain sit-up?', 'Fokus pada latihan yang melatih seluruh otot inti, seperti leg raises, bicycle crunches, dan plank. Mengurangi lemak tubuh secara keseluruhan melalui diet dan kardio adalah kunci utama.', 115, 4.7, '2025-07-16 05:40:00'),
(148, 'USR200', 'nutrition', 'Saya merasa begah setelah minum susu. Apakah saya intoleran laktosa?', 'Gejala tersebut adalah tanda umum intoleransi laktosa. Coba hindari produk susu selama 1-2 minggu dan lihat apakah gejalanya membaik. Anda bisa beralih ke alternatif susu nabati seperti susu almond atau oat.', 105, 4.5, '2025-07-16 05:50:00'),
(149, 'USR101', 'fitness', 'Selain gym, olahraga apa yang bagus untuk menjaga kebugaran saat jadwal padat?', 'HIIT (High-Intensity Interval Training) selama 20 menit bisa sangat efektif. Anda juga bisa mencoba pilates atau yoga di rumah untuk fleksibilitas dan kekuatan inti.', 100, 4.8, '2025-07-17 02:00:00'),
(150, 'USR102', 'general', 'Bagaimana cara mengatasi stres makan (emotional eating)?', 'Kenali pemicunya. Saat dorongan makan muncul, coba alihkan dengan aktivitas lain seperti berjalan kaki singkat, mendengarkan musik, atau menelepon teman. Jangan menyimpan camilan tidak sehat di rumah.', 110, 4.9, '2025-07-17 02:10:00'),
(151, 'USR106', 'nutrition', 'Apa saja sumber protein nabati yang baik untuk menaikkan berat badan?', 'Lentil, buncis, tahu, tempe, dan quinoa sangat baik. Tambahkan juga selai kacang dan biji-bijian ke dalam makanan Anda untuk kalori dan protein ekstra.', 95, 4.7, '2025-07-17 02:20:00'),
(152, 'USR108', 'general', 'Apakah ada teh yang bisa membantu tidur lebih nyenyak?', 'Teh Chamomile adalah pilihan paling populer karena efek menenangkannya. Teh Valerian Root dan Lavender juga dikenal dapat membantu meningkatkan kualitas tidur.', 80, 4.9, '2025-07-17 02:30:00'),
(153, 'USR110', 'nutrition', 'Saya sering merasa kembung. Makanan apa yang harus saya hindari?', 'Coba kurangi minuman berkarbonasi, permen karet, dan sayuran seperti brokoli, kembang kol, dan kubis untuk sementara waktu. Makan perlahan dan jangan bicara saat makan.', 90, 4.3, '2025-07-17 02:40:00'),
(154, 'USR114', 'supplement', 'Apakah suplemen kolagen benar-benar bermanfaat untuk suara dan kulit?', 'Kolagen dapat membantu hidrasi dan elastisitas kulit. Meskipun tidak langsung berpengaruh pada suara, menjaga hidrasi tubuh secara keseluruhan, termasuk dengan kolagen, baik untuk selaput lendir tenggorokan.', 100, 4.6, '2025-07-17 02:50:00'),
(155, 'USR120', 'fitness', 'Latihan apa yang bisa dilakukan di kamar hotel tanpa alat?', 'Bodyweight circuit: Lakukan 3 set dari 15 squat, 10 push-up, 20 lunges (10 per kaki), dan plank selama 30-60 detik. Ini melatih seluruh tubuh.', 115, 4.8, '2025-07-17 03:00:00'),
(156, 'USR124', 'nutrition', 'Bagaimana cara menjaga kulit tetap cerah saat sering terpapar lampu panggung?', 'Konsumsi makanan kaya Vitamin C (jeruk, paprika) dan Vitamin E (almond, biji bunga matahari). Lycopene dari tomat juga bertindak sebagai tabir surya internal.', 105, 4.9, '2025-07-17 03:10:00'),
(157, 'USR126', 'nutrition', 'Saya sering merasa lapar beberapa jam setelah makan. Apa yang salah?', 'Kemungkinan makanan Anda kurang serat atau protein. Coba tambahkan sumber protein tanpa lemak (ayam, ikan) dan serat (sayuran, kacang-kacangan) di setiap waktu makan untuk rasa kenyang yang lebih lama.', 120, 4.7, '2025-07-17 03:20:00'),
(158, 'USR140', 'general', 'Saya sulit tidur jika terlalu lapar. Apa camilan malam yang sehat?', 'Pilih camilan yang mengandung protein dan sedikit karbohidrat, seperti segenggam kecil almond, semangkuk kecil yogurt Yunani, atau sepotong roti gandum dengan selai kacang.', 90, 4.8, '2025-07-17 03:30:00'),
(159, 'USR142', 'fitness', 'Bagaimana cara melatih keseimbangan untuk koreografi yang sulit?', 'Latihan seperti berdiri dengan satu kaki, yoga (pose pohon), dan menggunakan bosu ball dapat secara signifikan meningkatkan keseimbangan dan stabilitas inti Anda.', 100, 4.9, '2025-07-17 03:40:00'),
(160, 'USR145', 'general', 'Tips menjaga kesehatan mental saat berada di bawah tekanan publik?', 'Jadwalkan waktu \"me time\" tanpa gadget. Lakukan hobi yang Anda nikmati, terhubung dengan orang terdekat, dan jangan ragu untuk berbicara dengan profesional jika perlu. Nutrisi yang baik dan olahraga juga sangat berpengaruh.', 130, 5.0, '2025-07-17 03:50:00'),
(161, 'USR148', 'nutrition', 'Apakah ada makanan yang bisa membantu mengurangi peradangan otot?', 'Ya. Makanan kaya omega-3 seperti salmon, kunyit (curcumin), jahe, dan buah-buahan seperti ceri dan nanas memiliki sifat anti-inflamasi yang dapat membantu pemulihan.', 110, 4.7, '2025-07-18 04:00:00'),
(162, 'USR150', 'fitness', 'Bagaimana cara agar tetap termotivasi berolahraga saat sedang tidak mood?', 'Coba turunkan intensitasnya. Daripada tidak sama sekali, lakukan jalan kaki ringan selama 20 menit atau peregangan. Kadang, memulai adalah bagian tersulit. Putar juga musik favorit Anda.', 100, 4.6, '2025-07-18 04:10:00'),
(163, 'USR154', 'nutrition', 'Saya ingin menurunkan 2 kg dalam sebulan. Berapa defisit kalori yang aman?', 'Defisit kalori yang aman dan berkelanjutan adalah sekitar 300-500 kkal per hari dari total kebutuhan energi harian Anda (TDEE). Ini akan menghasilkan penurunan berat badan sekitar 0.25-0.5 kg per minggu.', 120, 4.9, '2025-07-18 04:20:00'),
(164, 'USR158', 'general', 'Bagaimana cara memasak sayuran agar vitaminnya tidak hilang?', 'Metode memasak terbaik adalah mengukus (steaming) atau menumis cepat (stir-frying). Hindari merebus sayuran terlalu lama karena banyak vitamin larut air akan hilang ke dalam air rebusan.', 95, 4.8, '2025-07-18 04:30:00'),
(165, 'USR162', 'nutrition', 'Saya sering menginginkan makanan manis setelah makan malam. Bagaimana mengatasinya?', 'Ini bisa jadi kebiasaan. Coba ganti dengan teh herbal manis seperti peppermint atau secangkir kecil buah beri. Sikat gigi setelah makan malam juga bisa memberi sinyal ke otak bahwa waktu makan sudah selesai.', 105, 4.7, '2025-07-18 04:40:00'),
(166, 'USR164', 'fitness', 'Apakah lompat tali (skipping) efektif untuk membakar kalori?', 'Sangat efektif. Lompat tali adalah latihan kardio berdampak tinggi yang membakar banyak kalori dalam waktu singkat dan juga meningkatkan koordinasi serta kesehatan kardiovaskular.', 90, 4.9, '2025-07-18 04:50:00'),
(167, 'USR166', 'supplement', 'Suplemen apa yang bisa membantu mengurangi rambut rontok?', 'Selain Biotin, pastikan Anda tidak kekurangan Zat Besi dan Vitamin D, karena keduanya sering dikaitkan dengan kerontokan rambut. Konsultasikan dengan dokter untuk tes darah jika perlu.', 100, 4.5, '2025-07-18 05:00:00'),
(168, 'USR168', 'nutrition', 'Apakah benar minum air es bisa membuat gemuk?', 'Tidak, itu mitos. Air es tidak mengandung kalori. Suhu air tidak mempengaruhi berat badan. Yang membuat gemuk adalah minuman manis yang seringkali disajikan dingin, seperti soda atau es teh manis.', 85, 5.0, '2025-07-18 05:10:00'),
(169, 'USR170', 'general', 'Saya sering merasa sangat mengantuk sekitar jam 2 siang. Apa solusinya?', 'Ini adalah penurunan energi alami. Coba lakukan jalan kaki singkat selama 10 menit, minum segelas air dingin, atau makan camilan ringan yang mengandung protein, bukan gula.', 95, 4.6, '2025-07-18 05:20:00'),
(170, 'USR172', 'fitness', 'Bagaimana cara mengetahui detak jantung target untuk pembakaran lemak?', 'Perkiraan kasarnya adalah 220 dikurangi usia Anda, lalu kalikan hasilnya dengan 0.6-0.7 (60-70%). Berolahraga dalam rentang detak jantung ini akan memaksimalkan penggunaan lemak sebagai energi.', 120, 4.7, '2025-07-18 05:30:00'),
(171, 'USR174', 'nutrition', 'Apakah ada makanan tertentu yang harus dihindari agar tidak mudah kembung sebelum tampil?', 'Ya, hindari minuman berkarbonasi, makanan yang digoreng, produk susu, dan sayuran seperti brokoli atau kembang kol pada hari Anda akan tampil.', 110, 4.8, '2025-07-19 02:00:00'),
(172, 'USR175', 'general', 'Bagaimana cara membangun kebiasaan minum air putih yang cukup?', 'Selalu bawa botol minum. Atur pengingat setiap jam di ponsel Anda untuk minum beberapa teguk. Anda juga bisa menambahkan rasa dengan irisan lemon atau daun mint.', 90, 4.9, '2025-07-19 02:10:00'),
(173, 'USR176', 'fitness', 'Latihan apa yang bagus untuk kekuatan pergelangan kaki untuk menari?', 'Latihan seperti calf raises, ankle circles, dan menyeimbangkan diri di atas bantal atau papan keseimbangan dapat memperkuat otot-otot di sekitar pergelangan kaki Anda.', 100, 4.7, '2025-07-19 02:20:00'),
(174, 'USR178', 'nutrition', 'Saya ingin mengurangi asupan karbohidrat, apa pengganti nasi yang baik?', 'Anda bisa mencoba nasi kembang kol (cauliflower rice), quinoa, atau shirataki noodles. Semuanya lebih rendah karbohidrat dan kalori dibandingkan nasi putih.', 95, 4.8, '2025-07-19 02:30:00');
INSERT INTO `ai_consultations` (`id`, `user_id`, `consultation_type`, `question`, `ai_response`, `consultation_duration`, `satisfaction_rating`, `created_at`) VALUES
(175, 'USR179', 'supplement', 'Apakah perlu mengonsumsi suplemen probiotik setiap hari?', 'Jika Anda tidak memiliki masalah pencernaan, Anda bisa mendapatkan probiotik dari makanan fermentasi seperti yogurt, kimchi, atau tempe. Suplemen harian bisa bermanfaat jika Anda sering mengalami masalah pencernaan.', 105, 4.5, '2025-07-19 02:40:00'),
(176, 'USR182', 'general', 'Bagaimana cara mengatasi keinginan ngemil saat menonton drama?', 'Siapkan camilan sehat terlebih dahulu, seperti irisan buah, popcorn tanpa mentega, atau edamame. Minum teh herbal juga bisa membantu mengurangi keinginan ngemil.', 90, 4.6, '2025-07-19 02:50:00'),
(177, 'USR183', 'fitness', 'Manfaat sauna setelah berolahraga?', 'Sauna dapat membantu relaksasi otot, mengurangi nyeri, dan meningkatkan sirkulasi darah. Namun, pastikan Anda rehidrasi dengan minum banyak air setelahnya.', 85, 4.7, '2025-07-19 03:00:00'),
(178, 'USR184', 'nutrition', 'Apakah ada makanan yang bisa membantu meningkatkan mood?', 'Dark chocolate, pisang, dan makanan kaya omega-3 seperti salmon dapat membantu meningkatkan produksi serotonin, hormon yang mengatur suasana hati. Makanan fermentasi juga baik untuk kesehatan usus yang terhubung dengan mood.', 110, 4.9, '2025-07-19 03:10:00'),
(179, 'USR186', 'general', 'Saya sering terbangun karena kaki kram. Apa penyebabnya?', 'Kram kaki seringkali disebabkan oleh dehidrasi atau kekurangan mineral seperti kalium, kalsium, atau magnesium. Pastikan Anda cukup minum dan konsumsi makanan seperti pisang, yogurt, dan kacang-kacangan.', 100, 4.8, '2025-07-19 03:20:00'),
(180, 'USR187', 'general', 'Bagaimana cara membuat air infus (infused water) yang menyegarkan?', 'Kombinasi yang populer adalah lemon dan mint; mentimun dan jeruk nipis; atau stroberi dan basil. Cukup masukkan irisan buah/herbal ke dalam sebotol air dan diamkan di kulkas selama beberapa jam.', 90, 5.0, '2025-07-19 03:30:00'),
(181, 'USR189', 'fitness', 'Apakah peregangan sebelum latihan itu penting?', 'Peregangan dinamis (dynamic stretching) sebelum latihan sangat penting. Ini mempersiapkan otot Anda untuk bergerak dan mengurangi risiko cedera. Contohnya high knees atau leg swings. Simpan peregangan statis untuk setelah latihan.', 115, 4.7, '2025-07-20 04:00:00'),
(182, 'USR190', 'nutrition', 'Saya tidak suka sayur. Bagaimana cara agar tetap mendapat cukup serat?', 'Anda bisa mendapatkan serat dari buah-buahan (apel, pir, beri), oatmeal, biji chia, lentil, dan kacang-kacangan. Mencampurkan bayam ke dalam smoothie juga cara yang bagus untuk menyembunyikan rasa sayur.', 105, 4.8, '2025-07-20 04:10:00'),
(183, 'USR191', 'general', 'Apakah minum kopi bisa menyebabkan dehidrasi?', 'Kopi memiliki efek diuretik ringan, tetapi jumlah air dalam secangkir kopi biasanya lebih dari cukup untuk mengimbangi efek tersebut. Jadi, dalam jumlah sedang, kopi tidak menyebabkan dehidrasi.', 90, 4.5, '2025-07-20 04:20:00'),
(185, 'USR194', 'fitness', 'Bagaimana cara mengukur persentase lemak tubuh tanpa alat khusus?', 'Metode paling sederhana adalah dengan menggunakan pita ukur untuk mengukur lingkar leher, pinggang, dan pinggul, lalu memasukkan data tersebut ke dalam kalkulator lemak tubuh online (seperti metode Navy). Namun, hasilnya hanya perkiraan.', 120, 4.4, '2025-07-20 04:40:00'),
(186, 'USR195', 'nutrition', 'Saya suka makanan Amerika. Bagaimana cara membuatnya lebih sehat?', 'Ganti kentang goreng dengan kentang panggang. Pilih daging tanpa lemak untuk burger Anda dan gunakan roti gandum. Perbanyak porsi sayuran seperti selada dan tomat.', 100, 4.7, '2025-07-20 04:50:00'),
(187, 'USR196', 'supplement', 'Apakah suplemen Vitamin E baik untuk bekas luka atau jerawat?', 'Minyak Vitamin E yang dioleskan secara topikal dapat membantu melembapkan kulit dan beberapa orang merasa terbantu untuk memudarkan bekas luka. Namun, efektivitasnya bervariasi untuk setiap individu.', 85, 4.2, '2025-07-20 05:00:00'),
(188, 'USR198', 'general', 'Bagaimana cara mengetahui apakah saya sudah cukup minum air?', 'Cara termudah adalah dengan melihat warna urin Anda. Jika warnanya kuning pucat atau hampir bening, Anda terhidrasi dengan baik. Jika warnanya kuning pekat, Anda perlu minum lebih banyak.', 95, 4.9, '2025-07-20 05:10:00');

-- --------------------------------------------------------

--
-- Table structure for table `manager`
--

CREATE TABLE `manager` (
  `id_manager` int(11) NOT NULL,
  `nama_manager` varchar(255) NOT NULL,
  `email_manager` varchar(255) NOT NULL,
  `no_telp` varchar(13) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_karyawan` varchar(50) NOT NULL,
  `date_joined` date NOT NULL,
  `photo_url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `manager`
--

INSERT INTO `manager` (`id_manager`, `nama_manager`, `email_manager`, `no_telp`, `password`, `id_karyawan`, `date_joined`, `photo_url`) VALUES
(1, 'Go Yoon Jung', 'goyoonjung@nutrivit.com', '081421743218', '$2y$10$UNuHZAoK1l3/dR7xvVDcu.KUEWIxoMIH41L/g5WhH9ae.FHJQ1Vc6', 'NV-GYJ-001', '2020-04-22', 'assets/images/manager_1_1752572008.jpg');

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
(1, 'USR001', '2025-07-12', 2200, 2185, 130.00, 132.00, 225.00, 220.00, 75.00, 74.00, 99.30, '2025-07-12 12:51:00'),
(2, 'USR002', '2025-07-12', 1800, 1750, 90.00, 88.00, 180.00, 175.00, 60.00, 59.00, 97.20, '2025-07-12 12:51:00'),
(3, 'USR003', '2025-07-12', 2500, 2515, 150.00, 148.00, 250.00, 255.00, 85.00, 85.00, 100.60, '2025-07-12 12:51:00'),
(4, 'USR004', '2025-07-12', 1900, 1805, 95.00, 90.00, 190.00, 180.00, 65.00, 63.00, 95.00, '2025-07-12 12:51:00'),
(5, 'USR005', '2025-07-12', 2400, 2380, 140.00, 141.00, 240.00, 235.00, 80.00, 78.00, 99.10, '2025-07-12 12:51:00'),
(6, 'USR006', '2025-07-12', 1700, 1720, 85.00, 86.00, 170.00, 170.00, 58.00, 58.00, 101.10, '2025-07-12 12:51:00'),
(7, 'USR007', '2025-07-12', 2100, 2050, 110.00, 105.00, 210.00, 208.00, 70.00, 68.00, 97.60, '2025-07-12 12:51:00'),
(8, 'USR008', '2025-07-12', 1750, 1690, 88.00, 85.00, 175.00, 170.00, 60.00, 57.00, 96.50, '2025-07-12 12:51:00'),
(9, 'USR009', '2025-07-12', 2600, 2580, 160.00, 162.00, 260.00, 255.00, 90.00, 88.00, 99.20, '2025-07-12 12:51:00'),
(10, 'USR010', '2025-07-12', 1600, 1615, 80.00, 80.00, 160.00, 162.00, 55.00, 55.00, 100.90, '2025-07-12 12:51:00'),
(11, 'USR011', '2025-07-12', 2300, 2250, 135.00, 130.00, 230.00, 225.00, 80.00, 78.00, 97.80, '2025-07-12 12:51:00'),
(12, 'USR012', '2025-07-12', 1850, 1860, 92.00, 93.00, 185.00, 185.00, 62.00, 62.00, 100.50, '2025-07-12 12:51:00'),
(13, 'USR013', '2025-07-12', 2250, 2240, 125.00, 125.00, 225.00, 220.00, 78.00, 77.00, 99.50, '2025-07-12 12:51:00'),
(14, 'USR014', '2025-07-12', 1650, 1590, 82.00, 80.00, 165.00, 160.00, 56.00, 53.00, 96.30, '2025-07-12 12:51:00'),
(15, 'USR015', '2025-07-12', 1950, 1950, 98.00, 98.00, 195.00, 195.00, 68.00, 68.00, 100.00, '2025-07-12 12:51:00'),
(16, 'USR016', '2025-07-12', 2700, 2680, 170.00, 168.00, 270.00, 265.00, 95.00, 94.00, 99.20, '2025-07-12 12:51:00'),
(17, 'USR017', '2025-07-12', 1700, 1650, 85.00, 82.00, 170.00, 165.00, 58.00, 56.00, 97.00, '2025-07-12 12:51:00'),
(18, 'USR018', '2025-07-12', 2450, 2400, 145.00, 140.00, 245.00, 240.00, 82.00, 80.00, 97.90, '2025-07-12 12:51:00'),
(19, 'USR019', '2025-07-12', 2000, 2020, 100.00, 101.00, 200.00, 200.00, 70.00, 70.00, 101.00, '2025-07-12 12:51:00'),
(20, 'USR020', '2025-07-12', 2300, 2280, 130.00, 130.00, 230.00, 225.00, 80.00, 79.00, 99.10, '2025-07-12 12:51:00'),
(21, 'USR021', '2025-07-12', 1800, 1790, 90.00, 90.00, 180.00, 178.00, 60.00, 59.00, 99.40, '2025-07-12 12:51:00'),
(22, 'USR022', '2025-07-12', 2200, 2150, 120.00, 118.00, 220.00, 215.00, 75.00, 72.00, 97.70, '2025-07-12 12:51:00'),
(23, 'USR023', '2025-07-12', 1750, 1760, 88.00, 89.00, 175.00, 175.00, 60.00, 60.00, 100.50, '2025-07-12 12:51:00'),
(24, 'USR024', '2025-07-12', 2150, 2140, 115.00, 115.00, 215.00, 212.00, 72.00, 71.00, 99.50, '2025-07-12 12:51:00'),
(25, 'USR025', '2025-07-12', 1900, 1880, 95.00, 94.00, 190.00, 188.00, 65.00, 64.00, 98.90, '2025-07-12 12:51:00'),
(26, 'USR026', '2025-07-12', 2800, 2780, 180.00, 178.00, 280.00, 275.00, 100.00, 99.00, 99.20, '2025-07-12 12:51:00'),
(27, 'USR027', '2025-07-12', 1800, 1750, 90.00, 88.00, 180.00, 175.00, 60.00, 58.00, 97.20, '2025-07-12 12:51:00'),
(28, 'USR028', '2025-07-12', 2350, 2300, 135.00, 132.00, 235.00, 230.00, 80.00, 78.00, 97.80, '2025-07-12 12:51:00'),
(29, 'USR029', '2025-07-12', 2200, 2210, 120.00, 121.00, 220.00, 220.00, 75.00, 75.00, 100.40, '2025-07-12 12:51:00'),
(30, 'USR030', '2025-07-12', 1700, 1680, 85.00, 84.00, 170.00, 168.00, 58.00, 57.00, 98.80, '2025-07-12 12:51:00'),
(31, 'USR031', '2025-07-12', 2300, 2290, 130.00, 130.00, 230.00, 228.00, 80.00, 79.00, 99.50, '2025-07-12 12:51:00'),
(32, 'USR032', '2025-07-12', 1650, 1640, 82.00, 82.00, 165.00, 163.00, 55.00, 54.00, 99.30, '2025-07-12 12:51:00'),
(33, 'USR033', '2025-07-12', 2500, 2480, 150.00, 148.00, 250.00, 245.00, 85.00, 84.00, 99.20, '2025-07-12 12:51:00'),
(34, 'USR034', '2025-07-12', 1850, 1830, 92.00, 91.00, 185.00, 182.00, 62.00, 61.00, 98.90, '2025-07-12 12:51:00'),
(35, 'USR035', '2025-07-12', 2100, 2080, 110.00, 110.00, 210.00, 208.00, 70.00, 69.00, 99.00, '2025-07-12 12:51:00'),
(36, 'USR036', '2025-07-12', 1700, 1710, 85.00, 86.00, 170.00, 170.00, 58.00, 58.00, 100.50, '2025-07-12 12:51:00'),
(37, 'USR037', '2025-07-12', 2400, 2380, 140.00, 138.00, 240.00, 238.00, 80.00, 79.00, 99.10, '2025-07-12 12:51:00'),
(38, 'USR038', '2025-07-12', 1600, 1580, 80.00, 78.00, 160.00, 158.00, 55.00, 54.00, 98.70, '2025-07-12 12:51:00'),
(39, 'USR039', '2025-07-12', 2200, 2190, 120.00, 120.00, 220.00, 218.00, 75.00, 74.00, 99.50, '2025-07-12 12:51:00'),
(40, 'USR040', '2025-07-12', 2000, 1980, 100.00, 98.00, 200.00, 198.00, 70.00, 69.00, 99.00, '2025-07-12 12:51:00'),
(41, 'USR041', '2025-07-12', 2500, 2490, 150.00, 150.00, 250.00, 248.00, 85.00, 84.00, 99.60, '2025-07-12 12:51:00'),
(42, 'USR042', '2025-07-12', 1800, 1780, 90.00, 89.00, 180.00, 178.00, 60.00, 59.00, 98.80, '2025-07-12 12:51:00'),
(43, 'USR043', '2025-07-12', 2400, 2390, 140.00, 140.00, 240.00, 238.00, 80.00, 79.00, 99.50, '2025-07-12 12:51:00'),
(44, 'USR044', '2025-07-12', 1700, 1680, 85.00, 84.00, 170.00, 168.00, 58.00, 57.00, 98.80, '2025-07-12 12:51:00'),
(45, 'USR045', '2025-07-12', 2300, 2290, 130.00, 130.00, 230.00, 228.00, 80.00, 79.00, 99.50, '2025-07-12 12:51:00'),
(46, 'USR046', '2025-07-12', 1800, 1790, 90.00, 90.00, 180.00, 178.00, 60.00, 59.00, 99.40, '2025-07-12 12:51:00'),
(47, 'USR047', '2025-07-12', 2400, 2380, 140.00, 139.00, 240.00, 238.00, 80.00, 79.00, 99.10, '2025-07-12 12:51:00'),
(48, 'USR048', '2025-07-12', 1600, 1590, 80.00, 80.00, 160.00, 158.00, 55.00, 54.00, 99.30, '2025-07-12 12:51:00'),
(49, 'USR049', '2025-07-12', 2200, 2190, 120.00, 120.00, 220.00, 218.00, 75.00, 74.00, 99.50, '2025-07-12 12:51:00'),
(50, 'USR050', '2025-07-12', 1850, 1840, 92.00, 92.00, 185.00, 183.00, 62.00, 61.00, 99.40, '2025-07-12 12:51:00'),
(51, 'USR051', '2025-07-12', 2100, 2090, 110.00, 110.00, 210.00, 208.00, 70.00, 69.00, 99.50, '2025-07-12 12:51:00'),
(52, 'USR052', '2025-07-12', 1900, 1890, 95.00, 95.00, 190.00, 188.00, 65.00, 64.00, 99.40, '2025-07-12 12:51:00'),
(53, 'USR053', '2025-07-12', 2600, 2590, 160.00, 160.00, 260.00, 258.00, 90.00, 89.00, 99.60, '2025-07-12 12:51:00'),
(54, 'USR054', '2025-07-12', 1700, 1690, 85.00, 85.00, 170.00, 168.00, 58.00, 57.00, 99.40, '2025-07-12 12:51:00'),
(55, 'USR055', '2025-07-12', 2300, 2290, 130.00, 130.00, 230.00, 228.00, 80.00, 79.00, 99.50, '2025-07-12 12:51:00'),
(56, 'USR056', '2025-07-12', 1800, 1790, 90.00, 90.00, 180.00, 178.00, 60.00, 59.00, 99.40, '2025-07-12 12:51:00'),
(57, 'USR057', '2025-07-12', 2500, 2490, 150.00, 150.00, 250.00, 248.00, 85.00, 84.00, 99.60, '2025-07-12 12:51:00'),
(58, 'USR058', '2025-07-12', 1900, 1890, 95.00, 95.00, 190.00, 188.00, 65.00, 64.00, 99.40, '2025-07-12 12:51:00'),
(59, 'USR059', '2025-07-12', 2300, 2290, 130.00, 130.00, 230.00, 228.00, 80.00, 79.00, 99.50, '2025-07-12 12:51:00'),
(60, 'USR060', '2025-07-12', 1950, 1940, 98.00, 98.00, 195.00, 193.00, 68.00, 67.00, 99.40, '2025-07-12 12:51:00'),
(61, 'USR061', '2025-07-12', 2200, 2190, 120.00, 120.00, 220.00, 218.00, 75.00, 74.00, 99.50, '2025-07-12 12:51:00'),
(62, 'USR062', '2025-07-12', 1700, 1690, 85.00, 85.00, 170.00, 168.00, 58.00, 57.00, 99.40, '2025-07-12 12:51:00'),
(63, 'USR063', '2025-07-12', 2400, 2390, 140.00, 140.00, 240.00, 238.00, 80.00, 79.00, 99.50, '2025-07-12 12:51:00'),
(64, 'USR064', '2025-07-12', 1650, 1640, 82.00, 82.00, 165.00, 163.00, 55.00, 54.00, 99.30, '2025-07-12 12:51:00'),
(65, 'USR065', '2025-07-12', 2100, 2090, 110.00, 110.00, 210.00, 208.00, 70.00, 69.00, 99.50, '2025-07-12 12:51:00'),
(66, 'USR066', '2025-07-12', 1750, 1740, 88.00, 88.00, 175.00, 173.00, 60.00, 59.00, 99.40, '2025-07-12 12:51:00'),
(67, 'USR067', '2025-07-12', 2150, 2140, 115.00, 115.00, 215.00, 212.00, 72.00, 71.00, 99.50, '2025-07-12 12:51:00'),
(68, 'USR068', '2025-07-12', 1600, 1590, 80.00, 80.00, 160.00, 158.00, 55.00, 54.00, 99.30, '2025-07-12 12:51:00'),
(69, 'USR069', '2025-07-12', 2200, 2190, 120.00, 120.00, 220.00, 218.00, 75.00, 74.00, 99.50, '2025-07-12 12:51:00'),
(70, 'USR070', '2025-07-12', 1700, 1690, 85.00, 85.00, 170.00, 168.00, 58.00, 57.00, 99.40, '2025-07-12 12:51:00'),
(71, 'USR071', '2025-07-12', 2300, 2290, 130.00, 130.00, 230.00, 228.00, 80.00, 79.00, 99.50, '2025-07-12 12:51:00'),
(72, 'USR072', '2025-07-12', 1750, 1740, 88.00, 88.00, 175.00, 173.00, 60.00, 59.00, 99.40, '2025-07-12 12:51:00'),
(73, 'USR073', '2025-07-12', 2250, 2240, 125.00, 125.00, 225.00, 222.00, 78.00, 77.00, 99.50, '2025-07-12 12:51:00'),
(74, 'USR074', '2025-07-12', 1600, 1590, 80.00, 80.00, 160.00, 158.00, 55.00, 54.00, 99.30, '2025-07-12 12:51:00'),
(75, 'USR075', '2025-07-12', 2200, 2190, 120.00, 120.00, 220.00, 218.00, 75.00, 74.00, 99.50, '2025-07-12 12:51:00'),
(76, 'USR076', '2025-07-12', 2300, 2290, 130.00, 130.00, 230.00, 228.00, 80.00, 79.00, 99.50, '2025-07-12 12:51:00'),
(77, 'USR077', '2025-07-12', 2200, 2190, 120.00, 120.00, 220.00, 218.00, 75.00, 74.00, 99.50, '2025-07-12 12:51:00'),
(78, 'USR078', '2025-07-12', 1750, 1740, 88.00, 88.00, 175.00, 173.00, 60.00, 59.00, 99.40, '2025-07-12 12:51:00'),
(79, 'USR079', '2025-07-12', 2400, 2390, 140.00, 140.00, 240.00, 238.00, 80.00, 79.00, 99.50, '2025-07-12 12:51:00'),
(80, 'USR080', '2025-07-12', 1800, 1790, 90.00, 90.00, 180.00, 178.00, 60.00, 59.00, 99.40, '2025-07-12 12:51:00'),
(81, 'USR081', '2025-07-12', 2300, 2290, 130.00, 130.00, 230.00, 228.00, 80.00, 79.00, 99.50, '2025-07-12 12:51:00'),
(82, 'USR082', '2025-07-12', 1850, 1840, 92.00, 92.00, 185.00, 183.00, 62.00, 61.00, 99.40, '2025-07-12 12:51:00'),
(83, 'USR083', '2025-07-12', 2200, 2190, 120.00, 120.00, 220.00, 218.00, 75.00, 74.00, 99.50, '2025-07-12 12:51:00'),
(84, 'USR084', '2025-07-12', 1700, 1690, 85.00, 85.00, 170.00, 168.00, 58.00, 57.00, 99.40, '2025-07-12 12:51:00'),
(85, 'USR085', '2025-07-12', 2100, 2090, 110.00, 110.00, 210.00, 208.00, 70.00, 69.00, 99.50, '2025-07-12 12:51:00'),
(86, 'USR086', '2025-07-12', 1750, 1740, 88.00, 88.00, 175.00, 173.00, 60.00, 59.00, 99.40, '2025-07-12 12:51:00'),
(87, 'USR087', '2025-07-12', 2300, 2290, 130.00, 130.00, 230.00, 228.00, 80.00, 79.00, 99.50, '2025-07-12 12:51:00'),
(88, 'USR088', '2025-07-12', 1800, 1790, 90.00, 90.00, 180.00, 178.00, 60.00, 59.00, 99.40, '2025-07-12 12:51:00'),
(89, 'USR089', '2025-07-12', 2250, 2240, 125.00, 125.00, 225.00, 222.00, 78.00, 77.00, 99.50, '2025-07-12 12:51:00'),
(90, 'USR090', '2025-07-12', 2000, 1990, 100.00, 100.00, 200.00, 198.00, 70.00, 69.00, 99.50, '2025-07-12 12:51:00'),
(91, 'USR091', '2025-07-12', 2300, 2290, 130.00, 130.00, 230.00, 228.00, 80.00, 79.00, 99.50, '2025-07-12 12:51:00'),
(92, 'USR092', '2025-07-12', 1800, 1790, 90.00, 90.00, 180.00, 178.00, 60.00, 59.00, 99.40, '2025-07-12 12:51:00'),
(93, 'USR093', '2025-07-12', 2400, 2390, 140.00, 140.00, 240.00, 238.00, 80.00, 79.00, 99.50, '2025-07-12 12:51:00'),
(94, 'USR094', '2025-07-12', 1700, 1690, 85.00, 85.00, 170.00, 168.00, 58.00, 57.00, 99.40, '2025-07-12 12:51:00'),
(95, 'USR095', '2025-07-12', 2250, 2240, 125.00, 125.00, 225.00, 222.00, 78.00, 77.00, 99.50, '2025-07-12 12:51:00'),
(96, 'USR096', '2025-07-12', 1600, 1590, 80.00, 80.00, 160.00, 158.00, 55.00, 54.00, 99.30, '2025-07-12 12:51:00'),
(97, 'USR097', '2025-07-12', 2200, 2190, 120.00, 120.00, 220.00, 218.00, 75.00, 74.00, 99.50, '2025-07-12 12:51:00'),
(98, 'USR098', '2025-07-12', 1900, 1890, 95.00, 95.00, 190.00, 188.00, 65.00, 64.00, 99.40, '2025-07-12 12:51:00'),
(99, 'USR099', '2025-07-12', 2200, 2190, 120.00, 120.00, 220.00, 218.00, 75.00, 74.00, 99.50, '2025-07-12 12:51:00'),
(100, 'USR100', '2025-07-12', 1650, 1640, 82.00, 82.00, 165.00, 163.00, 55.00, 54.00, 99.30, '2025-07-12 12:51:00');

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
(6, 'ORD20240622002', 'USR002', 125000.00, 'delivered', 'e_wallet', NULL, '2025-06-24 17:18:32'),
(7, 'ORD20250625001', 'USR010', 445000.00, 'delivered', 'e_wallet', 'Jl. Mawar No. 10, Jakarta', '2025-06-25 09:15:00'),
(8, 'ORD20250626001', 'USR015', 185000.00, 'shipped', 'credit_card', 'Jl. Melati No. 22, Bandung', '2025-06-26 11:30:00'),
(9, 'ORD20250627001', 'USR021', 75000.00, 'paid', 'bank_transfer', 'Jl. Anggrek No. 5, Surabaya', '2025-06-27 14:00:00'),
(10, 'ORD20250628001', 'USR035', 519000.00, 'delivered', 'e_wallet', 'Jl. Kamboja No. 1, Yogyakarta', '2025-06-28 16:45:00'),
(11, 'ORD20250629001', 'USR042', 220000.00, 'cancelled', 'credit_card', 'Jl. Tulip No. 8, Semarang', '2025-06-29 18:20:00'),
(12, 'ORD20250630001', 'USR050', 305000.00, 'shipped', 'bank_transfer', 'Jl. Dahlia No. 12, Medan', '2025-06-30 20:00:00'),
(13, 'ORD20250701001', 'USR063', 604000.00, 'delivered', 'credit_card', 'Jl. Cempaka No. 30, Makassar', '2025-07-01 10:10:00'),
(14, 'ORD20250702001', 'USR077', 180000.00, 'pending', 'e_wallet', 'Jl. Kenanga No. 19, Palembang', '2025-07-02 12:00:00'),
(15, 'ORD20250703001', 'USR088', 220000.00, 'paid', 'bank_transfer', 'Jl. Flamboyan No. 7, Bali', '2025-07-03 15:30:00'),
(16, 'ORD20250704001', 'USR099', 424000.00, 'shipped', 'credit_card', 'Jl. Bougenville No. 2, Manado', '2025-07-04 17:00:00'),
(17, 'ORD20250705001', 'USR003', 375000.00, 'delivered', 'e_wallet', 'Jl. Sudirman No. 55, Jakarta Pusat', '2025-07-05 11:00:00'),
(18, 'ORD20250706001', 'USR011', 150000.00, 'delivered', 'bank_transfer', 'Jl. Gatot Subroto No. 101, Bandung', '2025-07-06 13:20:00'),
(19, 'ORD20250707001', 'USR024', 405000.00, 'shipped', 'credit_card', 'Jl. Diponegoro No. 88, Surabaya', '2025-07-07 09:45:00'),
(20, 'ORD20250708001', 'USR033', 299000.00, 'paid', 'e_wallet', 'Jl. Malioboro No. 123, Yogyakarta', '2025-07-08 19:00:00'),
(21, 'ORD20250709001', 'USR058', 95000.00, 'cancelled', 'bank_transfer', 'Jl. Asia Afrika No. 45, Bandung', '2025-07-09 21:00:00'),
(22, 'ORD20250710001', 'USR069', 598000.00, 'delivered', 'credit_card', 'Jl. Thamrin No. 9, Jakarta', '2025-07-10 10:00:00'),
(23, 'ORD20250711001', 'USR081', 180000.00, 'shipped', 'e_wallet', 'Jl. Pajajaran No. 33, Bogor', '2025-07-11 14:15:00'),
(24, 'ORD20250712001', 'USR095', 345000.00, 'pending', 'bank_transfer', 'Jl. Pemuda No. 77, Semarang', '2025-07-12 09:00:00'),
(25, 'ORD20250712002', 'USR001', 299000.00, 'delivered', 'credit_card', 'Jl. Merdeka No. 1, Jakarta', '2025-07-12 14:00:10'),
(26, 'ORD20250712003', 'USR002', 125000.00, 'delivered', 'e_wallet', 'Jl. Asia Afrika No. 10, Bandung', '2025-07-12 14:05:20'),
(27, 'ORD20250713001', 'USR003', 445000.00, 'delivered', 'bank_transfer', 'Jl. Tunjungan No. 20, Surabaya', '2025-07-13 09:10:30'),
(28, 'ORD20250713002', 'USR004', 185000.00, 'delivered', 'credit_card', 'Jl. Malioboro No. 30, Yogyakarta', '2025-07-13 10:15:40'),
(29, 'ORD20250714001', 'USR005', 75000.00, 'delivered', 'e_wallet', 'Jl. Pemuda No. 40, Semarang', '2025-07-14 11:20:50'),
(30, 'ORD20250714002', 'USR006', 519000.00, 'delivered', 'bank_transfer', 'Jl. Gajah Mada No. 50, Medan', '2025-07-14 12:25:00'),
(31, 'ORD20250715001', 'USR007', 220000.00, 'delivered', 'credit_card', 'Jl. Losari No. 60, Makassar', '2025-07-15 13:30:10'),
(32, 'ORD20250715002', 'USR008', 305000.00, 'delivered', 'e_wallet', 'Jl. Ampera No. 70, Palembang', '2025-07-15 14:35:20'),
(33, 'ORD20250716001', 'USR009', 604000.00, 'delivered', 'bank_transfer', 'Jl. Kuta No. 80, Bali', '2025-07-16 15:40:30'),
(34, 'ORD20250716002', 'USR010', 180000.00, 'delivered', 'credit_card', 'Jl. Sam Ratulangi No. 90, Manado', '2025-07-16 16:45:40'),
(35, 'ORD20250717001', 'USR011', 220000.00, 'delivered', 'e_wallet', 'Jl. Pajajaran No. 100, Bogor', '2025-07-17 17:50:50'),
(36, 'ORD20250717002', 'USR012', 424000.00, 'delivered', 'bank_transfer', 'Jl. Ahmad Yani No. 110, Bekasi', '2025-07-17 18:55:00'),
(37, 'ORD20250718001', 'USR013', 375000.00, 'delivered', 'credit_card', 'Jl. Margonda Raya No. 120, Depok', '2025-07-18 09:00:10'),
(38, 'ORD20250718002', 'USR014', 150000.00, 'delivered', 'e_wallet', 'Jl. Serpong Raya No. 130, Tangerang', '2025-07-18 10:05:20'),
(39, 'ORD20250719001', 'USR015', 405000.00, 'delivered', 'bank_transfer', 'Jl. Cihampelas No. 140, Bandung', '2025-07-19 11:10:30'),
(40, 'ORD20250719002', 'USR016', 299000.00, 'delivered', 'credit_card', 'Jl. Darmo No. 150, Surabaya', '2025-07-19 12:15:40'),
(41, 'ORD20250720001', 'USR017', 95000.00, 'delivered', 'e_wallet', 'Jl. Pahlawan No. 160, Semarang', '2025-07-20 13:20:50'),
(42, 'ORD20250720002', 'USR018', 598000.00, 'delivered', 'bank_transfer', 'Jl. Sudirman No. 170, Jakarta', '2025-07-20 14:25:00'),
(43, 'ORD20250721001', 'USR019', 180000.00, 'delivered', 'credit_card', 'Jl. Diponegoro No. 180, Bandung', '2025-07-21 15:30:10'),
(44, 'ORD20250721002', 'USR020', 345000.00, 'delivered', 'e_wallet', 'Jl. Basuki Rahmat No. 190, Surabaya', '2025-07-21 16:35:20'),
(45, 'ORD20250722001', 'USR021', 125000.00, 'shipped', 'bank_transfer', 'Jl. Gejayan No. 200, Yogyakarta', '2025-07-22 17:40:30'),
(46, 'ORD20250722002', 'USR022', 185000.00, 'shipped', 'credit_card', 'Jl. Pandanaran No. 210, Semarang', '2025-07-22 18:45:40'),
(47, 'ORD20250723001', 'USR023', 299000.00, 'paid', 'e_wallet', 'Jl. Urip Sumoharjo No. 220, Makassar', '2025-07-23 09:50:50'),
(48, 'ORD20250723002', 'USR024', 75000.00, 'paid', 'bank_transfer', 'Jl. Rajawali No. 230, Palembang', '2025-07-23 10:55:00'),
(49, 'ORD20250724001', 'USR025', 150000.00, 'pending', 'credit_card', 'Jl. Sunset Road No. 240, Bali', '2025-07-24 11:00:10'),
(50, 'ORD20250724002', 'USR026', 220000.00, 'pending', 'e_wallet', 'Jl. Boulevard No. 250, Manado', '2025-07-24 12:05:20'),
(51, 'ORD20250725001', 'USR027', 180000.00, 'cancelled', 'bank_transfer', 'Jl. Juanda No. 260, Bogor', '2025-07-25 13:10:30'),
(52, 'ORD20250725002', 'USR028', 299000.00, 'delivered', 'credit_card', 'Jl. Bintaro Raya No. 270, Tangerang', '2025-07-25 14:15:40'),
(53, 'ORD20250726001', 'USR029', 424000.00, 'delivered', 'e_wallet', 'Jl. Lenteng Agung No. 280, Depok', '2025-07-26 15:20:50'),
(54, 'ORD20250726002', 'USR030', 125000.00, 'delivered', 'bank_transfer', 'Jl. Riau No. 290, Bandung', '2025-07-26 16:25:00'),
(55, 'ORD20250727001', 'USR031', 185000.00, 'delivered', 'credit_card', 'Jl. Mayjend Sungkono No. 300, Surabaya', '2025-07-27 17:30:10'),
(56, 'ORD20250727002', 'USR032', 75000.00, 'delivered', 'e_wallet', 'Jl. Simanjuntak No. 310, Yogyakarta', '2025-07-27 18:35:20'),
(57, 'ORD20250728001', 'USR033', 299000.00, 'delivered', 'bank_transfer', 'Jl. Gajah Mada No. 320, Semarang', '2025-07-28 09:40:30'),
(58, 'ORD20250728002', 'USR034', 150000.00, 'delivered', 'credit_card', 'Jl. Sisingamangaraja No. 330, Medan', '2025-07-28 10:45:40'),
(59, 'ORD20250729001', 'USR035', 220000.00, 'delivered', 'e_wallet', 'Jl. Sultan Hasanuddin No. 340, Makassar', '2025-07-29 11:50:50'),
(60, 'ORD20250729002', 'USR036', 180000.00, 'delivered', 'bank_transfer', 'Jl. Demang Lebar Daun No. 350, Palembang', '2025-07-29 12:55:00'),
(61, 'ORD20250730001', 'USR037', 299000.00, 'delivered', 'credit_card', 'Jl. Legian No. 360, Bali', '2025-07-30 13:00:10'),
(62, 'ORD20250730002', 'USR038', 125000.00, 'delivered', 'e_wallet', 'Jl. Pierre Tendean No. 370, Manado', '2025-07-30 14:05:20'),
(63, 'ORD20250731001', 'USR039', 185000.00, 'delivered', 'bank_transfer', 'Jl. Baranangsiang No. 380, Bogor', '2025-07-31 15:10:30'),
(64, 'ORD20250731002', 'USR040', 75000.00, 'delivered', 'credit_card', 'Jl. Ciledug Raya No. 390, Tangerang', '2025-07-31 16:15:40'),
(65, 'ORD20250801001', 'USR041', 299000.00, 'shipped', 'e_wallet', 'Jl. Sawangan No. 400, Depok', '2025-08-01 17:20:50'),
(66, 'ORD20250801002', 'USR042', 150000.00, 'shipped', 'bank_transfer', 'Jl. Dago No. 410, Bandung', '2025-08-01 18:25:00'),
(67, 'ORD20250802001', 'USR043', 220000.00, 'paid', 'credit_card', 'Jl. Kertajaya No. 420, Surabaya', '2025-08-02 09:30:10'),
(68, 'ORD20250802002', 'USR044', 180000.00, 'paid', 'e_wallet', 'Jl. Kaliurang No. 430, Yogyakarta', '2025-08-02 10:35:20'),
(69, 'ORD20250803001', 'USR045', 299000.00, 'pending', 'bank_transfer', 'Jl. Sriwijaya No. 440, Semarang', '2025-08-03 11:40:30'),
(70, 'ORD20250803002', 'USR046', 125000.00, 'pending', 'credit_card', 'Jl. Gatot Subroto No. 450, Medan', '2025-08-03 12:45:40'),
(71, 'ORD20250804001', 'USR047', 185000.00, 'delivered', 'e_wallet', 'Jl. Perintis Kemerdekaan No. 460, Makassar', '2025-08-04 13:50:50'),
(72, 'ORD20250804002', 'USR048', 75000.00, 'delivered', 'bank_transfer', 'Jl. Jend. Sudirman No. 470, Palembang', '2025-08-04 14:55:00'),
(73, 'ORD20250805001', 'USR049', 299000.00, 'delivered', 'credit_card', 'Jl. Seminyak No. 480, Bali', '2025-08-05 15:00:10'),
(74, 'ORD20250805002', 'USR050', 150000.00, 'delivered', 'e_wallet', 'Jl. Wolter Monginsidi No. 490, Manado', '2025-08-05 16:05:20'),
(75, 'ORD20250806001', 'USR051', 220000.00, 'delivered', 'bank_transfer', 'Jl. Siliwangi No. 500, Bogor', '2025-08-06 17:10:30'),
(76, 'ORD20250806002', 'USR052', 180000.00, 'delivered', 'credit_card', 'Jl. Ciputat Raya No. 510, Tangerang', '2025-08-06 18:15:40'),
(77, 'ORD20250807001', 'USR053', 299000.00, 'delivered', 'e_wallet', 'Jl. Cinere Raya No. 520, Depok', '2025-08-07 09:20:50'),
(78, 'ORD20250807002', 'USR054', 125000.00, 'delivered', 'bank_transfer', 'Jl. Setiabudi No. 530, Bandung', '2025-08-07 10:25:00'),
(79, 'ORD20250808001', 'USR055', 185000.00, 'delivered', 'credit_card', 'Jl. Dharmawangsa No. 540, Surabaya', '2025-08-08 11:30:10'),
(80, 'ORD20250808002', 'USR056', 75000.00, 'delivered', 'e_wallet', 'Jl. Palagan Tentara Pelajar No. 550, Yogyakarta', '2025-08-08 12:35:20'),
(81, 'ORD20250809001', 'USR057', 299000.00, 'delivered', 'bank_transfer', 'Jl. Pahlawan No. 560, Semarang', '2025-08-09 13:40:30'),
(82, 'ORD20250809002', 'USR058', 150000.00, 'delivered', 'credit_card', 'Jl. Pahlawan No. 50, Semarang', '2025-08-09 14:45:40'),
(83, 'ORD20250810001', 'USR059', 220000.00, 'delivered', 'e_wallet', 'Jl. A. P. Pettarani No. 580, Makassar', '2025-08-10 15:50:50'),
(84, 'ORD20250810002', 'USR060', 180000.00, 'delivered', 'bank_transfer', 'Jl. R. Sukamto No. 590, Palembang', '2025-08-10 16:55:00'),
(85, 'ORD20250811001', 'USR061', 299000.00, 'delivered', 'credit_card', 'Jl. Ubud No. 600, Bali', '2025-08-11 17:00:10'),
(86, 'ORD20250811002', 'USR062', 125000.00, 'delivered', 'e_wallet', 'Jl. Bethesda No. 610, Manado', '2025-08-11 18:05:20'),
(87, 'ORD20250812001', 'USR063', 185000.00, 'delivered', 'bank_transfer', 'Jl. Tajur No. 620, Bogor', '2025-08-12 09:10:30'),
(88, 'ORD20250812002', 'USR064', 75000.00, 'delivered', 'credit_card', 'Jl. Pondok Aren No. 630, Tangerang', '2025-08-12 10:15:40'),
(89, 'ORD20250813001', 'USR065', 299000.00, 'shipped', 'e_wallet', 'Jl. Beji No. 640, Depok', '2025-08-13 11:20:50'),
(90, 'ORD20250813002', 'USR066', 150000.00, 'shipped', 'bank_transfer', 'Jl. Pasteur No. 650, Bandung', '2025-08-13 12:25:00'),
(91, 'ORD20250814001', 'USR067', 220000.00, 'paid', 'credit_card', 'Jl. Manyar Kertoarjo No. 660, Surabaya', '2025-08-14 13:30:10'),
(92, 'ORD20250814002', 'USR068', 180000.00, 'paid', 'e_wallet', 'Jl. Monjali No. 670, Yogyakarta', '2025-08-14 14:35:20'),
(93, 'ORD20250815001', 'USR069', 299000.00, 'pending', 'bank_transfer', 'Jl. Majapahit No. 680, Semarang', '2025-08-15 15:40:30'),
(94, 'ORD20250815002', 'USR070', 125000.00, 'pending', 'credit_card', 'Jl. Juanda No. 690, Medan', '2025-08-15 16:45:40'),
(95, 'ORD20250816001', 'USR071', 185000.00, 'delivered', 'e_wallet', 'Jl. Cendrawasih No. 700, Makassar', '2025-08-16 17:50:50'),
(96, 'ORD20250816002', 'USR072', 75000.00, 'delivered', 'bank_transfer', 'Jl. Kol. H. Burlian No. 710, Palembang', '2025-08-16 18:55:00'),
(97, 'ORD20250817001', 'USR073', 299000.00, 'delivered', 'credit_card', 'Jl. Canggu No. 720, Bali', '2025-08-17 09:00:10'),
(98, 'ORD20250817002', 'USR074', 150000.00, 'delivered', 'e_wallet', 'Jl. Toar No. 730, Manado', '2025-08-17 10:05:20'),
(99, 'ORD20250818001', 'USR075', 220000.00, 'delivered', 'bank_transfer', 'Jl. Empang No. 740, Bogor', '2025-08-18 11:10:30'),
(100, 'ORD20250818002', 'USR076', 180000.00, 'delivered', 'credit_card', 'Jl. Pamulang Raya No. 750, Tangerang', '2025-08-18 12:15:40'),
(101, 'ORD20250819001', 'USR077', 299000.00, 'delivered', 'e_wallet', 'Jl. Kukusan No. 760, Depok', '2025-08-19 13:20:50'),
(102, 'ORD20250819002', 'USR078', 125000.00, 'delivered', 'bank_transfer', 'Jl. Sukajadi No. 770, Bandung', '2025-08-19 14:25:00'),
(103, 'ORD20250820001', 'USR079', 185000.00, 'delivered', 'credit_card', 'Jl. Ngagel No. 780, Surabaya', '2025-08-20 15:30:10'),
(104, 'ORD20250820002', 'USR080', 75000.00, 'delivered', 'e_wallet', 'Jl. Affandi No. 790, Yogyakarta', '2025-08-20 16:35:20'),
(105, 'ORD20250821001', 'USR081', 299000.00, 'delivered', 'bank_transfer', 'Jl. Gajah Mungkur No. 800, Semarang', '2025-08-21 17:40:30'),
(106, 'ORD20250821002', 'USR082', 150000.00, 'delivered', 'credit_card', 'Jl. Iskandar Muda No. 810, Medan', '2025-08-21 18:45:40'),
(107, 'ORD20250822001', 'USR083', 220000.00, 'delivered', 'e_wallet', 'Jl. Ratulangi No. 820, Makassar', '2025-08-22 09:50:50'),
(108, 'ORD20250822002', 'USR084', 180000.00, 'delivered', 'bank_transfer', 'Jl. Basuki Rahmat No. 830, Palembang', '2025-08-22 10:55:00'),
(109, 'ORD20250823001', 'USR085', 299000.00, 'delivered', 'credit_card', 'Jl. Nusa Dua No. 840, Bali', '2025-08-23 11:00:10'),
(110, 'ORD20250823002', 'USR086', 125000.00, 'delivered', 'e_wallet', 'Jl. Lumimuut No. 850, Manado', '2025-08-23 12:05:20'),
(111, 'ORD20250824001', 'USR087', 185000.00, 'delivered', 'bank_transfer', 'Jl. Ciawi No. 860, Bogor', '2025-08-24 13:10:30'),
(112, 'ORD20250824002', 'USR088', 75000.00, 'delivered', 'credit_card', 'Jl. BSD Raya No. 870, Tangerang', '2025-08-24 14:15:40'),
(113, 'ORD20250825001', 'USR089', 299000.00, 'paid', 'e_wallet', 'Jl. Tole Iskandar No. 880, Depok', '2025-08-25 15:20:50'),
(114, 'ORD20250825002', 'USR090', 150000.00, 'paid', 'bank_transfer', 'Jl. Braga No. 890, Bandung', '2025-08-25 16:25:00'),
(115, 'ORD20250826001', 'USR091', 220000.00, 'shipped', 'credit_card', 'Jl. Gubeng No. 900, Surabaya', '2025-08-26 17:30:10'),
(116, 'ORD20250826002', 'USR092', 180000.00, 'shipped', 'e_wallet', 'Jl. Taman Siswa No. 910, Yogyakarta', '2025-08-26 18:35:20'),
(117, 'ORD20250827001', 'USR093', 299000.00, 'pending', 'bank_transfer', 'Jl. Veteran No. 920, Semarang', '2025-08-27 09:40:30'),
(118, 'ORD20250827002', 'USR094', 125000.00, 'pending', 'credit_card', 'Jl. S. Parman No. 930, Medan', '2025-08-27 10:45:40'),
(119, 'ORD20250828001', 'USR095', 185000.00, 'delivered', 'e_wallet', 'Jl. Alauddin No. 940, Makassar', '2025-08-28 11:50:50'),
(120, 'ORD20250828002', 'USR096', 75000.00, 'delivered', 'bank_transfer', 'Jl. Angkatan 45 No. 950, Palembang', '2025-08-28 12:55:00'),
(121, 'ORD20250829001', 'USR097', 299000.00, 'delivered', 'credit_card', 'Jl. Kintamani No. 960, Bali', '2025-08-29 13:00:10'),
(122, 'ORD20250829002', 'USR098', 125000.00, 'delivered', 'e_wallet', 'Jl. Ahmad Yani No. 970, Manado', '2025-08-29 14:05:20'),
(123, 'ORD20250830001', 'USR099', 185000.00, 'delivered', 'bank_transfer', 'Jl. Pajajaran No. 980, Bogor', '2025-08-30 15:10:30'),
(124, 'ORD20250830002', 'USR100', 75000.00, 'delivered', 'credit_card', 'Jl. Gading Serpong No. 990, Tangerang', '2025-08-30 16:15:40'),
(125, 'ORD20250831001', 'USR001', 445000.00, 'delivered', 'e_wallet', 'Jl. Depok No. 1000, Depok', '2025-08-31 17:20:50'),
(126, 'ORD20250901001', 'USR101', 484000.00, 'delivered', 'credit_card', '123 Gangnam-gu, Seoul', '2025-09-01 03:00:00'),
(127, 'ORD20250901002', 'USR102', 125000.00, 'delivered', 'e_wallet', '456 Mapo-gu, Seoul', '2025-09-01 04:15:00'),
(128, 'ORD20250902001', 'USR103', 299000.00, 'delivered', 'bank_transfer', '789 Yongsan-gu, Seoul', '2025-09-02 02:30:00'),
(129, 'ORD20250902002', 'USR104', 95000.00, 'delivered', 'e_wallet', '101 Haeundae-gu, Busan', '2025-09-02 07:00:00'),
(130, 'ORD20250903001', 'USR105', 185000.00, 'delivered', 'credit_card', '212 Seocho-gu, Seoul', '2025-09-03 09:20:00'),
(131, 'ORD20250903002', 'USR106', 75000.00, 'delivered', 'bank_transfer', '321 Jung-gu, Daegu', '2025-09-03 11:00:00'),
(132, 'ORD20250904001', 'USR107', 449000.00, 'delivered', 'e_wallet', '432 Itaewon-ro, Seoul', '2025-09-04 01:45:00'),
(133, 'ORD20250904002', 'USR108', 220000.00, 'delivered', 'credit_card', '543 Apgujeong-ro, Seoul', '2025-09-04 04:50:00'),
(134, 'ORD20250905001', 'USR109', 604000.00, 'delivered', 'bank_transfer', '654 Hongdae, Seoul', '2025-09-05 06:00:00'),
(135, 'ORD20250905002', 'USR110', 180000.00, 'delivered', 'e_wallet', '765 Myeongdong, Seoul', '2025-09-05 08:10:00'),
(136, 'ORD20250906001', 'USR111', 299000.00, 'delivered', 'credit_card', '876 Seongsu-dong, Seoul', '2025-09-06 10:20:00'),
(137, 'ORD20250906002', 'USR112', 125000.00, 'delivered', 'bank_transfer', '987 Garosu-gil, Seoul', '2025-09-06 12:30:00'),
(138, 'ORD20250907001', 'USR113', 445000.00, 'delivered', 'e_wallet', '111 Dongdaemun, Seoul', '2025-09-07 02:00:00'),
(139, 'ORD20250907002', 'USR114', 185000.00, 'delivered', 'credit_card', '222 Insadong, Seoul', '2025-09-07 04:20:00'),
(140, 'ORD20250908001', 'USR115', 75000.00, 'shipped', 'bank_transfer', '333 Samcheong-dong, Seoul', '2025-09-08 06:40:00'),
(141, 'ORD20250908002', 'USR116', 519000.00, 'shipped', 'e_wallet', '444 Bukchon Hanok Village, Seoul', '2025-09-08 08:00:00'),
(142, 'ORD20250909001', 'USR117', 220000.00, 'paid', 'credit_card', '555 Namsan, Seoul', '2025-09-09 10:20:00'),
(143, 'ORD20250909002', 'USR118', 305000.00, 'paid', 'bank_transfer', '666 Yeouido, Seoul', '2025-09-09 12:40:00'),
(144, 'ORD20250910001', 'USR119', 604000.00, 'pending', 'e_wallet', '777 Jamsil, Seoul', '2025-09-10 01:00:00'),
(145, 'ORD20250910002', 'USR120', 180000.00, 'pending', 'credit_card', '888 COEX, Seoul', '2025-09-10 03:30:00'),
(146, 'ORD20250911001', 'USR121', 220000.00, 'delivered', 'bank_transfer', '999 Gangbuk-gu, Seoul', '2025-09-11 05:50:00'),
(147, 'ORD20250911002', 'USR122', 424000.00, 'delivered', 'e_wallet', '121 Songpa-gu, Seoul', '2025-09-11 07:10:00'),
(148, 'ORD20250912001', 'USR123', 375000.00, 'delivered', 'credit_card', '232 Eunpyeong-gu, Seoul', '2025-09-12 09:30:00'),
(149, 'ORD20250912002', 'USR124', 150000.00, 'delivered', 'bank_transfer', '343 Dobong-gu, Seoul', '2025-09-12 11:50:00'),
(150, 'ORD20250913001', 'USR125', 405000.00, 'delivered', 'e_wallet', '454 Nowon-gu, Seoul', '2025-09-13 02:20:00'),
(151, 'ORD20250913002', 'USR126', 299000.00, 'delivered', 'credit_card', '565 Jungnang-gu, Seoul', '2025-09-13 04:40:00'),
(152, 'ORD20250914001', 'USR127', 95000.00, 'delivered', 'bank_transfer', '676 Gwangjin-gu, Seoul', '2025-09-14 06:00:00'),
(153, 'ORD20250914002', 'USR128', 598000.00, 'delivered', 'e_wallet', '787 Dongjak-gu, Seoul', '2025-09-14 08:20:00'),
(154, 'ORD20250915001', 'USR129', 180000.00, 'delivered', 'credit_card', '898 Gwanak-gu, Seoul', '2025-09-15 10:40:00'),
(155, 'ORD20250915002', 'USR130', 345000.00, 'delivered', 'bank_transfer', '909 Geumcheon-gu, Seoul', '2025-09-15 12:00:00'),
(156, 'ORD20250916001', 'USR131', 125000.00, 'cancelled', 'e_wallet', '112 Guro-gu, Seoul', '2025-09-16 01:30:00'),
(157, 'ORD20250916002', 'USR132', 185000.00, 'cancelled', 'credit_card', '223 Yangcheon-gu, Seoul', '2025-09-16 03:50:00'),
(158, 'ORD20250917001', 'USR133', 299000.00, 'delivered', 'bank_transfer', '334 Gangseo-gu, Seoul', '2025-09-17 05:10:00'),
(159, 'ORD20250917002', 'USR134', 75000.00, 'delivered', 'e_wallet', '445 Yeongdeungpo-gu, Seoul', '2025-09-17 07:30:00'),
(160, 'ORD20250918001', 'USR135', 150000.00, 'delivered', 'credit_card', '556 Seodaemun-gu, Seoul', '2025-09-18 09:50:00'),
(161, 'ORD20250918002', 'USR136', 220000.00, 'delivered', 'bank_transfer', '667 Jongno-gu, Seoul', '2025-09-18 11:10:00'),
(162, 'ORD20250919001', 'USR137', 180000.00, 'delivered', 'e_wallet', '778 Seodaemun-gu, Seoul', '2025-09-19 02:40:00'),
(163, 'ORD20250919002', 'USR138', 299000.00, 'delivered', 'credit_card', '889 Mapo-gu, Seoul', '2025-09-19 04:00:00'),
(164, 'ORD20250920001', 'USR139', 424000.00, 'delivered', 'bank_transfer', '990 Yongsan-gu, Seoul', '2025-09-20 06:20:00'),
(165, 'ORD20250920002', 'USR140', 125000.00, 'delivered', 'e_wallet', '101 Gangnam-gu, Seoul', '2025-09-20 08:40:00'),
(166, 'ORD20250921001', 'USR141', 185000.00, 'delivered', 'credit_card', '212 Seocho-gu, Seoul', '2025-09-21 10:00:00'),
(167, 'ORD20250921002', 'USR142', 75000.00, 'delivered', 'bank_transfer', '323 Songpa-gu, Seoul', '2025-09-21 12:20:00'),
(168, 'ORD20250922001', 'USR143', 299000.00, 'delivered', 'e_wallet', '434 Gangdong-gu, Seoul', '2025-09-22 01:50:00'),
(169, 'ORD20250922002', 'USR144', 150000.00, 'delivered', 'credit_card', '545 Gwangjin-gu, Seoul', '2025-09-22 03:10:00'),
(170, 'ORD20250923001', 'USR145', 220000.00, 'delivered', 'bank_transfer', '656 Seongdong-gu, Seoul', '2025-09-23 05:30:00'),
(171, 'ORD20250923002', 'USR146', 180000.00, 'delivered', 'e_wallet', '767 Jungnang-gu, Seoul', '2025-09-23 07:50:00'),
(172, 'ORD20250924001', 'USR147', 299000.00, 'delivered', 'credit_card', '878 Nowon-gu, Seoul', '2025-09-24 09:10:00'),
(173, 'ORD20250924002', 'USR148', 125000.00, 'delivered', 'bank_transfer', '989 Dobong-gu, Seoul', '2025-09-24 11:30:00'),
(174, 'ORD20250925001', 'USR149', 185000.00, 'delivered', 'e_wallet', '113 Gangbuk-gu, Seoul', '2025-09-25 02:00:00'),
(175, 'ORD20250925002', 'USR150', 75000.00, 'delivered', 'credit_card', '224 Seongbuk-gu, Seoul', '2025-09-25 04:20:00'),
(176, 'ORD20250926001', 'USR151', 484000.00, 'shipped', 'bank_transfer', '335 Jongno-gu, Seoul', '2025-09-26 06:40:00'),
(177, 'ORD20250926002', 'USR152', 125000.00, 'shipped', 'e_wallet', '446 Jung-gu, Seoul', '2025-09-26 08:00:00'),
(178, 'ORD20250927001', 'USR153', 299000.00, 'paid', 'credit_card', '557 Eunpyeong-gu, Seoul', '2025-09-27 10:20:00'),
(179, 'ORD20250927002', 'USR154', 95000.00, 'paid', 'bank_transfer', '668 Seodaemun-gu, Seoul', '2025-09-27 12:40:00'),
(180, 'ORD20250928001', 'USR155', 185000.00, 'pending', 'e_wallet', '779 Mapo-gu, Seoul', '2025-09-28 01:30:00'),
(181, 'ORD20250928002', 'USR156', 75000.00, 'pending', 'credit_card', '880 Yangcheon-gu, Seoul', '2025-09-28 03:50:00'),
(182, 'ORD20250929001', 'USR157', 449000.00, 'delivered', 'bank_transfer', '991 Guro-gu, Seoul', '2025-09-29 05:10:00'),
(183, 'ORD20250929002', 'USR158', 220000.00, 'delivered', 'e_wallet', '102 Geumcheon-gu, Seoul', '2025-09-29 07:30:00'),
(184, 'ORD20250930001', 'USR159', 604000.00, 'delivered', 'credit_card', '213 Yeongdeungpo-gu, Seoul', '2025-09-30 09:50:00'),
(185, 'ORD20250930002', 'USR160', 180000.00, 'delivered', 'bank_transfer', '324 Dongjak-gu, Seoul', '2025-09-30 11:10:00');

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
(16, 6, 'PRD008', 2, 180000.00, 360000.00),
(17, 7, 'PRD001', 1, 299000.00, 299000.00),
(18, 7, 'PRD006', 1, 150000.00, 150000.00),
(19, 8, 'PRD003', 1, 185000.00, 185000.00),
(20, 9, 'PRD004', 1, 75000.00, 75000.00),
(21, 10, 'PRD001', 1, 299000.00, 299000.00),
(22, 10, 'PRD007', 1, 220000.00, 220000.00),
(23, 11, 'PRD007', 1, 220000.00, 220000.00),
(24, 12, 'PRD002', 1, 125000.00, 125000.00),
(25, 12, 'PRD003', 1, 185000.00, 185000.00),
(26, 13, 'PRD001', 1, 299000.00, 299000.00),
(27, 13, 'PRD007', 1, 220000.00, 220000.00),
(28, 13, 'PRD005', 1, 95000.00, 95000.00),
(29, 14, 'PRD008', 1, 180000.00, 180000.00),
(30, 15, 'PRD007', 1, 220000.00, 220000.00),
(31, 16, 'PRD001', 1, 299000.00, 299000.00),
(32, 16, 'PRD002', 1, 125000.00, 125000.00),
(33, 17, 'PRD004', 5, 75000.00, 375000.00),
(34, 18, 'PRD006', 1, 150000.00, 150000.00),
(35, 19, 'PRD003', 1, 185000.00, 185000.00),
(36, 19, 'PRD007', 1, 220000.00, 220000.00),
(37, 20, 'PRD001', 1, 299000.00, 299000.00),
(38, 21, 'PRD005', 1, 95000.00, 95000.00),
(39, 22, 'PRD001', 2, 299000.00, 598000.00),
(40, 23, 'PRD008', 1, 180000.00, 180000.00),
(41, 24, 'PRD002', 1, 125000.00, 125000.00),
(42, 24, 'PRD007', 1, 220000.00, 220000.00),
(43, 25, 'PRD001', 1, 299000.00, 299000.00),
(44, 26, 'PRD002', 1, 125000.00, 125000.00),
(45, 27, 'PRD001', 1, 299000.00, 299000.00),
(46, 27, 'PRD006', 1, 150000.00, 150000.00),
(47, 28, 'PRD003', 1, 185000.00, 185000.00),
(48, 29, 'PRD004', 1, 75000.00, 75000.00),
(49, 30, 'PRD001', 1, 299000.00, 299000.00),
(50, 30, 'PRD007', 1, 220000.00, 220000.00),
(51, 31, 'PRD007', 1, 220000.00, 220000.00),
(52, 32, 'PRD002', 1, 125000.00, 125000.00),
(53, 32, 'PRD003', 1, 185000.00, 185000.00),
(54, 33, 'PRD001', 1, 299000.00, 299000.00),
(55, 33, 'PRD007', 1, 220000.00, 220000.00),
(56, 33, 'PRD005', 1, 95000.00, 95000.00),
(57, 34, 'PRD008', 1, 180000.00, 180000.00),
(58, 35, 'PRD007', 1, 220000.00, 220000.00),
(59, 36, 'PRD001', 1, 299000.00, 299000.00),
(60, 36, 'PRD002', 1, 125000.00, 125000.00),
(61, 37, 'PRD004', 5, 75000.00, 375000.00),
(62, 38, 'PRD006', 1, 150000.00, 150000.00),
(63, 39, 'PRD003', 1, 185000.00, 185000.00),
(64, 39, 'PRD007', 1, 220000.00, 220000.00),
(65, 40, 'PRD001', 1, 299000.00, 299000.00),
(66, 41, 'PRD005', 1, 95000.00, 95000.00),
(67, 42, 'PRD001', 2, 299000.00, 598000.00),
(68, 43, 'PRD008', 1, 180000.00, 180000.00),
(69, 44, 'PRD002', 1, 125000.00, 125000.00),
(70, 44, 'PRD007', 1, 220000.00, 220000.00),
(71, 45, 'PRD002', 1, 125000.00, 125000.00),
(72, 46, 'PRD003', 1, 185000.00, 185000.00),
(73, 47, 'PRD001', 1, 299000.00, 299000.00),
(74, 48, 'PRD004', 1, 75000.00, 75000.00),
(75, 49, 'PRD006', 1, 150000.00, 150000.00),
(76, 50, 'PRD007', 1, 220000.00, 220000.00),
(77, 51, 'PRD008', 1, 180000.00, 180000.00),
(78, 52, 'PRD001', 1, 299000.00, 299000.00),
(79, 53, 'PRD001', 1, 299000.00, 299000.00),
(80, 53, 'PRD002', 1, 125000.00, 125000.00),
(81, 54, 'PRD002', 1, 125000.00, 125000.00),
(82, 55, 'PRD003', 1, 185000.00, 185000.00),
(83, 56, 'PRD004', 1, 75000.00, 75000.00),
(84, 57, 'PRD001', 1, 299000.00, 299000.00),
(85, 58, 'PRD006', 1, 150000.00, 150000.00),
(86, 59, 'PRD007', 1, 220000.00, 220000.00),
(87, 60, 'PRD008', 1, 180000.00, 180000.00),
(88, 61, 'PRD001', 1, 299000.00, 299000.00),
(89, 62, 'PRD002', 1, 125000.00, 125000.00),
(90, 63, 'PRD003', 1, 185000.00, 185000.00),
(91, 64, 'PRD004', 1, 75000.00, 75000.00),
(92, 65, 'PRD001', 1, 299000.00, 299000.00),
(93, 66, 'PRD006', 1, 150000.00, 150000.00),
(94, 67, 'PRD007', 1, 220000.00, 220000.00),
(95, 68, 'PRD008', 1, 180000.00, 180000.00),
(96, 69, 'PRD001', 1, 299000.00, 299000.00),
(97, 70, 'PRD002', 1, 125000.00, 125000.00),
(98, 71, 'PRD003', 1, 185000.00, 185000.00),
(99, 72, 'PRD004', 1, 75000.00, 75000.00),
(100, 73, 'PRD001', 1, 299000.00, 299000.00),
(101, 74, 'PRD006', 1, 150000.00, 150000.00),
(102, 75, 'PRD007', 1, 220000.00, 220000.00),
(103, 76, 'PRD008', 1, 180000.00, 180000.00),
(104, 77, 'PRD001', 1, 299000.00, 299000.00),
(105, 78, 'PRD002', 1, 125000.00, 125000.00),
(106, 79, 'PRD003', 1, 185000.00, 185000.00),
(107, 80, 'PRD004', 1, 75000.00, 75000.00),
(108, 81, 'PRD001', 1, 299000.00, 299000.00),
(109, 82, 'PRD006', 1, 150000.00, 150000.00),
(110, 83, 'PRD007', 1, 220000.00, 220000.00),
(111, 84, 'PRD008', 1, 180000.00, 180000.00),
(112, 85, 'PRD001', 1, 299000.00, 299000.00),
(113, 86, 'PRD002', 1, 125000.00, 125000.00),
(114, 87, 'PRD003', 1, 185000.00, 185000.00),
(115, 88, 'PRD004', 1, 75000.00, 75000.00),
(116, 89, 'PRD001', 1, 299000.00, 299000.00),
(117, 90, 'PRD006', 1, 150000.00, 150000.00),
(118, 91, 'PRD007', 1, 220000.00, 220000.00),
(119, 92, 'PRD008', 1, 180000.00, 180000.00),
(120, 93, 'PRD001', 1, 299000.00, 299000.00),
(121, 94, 'PRD002', 1, 125000.00, 125000.00),
(122, 95, 'PRD003', 1, 185000.00, 185000.00),
(123, 96, 'PRD004', 1, 75000.00, 75000.00),
(124, 97, 'PRD001', 1, 299000.00, 299000.00),
(125, 98, 'PRD006', 1, 150000.00, 150000.00),
(126, 99, 'PRD007', 1, 220000.00, 220000.00),
(127, 100, 'PRD008', 1, 180000.00, 180000.00),
(128, 101, 'PRD001', 1, 299000.00, 299000.00),
(129, 102, 'PRD002', 1, 125000.00, 125000.00),
(130, 103, 'PRD003', 1, 185000.00, 185000.00),
(131, 104, 'PRD004', 1, 75000.00, 75000.00),
(132, 105, 'PRD001', 1, 299000.00, 299000.00),
(133, 106, 'PRD006', 1, 150000.00, 150000.00),
(134, 107, 'PRD007', 1, 220000.00, 220000.00),
(135, 108, 'PRD008', 1, 180000.00, 180000.00),
(136, 109, 'PRD001', 1, 299000.00, 299000.00),
(137, 110, 'PRD002', 1, 125000.00, 125000.00),
(138, 111, 'PRD003', 1, 185000.00, 185000.00),
(139, 112, 'PRD004', 1, 75000.00, 75000.00),
(140, 113, 'PRD001', 1, 299000.00, 299000.00),
(141, 114, 'PRD006', 1, 150000.00, 150000.00),
(142, 115, 'PRD007', 1, 220000.00, 220000.00),
(143, 116, 'PRD008', 1, 180000.00, 180000.00),
(144, 117, 'PRD001', 1, 299000.00, 299000.00),
(145, 118, 'PRD002', 1, 125000.00, 125000.00),
(146, 119, 'PRD003', 1, 185000.00, 185000.00),
(147, 120, 'PRD004', 1, 75000.00, 75000.00),
(148, 121, 'PRD001', 1, 299000.00, 299000.00),
(149, 122, 'PRD002', 1, 125000.00, 125000.00),
(150, 123, 'PRD003', 1, 185000.00, 185000.00),
(151, 124, 'PRD004', 1, 75000.00, 75000.00),
(152, 125, 'PRD001', 1, 299000.00, 299000.00),
(153, 125, 'PRD006', 1, 150000.00, 150000.00),
(154, 126, 'PRD001', 1, 299000.00, 299000.00),
(155, 126, 'PRD003', 1, 185000.00, 185000.00),
(156, 127, 'PRD002', 1, 125000.00, 125000.00),
(157, 128, 'PRD001', 1, 299000.00, 299000.00),
(158, 129, 'PRD005', 1, 95000.00, 95000.00),
(159, 130, 'PRD003', 1, 185000.00, 185000.00),
(160, 131, 'PRD004', 1, 75000.00, 75000.00),
(161, 132, 'PRD001', 1, 299000.00, 299000.00),
(162, 132, 'PRD006', 1, 150000.00, 150000.00),
(163, 133, 'PRD007', 1, 220000.00, 220000.00),
(164, 134, 'PRD001', 1, 299000.00, 299000.00),
(165, 134, 'PRD007', 1, 220000.00, 220000.00),
(166, 134, 'PRD005', 1, 95000.00, 95000.00),
(167, 135, 'PRD008', 1, 180000.00, 180000.00),
(168, 136, 'PRD001', 1, 299000.00, 299000.00),
(169, 137, 'PRD002', 1, 125000.00, 125000.00),
(170, 138, 'PRD001', 1, 299000.00, 299000.00),
(171, 138, 'PRD006', 1, 150000.00, 150000.00),
(172, 139, 'PRD003', 1, 185000.00, 185000.00),
(173, 140, 'PRD004', 1, 75000.00, 75000.00),
(174, 141, 'PRD001', 1, 299000.00, 299000.00),
(175, 141, 'PRD007', 1, 220000.00, 220000.00),
(176, 142, 'PRD007', 1, 220000.00, 220000.00),
(177, 143, 'PRD002', 1, 125000.00, 125000.00),
(178, 143, 'PRD003', 1, 185000.00, 185000.00),
(179, 144, 'PRD001', 1, 299000.00, 299000.00),
(180, 144, 'PRD007', 1, 220000.00, 220000.00),
(181, 144, 'PRD005', 1, 95000.00, 95000.00),
(182, 145, 'PRD008', 1, 180000.00, 180000.00),
(183, 146, 'PRD007', 1, 220000.00, 220000.00),
(184, 147, 'PRD001', 1, 299000.00, 299000.00),
(185, 147, 'PRD002', 1, 125000.00, 125000.00),
(186, 148, 'PRD004', 5, 75000.00, 375000.00),
(187, 149, 'PRD006', 1, 150000.00, 150000.00),
(188, 150, 'PRD003', 1, 185000.00, 185000.00),
(189, 150, 'PRD007', 1, 220000.00, 220000.00),
(190, 151, 'PRD001', 1, 299000.00, 299000.00),
(191, 152, 'PRD005', 1, 95000.00, 95000.00),
(192, 153, 'PRD001', 2, 299000.00, 598000.00),
(193, 154, 'PRD008', 1, 180000.00, 180000.00),
(194, 155, 'PRD002', 1, 125000.00, 125000.00),
(195, 155, 'PRD007', 1, 220000.00, 220000.00),
(196, 158, 'PRD001', 1, 299000.00, 299000.00),
(197, 159, 'PRD004', 1, 75000.00, 75000.00),
(198, 160, 'PRD006', 1, 150000.00, 150000.00),
(199, 161, 'PRD007', 1, 220000.00, 220000.00),
(200, 162, 'PRD008', 1, 180000.00, 180000.00),
(201, 163, 'PRD001', 1, 299000.00, 299000.00),
(202, 164, 'PRD001', 1, 299000.00, 299000.00),
(203, 164, 'PRD002', 1, 125000.00, 125000.00),
(204, 165, 'PRD002', 1, 125000.00, 125000.00),
(205, 166, 'PRD003', 1, 185000.00, 185000.00),
(206, 167, 'PRD004', 1, 75000.00, 75000.00),
(207, 168, 'PRD001', 1, 299000.00, 299000.00),
(208, 169, 'PRD006', 1, 150000.00, 150000.00),
(209, 170, 'PRD007', 1, 220000.00, 220000.00),
(210, 171, 'PRD008', 1, 180000.00, 180000.00),
(211, 172, 'PRD001', 1, 299000.00, 299000.00),
(212, 173, 'PRD002', 1, 125000.00, 125000.00),
(213, 174, 'PRD003', 1, 185000.00, 185000.00),
(214, 175, 'PRD004', 1, 75000.00, 75000.00),
(215, 176, 'PRD001', 1, 299000.00, 299000.00),
(216, 176, 'PRD006', 1, 150000.00, 150000.00),
(217, 177, 'PRD007', 1, 220000.00, 220000.00),
(218, 178, 'PRD008', 1, 180000.00, 180000.00),
(219, 179, 'PRD001', 1, 299000.00, 299000.00),
(220, 180, 'PRD002', 1, 125000.00, 125000.00),
(221, 181, 'PRD003', 1, 185000.00, 185000.00),
(222, 182, 'PRD004', 1, 75000.00, 75000.00),
(223, 183, 'PRD001', 1, 299000.00, 299000.00),
(224, 183, 'PRD006', 1, 150000.00, 150000.00),
(225, 184, 'PRD001', 2, 299000.00, 598000.00),
(226, 184, 'PRD008', 1, 180000.00, 180000.00),
(227, 185, 'PRD008', 1, 180000.00, 180000.00);

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
('PRD001', 'NuVit Whey Protein Premium', 'protein', 'High-quality whey protein for muscle building', 299000.00, 45, 'nuvit-whey.jpg', 'Active', '2025-06-24 17:18:32', '2025-07-15 08:59:37'),
('PRD002', 'NuVit-C Boost', 'vitamin', 'Immune system booster vitamin C tablets', 125000.00, 18, 'nuvit-cboost.jpg', 'Active', '2025-06-24 17:18:32', '2025-07-15 08:59:37'),
('PRD003', 'NuVit-Omega Brain', 'supplement', 'Pure fish oil for heart and brain health', 185000.00, 32, 'nuvit-omega.jpg', 'Active', '2025-06-24 17:18:32', '2025-07-15 08:59:37'),
('PRD004', 'NuVit-MultiCore', 'vitamin', 'Complete daily vitamin and mineral supplement', 75000.00, 67, NULL, 'Active', '2025-06-24 17:18:32', '2025-07-16 06:40:57'),
('PRD005', 'NuVit-Detox Tea', 'herbal', 'Natural detox tea blend for cleansing', 95000.00, 89, NULL, 'Active', '2025-06-24 17:18:32', '2025-07-16 06:40:57'),
('PRD006', 'NuVit-Creatine', 'supplement', 'Pure creatine for strength and power', 150000.00, 56, NULL, 'Active', '2025-06-24 17:18:32', '2025-07-16 06:40:57'),
('PRD007', 'NuVit-Collagen Peptides', 'supplement', 'Anti-aging collagen supplement', 220000.00, 34, NULL, 'Active', '2025-06-24 17:18:32', '2025-07-16 06:40:57'),
('PRD008', 'NuVit-Organic Spirulina', 'organic', 'Superfood spirulina powder', 180000.00, 42, NULL, 'Active', '2025-06-24 17:18:32', '2025-07-16 06:40:57');

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
(6, 'USR005', 'PRD001', 5, 4.9, 'Hasil terbaik untuk muscle building', '2025-06-24 17:18:32'),
(7, 'USR010', 'PRD001', 7, 5.0, 'Produk original, pengiriman cepat. Sangat memuaskan!', '2025-06-28 10:00:00'),
(8, 'USR010', 'PRD006', 7, 4.5, 'Creatine-nya terasa efeknya, angkatan jadi lebih kuat.', '2025-06-28 10:05:00'),
(9, 'USR035', 'PRD007', 10, 4.8, 'Collagennya bagus untuk kulit, terasa lebih kenyal.', '2025-07-01 11:00:00'),
(10, 'USR063', 'PRD001', 13, 4.9, 'Selalu repeat order whey protein di sini. Terbaik!', '2025-07-04 09:00:00'),
(11, 'USR003', 'PRD004', 17, 4.0, 'Multivitaminnya oke, harganya terjangkau.', '2025-07-08 13:00:00'),
(12, 'USR011', 'PRD006', 18, 4.2, 'Barang sesuai pesanan, packing aman.', '2025-07-09 14:00:00'),
(13, 'USR069', 'PRD001', 22, 5.0, 'Dua kali beli dan selalu puas. Seller responsif.', '2025-07-12 11:00:00'),
(14, 'USR001', 'PRD001', 25, 4.8, 'Kualitasnya mantap! Pasti akan beli lagi di sini.', '2025-07-15 10:00:00'),
(15, 'USR002', 'PRD002', 26, 4.9, 'Sangat direkomendasikan. Efeknya terasa setelah beberapa kali pemakaian.', '2025-07-15 11:00:00'),
(16, 'USR003', 'PRD001', 27, 4.7, 'Packing aman dan rapi. Terima kasih seller.', '2025-07-16 12:00:00'),
(17, 'USR004', 'PRD003', 28, 4.6, 'Harga bersaing, kualitas tidak murahan. Puas!', '2025-07-16 13:00:00'),
(18, 'USR005', 'PRD004', 29, 4.5, 'Agak lama di pengiriman, tapi produknya oke.', '2025-07-17 14:00:00'),
(19, 'USR006', 'PRD001', 30, 4.8, 'Rasanya enak dan mudah larut. Tidak mengecewakan.', '2025-07-17 15:00:00'),
(20, 'USR007', 'PRD007', 31, 4.9, 'Sesuai ekspektasi. Bekerja dengan baik.', '2025-07-18 16:00:00'),
(21, 'USR008', 'PRD002', 32, 5.0, 'Luar biasa! Produk original dan berkhasiat.', '2025-07-18 17:00:00'),
(22, 'USR009', 'PRD001', 33, 4.7, 'Pelayanan seller ramah dan responsif.', '2025-07-19 18:00:00'),
(23, 'USR010', 'PRD008', 34, 4.6, 'Produknya bagus, sesuai deskripsi. Pengiriman juga cepat.', '2025-07-19 19:00:00'),
(24, 'USR011', 'PRD007', 35, 4.8, 'Kualitasnya mantap! Pasti akan beli lagi di sini.', '2025-07-20 20:00:00'),
(25, 'USR012', 'PRD001', 36, 4.9, 'Sangat direkomendasikan. Efeknya terasa setelah beberapa kali pemakaian.', '2025-07-20 21:00:00'),
(26, 'USR013', 'PRD004', 37, 4.7, 'Packing aman dan rapi. Terima kasih seller.', '2025-07-21 22:00:00'),
(27, 'USR014', 'PRD006', 38, 4.6, 'Harga bersaing, kualitas tidak murahan. Puas!', '2025-07-21 23:00:00'),
(28, 'USR015', 'PRD003', 39, 4.5, 'Agak lama di pengiriman, tapi produknya oke.', '2025-07-22 10:00:00'),
(29, 'USR016', 'PRD001', 40, 4.8, 'Rasanya enak dan mudah larut. Tidak mengecewakan.', '2025-07-22 11:00:00'),
(30, 'USR017', 'PRD005', 41, 4.9, 'Sesuai ekspektasi. Bekerja dengan baik.', '2025-07-23 12:00:00'),
(31, 'USR018', 'PRD001', 42, 5.0, 'Luar biasa! Produk original dan berkhasiat.', '2025-07-23 13:00:00'),
(32, 'USR019', 'PRD008', 43, 4.7, 'Pelayanan seller ramah dan responsif.', '2025-07-24 14:00:00'),
(33, 'USR020', 'PRD002', 44, 4.6, 'Produknya bagus, sesuai deskripsi. Pengiriman juga cepat.', '2025-07-24 15:00:00'),
(34, 'USR028', 'PRD001', 52, 4.8, 'Kualitasnya mantap! Pasti akan beli lagi di sini.', '2025-07-28 16:00:00'),
(35, 'USR029', 'PRD001', 53, 4.9, 'Sangat direkomendasikan. Efeknya terasa setelah beberapa kali pemakaian.', '2025-07-29 17:00:00'),
(36, 'USR030', 'PRD002', 54, 4.7, 'Packing aman dan rapi. Terima kasih seller.', '2025-07-29 18:00:00'),
(37, 'USR031', 'PRD003', 55, 4.6, 'Harga bersaing, kualitas tidak murahan. Puas!', '2025-07-30 19:00:00'),
(38, 'USR032', 'PRD004', 56, 4.5, 'Agak lama di pengiriman, tapi produknya oke.', '2025-07-30 20:00:00'),
(39, 'USR033', 'PRD001', 57, 4.8, 'Rasanya enak dan mudah larut. Tidak mengecewakan.', '2025-07-31 21:00:00'),
(40, 'USR034', 'PRD006', 58, 4.9, 'Sesuai ekspektasi. Bekerja dengan baik.', '2025-07-31 22:00:00'),
(41, 'USR035', 'PRD007', 59, 5.0, 'Luar biasa! Produk original dan berkhasiat.', '2025-08-01 10:00:00'),
(42, 'USR036', 'PRD008', 60, 4.7, 'Pelayanan seller ramah dan responsif.', '2025-08-01 11:00:00'),
(43, 'USR037', 'PRD001', 61, 4.6, 'Produknya bagus, sesuai deskripsi. Pengiriman juga cepat.', '2025-08-02 12:00:00'),
(44, 'USR038', 'PRD002', 62, 4.8, 'Kualitasnya mantap! Pasti akan beli lagi di sini.', '2025-08-02 13:00:00'),
(45, 'USR039', 'PRD003', 63, 4.9, 'Sangat direkomendasikan. Efeknya terasa setelah beberapa kali pemakaian.', '2025-08-03 14:00:00'),
(46, 'USR040', 'PRD004', 64, 4.7, 'Packing aman dan rapi. Terima kasih seller.', '2025-08-03 15:00:00'),
(47, 'USR047', 'PRD003', 71, 4.6, 'Harga bersaing, kualitas tidak murahan. Puas!', '2025-08-07 16:00:00'),
(48, 'USR048', 'PRD004', 72, 4.5, 'Agak lama di pengiriman, tapi produknya oke.', '2025-08-07 17:00:00'),
(49, 'USR049', 'PRD001', 73, 4.8, 'Rasanya enak dan mudah larut. Tidak mengecewakan.', '2025-08-08 18:00:00'),
(50, 'USR050', 'PRD006', 74, 4.9, 'Sesuai ekspektasi. Bekerja dengan baik.', '2025-08-08 19:00:00'),
(51, 'USR051', 'PRD007', 75, 5.0, 'Luar biasa! Produk original dan berkhasiat.', '2025-08-09 20:00:00'),
(52, 'USR052', 'PRD008', 76, 4.7, 'Pelayanan seller ramah dan responsif.', '2025-08-09 21:00:00'),
(53, 'USR053', 'PRD001', 77, 4.6, 'Produknya bagus, sesuai deskripsi. Pengiriman juga cepat.', '2025-08-10 22:00:00'),
(54, 'USR054', 'PRD002', 78, 4.8, 'Kualitasnya mantap! Pasti akan beli lagi di sini.', '2025-08-10 23:00:00'),
(55, 'USR055', 'PRD003', 79, 4.9, 'Sangat direkomendasikan. Efeknya terasa setelah beberapa kali pemakaian.', '2025-08-11 10:00:00'),
(56, 'USR056', 'PRD004', 80, 4.7, 'Packing aman dan rapi. Terima kasih seller.', '2025-08-11 11:00:00'),
(57, 'USR057', 'PRD001', 81, 4.6, 'Harga bersaing, kualitas tidak murahan. Puas!', '2025-08-12 12:00:00'),
(58, 'USR058', 'PRD006', 82, 4.5, 'Agak lama di pengiriman, tapi produknya oke.', '2025-08-12 13:00:00'),
(59, 'USR059', 'PRD007', 83, 4.8, 'Rasanya enak dan mudah larut. Tidak mengecewakan.', '2025-08-13 14:00:00'),
(60, 'USR060', 'PRD008', 84, 4.9, 'Sesuai ekspektasi. Bekerja dengan baik.', '2025-08-13 15:00:00'),
(61, 'USR061', 'PRD001', 85, 5.0, 'Luar biasa! Produk original dan berkhasiat.', '2025-08-14 16:00:00'),
(62, 'USR062', 'PRD002', 86, 4.7, 'Pelayanan seller ramah dan responsif.', '2025-08-14 17:00:00'),
(63, 'USR063', 'PRD003', 87, 4.6, 'Produknya bagus, sesuai deskripsi. Pengiriman juga cepat.', '2025-08-15 18:00:00'),
(64, 'USR064', 'PRD004', 88, 4.8, 'Kualitasnya mantap! Pasti akan beli lagi di sini.', '2025-08-15 19:00:00'),
(65, 'USR071', 'PRD003', 95, 4.9, 'Sangat direkomendasikan. Efeknya terasa setelah beberapa kali pemakaian.', '2025-08-19 20:00:00'),
(66, 'USR072', 'PRD004', 96, 4.7, 'Packing aman dan rapi. Terima kasih seller.', '2025-08-19 21:00:00'),
(67, 'USR073', 'PRD001', 97, 4.6, 'Harga bersaing, kualitas tidak murahan. Puas!', '2025-08-20 22:00:00'),
(68, 'USR074', 'PRD006', 98, 4.5, 'Agak lama di pengiriman, tapi produknya oke.', '2025-08-20 23:00:00'),
(69, 'USR075', 'PRD007', 99, 4.8, 'Rasanya enak dan mudah larut. Tidak mengecewakan.', '2025-08-21 10:00:00'),
(70, 'USR076', 'PRD008', 100, 4.9, 'Sesuai ekspektasi. Bekerja dengan baik.', '2025-08-21 11:00:00'),
(71, 'USR077', 'PRD001', 101, 5.0, 'Luar biasa! Produk original dan berkhasiat.', '2025-08-22 12:00:00'),
(72, 'USR078', 'PRD002', 102, 4.7, 'Pelayanan seller ramah dan responsif.', '2025-08-22 13:00:00'),
(73, 'USR079', 'PRD003', 103, 4.6, 'Produknya bagus, sesuai deskripsi. Pengiriman juga cepat.', '2025-08-23 14:00:00'),
(74, 'USR080', 'PRD004', 104, 4.8, 'Kualitasnya mantap! Pasti akan beli lagi di sini.', '2025-08-23 15:00:00'),
(75, 'USR081', 'PRD001', 105, 4.9, 'Sangat direkomendasikan. Efeknya terasa setelah beberapa kali pemakaian.', '2025-08-24 16:00:00'),
(76, 'USR082', 'PRD006', 106, 4.7, 'Packing aman dan rapi. Terima kasih seller.', '2025-08-24 17:00:00'),
(77, 'USR083', 'PRD007', 107, 4.6, 'Harga bersaing, kualitas tidak murahan. Puas!', '2025-08-25 18:00:00'),
(78, 'USR084', 'PRD008', 108, 4.5, 'Agak lama di pengiriman, tapi produknya oke.', '2025-08-25 19:00:00'),
(79, 'USR085', 'PRD001', 109, 4.8, 'Rasanya enak dan mudah larut. Tidak mengecewakan.', '2025-08-26 20:00:00'),
(80, 'USR086', 'PRD002', 110, 4.9, 'Sesuai ekspektasi. Bekerja dengan baik.', '2025-08-26 21:00:00'),
(81, 'USR087', 'PRD003', 111, 5.0, 'Luar biasa! Produk original dan berkhasiat.', '2025-08-27 22:00:00'),
(82, 'USR088', 'PRD004', 112, 4.7, 'Pelayanan seller ramah dan responsif.', '2025-08-27 23:00:00'),
(83, 'USR095', 'PRD003', 119, 4.6, 'Produknya bagus, sesuai deskripsi. Pengiriman juga cepat.', '2025-08-31 10:00:00'),
(84, 'USR096', 'PRD004', 120, 4.8, 'Kualitasnya mantap! Pasti akan beli lagi di sini.', '2025-08-31 11:00:00'),
(85, 'USR097', 'PRD001', 121, 4.9, 'Sangat direkomendasikan. Efeknya terasa setelah beberapa kali pemakaian.', '2025-09-01 12:00:00'),
(86, 'USR098', 'PRD002', 122, 4.7, 'Packing aman dan rapi. Terima kasih seller.', '2025-09-01 13:00:00'),
(87, 'USR099', 'PRD003', 123, 4.6, 'Harga bersaing, kualitas tidak murahan. Puas!', '2025-09-02 14:00:00'),
(88, 'USR100', 'PRD004', 124, 4.5, 'Agak lama di pengiriman, tapi produknya oke.', '2025-09-02 15:00:00'),
(89, 'USR001', 'PRD001', 125, 4.8, 'Rasanya enak dan mudah larut. Tidak mengecewakan.', '2025-09-03 16:00:00'),
(90, 'USR001', 'PRD006', 125, 4.9, 'Sesuai ekspektasi. Bekerja dengan baik.', '2025-09-03 17:00:00'),
(91, 'USR002', 'PRD002', 2, 5.0, 'Luar biasa! Produk original dan berkhasiat.', '2025-09-04 18:00:00'),
(92, 'USR004', 'PRD003', 4, 4.7, 'Pelayanan seller ramah dan responsif.', '2025-09-04 19:00:00'),
(93, 'USR005', 'PRD001', 5, 4.6, 'Produknya bagus, sesuai deskripsi. Pengiriman juga cepat.', '2025-09-05 20:00:00'),
(94, 'USR002', 'PRD004', 6, 4.8, 'Kualitasnya mantap! Pasti akan beli lagi di sini.', '2025-09-05 21:00:00'),
(95, 'USR010', 'PRD001', 7, 4.9, 'Sangat direkomendasikan. Efeknya terasa setelah beberapa kali pemakaian.', '2025-09-06 22:00:00'),
(96, 'USR015', 'PRD003', 8, 4.7, 'Packing aman dan rapi. Terima kasih seller.', '2025-09-06 23:00:00'),
(97, 'USR021', 'PRD004', 9, 4.6, 'Harga bersaing, kualitas tidak murahan. Puas!', '2025-09-07 10:00:00'),
(98, 'USR035', 'PRD001', 10, 4.5, 'Agak lama di pengiriman, tapi produknya oke.', '2025-09-07 11:00:00'),
(99, 'USR042', 'PRD007', 11, 4.8, 'Rasanya enak dan mudah larut. Tidak mengecewakan.', '2025-09-08 12:00:00'),
(100, 'USR050', 'PRD002', 12, 4.9, 'Sesuai ekspektasi. Bekerja dengan baik.', '2025-09-08 13:00:00'),
(101, 'USR063', 'PRD007', 13, 5.0, 'Luar biasa! Produk original dan berkhasiat.', '2025-09-09 14:00:00'),
(102, 'USR101', 'PRD001', 126, 5.0, 'Whey protein terbaik! Rasa coklatnya pas dan tidak terlalu manis.', '2025-09-05 05:00:00'),
(103, 'USR101', 'PRD003', 126, 4.5, 'Omega-3 ini sangat membantu fokus saya. Recommended.', '2025-09-05 05:01:00'),
(104, 'USR102', 'PRD002', 127, 2.0, 'Pengiriman sangat lama, lebih dari seminggu. Produknya sih oke.', '2025-09-06 03:00:00'),
(105, 'USR103', 'PRD001', 128, 4.8, 'Kualitas premium, sesuai dengan harganya.', '2025-09-06 07:00:00'),
(106, 'USR104', 'PRD005', 129, 1.5, 'Rasanya aneh, tidak seperti teh herbal biasanya. Saya tidak suka.', '2025-09-07 04:00:00'),
(107, 'USR105', 'PRD003', 130, 4.0, 'Produk bagus, tapi packingnya sedikit penyok.', '2025-09-07 11:00:00'),
(108, 'USR106', 'PRD004', 131, 5.0, 'Multivitamin yang saya butuhkan setiap hari. Praktis!', '2025-09-08 02:00:00'),
(109, 'USR107', 'PRD001', 132, 4.9, 'Sangat membantu recovery setelah nge-gym.', '2025-09-08 06:00:00'),
(110, 'USR108', 'PRD007', 133, 2.5, 'Tidak terlalu melihat ada perubahan signifikan di kulit setelah sebulan pemakaian.', '2025-09-09 08:00:00'),
(111, 'USR109', 'PRD001', 134, 5.0, 'Golden Maknae approved! Protein ini luar biasa.', '2025-09-10 03:00:00'),
(112, 'USR109', 'PRD007', 134, 4.8, 'Membuat kulit lebih cerah.', '2025-09-10 03:01:00'),
(113, 'USR110', 'PRD008', 135, 3.0, 'Baunya agak menyengat, tapi khasiatnya lumayan.', '2025-09-11 04:00:00'),
(114, 'USR111', 'PRD001', 136, 4.7, 'Wajahku jadi lebih fit setelah konsumsi ini.', '2025-09-12 05:00:00'),
(115, 'USR112', 'PRD002', 137, 1.0, 'Botolnya pecah saat diterima! Isinya tumpah semua. Kecewa berat.', '2025-09-12 07:00:00'),
(116, 'USR113', 'PRD001', 138, 4.8, 'Sangat cocok untuk aktor laga seperti saya.', '2025-09-13 08:00:00'),
(117, 'USR114', 'PRD003', 139, 5.0, 'My voice feels better after taking this. Love it!', '2025-09-13 09:00:00'),
(118, 'USR117', 'PRD001', 146, 4.9, 'Membantu menjaga stamina saat syuting.', '2025-09-15 10:00:00'),
(119, 'USR118', 'PRD007', 147, 4.5, 'Tinggi badanku jadi terlihat lebih proporsional.', '2025-09-16 11:00:00'),
(120, 'USR119', 'PRD001', 148, 4.8, 'Sangat bagus untuk menjaga berat badan ideal.', '2025-09-17 12:00:00'),
(121, 'USR120', 'PRD004', 149, 2.0, 'Salah kirim produk, yang datang bukan multivitamin. Proses retur agak ribet.', '2025-09-18 13:00:00'),
(122, 'USR121', 'PRD001', 150, 5.0, 'Good vibes, good protein!', '2025-09-19 14:00:00'),
(123, 'USR122', 'PRD002', 151, 4.9, 'Suaraku jadi lebih jernih. Suka banget!', '2025-09-20 15:00:00'),
(124, 'USR123', 'PRD007', 152, 4.7, 'Membantu menjaga elastisitas kulit saat diet.', '2025-09-21 03:00:00'),
(125, 'USR124', 'PRD005', 153, 4.6, 'Tehnya wangi dan menenangkan.', '2025-09-22 04:00:00'),
(126, 'USR126', 'PRD008', 154, 3.5, 'Biasa saja, tidak ada yang spesial.', '2025-09-23 05:00:00'),
(127, 'USR127', 'PRD001', 155, 4.8, 'Energi jadi lebih stabil untuk latihan dance.', '2025-09-24 06:00:00'),
(128, 'USR128', 'PRD003', 156, 1.0, 'Produk sudah mau expired! Seller tidak teliti.', '2025-09-25 07:00:00'),
(129, 'USR129', 'PRD006', 157, 4.9, 'Performance di panggung jadi lebih maksimal.', '2025-09-26 08:00:00'),
(130, 'USR130', 'PRD007', 158, 5.0, 'Wajah terlihat lebih muda, suka sekali!', '2025-09-27 09:00:00'),
(131, 'USR132', 'PRD001', 159, 4.7, 'Membantu membentuk abs.', '2025-09-28 10:00:00'),
(132, 'USR133', 'PRD001', 160, 4.8, 'Need this for my b-boy practice. It works.', '2025-09-29 11:00:00'),
(133, 'USR134', 'PRD002', 161, 4.9, 'Vitamin C penting untuk menjaga stamina saat comeback.', '2025-09-30 12:00:00'),
(134, 'USR136', 'PRD004', 162, 2.5, 'Tabletnya terlalu besar, sulit ditelan.', '2025-10-01 13:00:00'),
(135, 'USR137', 'PRD001', 163, 5.0, 'Wild and organic, just like me. Perfect!', '2025-10-02 14:00:00'),
(136, 'USR138', 'PRD007', 164, 4.8, 'My AI version recommends this. It is good.', '2025-10-03 15:00:00'),
(137, 'USR139', 'PRD003', 165, 4.9, 'Membantu berpikir lebih jernih saat membuat lirik.', '2025-10-04 03:00:00'),
(138, 'USR140', 'PRD002', 166, 4.7, 'Imun jadi lebih kuat, tidak gampang sakit.', '2025-10-05 04:00:00'),
(139, 'USR141', 'PRD008', 167, 4.6, 'Bagus untuk detoksifikasi.', '2025-10-06 05:00:00'),
(140, 'USR142', 'PRD004', 168, 4.5, 'Semua vitamin yang dibutuhkan ada di sini.', '2025-10-07 06:00:00'),
(141, 'USR143', 'PRD001', 169, 4.8, 'I am your hope, this is my protein!', '2025-10-08 07:00:00'),
(142, 'USR144', 'PRD006', 170, 2.0, 'Tidak cocok di perut saya, jadi mual.', '2025-10-09 08:00:00'),
(143, 'USR145', 'PRD007', 171, 5.0, 'Worldwide handsome approved!', '2025-10-10 09:00:00'),
(144, 'USR146', 'PRD008', 172, 4.7, 'Rasanya unik, tapi menyehatkan.', '2025-10-11 10:00:00'),
(145, 'USR147', 'PRD001', 173, 4.9, 'Perfect for recovery after dance practice.', '2025-10-12 11:00:00'),
(146, 'USR148', 'PRD001', 174, 1.0, 'This is not my style! Rasanya aneh!', '2025-10-13 12:00:00'),
(147, 'USR149', 'PRD003', 175, 4.8, 'Bagus untuk kesehatan kulit.', '2025-10-14 13:00:00'),
(148, 'USR150', 'PRD005', 176, 4.6, 'Suka tehnya, wanginya bikin rileks.', '2025-10-15 14:00:00'),
(149, 'USR152', 'PRD002', 177, 5.0, 'The baddest female loves this vitamin!', '2025-10-16 15:00:00'),
(150, 'USR154', 'PRD007', 178, 4.9, 'Membuat awet muda!', '2025-10-17 03:00:00'),
(151, 'USR156', 'PRD004', 179, 4.8, 'My number one choice for multivitamin.', '2025-10-18 04:00:00'),
(152, 'USR157', 'PRD001', 180, 4.9, 'Fantastic baby! This protein is fantastic!', '2025-10-19 05:00:00'),
(153, 'USR158', 'PRD008', 181, 4.7, 'Produk organik yang sangat bagus.', '2025-10-20 06:00:00'),
(154, 'USR159', 'PRD001', 182, 4.8, 'Membantu membentuk badan. Kualitas super.', '2025-10-21 07:00:00'),
(155, 'USR160', 'PRD005', 183, 2.5, 'Efek detox-nya tidak terlalu terasa.', '2025-10-22 08:00:00'),
(156, 'USR161', 'PRD003', 184, 4.6, 'Minyak ikannya tidak amis.', '2025-10-23 09:00:00'),
(157, 'USR162', 'PRD002', 185, 5.0, 'Like a sunshine, this vitamin brightens up my day!', '2025-10-24 10:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(11) NOT NULL,
  `product_id` varchar(10) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total_price` decimal(12,2) NOT NULL,
  `sale_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `product_id`, `quantity`, `total_price`, `sale_date`) VALUES
(396, 'PRD001', 4, 1196000.00, '2025-06-25'),
(397, 'PRD002', 4, 500000.00, '2025-06-25'),
(398, 'PRD003', 2, 370000.00, '2025-06-25'),
(399, 'PRD004', 5, 375000.00, '2025-06-25'),
(400, 'PRD005', 2, 190000.00, '2025-06-25'),
(401, 'PRD006', 3, 450000.00, '2025-06-25'),
(402, 'PRD007', 2, 440000.00, '2025-06-25'),
(403, 'PRD008', 2, 360000.00, '2025-06-25'),
(404, 'PRD003', 1, 185000.00, '2025-06-26'),
(405, 'PRD004', 1, 75000.00, '2025-06-27'),
(406, 'PRD001', 1, 299000.00, '2025-06-28'),
(407, 'PRD007', 1, 220000.00, '2025-06-28'),
(408, 'PRD001', 1, 299000.00, '2025-07-01'),
(409, 'PRD002', 1, 125000.00, '2025-07-01'),
(410, 'PRD003', 1, 185000.00, '2025-07-01'),
(411, 'PRD005', 1, 95000.00, '2025-07-01'),
(412, 'PRD007', 1, 220000.00, '2025-07-01'),
(413, 'PRD008', 1, 180000.00, '2025-07-02'),
(414, 'PRD007', 1, 220000.00, '2025-07-03'),
(415, 'PRD001', 1, 299000.00, '2025-07-05'),
(416, 'PRD002', 1, 125000.00, '2025-07-05'),
(417, 'PRD004', 5, 375000.00, '2025-07-05'),
(418, 'PRD006', 1, 150000.00, '2025-07-06'),
(419, 'PRD003', 1, 185000.00, '2025-07-07'),
(420, 'PRD007', 1, 220000.00, '2025-07-07'),
(421, 'PRD001', 1, 299000.00, '2025-07-09'),
(422, 'PRD001', 2, 598000.00, '2025-07-10'),
(423, 'PRD008', 1, 180000.00, '2025-07-11'),
(424, 'PRD001', 1, 299000.00, '2025-07-12'),
(425, 'PRD002', 2, 250000.00, '2025-07-12'),
(426, 'PRD007', 1, 220000.00, '2025-07-12'),
(427, 'PRD001', 1, 299000.00, '2025-07-13'),
(428, 'PRD003', 1, 185000.00, '2025-07-13'),
(429, 'PRD006', 1, 150000.00, '2025-07-13'),
(430, 'PRD001', 1, 299000.00, '2025-07-14'),
(431, 'PRD004', 1, 75000.00, '2025-07-14'),
(432, 'PRD007', 1, 220000.00, '2025-07-14'),
(433, 'PRD002', 1, 125000.00, '2025-07-15'),
(434, 'PRD003', 1, 185000.00, '2025-07-15'),
(435, 'PRD007', 1, 220000.00, '2025-07-15'),
(436, 'PRD001', 1, 299000.00, '2025-07-16'),
(437, 'PRD005', 1, 95000.00, '2025-07-16'),
(438, 'PRD007', 1, 220000.00, '2025-07-16'),
(439, 'PRD008', 1, 180000.00, '2025-07-16'),
(440, 'PRD001', 1, 299000.00, '2025-07-18'),
(441, 'PRD002', 1, 125000.00, '2025-07-18'),
(442, 'PRD004', 5, 375000.00, '2025-07-18'),
(443, 'PRD006', 1, 150000.00, '2025-07-18'),
(444, 'PRD007', 1, 220000.00, '2025-07-18'),
(445, 'PRD001', 1, 299000.00, '2025-07-19'),
(446, 'PRD003', 1, 185000.00, '2025-07-19'),
(447, 'PRD007', 1, 220000.00, '2025-07-19'),
(448, 'PRD001', 2, 598000.00, '2025-07-20'),
(449, 'PRD005', 1, 95000.00, '2025-07-20'),
(450, 'PRD002', 1, 125000.00, '2025-07-21'),
(451, 'PRD007', 1, 220000.00, '2025-07-21'),
(452, 'PRD008', 1, 180000.00, '2025-07-21'),
(453, 'PRD001', 1, 299000.00, '2025-07-23'),
(454, 'PRD002', 1, 125000.00, '2025-07-23'),
(455, 'PRD003', 1, 185000.00, '2025-07-23'),
(456, 'PRD004', 1, 75000.00, '2025-07-23'),
(457, 'PRD006', 1, 150000.00, '2025-07-24'),
(458, 'PRD007', 1, 220000.00, '2025-07-24'),
(459, 'PRD001', 1, 299000.00, '2025-07-25'),
(460, 'PRD001', 1, 299000.00, '2025-07-26'),
(461, 'PRD002', 2, 250000.00, '2025-07-26'),
(462, 'PRD001', 1, 299000.00, '2025-07-28'),
(463, 'PRD003', 1, 185000.00, '2025-07-28'),
(464, 'PRD004', 1, 75000.00, '2025-07-28'),
(465, 'PRD006', 1, 150000.00, '2025-07-28'),
(466, 'PRD007', 1, 220000.00, '2025-07-29'),
(467, 'PRD008', 1, 180000.00, '2025-07-29'),
(468, 'PRD001', 1, 299000.00, '2025-07-30'),
(469, 'PRD002', 1, 125000.00, '2025-07-30'),
(470, 'PRD003', 1, 185000.00, '2025-07-31'),
(471, 'PRD004', 1, 75000.00, '2025-07-31'),
(472, 'PRD001', 1, 299000.00, '2025-08-02'),
(473, 'PRD006', 1, 150000.00, '2025-08-02'),
(474, 'PRD007', 1, 220000.00, '2025-08-02'),
(475, 'PRD008', 1, 180000.00, '2025-08-02'),
(476, 'PRD001', 1, 299000.00, '2025-08-03'),
(477, 'PRD002', 1, 125000.00, '2025-08-03'),
(478, 'PRD003', 1, 185000.00, '2025-08-04'),
(479, 'PRD004', 1, 75000.00, '2025-08-04'),
(480, 'PRD001', 1, 299000.00, '2025-08-05'),
(481, 'PRD006', 1, 150000.00, '2025-08-05'),
(482, 'PRD001', 1, 299000.00, '2025-08-07'),
(483, 'PRD002', 1, 125000.00, '2025-08-07'),
(484, 'PRD007', 1, 220000.00, '2025-08-07'),
(485, 'PRD008', 1, 180000.00, '2025-08-07'),
(486, 'PRD003', 1, 185000.00, '2025-08-08'),
(487, 'PRD004', 1, 75000.00, '2025-08-08'),
(488, 'PRD001', 1, 299000.00, '2025-08-09'),
(489, 'PRD006', 1, 150000.00, '2025-08-09'),
(490, 'PRD007', 1, 220000.00, '2025-08-10'),
(491, 'PRD008', 1, 180000.00, '2025-08-10'),
(492, 'PRD001', 1, 299000.00, '2025-08-12'),
(493, 'PRD002', 1, 125000.00, '2025-08-12'),
(494, 'PRD003', 1, 185000.00, '2025-08-12'),
(495, 'PRD004', 1, 75000.00, '2025-08-12'),
(496, 'PRD001', 1, 299000.00, '2025-08-13'),
(497, 'PRD006', 1, 150000.00, '2025-08-13'),
(498, 'PRD007', 1, 220000.00, '2025-08-14'),
(499, 'PRD008', 1, 180000.00, '2025-08-14'),
(500, 'PRD001', 1, 299000.00, '2025-08-15'),
(501, 'PRD002', 1, 125000.00, '2025-08-15'),
(502, 'PRD001', 1, 299000.00, '2025-08-17'),
(503, 'PRD003', 1, 185000.00, '2025-08-17'),
(504, 'PRD004', 1, 75000.00, '2025-08-17'),
(505, 'PRD006', 1, 150000.00, '2025-08-17'),
(506, 'PRD007', 1, 220000.00, '2025-08-18'),
(507, 'PRD008', 1, 180000.00, '2025-08-18'),
(508, 'PRD001', 1, 299000.00, '2025-08-19'),
(509, 'PRD002', 1, 125000.00, '2025-08-19'),
(510, 'PRD003', 1, 185000.00, '2025-08-20'),
(511, 'PRD004', 1, 75000.00, '2025-08-20'),
(512, 'PRD001', 1, 299000.00, '2025-08-22'),
(513, 'PRD006', 1, 150000.00, '2025-08-22'),
(514, 'PRD007', 1, 220000.00, '2025-08-22'),
(515, 'PRD008', 1, 180000.00, '2025-08-22'),
(516, 'PRD001', 1, 299000.00, '2025-08-23'),
(517, 'PRD002', 1, 125000.00, '2025-08-23'),
(518, 'PRD003', 1, 185000.00, '2025-08-24'),
(519, 'PRD004', 1, 75000.00, '2025-08-24'),
(520, 'PRD001', 1, 299000.00, '2025-08-25'),
(521, 'PRD006', 1, 150000.00, '2025-08-25'),
(522, 'PRD001', 1, 299000.00, '2025-08-27'),
(523, 'PRD002', 1, 125000.00, '2025-08-27'),
(524, 'PRD007', 1, 220000.00, '2025-08-27'),
(525, 'PRD008', 1, 180000.00, '2025-08-27'),
(526, 'PRD003', 1, 185000.00, '2025-08-28'),
(527, 'PRD004', 1, 75000.00, '2025-08-28'),
(528, 'PRD001', 1, 299000.00, '2025-08-29'),
(529, 'PRD002', 1, 125000.00, '2025-08-29'),
(530, 'PRD003', 1, 185000.00, '2025-08-30'),
(531, 'PRD004', 1, 75000.00, '2025-08-30'),
(532, 'PRD001', 2, 598000.00, '2025-09-01'),
(533, 'PRD002', 1, 125000.00, '2025-09-01'),
(534, 'PRD003', 1, 185000.00, '2025-09-01'),
(535, 'PRD006', 1, 150000.00, '2025-09-01'),
(536, 'PRD001', 1, 299000.00, '2025-09-02'),
(537, 'PRD005', 1, 95000.00, '2025-09-02'),
(538, 'PRD003', 1, 185000.00, '2025-09-03'),
(539, 'PRD004', 1, 75000.00, '2025-09-03'),
(540, 'PRD001', 1, 299000.00, '2025-09-04'),
(541, 'PRD006', 1, 150000.00, '2025-09-04'),
(542, 'PRD007', 1, 220000.00, '2025-09-04'),
(543, 'PRD001', 1, 299000.00, '2025-09-05'),
(544, 'PRD005', 1, 95000.00, '2025-09-05'),
(545, 'PRD007', 1, 220000.00, '2025-09-05'),
(546, 'PRD008', 1, 180000.00, '2025-09-05'),
(547, 'PRD001', 1, 299000.00, '2025-09-06'),
(548, 'PRD002', 1, 125000.00, '2025-09-06'),
(549, 'PRD001', 1, 299000.00, '2025-09-07'),
(550, 'PRD003', 1, 185000.00, '2025-09-07'),
(551, 'PRD006', 1, 150000.00, '2025-09-07'),
(552, 'PRD001', 1, 299000.00, '2025-09-08'),
(553, 'PRD004', 1, 75000.00, '2025-09-08'),
(554, 'PRD007', 1, 220000.00, '2025-09-08'),
(555, 'PRD002', 1, 125000.00, '2025-09-09'),
(556, 'PRD003', 1, 185000.00, '2025-09-09'),
(557, 'PRD007', 1, 220000.00, '2025-09-09'),
(558, 'PRD001', 1, 299000.00, '2025-09-10'),
(559, 'PRD005', 1, 95000.00, '2025-09-10'),
(560, 'PRD007', 1, 220000.00, '2025-09-10'),
(561, 'PRD008', 1, 180000.00, '2025-09-10'),
(562, 'PRD001', 1, 299000.00, '2025-09-11'),
(563, 'PRD002', 1, 125000.00, '2025-09-11'),
(564, 'PRD007', 1, 220000.00, '2025-09-11'),
(565, 'PRD004', 5, 375000.00, '2025-09-12'),
(566, 'PRD006', 1, 150000.00, '2025-09-12'),
(567, 'PRD001', 1, 299000.00, '2025-09-13'),
(568, 'PRD003', 1, 185000.00, '2025-09-13'),
(569, 'PRD007', 1, 220000.00, '2025-09-13'),
(570, 'PRD001', 2, 598000.00, '2025-09-14'),
(571, 'PRD005', 1, 95000.00, '2025-09-14'),
(572, 'PRD002', 1, 125000.00, '2025-09-15'),
(573, 'PRD007', 1, 220000.00, '2025-09-15'),
(574, 'PRD008', 1, 180000.00, '2025-09-15'),
(575, 'PRD001', 1, 299000.00, '2025-09-17'),
(576, 'PRD004', 1, 75000.00, '2025-09-17'),
(577, 'PRD006', 1, 150000.00, '2025-09-18'),
(578, 'PRD007', 1, 220000.00, '2025-09-18'),
(579, 'PRD001', 1, 299000.00, '2025-09-19'),
(580, 'PRD008', 1, 180000.00, '2025-09-19'),
(581, 'PRD001', 1, 299000.00, '2025-09-20'),
(582, 'PRD002', 2, 250000.00, '2025-09-20'),
(583, 'PRD003', 1, 185000.00, '2025-09-21'),
(584, 'PRD004', 1, 75000.00, '2025-09-21'),
(585, 'PRD001', 1, 299000.00, '2025-09-22'),
(586, 'PRD006', 1, 150000.00, '2025-09-22'),
(587, 'PRD007', 1, 220000.00, '2025-09-23'),
(588, 'PRD008', 1, 180000.00, '2025-09-23'),
(589, 'PRD001', 1, 299000.00, '2025-09-24'),
(590, 'PRD002', 1, 125000.00, '2025-09-24'),
(591, 'PRD003', 1, 185000.00, '2025-09-25'),
(592, 'PRD004', 1, 75000.00, '2025-09-25'),
(593, 'PRD001', 1, 299000.00, '2025-09-26'),
(594, 'PRD006', 1, 150000.00, '2025-09-26'),
(595, 'PRD007', 1, 220000.00, '2025-09-26'),
(596, 'PRD001', 1, 299000.00, '2025-09-27'),
(597, 'PRD008', 1, 180000.00, '2025-09-27'),
(598, 'PRD002', 1, 125000.00, '2025-09-28'),
(599, 'PRD003', 1, 185000.00, '2025-09-28'),
(600, 'PRD001', 1, 299000.00, '2025-09-29'),
(601, 'PRD004', 1, 75000.00, '2025-09-29'),
(602, 'PRD006', 1, 150000.00, '2025-09-29'),
(603, 'PRD001', 2, 598000.00, '2025-09-30'),
(604, 'PRD008', 2, 360000.00, '2025-09-30');

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
('USR008', 'Rina Wati', 'rina@email.com', '', '081234567808', 'female', 26, 58.00, 162.00, 'Premium', 'pending', 'pending', '2025-06-24 17:18:32', '2025-06-24 17:18:32'),
('USR009', 'Eka Putra', 'eka@email.com', '', '081234567809', 'male', 40, 85.20, 168.00, 'Reguler', 'active', 'pending', '2025-06-25 17:18:32', '2025-06-25 17:18:32'),
('USR010', 'Fitriani', 'fitri@email.com', '', '081234567810', 'female', 22, 50.50, 155.00, 'Premium', 'active', 'active', '2025-06-26 17:18:32', '2025-07-05 13:01:57'),
('USR011', 'Guntur Wibowo', 'guntur@email.com', '', '081234567811', 'male', 33, 78.00, 180.00, 'Reguler', 'inactive', 'inactive', '2025-06-27 17:18:32', '2025-07-06 13:01:57'),
('USR012', 'Hesti Puspita', 'hesti@email.com', '', '081234567812', 'female', 31, 62.30, 163.00, 'Premium', 'active', 'pending', '2025-06-28 17:18:32', '2025-06-28 17:18:32'),
('USR013', 'Irfan Hakim', 'irfan@email.com', '', '081234567813', 'male', 28, 72.00, 177.00, 'Premium', 'active', 'active', '2025-06-29 17:18:32', '2025-07-07 13:01:57'),
('USR014', 'Jihan Aulia', 'jihan@email.com', '', '081234567814', 'female', 24, 53.00, 159.00, 'Reguler', 'pending', 'pending', '2025-06-30 17:18:32', '2025-06-30 17:18:32'),
('USR015', 'Kartika Putri', 'kartika@email.com', '', '081234567815', 'female', 29, 59.50, 164.00, 'Premium', 'active', 'inactive', '2025-07-01 17:18:32', '2025-07-08 13:01:57'),
('USR016', 'Lukman Sardi', 'lukman@email.com', '', '081234567816', 'male', 45, 90.00, 175.00, 'Reguler', 'active', 'active', '2025-07-02 17:18:32', '2025-07-09 13:01:57'),
('USR017', 'Nina Zatulini', 'nina@email.com', '', '081234567817', 'female', 26, 54.00, 161.00, 'Premium', 'inactive', 'pending', '2025-07-03 17:18:32', '2025-07-03 17:18:32'),
('USR018', 'Surya Saputra', 'surya@email.com', '', '081234567818', 'male', 38, 82.50, 176.00, 'Premium', 'active', 'active', '2025-07-04 17:18:32', '2025-07-10 13:01:57'),
('USR019', 'Tika Ramlan', 'tika@email.com', '', '081234567819', 'female', 34, 65.00, 166.00, 'Reguler', 'active', 'inactive', '2025-07-05 17:18:32', '2025-07-11 13:01:57'),
('USR020', 'Doni Kusuma', 'doni@email.com', '', '081234567820', 'male', 31, 74.00, 174.00, 'Premium', 'pending', 'pending', '2025-07-06 17:18:32', '2025-07-06 17:18:32'),
('USR021', 'Citra Kirana', 'citra@email.com', '', '081234567821', 'female', 28, 56.80, 168.00, 'Premium', 'active', 'active', '2025-07-07 17:18:32', '2025-07-12 13:01:57'),
('USR022', 'Dimas Anggara', 'dimas@email.com', '', '081234567822', 'male', 30, 71.50, 179.00, 'Reguler', 'active', 'pending', '2025-07-08 17:18:32', '2025-07-08 17:18:32'),
('USR023', 'Wulan Guritno', 'wulan@email.com', '', '081234567823', 'female', 41, 55.00, 165.00, 'Premium', 'inactive', 'inactive', '2025-07-09 17:18:32', '2025-07-09 17:18:32'),
('USR024', 'Fajar Nugraha', 'fajar@email.com', '', '081234567824', 'male', 26, 65.00, 170.00, 'Premium', 'active', 'active', '2025-07-10 17:18:32', '2025-07-11 13:01:57'),
('USR025', 'Zaskia Adya Mecca', 'zaskia@email.com', '', '081234567825', 'female', 36, 61.00, 167.00, 'Reguler', 'active', 'active', '2025-07-11 17:18:32', '2025-07-12 13:01:57'),
('USR026', 'Gilang Dirga', 'gilang@email.com', '', '081234567826', 'male', 34, 95.00, 182.00, 'Premium', 'active', 'pending', '2025-07-12 17:18:32', '2025-07-12 17:18:32'),
('USR027', 'Yasmine Wildblood', 'yasmine@email.com', '', '081234567827', 'female', 32, 57.50, 170.00, 'Premium', 'pending', 'pending', '2025-07-13 17:18:32', '2025-07-13 17:18:32'),
('USR028', 'Herjunot Ali', 'herjunot@email.com', '', '081234567828', 'male', 38, 76.00, 181.00, 'Reguler', 'active', 'inactive', '2025-07-14 17:18:32', '2025-07-14 13:01:57'),
('USR029', 'Vino G. Bastian', 'vino@email.com', '', '081234567829', 'male', 41, 70.00, 178.00, 'Premium', 'active', 'active', '2025-07-15 17:18:32', '2025-07-15 13:01:57'),
('USR030', 'Marsha Timothy', 'marsha@email.com', '', '081234567830', 'female', 44, 54.00, 164.00, 'Premium', 'inactive', 'pending', '2025-07-16 17:18:32', '2025-07-16 17:18:32'),
('USR031', 'Reza Rahadian', 'reza@email.com', '', '081234567831', 'male', 36, 73.50, 177.00, 'Premium', 'active', 'active', '2025-07-17 17:18:32', '2025-07-17 13:01:57'),
('USR032', 'Bunga Citra Lestari', 'bcl@email.com', '', '081234567832', 'female', 40, 52.00, 160.00, 'Premium', 'active', 'inactive', '2025-07-18 17:18:32', '2025-07-18 13:01:57'),
('USR033', 'Christian Sugiono', 'csugiono@email.com', '', '081234567833', 'male', 42, 80.00, 185.00, 'Reguler', 'pending', 'pending', '2025-07-19 17:18:32', '2025-07-19 17:18:32'),
('USR034', 'Titi Kamal', 'titi@email.com', '', '081234567834', 'female', 41, 58.00, 169.00, 'Premium', 'active', 'active', '2025-07-20 17:18:32', '2025-07-20 13:01:57'),
('USR035', 'Adipati Dolken', 'adipati@email.com', '', '081234567835', 'male', 31, 68.00, 176.00, 'Premium', 'active', 'pending', '2025-07-21 17:18:32', '2025-07-21 17:18:32'),
('USR036', 'Pevita Pearce', 'pevita@email.com', '', '081234567836', 'female', 30, 53.00, 165.00, 'Premium', 'active', 'active', '2025-07-22 17:18:32', '2025-07-22 13:01:57'),
('USR037', 'Chicco Jerikho', 'chicco@email.com', '', '081234567837', 'male', 39, 75.00, 180.00, 'Reguler', 'inactive', 'inactive', '2025-07-23 17:18:32', '2025-07-23 17:18:32'),
('USR038', 'Putri Marino', 'putri@email.com', '', '081234567838', 'female', 29, 51.00, 162.00, 'Premium', 'active', 'pending', '2025-07-24 17:18:32', '2025-07-24 17:18:32'),
('USR039', 'Iko Uwais', 'iko@email.com', '', '081234567839', 'male', 40, 69.00, 172.00, 'Premium', 'active', 'active', '2025-07-25 17:18:32', '2025-07-25 13:01:57'),
('USR040', 'Audy Item', 'audy@email.com', '', '081234567840', 'female', 40, 70.00, 168.00, 'Reguler', 'active', 'inactive', '2025-07-26 17:18:32', '2025-07-26 13:01:57'),
('USR041', 'Joe Taslim', 'joe@email.com', '', '081234567841', 'male', 42, 80.00, 180.00, 'Premium', 'pending', 'pending', '2025-07-27 17:18:32', '2025-07-27 17:18:32'),
('USR042', 'Atiqah Hasiholan', 'atiqah@email.com', '', '081234567842', 'female', 41, 56.00, 167.00, 'Premium', 'active', 'active', '2025-07-28 17:18:32', '2025-07-28 13:01:57'),
('USR043', 'Rio Dewanto', 'rio@email.com', '', '081234567843', 'male', 35, 78.00, 183.00, 'Reguler', 'active', 'pending', '2025-07-29 17:18:32', '2025-07-29 17:18:32'),
('USR044', 'Laura Basuki', 'laura@email.com', '', '081234567844', 'female', 35, 50.00, 174.00, 'Premium', 'inactive', 'inactive', '2025-07-30 17:18:32', '2025-07-30 17:18:32'),
('USR045', 'Nicholas Saputra', 'nicholas@email.com', '', '081234567845', 'male', 39, 77.00, 181.00, 'Premium', 'active', 'active', '2025-07-31 17:18:32', '2025-07-31 13:01:57'),
('USR046', 'Dian Sastrowardoyo', 'dian@email.com', '', '081234567846', 'female', 41, 55.00, 165.00, 'Premium', 'active', 'active', '2025-08-01 17:18:32', '2025-08-01 13:01:57'),
('USR047', 'Samuel Rizal', 'samuel@email.com', '', '081234567847', 'male', 42, 79.00, 182.00, 'Reguler', 'pending', 'pending', '2025-08-02 17:18:32', '2025-08-02 17:18:32'),
('USR048', 'Shandy Aulia', 'shandy@email.com', '', '081234567848', 'female', 36, 48.00, 164.00, 'Premium', 'active', 'pending', '2025-08-03 17:18:32', '2025-08-03 17:18:32'),
('USR049', 'Fedi Nuril', 'fedi@email.com', '', '081234567849', 'male', 41, 72.00, 175.00, 'Premium', 'active', 'inactive', '2025-08-04 17:18:32', '2025-08-04 13:01:57'),
('USR050', 'Rianti Cartwright', 'rianti@email.com', '', '081234567850', 'female', 39, 57.00, 169.00, 'Reguler', 'active', 'active', '2025-08-05 17:18:32', '2025-08-05 13:01:57'),
('USR051', 'Agus Kuncoro', 'agus@email.com', '', '081234567851', 'male', 51, 68.50, 170.00, 'Premium', 'inactive', 'pending', '2025-08-06 17:18:32', '2025-08-06 17:18:32'),
('USR052', 'Luna Maya', 'luna@email.com', '', '081234567852', 'female', 39, 59.00, 173.00, 'Premium', 'active', 'active', '2025-08-07 17:18:32', '2025-08-07 13:01:57'),
('USR053', 'Dwi Sasono', 'dwi@email.com', '', '081234567853', 'male', 43, 88.00, 178.00, 'Reguler', 'active', 'inactive', '2025-08-08 17:18:32', '2025-08-08 13:01:57'),
('USR054', 'Widi Mulia', 'widi@email.com', '', '081234567854', 'female', 44, 53.50, 163.00, 'Premium', 'pending', 'pending', '2025-08-09 17:18:32', '2025-08-09 17:18:32'),
('USR055', 'Oka Antara', 'oka@email.com', '', '081234567855', 'male', 42, 74.00, 179.00, 'Premium', 'active', 'active', '2025-08-10 17:18:32', '2025-08-10 13:01:57'),
('USR056', 'Raline Shah', 'raline@email.com', '', '081234567856', 'female', 38, 55.00, 171.00, 'Premium', 'active', 'pending', '2025-08-11 17:18:32', '2025-08-11 17:18:32'),
('USR057', 'Ario Bayu', 'ario@email.com', '', '081234567857', 'male', 38, 81.00, 184.00, 'Reguler', 'inactive', 'inactive', '2025-08-12 17:18:32', '2025-08-12 17:18:32'),
('USR058', 'Hannah Al Rashid', 'hannah@email.com', '', '081234567858', 'female', 37, 60.00, 170.00, 'Premium', 'active', 'active', '2025-08-13 17:18:32', '2025-08-13 13:01:57'),
('USR059', 'Abimana Aryasatya', 'abimana@email.com', '', '081234567859', 'male', 40, 76.50, 178.00, 'Premium', 'active', 'inactive', '2025-08-14 17:18:32', '2025-08-14 13:01:57'),
('USR060', 'Tara Basro', 'tara@email.com', '', '081234567860', 'female', 33, 63.00, 164.00, 'Premium', 'active', 'active', '2025-08-15 17:18:32', '2025-08-15 13:01:57'),
('USR061', 'Morgan Oey', 'morgan@email.com', '', '081234567861', 'male', 33, 69.00, 175.00, 'Reguler', 'pending', 'pending', '2025-08-16 17:18:32', '2025-08-16 17:18:32'),
('USR062', 'Chelsea Islan', 'chelsea@email.com', '', '081234567862', 'female', 28, 52.00, 166.00, 'Premium', 'active', 'pending', '2025-08-17 17:18:32', '2025-08-17 17:18:32'),
('USR063', 'Deva Mahenra', 'deva@email.com', '', '081234567863', 'male', 33, 73.00, 180.00, 'Premium', 'active', 'active', '2025-08-18 17:18:32', '2025-08-18 13:01:57'),
('USR064', 'Maudy Ayunda', 'maudy@email.com', '', '081234567864', 'female', 28, 50.00, 165.00, 'Premium', 'inactive', 'inactive', '2025-08-19 17:18:32', '2025-08-19 17:18:32'),
('USR065', 'Jefri Nichol', 'jefri@email.com', '', '081234567865', 'male', 24, 67.00, 174.00, 'Reguler', 'active', 'active', '2025-08-20 17:18:32', '2025-08-20 13:01:57'),
('USR066', 'Caitlin Halderman', 'caitlin@email.com', '', '081234567866', 'female', 23, 54.00, 168.00, 'Premium', 'active', 'pending', '2025-08-21 17:18:32', '2025-08-21 17:18:32'),
('USR067', 'Angga Yunanda', 'angga@email.com', '', '081234567867', 'male', 23, 66.00, 175.00, 'Premium', 'pending', 'pending', '2025-08-22 17:18:32', '2025-08-22 17:18:32'),
('USR068', 'Adhisty Zara', 'zara@email.com', '', '081234567868', 'female', 20, 48.00, 160.00, 'Reguler', 'active', 'active', '2025-08-23 17:18:32', '2025-08-23 13:01:57'),
('USR069', 'Iqbaal Ramadhan', 'iqbaal@email.com', '', '081234567869', 'male', 23, 65.00, 172.00, 'Premium', 'active', 'inactive', '2025-08-24 17:18:32', '2025-08-24 13:01:57'),
('USR070', 'Vanesha Prescilla', 'vanesha@email.com', '', '081234567870', 'female', 23, 51.00, 164.00, 'Premium', 'active', 'active', '2025-08-25 17:18:32', '2025-08-25 13:01:57'),
('USR071', 'Bryan Domani', 'bryan@email.com', '', '081234567871', 'male', 23, 70.00, 178.00, 'Reguler', 'inactive', 'pending', '2025-08-26 17:18:32', '2025-08-26 17:18:32'),
('USR072', 'Megan Domani', 'megan@email.com', '', '081234567872', 'female', 21, 53.00, 169.00, 'Premium', 'active', 'active', '2025-08-27 17:18:32', '2025-08-27 13:01:57'),
('USR073', 'Jerome Polin', 'jerome@email.com', '', '081234567873', 'male', 25, 68.00, 177.00, 'Premium', 'active', 'pending', '2025-08-28 17:18:32', '2025-08-28 17:18:32'),
('USR074', 'Jessica Jane', 'jessica@email.com', '', '081234567874', 'female', 24, 49.00, 161.00, 'Reguler', 'pending', 'pending', '2025-08-29 17:18:32', '2025-08-29 17:18:32'),
('USR075', 'Al Ghazali', 'al@email.com', '', '081234567875', 'male', 25, 71.00, 176.00, 'Premium', 'active', 'active', '2025-08-30 17:18:32', '2025-08-30 13:01:57'),
('USR076', 'El Rumi', 'el@email.com', '', '081234567876', 'male', 24, 75.00, 178.00, 'Premium', 'active', 'inactive', '2025-08-31 17:18:32', '2025-08-31 13:01:57'),
('USR077', 'Dul Jaelani', 'dul@email.com', '', '081234567877', 'male', 22, 69.00, 175.00, 'Reguler', 'active', 'active', '2025-09-01 17:18:32', '2025-09-01 13:01:57'),
('USR078', 'Aaliyah Massaid', 'aaliyah@email.com', '', '081234567878', 'female', 21, 55.00, 167.00, 'Premium', 'inactive', 'pending', '2025-09-02 17:18:32', '2025-09-02 17:18:32'),
('USR079', 'Verrell Bramasta', 'verrell@email.com', '', '081234567879', 'male', 26, 78.00, 183.00, 'Premium', 'active', 'active', '2025-09-03 17:18:32', '2025-09-03 13:01:57'),
('USR080', 'Natasha Wilona', 'natasha@email.com', '', '081234567880', 'female', 24, 52.50, 166.00, 'Premium', 'active', 'pending', '2025-09-04 17:18:32', '2025-09-04 17:18:32'),
('USR081', 'Stefan William', 'stefan@email.com', '', '081234567881', 'male', 30, 74.00, 176.00, 'Reguler', 'pending', 'pending', '2025-09-05 17:18:32', '2025-09-05 17:18:32'),
('USR082', 'Celine Evangelista', 'celine@email.com', '', '081234567882', 'female', 31, 58.00, 169.00, 'Premium', 'active', 'active', '2025-09-06 17:18:32', '2025-09-06 13:01:57'),
('USR083', 'Rizky Nazar', 'rizky.n@email.com', '', '081234567883', 'male', 27, 69.50, 178.00, 'Premium', 'active', 'inactive', '2025-09-07 17:18:32', '2025-09-07 13:01:57'),
('USR084', 'Syifa Hadju', 'syifa@email.com', '', '081234567884', 'female', 23, 50.50, 163.00, 'Premium', 'active', 'active', '2025-09-08 17:18:32', '2025-09-08 13:01:57'),
('USR085', 'Randy Martin', 'randy@email.com', '', '081234567885', 'male', 24, 65.00, 173.00, 'Reguler', 'inactive', 'pending', '2025-09-09 17:18:32', '2025-09-09 17:18:32'),
('USR086', 'Cassandra Lee', 'cassandra@email.com', '', '081234567886', 'female', 22, 54.00, 165.00, 'Premium', 'active', 'active', '2025-09-10 17:18:32', '2025-09-10 13:01:57'),
('USR087', 'Harris Vriza', 'harris@email.com', '', '081234567887', 'male', 29, 72.00, 179.00, 'Premium', 'active', 'pending', '2025-09-11 17:18:32', '2025-09-11 17:18:32'),
('USR088', 'Ria Ricis', 'ricis@email.com', '', '081234567888', 'female', 28, 55.00, 158.00, 'Reguler', 'pending', 'pending', '2025-09-12 17:18:32', '2025-09-12 17:18:32'),
('USR089', 'Teuku Ryan', 'ryan.t@email.com', '', '081234567889', 'male', 29, 70.00, 174.00, 'Premium', 'active', 'active', '2025-09-13 17:18:32', '2025-09-13 13:01:57'),
('USR090', 'Oki Setiana Dewi', 'oki@email.com', '', '081234567890', 'female', 34, 68.00, 165.00, 'Premium', 'active', 'inactive', '2025-09-14 17:18:32', '2025-09-14 13:01:57'),
('USR091', 'Arya Saloka', 'arya.s@email.com', '', '081234567891', 'male', 32, 75.00, 177.00, 'Premium', 'active', 'active', '2025-09-15 17:18:32', '2025-09-15 13:01:57'),
('USR092', 'Amanda Manopo', 'amanda@email.com', '', '081234567892', 'female', 23, 56.00, 167.00, 'Reguler', 'inactive', 'pending', '2025-09-16 17:18:32', '2025-09-16 17:18:32'),
('USR093', 'Evan Sanders', 'evan@email.com', '', '081234567893', 'male', 41, 79.00, 180.00, 'Premium', 'active', 'active', '2025-09-17 17:18:32', '2025-09-17 13:01:57'),
('USR094', 'Glenca Chysara', 'glenca@email.com', '', '081234567894', 'female', 28, 53.00, 164.00, 'Premium', 'active', 'pending', '2025-09-18 17:18:32', '2025-09-18 17:18:32'),
('USR095', 'Rizky Billar', 'rizky.b@email.com', '', '081234567895', 'male', 28, 71.00, 175.00, 'Reguler', 'pending', 'pending', '2025-09-19 17:18:32', '2025-09-19 17:18:32'),
('USR096', 'Lesti Kejora', 'lesti@email.com', '', '081234567896', 'female', 24, 47.00, 155.00, 'Premium', 'active', 'active', '2025-09-20 17:18:32', '2025-09-20 13:01:57'),
('USR097', 'Atta Halilintar', 'atta@email.com', '', '081234567897', 'male', 28, 68.00, 172.00, 'Premium', 'active', 'inactive', '2025-09-21 17:18:32', '2025-09-21 13:01:57'),
('USR098', 'Aurel Hermansyah', 'aurel@email.com', '', '081234567898', 'female', 25, 65.00, 163.00, 'Premium', 'active', 'active', '2025-09-22 17:18:32', '2025-09-22 13:01:57'),
('USR099', 'Thariq Halilintar', 'thariq@email.com', '', '081234567899', 'male', 24, 67.00, 174.00, 'Reguler', 'inactive', 'pending', '2025-09-23 17:18:32', '2025-09-23 17:18:32'),
('USR100', 'Fuji Utami', 'fuji@email.com', '', '081234567900', 'female', 21, 49.00, 159.00, 'Premium', 'active', 'active', '2025-09-24 17:18:32', '2025-09-24 13:01:57'),
('USR101', 'Lee Min Ho', 'lee.minho@email.com', '', '081234567101', 'male', 36, 71.00, 187.00, 'Premium', 'active', 'active', '2025-07-13 03:00:00', '2025-07-13 03:00:00'),
('USR102', 'IU (Lee Ji-eun)', 'iu.jieun@email.com', '', '081234567102', 'female', 30, 47.00, 162.00, 'Premium', 'active', 'active', '2025-07-13 03:05:00', '2025-07-13 03:05:00'),
('USR103', 'Gong Yoo', 'gong.yoo@email.com', '', '081234567103', 'male', 44, 74.00, 184.00, 'Premium', 'active', 'pending', '2025-07-13 03:10:00', '2025-07-13 03:10:00'),
('USR104', 'Bae Suzy', 'bae.suzy@email.com', '', '081234567104', 'female', 28, 48.00, 168.00, 'Reguler', 'active', 'inactive', '2025-07-13 03:15:00', '2025-07-13 03:15:00'),
('USR105', 'Hyun Bin', 'hyun.bin@email.com', '', '081234567105', 'male', 41, 74.00, 185.00, 'Premium', 'inactive', 'pending', '2025-07-13 03:20:00', '2025-07-13 03:20:00'),
('USR106', 'Song Hye Kyo', 'song.hyekyo@email.com', '', '081234567106', 'female', 41, 45.00, 161.00, 'Premium', 'active', 'active', '2025-07-13 03:25:00', '2025-07-13 03:25:00'),
('USR107', 'Park Seo Joon', 'park.seojoon@email.com', '', '081234567107', 'male', 34, 69.00, 185.00, 'Reguler', 'active', 'active', '2025-07-13 03:30:00', '2025-07-13 03:30:00'),
('USR108', 'Jennie Kim', 'jennie.kim@email.com', '', '081234567108', 'female', 27, 45.00, 163.00, 'Premium', 'active', 'pending', '2025-07-13 03:35:00', '2025-07-13 03:35:00'),
('USR109', 'Jungkook', 'jungkook.bts@email.com', '', '081234567109', 'male', 26, 70.00, 178.00, 'Premium', 'active', 'active', '2025-07-13 03:40:00', '2025-07-13 03:40:00'),
('USR110', 'Jisoo Kim', 'jisoo.kim@email.com', '', '081234567110', 'female', 28, 45.00, 162.00, 'Reguler', 'pending', 'pending', '2025-07-13 03:45:00', '2025-07-13 03:45:00'),
('USR111', 'Cha Eun Woo', 'cha.eunwoo@email.com', '', '081234567111', 'male', 26, 73.00, 183.00, 'Premium', 'active', 'inactive', '2025-07-13 03:50:00', '2025-07-13 03:50:00'),
('USR112', 'Lisa Manoban', 'lisa.manoban@email.com', '', '081234567112', 'female', 26, 46.00, 167.00, 'Premium', 'active', 'active', '2025-07-13 03:55:00', '2025-07-13 03:55:00'),
('USR113', 'Ji Chang Wook', 'ji.changwook@email.com', '', '081234567113', 'male', 36, 65.00, 182.00, 'Reguler', 'active', 'pending', '2025-07-13 04:00:00', '2025-07-13 04:00:00'),
('USR114', 'Rosé Park', 'rose.park@email.com', '', '081234567114', 'female', 26, 46.00, 168.00, 'Premium', 'active', 'active', '2025-07-13 04:05:00', '2025-07-13 04:05:00'),
('USR115', 'Kim Soo Hyun', 'kim.soohyun@email.com', '', '081234567115', 'male', 35, 65.00, 180.00, 'Premium', 'inactive', 'pending', '2025-07-13 04:10:00', '2025-07-13 04:10:00'),
('USR116', 'Nayeon', 'nayeon.twice@email.com', '', '081234567116', 'female', 27, 47.00, 163.00, 'Reguler', 'active', 'inactive', '2025-07-13 04:15:00', '2025-07-13 04:15:00'),
('USR117', 'Song Joong Ki', 'song.joongki@email.com', '', '081234567117', 'male', 37, 65.00, 178.00, 'Premium', 'active', 'active', '2025-07-13 04:20:00', '2025-07-13 04:20:00'),
('USR118', 'Tzuyu', 'tzuyu.twice@email.com', '', '081234567118', 'female', 24, 48.00, 172.00, 'Premium', 'active', 'pending', '2025-07-13 04:25:00', '2025-07-13 04:25:00'),
('USR119', 'Lee Jong Suk', 'lee.jongsuk@email.com', '', '081234567119', 'male', 33, 65.00, 186.00, 'Reguler', 'active', 'active', '2025-07-13 04:30:00', '2025-07-13 04:30:00'),
('USR120', 'Sana Minatozaki', 'sana.twice@email.com', '', '081234567120', 'female', 26, 48.00, 168.00, 'Premium', 'pending', 'pending', '2025-07-13 04:35:00', '2025-07-13 04:35:00'),
('USR121', 'V (Kim Taehyung)', 'v.bts@email.com', '', '081234567121', 'male', 27, 63.00, 179.00, 'Premium', 'active', 'inactive', '2025-07-13 04:40:00', '2025-07-13 04:40:00'),
('USR122', 'Taeyeon', 'taeyeon.snsd@email.com', '', '081234567122', 'female', 34, 45.00, 160.00, 'Premium', 'active', 'active', '2025-07-13 04:45:00', '2025-07-13 04:45:00'),
('USR123', 'Jimin', 'jimin.bts@email.com', '', '081234567123', 'male', 27, 58.00, 174.00, 'Reguler', 'active', 'pending', '2025-07-13 04:50:00', '2025-07-13 04:50:00'),
('USR124', 'Yoona', 'yoona.snsd@email.com', '', '081234567124', 'female', 33, 47.00, 168.00, 'Premium', 'active', 'active', '2025-07-13 04:55:00', '2025-07-13 04:55:00'),
('USR125', 'G-Dragon', 'gdragon.bb@email.com', '', '081234567125', 'male', 35, 58.00, 177.00, 'Premium', 'inactive', 'pending', '2025-07-13 05:00:00', '2025-07-13 05:00:00'),
('USR126', 'Sunmi', 'sunmi.solo@email.com', '', '081234567126', 'female', 31, 50.00, 166.00, 'Reguler', 'active', 'inactive', '2025-07-13 05:05:00', '2025-07-13 05:05:00'),
('USR127', 'Kang Daniel', 'kang.daniel@email.com', '', '081234567127', 'male', 26, 67.00, 180.00, 'Premium', 'active', 'active', '2025-07-13 05:10:00', '2025-07-13 05:10:00'),
('USR128', 'Hwasa', 'hwasa.mmm@email.com', '', '081234567128', 'female', 28, 44.00, 162.00, 'Premium', 'active', 'pending', '2025-07-13 05:15:00', '2025-07-13 05:15:00'),
('USR129', 'Taemin', 'taemin.shinee@email.com', '', '081234567129', 'male', 30, 53.00, 179.00, 'Reguler', 'active', 'active', '2025-07-13 05:20:00', '2025-07-13 05:20:00'),
('USR130', 'Irene', 'irene.rv@email.com', '', '081234567130', 'female', 32, 44.00, 160.00, 'Premium', 'pending', 'pending', '2025-07-13 05:25:00', '2025-07-13 05:25:00'),
('USR131', 'Rain (Jung Ji Hoon)', 'rain.official@email.com', '', '081234567131', 'male', 41, 74.00, 185.00, 'Premium', 'active', 'inactive', '2025-07-13 05:30:00', '2025-07-13 05:30:00'),
('USR132', 'Seulgi', 'seulgi.rv@email.com', '', '081234567132', 'female', 29, 44.00, 164.00, 'Premium', 'active', 'active', '2025-07-13 05:35:00', '2025-07-13 05:35:00'),
('USR133', 'Jay Park', 'jay.park@email.com', '', '081234567133', 'male', 36, 60.00, 170.00, 'Reguler', 'active', 'pending', '2025-07-13 05:40:00', '2025-07-13 05:40:00'),
('USR134', 'Chungha', 'chungha.solo@email.com', '', '081234567134', 'female', 27, 44.00, 161.00, 'Premium', 'active', 'active', '2025-07-13 05:45:00', '2025-07-13 05:45:00'),
('USR135', 'Zico', 'zico.ko_z@email.com', '', '081234567135', 'male', 30, 65.00, 182.00, 'Premium', 'inactive', 'pending', '2025-07-13 05:50:00', '2025-07-13 05:50:00'),
('USR136', 'Somi', 'somi.solo@email.com', '', '081234567136', 'female', 22, 46.00, 172.00, 'Reguler', 'active', 'inactive', '2025-07-13 05:55:00', '2025-07-13 05:55:00'),
('USR137', 'Jackson Wang', 'jackson.got7@email.com', '', '081234567137', 'male', 29, 63.00, 174.00, 'Premium', 'active', 'active', '2025-07-13 06:00:00', '2025-07-13 06:00:00'),
('USR138', 'Karina', 'karina.aespa@email.com', '', '081234567138', 'female', 23, 45.00, 167.00, 'Premium', 'active', 'pending', '2025-07-13 06:05:00', '2025-07-13 06:05:00'),
('USR139', 'RM', 'rm.bts@email.com', '', '081234567139', 'male', 28, 67.00, 181.00, 'Reguler', 'active', 'active', '2025-07-13 06:10:00', '2025-07-13 06:10:00'),
('USR140', 'Winter', 'winter.aespa@email.com', '', '081234567140', 'female', 22, 44.00, 165.00, 'Premium', 'pending', 'pending', '2025-07-13 06:15:00', '2025-07-13 06:15:00'),
('USR141', 'Suga', 'suga.bts@email.com', '', '081234567141', 'male', 30, 59.00, 174.00, 'Premium', 'active', 'inactive', '2025-07-13 06:20:00', '2025-07-13 06:20:00'),
('USR142', 'Yuna', 'yuna.itzy@email.com', '', '081234567142', 'female', 19, 48.00, 170.00, 'Premium', 'active', 'active', '2025-07-13 06:25:00', '2025-07-13 06:25:00'),
('USR143', 'J-Hope', 'jhope.bts@email.com', '', '081234567143', 'male', 29, 65.00, 177.00, 'Reguler', 'active', 'pending', '2025-07-13 06:30:00', '2025-07-13 06:30:00'),
('USR144', 'Ryujin', 'ryujin.itzy@email.com', '', '081234567144', 'female', 22, 47.00, 164.00, 'Premium', 'active', 'active', '2025-07-13 06:35:00', '2025-07-13 06:35:00'),
('USR145', 'Jin', 'jin.bts@email.com', '', '081234567145', 'male', 30, 63.00, 179.00, 'Premium', 'inactive', 'pending', '2025-07-13 06:40:00', '2025-07-13 06:40:00'),
('USR146', 'Yeji', 'yeji.itzy@email.com', '', '081234567146', 'female', 23, 46.00, 167.00, 'Reguler', 'active', 'inactive', '2025-07-13 06:45:00', '2025-07-13 06:45:00'),
('USR147', 'Kai', 'kai.exo@email.com', '', '081234567147', 'male', 29, 63.00, 182.00, 'Premium', 'active', 'active', '2025-07-13 06:50:00', '2025-07-13 06:50:00'),
('USR148', 'Jessi', 'jessi.solo@email.com', '', '081234567148', 'female', 34, 50.00, 167.00, 'Premium', 'active', 'pending', '2025-07-13 06:55:00', '2025-07-13 06:55:00'),
('USR149', 'Sehun', 'sehun.exo@email.com', '', '081234567149', 'male', 29, 66.00, 183.00, 'Reguler', 'active', 'active', '2025-07-13 07:00:00', '2025-07-13 07:00:00'),
('USR150', 'HyunA', 'hyuna.solo@email.com', '', '081234567150', 'female', 31, 44.00, 164.00, 'Premium', 'pending', 'pending', '2025-07-13 07:05:00', '2025-07-13 07:05:00'),
('USR151', 'Chanyeol', 'chanyeol.exo@email.com', '', '081234567151', 'male', 30, 70.00, 186.00, 'Premium', 'active', 'inactive', '2025-07-14 02:00:00', '2025-07-14 02:00:00'),
('USR152', 'CL', 'cl.2ne1@email.com', '', '081234567152', 'female', 32, 48.00, 162.00, 'Premium', 'active', 'active', '2025-07-14 02:05:00', '2025-07-14 02:05:00'),
('USR153', 'Baekhyun', 'baekhyun.exo@email.com', '', '081234567153', 'male', 31, 58.00, 174.00, 'Reguler', 'active', 'pending', '2025-07-14 02:10:00', '2025-07-14 02:10:00'),
('USR154', 'Sandara Park', 'dara.2ne1@email.com', '', '081234567154', 'female', 38, 40.00, 162.00, 'Premium', 'active', 'active', '2025-07-14 02:15:00', '2025-07-14 02:15:00'),
('USR155', 'Suho', 'suho.exo@email.com', '', '081234567155', 'male', 32, 65.00, 173.00, 'Premium', 'inactive', 'pending', '2025-07-14 02:20:00', '2025-07-14 02:20:00'),
('USR156', 'BoA', 'boa.kwon@email.com', '', '081234567156', 'female', 36, 45.00, 160.00, 'Reguler', 'active', 'inactive', '2025-07-14 02:25:00', '2025-07-14 02:25:00'),
('USR157', 'Taeyang', 'taeyang.bb@email.com', '', '081234567157', 'male', 35, 58.00, 173.00, 'Premium', 'active', 'active', '2025-07-14 02:30:00', '2025-07-14 02:30:00'),
('USR158', 'Lee Hyori', 'lee.hyori@email.com', '', '081234567158', 'female', 44, 53.00, 167.00, 'Premium', 'active', 'pending', '2025-07-14 02:35:00', '2025-07-14 02:35:00'),
('USR159', 'Siwon', 'siwon.sj@email.com', '', '081234567159', 'male', 37, 75.00, 183.00, 'Reguler', 'active', 'active', '2025-07-14 02:40:00', '2025-07-14 02:40:00'),
('USR160', 'Joy', 'joy.rv@email.com', '', '081234567160', 'female', 26, 47.00, 167.00, 'Premium', 'pending', 'pending', '2025-07-14 02:45:00', '2025-07-14 02:45:00'),
('USR161', 'Heechul', 'heechul.sj@email.com', '', '081234567161', 'male', 40, 60.00, 179.00, 'Premium', 'active', 'inactive', '2025-07-14 02:50:00', '2025-07-14 02:50:00'),
('USR162', 'Wendy', 'wendy.rv@email.com', '', '081234567162', 'female', 29, 40.00, 160.00, 'Premium', 'active', 'active', '2025-07-14 02:55:00', '2025-07-14 02:55:00'),
('USR163', 'Taeyong', 'taeyong.nct@email.com', '', '081234567163', 'male', 28, 58.00, 175.00, 'Reguler', 'active', 'pending', '2025-07-14 03:00:00', '2025-07-14 03:00:00'),
('USR164', 'Yeri', 'yeri.rv@email.com', '', '081234567164', 'female', 24, 45.00, 160.00, 'Premium', 'active', 'active', '2025-07-14 03:05:00', '2025-07-14 03:05:00'),
('USR165', 'Jaehyun', 'jaehyun.nct@email.com', '', '081234567165', 'male', 26, 63.00, 180.00, 'Premium', 'inactive', 'pending', '2025-07-14 03:10:00', '2025-07-14 03:10:00'),
('USR166', 'Solar', 'solar.mmm@email.com', '', '081234567166', 'female', 32, 43.00, 163.00, 'Reguler', 'active', 'inactive', '2025-07-14 03:15:00', '2025-07-14 03:15:00'),
('USR167', 'Mark Lee', 'mark.nct@email.com', '', '081234567167', 'male', 23, 60.00, 175.00, 'Premium', 'active', 'active', '2025-07-14 03:20:00', '2025-07-14 03:20:00'),
('USR168', 'Moonbyul', 'moonbyul.mmm@email.com', '', '081234567168', 'female', 30, 45.00, 165.00, 'Premium', 'active', 'pending', '2025-07-14 03:25:00', '2025-07-14 03:25:00'),
('USR169', 'Wonwoo', 'wonwoo.svt@email.com', '', '081234567169', 'male', 27, 63.00, 182.00, 'Reguler', 'active', 'active', '2025-07-14 03:30:00', '2025-07-14 03:30:00'),
('USR170', 'Wheein', 'wheein.mmm@email.com', '', '081234567170', 'female', 28, 43.00, 162.00, 'Premium', 'pending', 'pending', '2025-07-14 03:35:00', '2025-07-14 03:35:00'),
('USR171', 'Mingyu', 'mingyu.svt@email.com', '', '081234567171', 'male', 26, 80.00, 187.00, 'Premium', 'active', 'inactive', '2025-07-14 03:40:00', '2025-07-14 03:40:00'),
('USR172', 'Park Bom', 'park.bom@email.com', '', '081234567172', 'female', 39, 45.00, 165.00, 'Premium', 'active', 'active', '2025-07-14 03:45:00', '2025-07-14 03:45:00'),
('USR173', 'S.Coups', 'scoups.svt@email.com', '', '081234567173', 'male', 27, 65.00, 178.00, 'Reguler', 'active', 'pending', '2025-07-14 03:50:00', '2025-07-14 03:50:00'),
('USR174', 'Jihyo', 'jihyo.twice@email.com', '', '081234567174', 'female', 26, 49.00, 162.00, 'Premium', 'active', 'active', '2025-07-14 03:55:00', '2025-07-14 03:55:00'),
('USR175', 'Vernon', 'vernon.svt@email.com', '', '081234567175', 'male', 25, 62.00, 178.00, 'Premium', 'inactive', 'pending', '2025-07-14 04:00:00', '2025-07-14 04:00:00'),
('USR176', 'Momo Hirai', 'momo.twice@email.com', '', '081234567176', 'female', 26, 48.00, 167.00, 'Reguler', 'active', 'inactive', '2025-07-14 04:05:00', '2025-07-14 04:05:00'),
('USR177', 'Hoshi', 'hoshi.svt@email.com', '', '081234567177', 'male', 27, 60.00, 177.00, 'Premium', 'active', 'active', '2025-07-14 04:10:00', '2025-07-14 04:10:00'),
('USR178', 'Giselle', 'giselle.aespa@email.com', '', '081234567178', 'female', 22, 45.00, 166.00, 'Premium', 'active', 'pending', '2025-07-14 04:15:00', '2025-07-14 04:15:00'),
('USR179', 'D.O.', 'do.exo@email.com', '', '081234567179', 'male', 30, 60.00, 173.00, 'Reguler', 'active', 'active', '2025-07-14 04:20:00', '2025-07-14 04:20:00'),
('USR180', 'Ningning', 'ningning.aespa@email.com', '', '081234567180', 'female', 20, 43.00, 161.00, 'Premium', 'pending', 'pending', '2025-07-14 04:25:00', '2025-07-14 04:25:00'),
('USR181', 'Minho', 'minho.shinee@email.com', '', '081234567181', 'male', 31, 60.00, 184.00, 'Premium', 'active', 'inactive', '2025-07-15 02:00:00', '2025-07-15 02:00:00'),
('USR182', 'Lia', 'lia.itzy@email.com', '', '081234567182', 'female', 23, 43.00, 162.00, 'Premium', 'active', 'active', '2025-07-15 02:05:00', '2025-07-15 02:05:00'),
('USR183', 'Key', 'key.shinee@email.com', '', '081234567183', 'male', 31, 59.00, 181.00, 'Reguler', 'active', 'pending', '2025-07-15 02:10:00', '2025-07-15 02:10:00'),
('USR184', 'Chaeryeong', 'chaeryeong.itzy@email.com', '', '081234567184', 'female', 22, 46.00, 166.00, 'Premium', 'active', 'active', '2025-07-15 02:15:00', '2025-07-15 02:15:00'),
('USR185', 'Onew', 'onew.shinee@email.com', '', '081234567185', 'male', 33, 61.00, 178.00, 'Premium', 'inactive', 'pending', '2025-07-15 02:20:00', '2025-07-15 02:20:00'),
('USR186', 'Kim Sejeong', 'sejeong.kim@email.com', '', '081234567186', 'female', 26, 48.00, 164.00, 'Reguler', 'active', 'inactive', '2025-07-15 02:25:00', '2025-07-15 02:25:00'),
('USR187', 'BamBam', 'bambam.got7@email.com', '', '081234567187', 'male', 26, 60.00, 178.00, 'Premium', 'active', 'active', '2025-07-15 02:30:00', '2025-07-15 02:30:00'),
('USR188', 'Park Min Young', 'park.minyoung@email.com', '', '081234567188', 'female', 37, 47.00, 164.00, 'Premium', 'active', 'pending', '2025-07-15 02:35:00', '2025-07-15 02:35:00'),
('USR189', 'Jay B', 'jayb.got7@email.com', '', '081234567189', 'male', 29, 66.00, 179.00, 'Reguler', 'active', 'active', '2025-07-15 02:40:00', '2025-07-15 02:40:00'),
('USR190', 'Kim Yoo Jung', 'kim.yoojung@email.com', '', '081234567190', 'female', 23, 45.00, 165.00, 'Premium', 'pending', 'pending', '2025-07-15 02:45:00', '2025-07-15 02:45:00'),
('USR191', 'Jinyoung', 'jinyoung.got7@email.com', '', '081234567191', 'male', 28, 63.00, 178.00, 'Premium', 'active', 'inactive', '2025-07-15 02:50:00', '2025-07-15 02:50:00'),
('USR192', 'Han So Hee', 'han.sohee@email.com', '', '081234567192', 'female', 28, 47.00, 165.00, 'Premium', 'active', 'active', '2025-07-15 02:55:00', '2025-07-15 02:55:00'),
('USR193', 'Doyoung', 'doyoung.nct@email.com', '', '081234567193', 'male', 27, 60.00, 178.00, 'Reguler', 'active', 'pending', '2025-07-15 03:00:00', '2025-07-15 03:00:00'),
('USR194', 'Gita Sekar Andarini', 'gitsekar30@email.com', '', '081234567194', 'female', 24, 45.00, 167.00, 'Premium', 'active', 'active', '2025-07-15 03:05:00', '2025-07-15 03:05:00'),
('USR195', 'Johnny', 'johnny.nct@email.com', '', '081234567195', 'male', 28, 68.00, 184.00, 'Premium', 'inactive', 'pending', '2025-07-15 03:10:00', '2025-07-15 03:10:00'),
('USR196', 'Kim Da Mi', 'kim.dami@email.com', '', '081234567196', 'female', 28, 46.00, 170.00, 'Reguler', 'active', 'inactive', '2025-07-15 03:15:00', '2025-07-15 03:15:00'),
('USR197', 'Lee Dong Wook', 'lee.dongwook@email.com', '', '081234567197', 'male', 41, 72.00, 184.00, 'Premium', 'active', 'active', '2025-07-15 03:20:00', '2025-07-15 03:20:00'),
('USR198', 'Shin Se Kyung', 'shin.sekyung@email.com', '', '081234567198', 'female', 33, 43.00, 164.00, 'Premium', 'active', 'pending', '2025-07-15 03:25:00', '2025-07-15 03:25:00'),
('USR199', 'Rowoon', 'rowoon.sf9@email.com', '', '081234567199', 'male', 26, 73.00, 190.00, 'Reguler', 'active', 'active', '2025-07-15 03:30:00', '2025-07-15 03:30:00'),
('USR200', 'Krystal Jung', 'krystal.jung@email.com', '', '081234567200', 'female', 28, 45.00, 165.00, 'Premium', 'pending', 'pending', '2025-07-15 03:35:00', '2025-07-15 03:35:00');

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
(7, 'USR005', 'weight', 'Ingin menambah massa otot', 'open', '2025-06-24 17:18:32'),
(8, 'USR006', 'sleep', 'Sering terbangun di tengah malam.', 'open', '2025-06-25 08:30:15'),
(9, 'USR007', 'other', 'Nyeri sendi setelah latihan angkat beban.', 'pending', '2025-06-25 11:20:05'),
(10, 'USR009', 'weight', 'Berat badan tidak kunjung naik meskipun sudah makan banyak.', 'open', '2025-06-26 09:00:00'),
(11, 'USR010', 'energy', 'Selalu merasa mengantuk setelah makan siang.', 'resolved', '2025-06-26 14:05:45'),
(12, 'USR011', 'immunity', 'Mudah tertular batuk dan pilek dari rekan kerja.', 'open', '2025-06-27 10:15:12'),
(13, 'USR012', 'digestion', 'Perut sering kembung dan begah.', 'resolved', '2025-06-28 16:45:30'),
(14, 'USR013', 'weight', 'Stuck di berat badan yang sama selama sebulan terakhir.', 'open', '2025-06-29 18:00:21'),
(15, 'USR015', 'sleep', 'Kualitas tidur menurun, sering mimpi buruk.', 'pending', '2025-07-01 22:10:00'),
(16, 'USR016', 'energy', 'Kurang bertenaga untuk aktivitas di pagi hari.', 'open', '2025-07-02 07:25:50'),
(17, 'USR018', 'other', 'Sakit kepala setelah sesi kardio intensitas tinggi.', 'resolved', '2025-07-04 19:30:00'),
(18, 'USR020', 'digestion', 'Mengalami sembelit beberapa kali dalam seminggu.', 'open', '2025-07-06 13:00:19'),
(19, 'USR021', 'immunity', 'Alergi kambuh lebih sering dari biasanya.', 'pending', '2025-07-07 11:55:00'),
(20, 'USR022', 'weight', 'Lemak di area perut sulit dihilangkan.', 'open', '2025-07-08 15:20:40'),
(21, 'USR023', 'energy', 'Kehilangan stamina dengan cepat saat berolahraga.', 'resolved', '2025-07-09 10:00:00'),
(22, 'USR025', 'sleep', 'Membutuhkan waktu lebih dari satu jam untuk bisa tertidur.', 'open', '2025-07-11 23:15:00'),
(23, 'USR028', 'digestion', 'Merasa mual setelah mengonsumsi suplemen protein.', 'resolved', '2025-07-14 09:40:10'),
(24, 'USR030', 'weight', 'Ingin program diet yang sesuai untuk ibu menyusui.', 'pending', '2025-07-16 12:00:00'),
(25, 'USR031', 'energy', 'Fokus menurun dan sulit konsentrasi saat bekerja.', 'open', '2025-07-17 14:30:25'),
(26, 'USR033', 'other', 'Kram otot pada bagian kaki saat tidur.', 'resolved', '2025-07-19 08:20:00'),
(27, 'USR034', 'immunity', 'Sering merasa tidak enak badan tanpa alasan yang jelas.', 'open', '2025-07-20 17:00:55'),
(28, 'USR036', 'weight', 'Bagaimana cara membentuk lengan dan paha?', 'open', '2025-07-22 20:00:00'),
(29, 'USR037', 'sleep', 'Jadwal tidur tidak teratur karena pekerjaan.', 'pending', '2025-07-23 23:50:00'),
(30, 'USR039', 'energy', 'Perlu suplemen energi yang aman untuk latihan bela diri.', 'resolved', '2025-07-25 10:10:10'),
(31, 'USR040', 'digestion', 'Asam lambung sering naik.', 'open', '2025-07-26 11:30:00'),
(32, 'USR042', 'weight', 'Sulit mengontrol nafsu makan, terutama makanan manis.', 'open', '2025-07-28 21:05:13'),
(33, 'USR045', 'other', 'Rambut rontok lebih banyak dari biasanya.', 'pending', '2025-07-31 13:45:00'),
(34, 'USR046', 'immunity', 'Badan pegal-pegal setelah sembuh dari sakit.', 'resolved', '2025-08-01 16:25:00'),
(35, 'USR049', 'sleep', 'Sering merasa lelah meskipun sudah tidur 8 jam.', 'open', '2025-08-04 09:00:00'),
(36, 'USR050', 'energy', 'Stamina menurun drastis saat memasuki trimester kedua kehamilan.', 'pending', '2025-08-05 11:00:00'),
(37, 'USR052', 'digestion', 'Diare setelah mencoba resep makanan sehat baru.', 'resolved', '2025-08-07 14:00:00'),
(38, 'USR055', 'weight', 'Target penurunan berat badan 5 kg dalam sebulan.', 'open', '2025-08-10 10:30:00'),
(39, 'USR058', 'immunity', 'Gampang masuk angin jika kurang tidur.', 'open', '2025-08-13 19:00:00'),
(40, 'USR060', 'other', 'Kulit menjadi lebih kering dari biasanya.', 'pending', '2025-08-15 15:00:00'),
(41, 'USR062', 'energy', 'Butuh rekomendasi snack penambah energi sebelum gym.', 'resolved', '2025-08-17 16:00:00'),
(42, 'USR063', 'weight', 'Cara cutting yang efektif tanpa kehilangan banyak massa otot.', 'open', '2025-08-18 11:45:00'),
(43, 'USR065', 'sleep', 'Terlalu banyak pikiran saat akan tidur.', 'open', '2025-08-20 23:30:00'),
(44, 'USR068', 'digestion', 'Sering merasa mulas di pagi hari.', 'pending', '2025-08-23 08:15:00'),
(45, 'USR069', 'immunity', 'Badan meriang setelah perjalanan jauh.', 'resolved', '2025-08-24 18:00:00'),
(46, 'USR071', 'energy', 'Sulit bangun pagi dan selalu menekan tombol snooze.', 'open', '2025-08-26 07:00:00'),
(47, 'USR075', 'weight', 'Program bulking untuk pemula.', 'open', '2025-08-30 12:30:00'),
(48, 'USR078', 'other', 'Mood swing yang parah menjelang menstruasi.', 'pending', '2025-09-02 14:00:00'),
(49, 'USR079', 'sleep', 'Tidur mendengkur sangat keras.', 'open', '2025-09-03 22:45:00'),
(50, 'USR082', 'digestion', 'Tidak cocok dengan susu sapi, butuh alternatif.', 'resolved', '2025-09-06 10:00:00'),
(51, 'USR083', 'energy', 'Merasa tidak produktif di tempat kerja.', 'open', '2025-09-07 11:20:00'),
(52, 'USR084', 'weight', 'Pipi terasa lebih chubby dari biasanya.', 'open', '2025-09-08 19:30:00'),
(53, 'USR088', 'immunity', 'Sariawan tidak kunjung sembuh.', 'pending', '2025-09-12 09:50:00'),
(54, 'USR091', 'sleep', 'Sering mengigau saat tidur.', 'resolved', '2025-09-15 13:00:00'),
(55, 'USR092', 'other', 'Jerawat muncul setelah mengganti produk skincare.', 'open', '2025-09-16 20:10:00'),
(56, 'USR096', 'energy', 'Kelelahan karena jadwal manggung yang padat.', 'open', '2025-09-20 16:00:00'),
(57, 'USR098', 'weight', 'Tips diet sehat pasca melahirkan.', 'pending', '2025-09-22 10:45:00'),
(58, 'USR100', 'digestion', 'Suka makanan pedas, tapi perut tidak kuat.', 'resolved', '2025-09-24 12:00:00'),
(59, 'USR003', 'energy', 'Cepat lelah saat bermain dengan anak.', 'open', '2025-09-25 18:30:00'),
(60, 'USR014', 'sleep', 'Insomnia karena cemas berlebihan.', 'open', '2025-09-25 23:00:00'),
(61, 'USR026', 'weight', 'Nafsu makan meningkat saat stress.', 'pending', '2025-09-26 14:20:00'),
(62, 'USR035', 'immunity', 'Mudah sakit jika cuaca sedang tidak menentu.', 'resolved', '2025-09-26 17:00:00'),
(63, 'USR048', 'digestion', 'Perut terasa perih jika telat makan.', 'open', '2025-09-27 09:10:00'),
(64, 'USR051', 'other', 'Sakit pinggang karena terlalu lama duduk.', 'open', '2025-09-27 11:00:00'),
(65, 'USR066', 'energy', 'Energi tidak stabil, kadang sangat aktif kadang sangat lemas.', 'pending', '2025-09-28 13:30:00'),
(66, 'USR077', 'sleep', 'Pola tidur berantakan karena sering begadang.', 'resolved', '2025-09-28 23:59:59'),
(67, 'USR089', 'weight', 'Ingin six-pack, tapi lemak perut masih tebal.', 'open', '2025-09-29 15:00:00'),
(68, 'USR099', 'immunity', 'Herpes di bibir sering kambuh.', 'open', '2025-09-29 19:45:00'),
(69, 'USR001', 'sleep', 'Tidur cukup tapi bangun tetap tidak segar.', 'pending', '2025-09-30 08:00:00'),
(70, 'USR008', 'energy', 'Sering pusing dan mata berkunang-kunang.', 'open', '2025-09-30 10:00:00'),
(71, 'USR101', 'sleep', 'Jadwal syuting yang padat membuat pola tidur saya berantakan.', 'open', '2025-07-15 07:00:00'),
(72, 'USR102', 'energy', 'Sering merasa lemas dan kurang energi saat mempersiapkan album baru.', 'resolved', '2025-07-15 07:05:00'),
(73, 'USR103', 'other', 'Nyeri pada bahu setelah melakukan adegan aksi.', 'open', '2025-07-15 07:10:00'),
(74, 'USR104', 'digestion', 'Perut terasa begah dan tidak nyaman setelah makan malam.', 'pending', '2025-07-15 07:15:00'),
(75, 'USR105', 'immunity', 'Merasa akan flu, butuh saran makanan untuk meningkatkan daya tahan tubuh.', 'open', '2025-07-15 07:20:00'),
(76, 'USR106', 'weight', 'Sulit sekali menaikkan berat badan agar tidak terlihat terlalu kurus di kamera.', 'resolved', '2025-07-15 07:25:00'),
(77, 'USR107', 'weight', 'Perlu menambah massa otot sekitar 3 kg untuk peran film, tapi progress lambat.', 'open', '2025-07-15 07:30:00'),
(78, 'USR108', 'energy', 'Stamina cepat terkuras saat latihan koreografi.', 'open', '2025-07-15 07:35:00'),
(79, 'USR109', 'sleep', 'Mengalami jet lag parah dan insomnia setelah tur.', 'pending', '2025-07-15 07:40:00'),
(80, 'USR111', 'other', 'Kulit wajah terlihat kusam dan lelah.', 'resolved', '2025-07-15 07:45:00'),
(81, 'USR112', 'weight', 'Bagaimana cara menjaga lingkar pinggang tetap kecil?', 'open', '2025-07-15 07:50:00'),
(82, 'USR113', 'immunity', 'Tenggorokan sering kering dan sakit setelah konser.', 'open', '2025-07-15 07:55:00'),
(83, 'USR115', 'sleep', 'Terbangun tengah malam dan sulit untuk tidur kembali.', 'pending', '2025-07-15 08:00:00'),
(84, 'USR116', 'energy', 'Merasa pusing jika melewatkan jam makan.', 'resolved', '2025-07-15 08:05:00'),
(85, 'USR117', 'other', 'Sendi lutut terasa nyeri setelah berlari.', 'open', '2025-07-15 08:10:00'),
(86, 'USR118', 'digestion', 'Sembelit saat sedang diet tinggi protein.', 'open', '2025-07-15 08:15:00'),
(87, 'USR121', 'weight', 'Wajah terlihat tirus, ingin menaikkan berat badan sedikit.', 'pending', '2025-07-15 08:20:00'),
(88, 'USR122', 'immunity', 'Butuh saran makanan untuk menjaga kualitas pita suara.', 'resolved', '2025-07-15 08:25:00'),
(89, 'USR123', 'energy', 'Otot paha terasa sangat pegal setelah latihan.', 'open', '2025-07-15 08:30:00'),
(90, 'USR125', 'sleep', 'Sering sakit kepala karena kurang tidur.', 'open', '2025-07-15 08:35:00'),
(91, 'USR128', 'weight', 'Ingin menambah berat badan di bagian paha dan pinggul.', 'pending', '2025-07-15 08:40:00'),
(92, 'USR130', 'other', 'Kulit sangat kering belakangan ini.', 'resolved', '2025-07-15 08:45:00'),
(93, 'USR131', 'energy', 'Bagaimana cara cepat mengembalikan energi setelah workout intens?', 'open', '2025-07-15 08:50:00'),
(94, 'USR133', 'weight', 'Lemak di perut bagian bawah sulit hilang.', 'open', '2025-07-15 08:55:00'),
(95, 'USR137', 'immunity', 'Sering merasa meriang saat bepergian ke negara dengan cuaca berbeda.', 'pending', '2025-07-15 09:00:00'),
(96, 'USR138', 'digestion', 'Asam lambung naik jika minum kopi.', 'resolved', '2025-07-15 09:05:00'),
(97, 'USR139', 'sleep', 'Sulit tidur karena pikiran terlalu aktif di malam hari.', 'open', '2025-07-15 09:10:00'),
(98, 'USR141', 'energy', 'Merasa tidak bertenaga jika tidak sarapan.', 'open', '2025-07-15 09:15:00'),
(99, 'USR144', 'other', 'Rambut menjadi rapuh dan mudah patah.', 'pending', '2025-07-15 09:20:00'),
(100, 'USR147', 'sleep', 'Hanya bisa tidur 4-5 jam sehari, bagaimana cara memaksimalkannya?', 'resolved', '2025-07-15 09:25:00'),
(101, 'USR151', 'energy', 'Stamina menurun sejak kembali dari wajib militer.', 'open', '2025-07-16 02:00:00'),
(102, 'USR152', 'weight', 'Berat badan gampang naik setelah masa promosi selesai.', 'open', '2025-07-16 02:05:00'),
(103, 'USR153', 'immunity', 'Mudah sariawan jika sedang banyak pikiran.', 'pending', '2025-07-16 02:10:00'),
(104, 'USR157', 'energy', 'Sering kram otot saat latihan vokal.', 'resolved', '2025-07-16 02:15:00'),
(105, 'USR159', 'weight', 'Ingin mengeringkan badan (cutting) tanpa kehilangan massa otot.', 'open', '2025-07-16 02:20:00'),
(106, 'USR160', 'digestion', 'Merasa mual jika makan terlalu banyak sayuran hijau.', 'open', '2025-07-16 02:25:00'),
(107, 'USR163', 'sleep', 'Sering mimpi buruk belakangan ini.', 'pending', '2025-07-16 02:30:00'),
(108, 'USR165', 'other', 'Timbul jerawat di punggung.', 'resolved', '2025-07-16 02:35:00'),
(109, 'USR167', 'energy', 'Nafsu makan menurun saat sedang stres.', 'open', '2025-07-16 02:40:00'),
(110, 'USR169', 'sleep', 'Mata terasa berat dan mengantuk sepanjang hari.', 'open', '2025-07-16 02:45:00'),
(111, 'USR171', 'weight', 'Susah menahan keinginan makan junk food di malam hari.', 'pending', '2025-07-16 02:50:00'),
(112, 'USR177', 'immunity', 'Gampang mimisan jika terlalu lelah.', 'resolved', '2025-07-16 02:55:00'),
(113, 'USR181', 'energy', 'Badan terasa pegal-pegal saat bangun tidur.', 'open', '2025-07-16 03:00:00'),
(114, 'USR188', 'other', 'Lingkaran hitam di bawah mata semakin jelas.', 'open', '2025-07-16 03:05:00'),
(115, 'USR192', 'sleep', 'Tidur tidak nyenyak, sering gelisah.', 'pending', '2025-07-16 03:10:00'),
(116, 'USR197', 'immunity', 'Sering bersin di pagi hari.', 'resolved', '2025-07-16 03:15:00'),
(117, 'USR199', 'weight', 'Perut buncit padahal bagian tubuh lain sudah kurus.', 'open', '2025-07-16 03:20:00'),
(118, 'USR200', 'digestion', 'Merasa begah dan ingin muntah setelah minum susu.', 'open', '2025-07-16 03:25:00');

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
-- Indexes for table `manager`
--
ALTER TABLE `manager`
  ADD PRIMARY KEY (`id_manager`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=189;

--
-- AUTO_INCREMENT for table `manager`
--
ALTER TABLE `manager`
  MODIFY `id_manager` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `nutrition_achievements`
--
ALTER TABLE `nutrition_achievements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `nutrition_needs`
--
ALTER TABLE `nutrition_needs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=186;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=228;

--
-- AUTO_INCREMENT for table `product_reviews`
--
ALTER TABLE `product_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=158;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=651;

--
-- AUTO_INCREMENT for table `user_complaints`
--
ALTER TABLE `user_complaints`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

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
