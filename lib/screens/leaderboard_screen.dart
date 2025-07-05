import 'package:flutter/material.dart';
import '../utils/constants.dart';

class LeaderboardScreen extends StatelessWidget {
  LeaderboardScreen({super.key});

  // Data dummy leaderboard
  final List<Map<String, dynamic>> leaderboard = [
    {"username": "Andi", "score": 9},
    {"username": "Budi", "score": 8},
    {"username": "Citra", "score": 8},
    {"username": "Dewi", "score": 7},
    {"username": "Eko", "score": 6},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: Padding(
        padding: kPaddingM,
        child: ListView.separated(
          itemCount: leaderboard.length,
          separatorBuilder: (_, __) => SizedBox(height: kSpacingM),
          itemBuilder: (context, index) {
            final user = leaderboard[index];
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
                    gradient: isTopThree ? LinearGradient(
                      colors: index == 0 
                          ? [Colors.amber.shade100, Colors.amber.shade50]
                          : index == 1
                              ? [Colors.grey.shade100, Colors.grey.shade50]
                              : [Colors.brown.shade100, Colors.brown.shade50],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ) : null,
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
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                    ),
                    title: Text(
                      user['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    subtitle: isTopThree ? Text(
                      index == 0 ? 'Juara 1' : index == 1 ? 'Juara 2' : 'Juara 3',
                      style: TextStyle(
                        color: index == 0 ? Colors.amber.shade700 : Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ) : null,
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
                        '${user['score']} pts',
                        style: TextStyle(
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