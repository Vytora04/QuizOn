import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/constants.dart';
import 'quiz_screen.dart';
import 'leaderboard_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final AuthService authService;
  const HomeScreen({super.key, required this.authService});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = widget.authService.currentUser;
    final displayName = user?.email?.split('@').first ?? 'Guest';

    final screens = [
      // Home Tab
      _buildHomeTab(context, displayName),
      // Profile Tab
      ProfileScreen(authService: widget.authService),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('QuizOn!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _confirmLogout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab(BuildContext context, String displayName) {
    return Padding(
      padding: kPaddingL,
      child: Center(
        child: SingleChildScrollView(
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
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: kPrimaryColor.withOpacity(0.2),
                        child: Icon(
                          Icons.person,
                          size: 32,
                          color: kPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: kSpacingM),
                      Text(
                        'Halo, $displayName!',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: kSpacingS),
                      Text(
                        'Selamat datang di QuizOn!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: kSpacingXL),
              _buildActionButton(
                text: 'Mulai Quiz',
                icon: Icons.play_arrow,
                onPressed: () => _navigateTo(const QuizScreen()),
                isPrimary: true,
              ),
              const SizedBox(height: kSpacingM),
              _buildActionButton(
                text: 'Leaderboard',
                icon: Icons.leaderboard,
                onPressed: () => _navigateTo(LeaderboardScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
    bool isPrimary = false,
  }) {
    return SizedBox(
      width: double.infinity,
      child: isPrimary
          ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                foregroundColor: Colors.white,
                padding: kPaddingM,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kRadiusM),
                ),
                elevation: kElevationM,
              ),
              onPressed: onPressed,
              icon: Icon(icon),
              label: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: kPrimaryColor,
                padding: kPaddingM,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kRadiusM),
                ),
                side: BorderSide(color: kPrimaryColor, width: 2),
              ),
              onPressed: onPressed,
              icon: Icon(icon),
              label: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }

  void _navigateTo(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  Future<void> _confirmLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await widget.authService.signOut();
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}