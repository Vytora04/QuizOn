class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String category; 

  Question({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.category,
  });
}

final dummyQuestions = [
  // Kategori: Umum
  Question(
    question: "Ibukota Indonesia adalah?",
    options: ["Bandung", "Jakarta", "Surabaya", "Medan"],
    correctAnswerIndex: 1,
    category: "Umum",
  ),
  Question(
    question: "2 + 5 = ...",
    options: ["5", "7", "8", "9"],
    correctAnswerIndex: 1,
    category: "Umum",
  ),
  Question(
    question: "Presiden pertama RI?",
    options: ["Soekarno", "Soeharto", "BJ Habibie", "Megawati"],
    correctAnswerIndex: 0,
    category: "Umum",
  ),
  Question(
    question: "Warna bendera Indonesia adalah?",
    options: ["Merah Putih", "Putih Merah", "Hijau Kuning", "Biru Putih"],
    correctAnswerIndex: 0,
    category: "Umum",
  ),
  Question(
    question: "Apa mata uang Indonesia?",
    options: ["Dollar", "Ringgit", "Rupiah", "Yen"],
    correctAnswerIndex: 2,
    category: "Umum",
  ),

  // Kategori: Sejarah
  Question(
    question: "Tahun berapa Indonesia merdeka?",
    options: ["1942", "1945", "1950", "1965"],
    correctAnswerIndex: 1,
    category: "Sejarah",
  ),
  Question(
    question: "Pahlawan nasional yang dikenal sebagai Bapak Proklamator adalah?",
    options: ["Moh. Hatta", "Soekarno", "Sudirman", "Diponegoro"],
    correctAnswerIndex: 1,
    category: "Sejarah",
  ),
  Question(
    question: "Siapa pencipta lagu 'Indonesia Raya'?",
    options: ["Ismail Marzuki", "WR Supratman", "H. Mutahar", "Gesang"],
    correctAnswerIndex: 1,
    category: "Sejarah",
  ),
  Question(
    question: "Candi Borobudur terletak di provinsi?",
    options: ["Jawa Timur", "Yogyakarta", "Jawa Tengah", "Bali"],
    correctAnswerIndex: 2,
    category: "Sejarah",
  ),
  Question(
    question: "Semboyan Bhinneka Tunggal Ika memiliki arti?",
    options: ["Bersatu Kita Teguh", "Berbeda-beda tetapi tetap satu", "Indonesia Pusaka", "Merdeka atau Mati"],
    correctAnswerIndex: 1,
    category: "Sejarah",
  ),

  // Kategori: Geografi
  Question(
    question: "Berapa jumlah benua di dunia?",
    options: ["5", "6", "7", "8"],
    correctAnswerIndex: 2,
    category: "Geografi",
  ),
  Question(
    question: "Apa nama samudra terbesar di dunia?",
    options: ["Samudra Atlantik", "Samudra Hindia", "Samudra Arktik", "Samudra Pasifik"],
    correctAnswerIndex: 3,
    category: "Geografi",
  ),
  Question(
    question: "Pulau terbesar di Indonesia adalah?",
    options: ["Jawa", "Sumatera", "Kalimantan", "Sulawesi"],
    correctAnswerIndex: 2,
    category: "Geografi",
  ),
  Question(
    question: "Gunung tertinggi di dunia adalah?",
    options: ["Gunung Kilimanjaro", "Gunung Everest", "Gunung Fuji", "Gunung Jaya Wijaya"],
    correctAnswerIndex: 1,
    category: "Geografi",
  ),
  Question(
    question: "Apa nama benua terkecil di dunia?",
    options: ["Asia", "Afrika", "Eropa", "Australia"],
    correctAnswerIndex: 3,
    category: "Geografi",
  ),

  // Kategori: Sains
  Question(
    question: "Planet terdekat dengan Matahari adalah?",
    options: ["Venus", "Mars", "Merkurius", "Jupiter"],
    correctAnswerIndex: 2,
    category: "Sains",
  ),
  Question(
    question: "Berapa lama waktu yang dibutuhkan Bumi untuk mengelilingi Matahari?",
    options: ["24 jam", "30 hari", "365 hari", "100 tahun"],
    correctAnswerIndex: 2,
    category: "Sains",
  ),
  Question(
    question: "Apa nama hewan tercepat di darat?",
    options: ["Singa", "Harimau", "Cheetah", "Kuda"],
    correctAnswerIndex: 2,
    category: "Sains",
  ),
  Question(
    question: "Apa nama bahan bakar utama Matahari?",
    options: ["Oksigen", "Hidrogen", "Helium", "Karbon"],
    correctAnswerIndex: 1,
    category: "Sains",
  ),
  Question(
    question: "Berapa warna dasar pelangi?",
    options: ["5", "6", "7", "8"],
    correctAnswerIndex: 2,
    category: "Sains",
  ),
];