import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';

void main() {
  runApp(QuizOnApp());
}

class QuizOnApp extends StatelessWidget {
  final AuthService authService = AuthService();

  QuizOnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizOn!',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      home: LoginScreen(authService: authService),
      routes: {
        '/login': (context) => LoginScreen(authService: authService),
      },
      debugShowCheckedModeBanner: false,
    );
  }
} 