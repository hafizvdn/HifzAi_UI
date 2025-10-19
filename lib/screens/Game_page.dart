import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learningflutter/screens/ranking_page.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<dynamic> surahList = [];
  int currentChapterIndex = 0;

  @override
  void initState() {
    super.initState();
    loadSurahData();
  }

  Future<void> loadSurahData() async {
    final String response =
        await rootBundle.loadString('assets/juz_amma_1.json');
    final data = json.decode(response);
    setState(() {
      surahList = data['data']['surahs'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentSurah = surahList.isNotEmpty ? surahList[currentChapterIndex] : null;
    final chapterNumber = currentSurah?['number'] ?? 0;
    final ayahs = currentSurah?['ayahs'] ?? [];
    final surahName = currentSurah != null ? getSurahName(chapterNumber) : '';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: surahList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Custom App Bar
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 8,
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left side - Stats
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.local_fire_department,
                                  color: Colors.grey[600], size: 28),
                              const SizedBox(width: 4),
                              Text(
                                '3',
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[600],
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Row(
                            children: [
                              const Icon(Icons.favorite,
                                  color: Colors.red, size: 28),
                              const SizedBox(width: 4),
                              Text(
                                '5',
                                style: GoogleFonts.poppins(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Right side - Trophy icon
                      IconButton(
                        icon: const Icon(Icons.emoji_events, size: 32),
                        color: Colors.black,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RankingPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Chapter Header
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF196580), Color(0xFF1B7A9E)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Chapter $chapterNumber:',
                            style: GoogleFonts.poppins(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Surah $surahName',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Scrollable Game Path
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: Stack(
                      children: [
                        // Path with levels
                        Column(
                          children: List.generate(ayahs.length, (index) {
                            return _buildLevelNode(
                              context,
                              index,
                              ayahs.length,
                              surahName,
                              chapterNumber,
                            );
                          }),
                        ),

                        // Quran Icon (IQRA)
                        Positioned(
                          left: 20,
                          top: 100,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFD699),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'IQRA',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const Icon(
                                  Icons.menu_book,
                                  color: Color(0xFF8B4513),
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Book Icon at bottom
                        Positioned(
                          right: 20,
                          bottom: 20,
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.auto_stories,
                              color: Colors.white,
                              size: 36,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildLevelNode(BuildContext context, int index, int totalLevels,
      String surahName, int chapterNumber) {
    // Alternate left and right positioning
    final isLeft = index % 2 == 0;
    final isFirst = index == 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Row(
        mainAxisAlignment:
            isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isLeft) const SizedBox(width: 120),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameLevelPage(
                    surahName: surahName,
                    levelNumber: index + 1,
                    chapterNumber: chapterNumber,
                  ),
                ),
              );
            },
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                gradient: isFirst
                    ? const LinearGradient(
                        colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    : null,
                color: isFirst ? null : const Color(0xFFBDBDBD),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(
                Icons.menu_book,
                color: isFirst ? Colors.white : const Color(0xFF8B7D7D),
                size: 36,
              ),
            ),
          ),
          if (!isLeft) const SizedBox(width: 120),
        ],
      ),
    );
  }

  String getSurahName(int number) {
    switch (number) {
      case 1:
        return 'An-Naba\'';
      case 2:
        return 'An-Nazi\'at';
      case 3:
        return 'Abasa';
      default:
        return 'Unknown';
    }
  }
}

// 🕹️ Game Level Page
class GameLevelPage extends StatelessWidget {
  final String surahName;
  final int levelNumber;
  final int chapterNumber;

  const GameLevelPage({
    super.key,
    required this.surahName,
    required this.levelNumber,
    required this.chapterNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chapter $chapterNumber: Surah $surahName',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF196580),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Level $levelNumber',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF196580),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Surah Annaba',//
              style: GoogleFonts.poppins(fontSize: 22),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF196580),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              onPressed: () {
                
              },
              child: Text(
                'Start Level',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}