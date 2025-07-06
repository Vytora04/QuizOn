class AuthService {
  String? _currentUser;

  // Dummy login (langsung masuk tanpa validasi)
  Future<bool> login(String username, String password) async {
    await Future.delayed(Duration(seconds: 1));
    _currentUser = username;
    return true;
  }

  String? get currentUser => _currentUser;

  void logout() {
    _currentUser = null;
  }
}