// Dummy Database Service
class DbService {
  // Simpan skor user secara lokal (sementara, nanti ganti ke Firestore)
  final Map<String, int> _userScores = {};

  Future<void> saveScore(String username, int score) async {
    await Future.delayed(Duration(milliseconds: 300));
    _userScores[username] = score;
  }

  Future<int?> getScore(String username) async {
    await Future.delayed(Duration(milliseconds: 300));
    return _userScores[username];
  }

  Future<List<Map<String, dynamic>>> getLeaderboard() async {
    await Future.delayed(Duration(milliseconds: 300));
    return _userScores.entries
        .map((e) => {"username": e.key, "score": e.value})
        .toList()
      ..sort((a, b) => ((b["score"] ?? 0) as int).compareTo((a["score"] ?? 0) as int));
  }
}