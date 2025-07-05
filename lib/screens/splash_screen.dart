import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'QuizOn!',
          style: GoogleFonts.poppins(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.indigo),
        ),
      ),
    );
  }
}