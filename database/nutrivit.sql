-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 15, 2025 at 11:00 AM
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
(100, 'USR099', 'general', 'Saya ingin memulai gaya hidup sehat, harus mulai dari mana?', 'Mulai dari satu atau dua perubahan kecil. Misalnya, targetkan minum 8 gelas air sehari dan berjalan kaki 20 menit setiap hari. Setelah itu menjadi kebiasaan, tambahkan perubahan baru secara bertahap.', 120, 5.0, '2025-12-03 12:00:00');

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
(1, 'Go Yoon Jung', 'goyoonjung@nutrivit.com', '081421743218', 'admin123', 'NV-GYJ-001', '2020-04-22', 'manager.jpg');

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
(125, 'ORD20250831001', 'USR001', 445000.00, 'delivered', 'e_wallet', 'Jl. Depok No. 1000, Depok', '2025-08-31 17:20:50');

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
(153, 125, 'PRD006', 1, 150000.00, 150000.00);

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
(101, 'USR063', 'PRD007', 13, 5.0, 'Luar biasa! Produk original dan berkhasiat.', '2025-09-09 14:00:00');

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
(1, 'PRD001', 3, 897000.00, '2025-06-24'),
(2, 'PRD002', 4, 500000.00, '2025-06-24'),
(3, 'PRD003', 2, 370000.00, '2025-06-24'),
(4, 'PRD004', 5, 375000.00, '2025-06-24'),
(5, 'PRD005', 2, 190000.00, '2025-06-24'),
(6, 'PRD006', 2, 300000.00, '2025-06-24'),
(7, 'PRD007', 2, 440000.00, '2025-06-24'),
(8, 'PRD008', 2, 360000.00, '2025-06-24'),
(9, 'PRD001', 1, 299000.00, '2025-06-25'),
(10, 'PRD006', 1, 150000.00, '2025-06-25'),
(11, 'PRD003', 1, 185000.00, '2025-06-26'),
(12, 'PRD004', 1, 75000.00, '2025-06-27'),
(13, 'PRD001', 1, 299000.00, '2025-06-28'),
(14, 'PRD007', 1, 220000.00, '2025-06-28'),
(15, 'PRD002', 1, 125000.00, '2025-06-30'),
(16, 'PRD003', 1, 185000.00, '2025-06-30'),
(17, 'PRD001', 1, 299000.00, '2025-07-01'),
(18, 'PRD005', 1, 95000.00, '2025-07-01'),
(19, 'PRD007', 1, 220000.00, '2025-07-01'),
(20, 'PRD008', 1, 180000.00, '2025-07-02'),
(21, 'PRD007', 1, 220000.00, '2025-07-03'),
(22, 'PRD001', 1, 299000.00, '2025-07-04'),
(23, 'PRD002', 1, 125000.00, '2025-07-04'),
(24, 'PRD004', 5, 375000.00, '2025-07-05'),
(25, 'PRD006', 1, 150000.00, '2025-07-06'),
(26, 'PRD003', 1, 185000.00, '2025-07-07'),
(27, 'PRD007', 1, 220000.00, '2025-07-07'),
(28, 'PRD001', 1, 299000.00, '2025-07-08'),
(29, 'PRD001', 2, 598000.00, '2025-07-10'),
(30, 'PRD008', 1, 180000.00, '2025-07-11'),
(31, 'PRD001', 1, 299000.00, '2025-07-12'),
(32, 'PRD002', 2, 250000.00, '2025-07-12'),
(33, 'PRD007', 1, 220000.00, '2025-07-12'),
(34, 'PRD001', 1, 299000.00, '2025-07-13'),
(35, 'PRD003', 1, 185000.00, '2025-07-13'),
(36, 'PRD006', 1, 150000.00, '2025-07-13'),
(37, 'PRD001', 1, 299000.00, '2025-07-14'),
(38, 'PRD004', 1, 75000.00, '2025-07-14'),
(39, 'PRD007', 1, 220000.00, '2025-07-14'),
(40, 'PRD002', 1, 125000.00, '2025-07-15'),
(41, 'PRD003', 1, 185000.00, '2025-07-15'),
(42, 'PRD007', 1, 220000.00, '2025-07-15'),
(43, 'PRD001', 1, 299000.00, '2025-07-16'),
(44, 'PRD005', 1, 95000.00, '2025-07-16'),
(45, 'PRD007', 1, 220000.00, '2025-07-16'),
(46, 'PRD008', 1, 180000.00, '2025-07-16'),
(47, 'PRD001', 1, 299000.00, '2025-07-17'),
(48, 'PRD002', 1, 125000.00, '2025-07-17'),
(49, 'PRD007', 1, 220000.00, '2025-07-17'),
(50, 'PRD004', 5, 375000.00, '2025-07-18'),
(51, 'PRD006', 1, 150000.00, '2025-07-18'),
(52, 'PRD001', 1, 299000.00, '2025-07-19'),
(53, 'PRD003', 1, 185000.00, '2025-07-19'),
(54, 'PRD007', 1, 220000.00, '2025-07-19'),
(55, 'PRD001', 2, 598000.00, '2025-07-20'),
(56, 'PRD005', 1, 95000.00, '2025-07-20'),
(57, 'PRD002', 1, 125000.00, '2025-07-21'),
(58, 'PRD007', 1, 220000.00, '2025-07-21'),
(59, 'PRD008', 1, 180000.00, '2025-07-21'),
(60, 'PRD002', 1, 125000.00, '2025-07-22'),
(61, 'PRD003', 1, 185000.00, '2025-07-22'),
(62, 'PRD001', 1, 299000.00, '2025-07-23'),
(63, 'PRD004', 1, 75000.00, '2025-07-23'),
(64, 'PRD006', 1, 150000.00, '2025-07-24'),
(65, 'PRD007', 1, 220000.00, '2025-07-24'),
(66, 'PRD001', 1, 299000.00, '2025-07-25'),
(67, 'PRD001', 1, 299000.00, '2025-07-26'),
(68, 'PRD002', 2, 250000.00, '2025-07-26'),
(69, 'PRD003', 1, 185000.00, '2025-07-27'),
(70, 'PRD004', 1, 75000.00, '2025-07-27'),
(71, 'PRD001', 1, 299000.00, '2025-07-28'),
(72, 'PRD006', 1, 150000.00, '2025-07-28'),
(73, 'PRD007', 1, 220000.00, '2025-07-29'),
(74, 'PRD008', 1, 180000.00, '2025-07-29'),
(75, 'PRD001', 1, 299000.00, '2025-07-30'),
(76, 'PRD002', 1, 125000.00, '2025-07-30'),
(77, 'PRD003', 1, 185000.00, '2025-07-31'),
(78, 'PRD004', 1, 75000.00, '2025-07-31'),
(79, 'PRD001', 1, 299000.00, '2025-08-01'),
(80, 'PRD006', 1, 150000.00, '2025-08-01'),
(81, 'PRD007', 1, 220000.00, '2025-08-02'),
(82, 'PRD008', 1, 180000.00, '2025-08-02'),
(83, 'PRD001', 1, 299000.00, '2025-08-03'),
(84, 'PRD002', 1, 125000.00, '2025-08-03'),
(85, 'PRD003', 1, 185000.00, '2025-08-04'),
(86, 'PRD004', 1, 75000.00, '2025-08-04'),
(87, 'PRD001', 1, 299000.00, '2025-08-05'),
(88, 'PRD006', 1, 150000.00, '2025-08-05'),
(89, 'PRD007', 1, 220000.00, '2025-08-06'),
(90, 'PRD008', 1, 180000.00, '2025-08-06'),
(91, 'PRD001', 1, 299000.00, '2025-08-07'),
(92, 'PRD002', 1, 125000.00, '2025-08-07'),
(93, 'PRD003', 1, 185000.00, '2025-08-08'),
(94, 'PRD004', 1, 75000.00, '2025-08-08'),
(95, 'PRD001', 1, 299000.00, '2025-08-09'),
(96, 'PRD006', 1, 150000.00, '2025-08-09'),
(97, 'PRD007', 1, 220000.00, '2025-08-10'),
(98, 'PRD008', 1, 180000.00, '2025-08-10'),
(99, 'PRD001', 1, 299000.00, '2025-08-11'),
(100, 'PRD002', 1, 125000.00, '2025-08-11'),
(101, 'PRD003', 1, 185000.00, '2025-08-12'),
(102, 'PRD004', 1, 75000.00, '2025-08-12'),
(103, 'PRD001', 1, 299000.00, '2025-08-13'),
(104, 'PRD006', 1, 150000.00, '2025-08-13'),
(105, 'PRD007', 1, 220000.00, '2025-08-14'),
(106, 'PRD008', 1, 180000.00, '2025-08-14'),
(107, 'PRD001', 1, 299000.00, '2025-08-15'),
(108, 'PRD002', 1, 125000.00, '2025-08-15'),
(109, 'PRD003', 1, 185000.00, '2025-08-16'),
(110, 'PRD004', 1, 75000.00, '2025-08-16'),
(111, 'PRD001', 1, 299000.00, '2025-08-17'),
(112, 'PRD006', 1, 150000.00, '2025-08-17'),
(113, 'PRD007', 1, 220000.00, '2025-08-18'),
(114, 'PRD008', 1, 180000.00, '2025-08-18'),
(115, 'PRD001', 1, 299000.00, '2025-08-19'),
(116, 'PRD002', 1, 125000.00, '2025-08-19'),
(117, 'PRD003', 1, 185000.00, '2025-08-20'),
(118, 'PRD004', 1, 75000.00, '2025-08-20'),
(119, 'PRD001', 1, 299000.00, '2025-08-21'),
(120, 'PRD006', 1, 150000.00, '2025-08-21'),
(121, 'PRD007', 1, 220000.00, '2025-08-22'),
(122, 'PRD008', 1, 180000.00, '2025-08-22'),
(123, 'PRD001', 1, 299000.00, '2025-08-23'),
(124, 'PRD002', 1, 125000.00, '2025-08-23'),
(125, 'PRD003', 1, 185000.00, '2025-08-24'),
(126, 'PRD004', 1, 75000.00, '2025-08-24'),
(127, 'PRD001', 1, 299000.00, '2025-08-25'),
(128, 'PRD006', 1, 150000.00, '2025-08-25'),
(129, 'PRD007', 1, 220000.00, '2025-08-26'),
(130, 'PRD008', 1, 180000.00, '2025-08-26'),
(131, 'PRD001', 1, 299000.00, '2025-08-27'),
(132, 'PRD002', 1, 125000.00, '2025-08-27'),
(133, 'PRD003', 1, 185000.00, '2025-08-28'),
(134, 'PRD004', 1, 75000.00, '2025-08-28'),
(135, 'PRD001', 1, 299000.00, '2025-08-29'),
(136, 'PRD002', 1, 125000.00, '2025-08-29'),
(137, 'PRD003', 1, 185000.00, '2025-08-30'),
(138, 'PRD004', 1, 75000.00, '2025-08-30'),
(139, 'PRD001', 1, 299000.00, '2025-08-31'),
(140, 'PRD006', 1, 150000.00, '2025-08-31');

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
('USR100', 'Fuji Utami', 'fuji@email.com', '', '081234567900', 'female', 21, 49.00, 159.00, 'Premium', 'active', 'active', '2025-09-24 17:18:32', '2025-09-24 13:01:57');

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
(70, 'USR008', 'energy', 'Sering pusing dan mata berkunang-kunang.', 'open', '2025-09-30 10:00:00');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=154;

--
-- AUTO_INCREMENT for table `product_reviews`
--
ALTER TABLE `product_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;

--
-- AUTO_INCREMENT for table `user_complaints`
--
ALTER TABLE `user_complaints`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

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
