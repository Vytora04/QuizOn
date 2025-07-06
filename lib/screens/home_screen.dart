import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/constants.dart';
import 'quiz_screen.dart';
import 'leaderboard_screen.dart';

class HomeScreen extends StatelessWidget {
  final AuthService authService;
  const HomeScreen({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    final name = authService.currentUser ?? 'Guest';
    return Scaffold(
      appBar: AppBar(
        title: Text('QuizOn!'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              authService.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: kPaddingL,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: kElevationL,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kRadiusL),
                ),
                child: Padding(
                  padding: kPaddingXL,
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        size: 64,
                        color: kPrimaryColor,
                      ),
                      SizedBox(height: kSpacingM),
                      Text(
                        'Halo, $name!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      SizedBox(height: kSpacingS),
                      Text(
                        'Selamat datang di QuizOn!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: kSpacingXL),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    foregroundColor: Colors.white,
                    padding: kPaddingM,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRadiusM),
                    ),
                    elevation: kElevationM,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (c) => QuizScreen()),
                    );
                  },
                  child: Text(
                    'Mulai Quiz',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: kSpacingM),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: kPrimaryColor,
                    padding: kPaddingM,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRadiusM),
                    ),
                    side: BorderSide(color: kPrimaryColor, width: 2),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (c) => LeaderboardScreen()),
                    );
                  },
                  child: Text(
                    'Leaderboard',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QuizScreen()),
          );
        },
        label: Text('Mulai Quiz'),
        icon: Icon(Icons.play_arrow),
        backgroundColor: kPrimaryColor,
        elevation: kElevationL,
      ),
    );
  }
}