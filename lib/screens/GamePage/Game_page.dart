import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learningflutter/screens/GamePage/LoadingScreen.dart';
import 'package:learningflutter/screens/GamePage/game_level.dart';
import 'package:learningflutter/screens/GamePage/ranking_page.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
// Note: You must add 'google_fonts' and 'sticky_grouped_list'
// to your pubspec.yaml

void main() {
  runApp(const MyApp());
}

// class GameLevel extends StatelessWidget {
//   final String surahName;
//   final int levelNumber;
//   final String chapterTitle;
//   final int chapterNumber;

//   const GameLevel({
//     super.key,
//     required this.surahName,
//     required this.levelNumber,
//     required this.chapterTitle,
//     required this.chapterNumber,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('$surahName - Level $levelNumber')),
//       body: Center(
//         child: Text(
//           'Playing $chapterTitle (Surah $chapterNumber)\nLevel $levelNumber',
//           textAlign: TextAlign.center,
//           style: GoogleFonts.poppins(fontSize: 22),
//         ),
//       ),
//     );
//   }
// }

// --- End Stub Pages ---

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sticky Header Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        // Set the background color to match the reference
        scaffoldBackgroundColor: const Color(0xFFE8E8E8),
      ),
      home: const GamePage(), // Changed to GamePage
    );
  }
}

/// A simple class to hold our data for each level.
/// This now includes the full 'surah' data map.
// In your _Element class
class _Element {
  final String chapterTitle;
  final int chapterNumber; // <-- ADD THIS LINE
  final Map<String, dynamic> surahData;
  final int levelIndex;
  final bool isUnlocked;
  final bool isCompleted;

  const _Element({
    required this.chapterTitle,
    required this.chapterNumber, // <-- ADD THIS LINE
    required this.surahData,
    required this.levelIndex,
    this.isUnlocked = false,
    this.isCompleted = false,
  });
}

// Renamed StickyChaptersPage to GamePage and made it StatefulWidget
class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  // State variables from your reference code
  List<_Element> _elements = []; // This will hold our transformed data
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSurahData();
  }

  // Copied from your reference code
  String getSurahName(int number) {
    // Map for Juz Amma surahs (78-114)
    const surahNames = {
      78: 'An-Naba\'',
      79: 'An-Nazi\'at',
      80: 'Abasa',
      81: 'At-Takwir',
      82: 'Al-Infitar',
      83: 'Al-Mutaffifin',
      84: 'Al-Inshiqaq',
      85: 'Al-Buruj',
      86: 'At-Tariq',
      87: 'Al-A\'la',
      88: 'Al-Ghashiyah',
      89: 'Al-Fajr',
      90: 'Al-Balad',
      91: 'Ash-Shams',
      92: 'Al-Lail',
      93: 'Ad-Duha',
      94: 'Ash-Sharh',
      95: 'At-Tin',
      96: 'Al-Alaq',
      97: 'Al-Qadr',
      98: 'Al-Bayyinah',
      99: 'Az-Zalzalah',
      100: 'Al-Adiyat',
      101: 'Al-Qari\'ah',
      102: 'At-Takathur',
      103: 'Al-Asr',
      104: 'Al-Humazah',
      105: 'Al-Fil',
      106: 'Quraish',
      107: 'Al-Ma\'un',
      108: 'Al-Kawthar',
      109: 'Al-Kafirun',
      110: 'An-Nasr',
      111: 'Al-Masad',
      112: 'Al-Ikhlas',
      113: 'Al-Falaq',
      114: 'An-Nas',
    };
    return surahNames[number] ?? 'Unknown';
  }

  // Modified from your reference code to build the _elements list
  Future<void> loadSurahData() async {
    try {
      final String response =
          await rootBundle.loadString('assets/juz_amma_1.json');
      final data = json.decode(response);
      final List<dynamic> surahList = data['data']['surahs'];

      // Transform the JSON data into the List<_Element> the UI needs
      final List<_Element> loadedElements = [];
      for (var surah in surahList) {
        final int chapterNumber = surah['number'];
        final String surahName = getSurahName(chapterNumber);
        final String chapterTitle = "Chapter $chapterNumber: $surahName";
        final List<dynamic> ayahs = surah['ayahs'];

        // Get level count using your reference code's logic
        final int levelCount = (ayahs.length / 4).ceil();

        for (int i = 0; i < levelCount; i++) {
          loadedElements.add(_Element(
            chapterTitle: chapterTitle,
            chapterNumber: chapterNumber,
            surahData: surah, // Pass the whole map
            levelIndex: i,
            // Logic from reference: First level is always unlocked
            isUnlocked: i == 0,
            isCompleted: false, // You can update this logic
          ));
        }
      }

      setState(() {
        _elements = loadedElements; // Set the new list
        isLoading = false;
      });
    } catch (e) {
      print('Error loading surah data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator while data is loading
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Show message if no data was loaded
    if (_elements.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            'No data available',
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ),
      );
    }

    // Data is loaded, build the sticky list UI
    return Scaffold(
        appBar: _buildCustomAppBar(context),
        body: StickyGroupedListView<_Element, int>( // <-- Change String to int
        elements: _elements,
        groupBy: (element) => element.chapterNumber, // <-- THE MAIN FIX
        groupSeparatorBuilder: (element) => _buildChapterHeader(element),
        itemBuilder: (context, element) => _buildLevelNode(context, element),
        order: StickyGroupedListOrder.ASC, // This will now sort numerically!
        floatingHeader: true,
        padding: const EdgeInsets.only(top: 20),
      ),
    );
  }

  /// Builds the custom AppBar from the reference code
  PreferredSizeWidget _buildCustomAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + MediaQuery.of(context).padding.top + 8),
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 8,
          left: 16,
          right: 16,
          bottom: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
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
                      '3', // TODO: Use real data
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
                    const Icon(Icons.favorite, color: Colors.red, size: 28),
                    const SizedBox(width: 4),
                    Text(
                      '5', // TODO: Use real data
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
    );
  }

  /// Builds the sticky chapter header widget
  /// This now takes an _Element to get all the surah data
  Widget _buildChapterHeader(_Element element) {
    // Get data from the element's surahData map
    final surahData = element.surahData;
    final chapterNumber = surahData['number'] ?? 0;
    final surahName = getSurahName(chapterNumber);
    final surahNameArabic = surahData['name'] ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Container(
        height: 100,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2C5F7C), Color(0xFF1E4A5F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        // This Column is from your reference code's header
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Chapter $chapterNumber:',
              style: GoogleFonts.poppins(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Surah $surahName',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  surahNameArabic,
                  style: GoogleFonts.amiri(
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
    );
  }

  /// Builds the regular list item (level node) widget
  Widget _buildLevelNode(BuildContext context, _Element element) {
    // Staggered path logic from reference code
    final leftOffsets = [0.0, 60.0, 200.0, 100.0, 40.0];
    final leftOffset = leftOffsets[element.levelIndex % leftOffsets.length];

    // Get data needed for navigation
    final surahData = element.surahData;
    final chapterNumber = surahData['number'] ?? 0;
    final surahName = getSurahName(chapterNumber);

    return Padding(
      padding: EdgeInsets.only(left: leftOffset, bottom: 20, right: 20),
      child: GestureDetector(
        // This is the correct code for the onTap in Game_page.dart

onTap: element.isUnlocked
    ? () {
        // 1. Get ALL ayahs for the chapter
        final allAyahs = element.surahData['ayahs'] as List<dynamic>;
        final int levelIndex = element.levelIndex;
        const int ayahsPerLevel = 4; // Make sure this matches your logic
        
        // 2. Calculate the START and END index for this level
        final int startIndex = levelIndex * ayahsPerLevel;
        final int endIndex = (startIndex + ayahsPerLevel > allAyahs.length)
                             ? allAyahs.length
                             : (startIndex + ayahsPerLevel);
        
        // 3. Create the sublist of ayahs for THIS level
        final List<dynamic> levelAyahs = allAyahs.sublist(startIndex, endIndex);

        // 4. Navigate to the LoadingScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoadingScreen(
              // Pass a real hint, e.g., the first ayah text
              levelHint: '"${(levelAyahs.first as Map<String, dynamic>)['text']}"',
              onComplete: () {
                // After loading, replace with GameLevel and pass the ayahs
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameLevel(
                      surahName: surahName,
                      levelNumber: element.levelIndex + 1,
                      chapterTitle: element.chapterTitle,
                      chapterNumber: chapterNumber,
                      ayahs: levelAyahs, // <-- This is the required argument
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }
    : null, // Disabled if not unlocked null, // Disabled if not unlocked
        child: Container(
          width: 80,
          height: 74,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: element.isCompleted
                ? Container(
                    width: 80,
                    height: 74,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF4CAF50),
                    ),
                    child:
                        const Icon(Icons.check, color: Colors.white, size: 36),
                  )
                : Image.asset(
                    element.isUnlocked
                        ? 'assets/image/unlock_level-01.png'
                        : 'assets/image/lock_level-01.png',
                    width: 80,
                    height: 74,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback to colored container with icon if image fails to load
                      return Container(
                        width: 80,
                        height: 74,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: element.isUnlocked
                              ? const Color(0xFF2C5F7C)
                              : const Color(0xFFB8B8B8),
                        ),
                        child: Icon(
                          element.isUnlocked ? Icons.menu_book : Icons.lock,
                          color: Colors.white
                              .withOpacity(element.isUnlocked ? 0.9 : 0.7),
                          size: 36,
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
