import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';
import '../models/user.dart';


class AuthService {
  late SharedPreferences _prefs;
  static const String _usersKey = 'registered_users';
  static const String _currentUserUsernameKey = 'current_user_username';

  User? _loggedInUser;

  User? get currentUser => _loggedInUser;

  AuthService() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    
    List<User> existingUsers = await _getRegisteredUsers();
    if (existingUsers.isEmpty) {
      final dummyUser = User(username: 'dummy', password: 'quizon');
      await _saveRegisteredUsers([dummyUser]);
    }

    await _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final String? username = _prefs.getString(_currentUserUsernameKey);
    if (username != null) {
      final users = await _getRegisteredUsers();
      _loggedInUser = users.firstWhereOrNull(
        (user) => user.username == username,
      );
    }
  }

  Future<List<User>> _getRegisteredUsers() async {
    final String? usersJson = _prefs.getString(_usersKey);
    if (usersJson == null || usersJson.isEmpty) {
      return [];
    }
    final List<dynamic> userMapList = jsonDecode(usersJson);
    return userMapList.map((map) => User.fromJson(map)).toList();
  }

  Future<void> _saveRegisteredUsers(List<User> users) async {
    final List<Map<String, dynamic>> userMapList = users.map((user) => user.toJson()).toList();
    await _prefs.setString(_usersKey, jsonEncode(userMapList));
  }

  Future<bool> login(String username, String password) async {
    await _initPrefs();
    final users = await _getRegisteredUsers();
    final foundUser = users.firstWhereOrNull(
      (user) => user.username == username && user.password == password,
    );
    if (foundUser != null) {
      _loggedInUser = foundUser;
      await _prefs.setString(_currentUserUsernameKey, foundUser.username);
      return true;
    }
    return false;
  }

  Future<bool> register(String username, String password) async {
    await _initPrefs();
    final users = await _getRegisteredUsers();
    if (users.any((user) => user.username == username)) {
      return false;
    }
    final newUser = User(username: username, password: password);
    users.add(newUser);
    await _saveRegisteredUsers(users);
    return true;
  }

  Future<bool> changePassword({
    required String username,
    required String currentPassword,
    required String newPassword,
  }) async {
    await _initPrefs();
    List<User> users = await _getRegisteredUsers();
    final userIndex = users.indexWhere(
      (user) => user.username == username && user.password == currentPassword,
    );

    if (userIndex != -1) {
      final updatedUser = User(
        username: users[userIndex].username,
        password: newPassword,
        highScore: users[userIndex].highScore,
      );
      users[userIndex] = updatedUser;
      await _saveRegisteredUsers(users);
      _loggedInUser = updatedUser;
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await _initPrefs();
    _loggedInUser = null;
    await _prefs.remove(_currentUserUsernameKey);
  }

  Future<bool> updateUserHighScore(String username, int newScore) async {
    await _initPrefs();
    List<User> users = await _getRegisteredUsers();
    final userIndex = users.indexWhere((user) => user.username == username);

    if (userIndex != -1) {
      if (newScore > users[userIndex].highScore) {
        final updatedUser = User(
          username: users[userIndex].username,
          password: users[userIndex].password,
          highScore: newScore,
        );
        users[userIndex] = updatedUser;
        await _saveRegisteredUsers(users);
        if (_loggedInUser?.username == username) {
          _loggedInUser = updatedUser;
        }
        return true;
      }
    }
    return false;
  }

  Future<List<User>> getLeaderboardUsers() async {
    await _initPrefs();
    List<User> users = await _getRegisteredUsers();
    users.sort((a, b) => b.highScore.compareTo(a.highScore));
    return users;
  }
}