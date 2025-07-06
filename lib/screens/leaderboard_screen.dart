import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../services/auth_service.dart';
import '../models/user.dart';

class LeaderboardScreen extends StatefulWidget {
  final AuthService authService;
  LeaderboardScreen({super.key, required this.authService});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<User> _leaderboardUsers = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadLeaderboard();
  }

  Future<void> _loadLeaderboard() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      _leaderboardUsers = await widget.authService.getLeaderboardUsers();
    } catch (e) {
      _errorMessage = 'Gagal memuat leaderboard: ${e.toString()}';
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Papan Peringkat',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Text(
                    _errorMessage!,
                    style: GoogleFonts.poppins(color: Colors.red),
                  ),
                )
              : Padding(
                  padding: kPaddingM,
                  child: _leaderboardUsers.isEmpty
                      ? Center(
                          child: Text(
                            'Belum ada skor di leaderboard.',
                            style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey.shade600),
                          ),
                        )
                      : ListView.separated(
                          itemCount: _leaderboardUsers.length,
                          separatorBuilder: (_, __) => SizedBox(height: kSpacingM),
                          itemBuilder: (context, index) {
                            final user = _leaderboardUsers[index];
                            final isTopThree = index < 3;

                            return AnimatedContainer(
                              duration: Duration(milliseconds: 300 + (index * 100)),
                              child: Card(
                                elevation: isTopThree ? kElevationL : kElevationM,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(kRadiusL),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(kRadiusL),
                                    gradient: isTopThree
                                        ? LinearGradient(
                                            colors: index == 0
                                                ? [Colors.amber.shade100, Colors.amber.shade50]
                                                : index == 1
                                                    ? [Colors.grey.shade100, Colors.grey.shade50]
                                                    : [Colors.brown.shade100, Colors.brown.shade50],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          )
                                        : null,
                                  ),
                                  child: ListTile(
                                    contentPadding: kPaddingM,
                                    leading: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: index == 0
                                          ? kAccentColor
                                          : index == 1
                                              ? Colors.grey
                                              : index == 2
                                                  ? Colors.brown
                                                  : kPrimaryColor,
                                      foregroundColor: Colors.white,
                                      child: index < 3
                                          ? Icon(
                                              index == 0 ? Icons.emoji_events : Icons.military_tech,
                                              size: 24,
                                            )
                                          : Text(
                                              '${index + 1}',
                                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
                                            ),
                                    ),
                                    title: Text(
                                      user.username,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.grey.shade900,
                                      ),
                                    ),
                                    subtitle: isTopThree
                                        ? Text(
                                            index == 0 ? 'Juara 1' : index == 1 ? 'Juara 2' : 'Juara 3',
                                            style: GoogleFonts.poppins(
                                              color: index == 0 ? Colors.amber.shade700 : Colors.grey.shade700,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        : null,
                                    trailing: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: kSpacingM,
                                        vertical: kSpacingS,
                                      ),
                                      decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        '${user.highScore} pts',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
    );
  }
}
