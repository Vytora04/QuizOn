class User {
  final String username;
  final String password;
  final int highScore;

  User({required this.username, required this.password, this.highScore = 0});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] as String,
      password: json['password'] as String, 
      highScore: json['highScore'] as int? ?? 0, 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'highScore': highScore,
    };
  }
}