import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  // Sample data - Replace with Firebase data later
  final List<Map<String, dynamic>> leaderboard = [
    {'rank': 1, 'username': 'luqm@n', 'xp': 200},
    {'rank': 2, 'username': 'muham@d23', 'xp': 180},
    {'rank': 3, 'username': 'hafizvdn', 'xp': 20},
    {'rank': 4, 'username': 'ismail_jun', 'xp': 10},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),
      appBar: AppBar(
        title: Text('Ranking', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF2C5F7C),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Title
            Text(
              'HifzAi League\nLeaderboard',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 32),
            
            // Leaderboard Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFF2C5F7C),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: leaderboard.map((player) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Rank and Username
                        Row(
                          children: [
                            Text(
                              '${player['rank']}. ',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              player['username'],
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: player['rank'] == 3 
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                color: player['rank'] == 3 
                                    ? const Color(0xFF2C5F7C)
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        // XP
                        Text(
                          '${player['xp']} xp',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Model for Leaderboard entry (for future Firebase integration)
class LeaderboardEntry {
  final int rank;
  final String username;
  final int xp;

  LeaderboardEntry({
    required this.rank,
    required this.username,
    required this.xp,
  });

  // Factory constructor for creating from Firebase
  factory LeaderboardEntry.fromJson(Map<String, dynamic> json, int rank) {
    return LeaderboardEntry(
      rank: rank,
      username: json['username'] ?? '',
      xp: json['xp'] ?? 0,
    );
  }
}

/* 
FIREBASE INTEGRATION GUIDE:
========================

1. Add this method to fetch data from Firebase:

Future<List<Map<String, dynamic>>> fetchLeaderboard() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .orderBy('xp', descending: true)
      .limit(10)
      .get();

  List<Map<String, dynamic>> leaderboard = [];
  int rank = 1;
  
  for (var doc in snapshot.docs) {
    leaderboard.add({
      'rank': rank,
      'username': doc['username'] ?? 'Anonymous',
      'xp': doc['xp'] ?? 0,
    });
    rank++;
  }
  
  return leaderboard;
}

2. Update initState:

@override
void initState() {
  super.initState();
  _loadLeaderboard();
}

void _loadLeaderboard() async {
  final data = await fetchLeaderboard();
  setState(() {
    leaderboard = data;
  });
}

3. Add loading state:

bool isLoading = true;

// In build method:
if (isLoading) {
  return Scaffold(
    body: Center(child: CircularProgressIndicator()),
  );
}
*/