import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/auth_service.dart';
import '../utils/constants.dart';
import 'quiz_screen.dart';
import 'leaderboard_screen.dart';
import 'profile_screen.dart';
import '../models/question.dart'; // Import to get categories from dummyQuestions

class HomeScreen extends StatefulWidget { // Changed to StatefulWidget
  final AuthService authService;
  const HomeScreen({super.key, required this.authService});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedCategory; // State variable to hold the selected category

  List<String> get _categories {
    // Extract unique categories from dummyQuestions
    final Set<String> categories = {};
    for (var q in dummyQuestions) {
      categories.add(q.category);
    }
    return ['Semua Kategori', ...categories.toList()]; // Add 'All Categories' option
  }

  @override
  Widget build(BuildContext context) {
    final String displayName = widget.authService.currentUser?.username ?? 'Guest';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QuizOn!',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => ProfileScreen(authService: widget.authService),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await widget.authService.logout();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
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
                        'Halo, $displayName!',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      SizedBox(height: kSpacingS),
                      Text(
                        'Selamat datang di QuizOn!',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: kSpacingL),
                      // Category Dropdown
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Pilih Kategori',
                          labelStyle: GoogleFonts.poppins(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(kRadiusM),
                          ),
                          prefixIcon: const Icon(Icons.category),
                        ),
                        value: _selectedCategory,
                        hint: Text('Pilih Kategori Quiz', style: GoogleFonts.poppins()),
                        items: _categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category, style: GoogleFonts.poppins()),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCategory = newValue;
                          });
                        },
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
                    String? categoryToPass = _selectedCategory == 'Semua Kategori' || _selectedCategory == null
                        ? null
                        : _selectedCategory;

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (c) => QuizScreen(authService: widget.authService, category: categoryToPass)),
                    );
                  },
                  child: Text(
                    'Mulai Quiz',
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
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
                      MaterialPageRoute(builder: (c) => LeaderboardScreen(authService: widget.authService)),
                    );
                  },
                  child: Text(
                    'Leaderboard',
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          String? categoryToPass = _selectedCategory == 'Semua Kategori' || _selectedCategory == null
              ? null
              : _selectedCategory;

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QuizScreen(authService: widget.authService, category: categoryToPass)),
          );
        },
        label: Text(
          'Mulai Quiz',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        icon: const Icon(Icons.play_arrow),
        backgroundColor: kPrimaryColor,
        elevation: kElevationL,
      ),
    );
  }
}