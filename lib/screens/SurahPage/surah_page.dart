import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learningflutter/screens/SurahPage/surah_detail.dart';

// Corrected the import path assuming surah_detail.dart is in the same directory

class SurahPage extends StatefulWidget {
  const SurahPage({super.key});
  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  // Sample data for recent surahs (Only needs basic info for display)
  final List<Map<String, dynamic>> recentSurahs = [
    {'number': 112, 'name': 'Al-Ikhlas', 'arabic': 'الإخلاص'},
    {'number': 78, 'name': 'An-Naba\'', 'arabic': 'النبأ'}, // Changed for demo
    {'number': 114, 'name': 'An-Nas', 'arabic': 'الناس'},   // Changed for demo
  ];

  // Full data for all surahs in Juz Amma
  final List<Map<String, dynamic>> allSurahs = [
    {'number': 78, 'name': 'An-Naba\'', 'arabic': 'النبأ', 'type': 'Makki', 'verses': 40},
    {'number': 79, 'name': 'An-Nazi\'at', 'arabic': 'النازعات', 'type': 'Makki', 'verses': 46},
    {'number': 80, 'name': 'Abasa', 'arabic': 'عبس', 'type': 'Makki', 'verses': 42},
    {'number': 81, 'name': 'At-Takwir', 'arabic': 'التكوير', 'type': 'Makki', 'verses': 29},
    {'number': 82, 'name': 'Al-Infitar', 'arabic': 'الإنفطار', 'type': 'Makki', 'verses': 19},
    {'number': 83, 'name': 'Al-Mutaffifin', 'arabic': 'المطففين', 'type': 'Makki', 'verses': 36},
    {'number': 84, 'name': 'Al-Inshiqaq', 'arabic': 'الإنشقاق', 'type': 'Makki', 'verses': 25},
    {'number': 85, 'name': 'Al-Buruj', 'arabic': 'البروج', 'type': 'Makki', 'verses': 22},
    {'number': 86, 'name': 'At-Tariq', 'arabic': 'الطارق', 'type': 'Makki', 'verses': 17},
    {'number': 87, 'name': 'Al-Ala', 'arabic': 'الأعلى', 'type': 'Makki', 'verses': 19},
    {'number': 88, 'name': 'Al-Ghashiyah', 'arabic': 'الغاشية', 'type': 'Makki', 'verses': 26},
    {'number': 89, 'name': 'Al-Fajr', 'arabic': 'الفجر', 'type': 'Makki', 'verses': 30},
    {'number': 90, 'name': 'Al-Balad', 'arabic': 'البلد', 'type': 'Makki', 'verses': 20},
    {'number': 91, 'name': 'Ash-Shams', 'arabic': 'الشمس', 'type': 'Makki', 'verses': 15},
    {'number': 92, 'name': 'Al-Lail', 'arabic': 'الليل', 'type': 'Makki', 'verses': 21},
    {'number': 93, 'name': 'Ad-Duha', 'arabic': 'الضحى', 'type': 'Makki', 'verses': 11},
    {'number': 94, 'name': 'Ash-Sharh', 'arabic': 'الشرح', 'type': 'Makki', 'verses': 8},
    {'number': 95, 'name': 'At-Tin', 'arabic': 'التين', 'type': 'Makki', 'verses': 8},
    {'number': 96, 'name': 'Al-Alaq', 'arabic': 'العلق', 'type': 'Makki', 'verses': 19},
    {'number': 97, 'name': 'Al-Qadr', 'arabic': 'القدر', 'type': 'Makki', 'verses': 5},
    {'number': 98, 'name': 'Al-Bayyina', 'arabic': 'البينة', 'type': 'Madani', 'verses': 8},
    {'number': 99, 'name': 'Az-Zalzalah', 'arabic': 'الزلزلة', 'type': 'Madani', 'verses': 8},
    {'number': 100, 'name': 'Al-Adiyat', 'arabic': 'العاديات', 'type': 'Makki', 'verses': 11},
    {'number': 101, 'name': 'Al-Qariah', 'arabic': 'القارعة', 'type': 'Makki', 'verses': 11},
    {'number': 102, 'name': 'At-Takathur', 'arabic': 'التكاثر', 'type': 'Makki', 'verses': 8},
    {'number': 103, 'name': 'Al-Asr', 'arabic': 'العصر', 'type': 'Makki', 'verses': 3},
    {'number': 104, 'name': 'Al-Humazah', 'arabic': 'الهمزة', 'type': 'Makki', 'verses': 9},
    {'number': 105, 'name': 'Al-Fil', 'arabic': 'الفيل', 'type': 'Makki', 'verses': 5},
    {'number': 106, 'name': 'Quraish', 'arabic': 'قريش', 'type': 'Makki', 'verses': 4},
    {'number': 107, 'name': 'Al-Maun', 'arabic': 'الماعون', 'type': 'Makki', 'verses': 7},
    {'number': 108, 'name': 'Al-Kawthar', 'arabic': 'الكوثر', 'type': 'Makki', 'verses': 3},
    {'number': 109, 'name': 'Al-Kafirun', 'arabic': 'الكافرون', 'type': 'Makki', 'verses': 6},
    {'number': 110, 'name': 'An-Nasr', 'arabic': 'النصر', 'type': 'Madani', 'verses': 3},
    {'number': 111, 'name': 'Al-Masad', 'arabic': 'المسد', 'type': 'Makki', 'verses': 5},
    {'number': 112, 'name': 'Al-Ikhlas', 'arabic': 'الإخلاص', 'type': 'Makki', 'verses': 4},
    {'number': 113, 'name': 'Al-Falaq', 'arabic': 'الفلق', 'type': 'Makki', 'verses': 5},
    {'number': 114, 'name': 'An-Nas', 'arabic': 'الناس', 'type': 'Makki', 'verses': 6},
  ];

  // 🔹 MODIFIED: Function now accepts type and verses count
  void navigateToSurah(
      int number, String name, String arabic, String type, int verses) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SurahDetailPage(
          surahNumber: number,
          surahName: name,
          surahArabic: arabic,
          // Pass the additional data
          surahType: type,
          totalVerses: verses,
        ),
      ),
    );
  }

  // Helper function to find surah details from the main list
  Map<String, dynamic>? findSurahDetails(int number) {
    try {
      return allSurahs.firstWhere((s) => s['number'] == number);
    } catch (e) {
      return null; // Return null if not found
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
      body: CustomScrollView(
        slivers: [
          // App Bar with Arabic title
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: const Color.fromRGBO(243, 243, 243, 1), // Corrected Color constructor
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'سورة', // Arabic word for Surah
                style: GoogleFonts.amiri(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),

          // Recent Surah Section
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RECENT SURAH',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Recent Surahs List
                  ...recentSurahs.map((recentSurah) {
                    // 🔹 ADDED: Find full details for navigation
                    final fullSurahData = findSurahDetails(recentSurah['number']);

                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          leading: SizedBox( // Keep leading simple or add icon later
                            width: 40,
                            height: 40,
                             child: Icon(
                               Icons.history,
                               color: Color(0xFF196580),
                               size: 24,
                             ),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                recentSurah['name']!,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                recentSurah['arabic']!,
                                style: GoogleFonts.amiri(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF196580),
                                ),
                              ),
                            ],
                          ),
                          trailing: const Icon(
                            Icons.chevron_right,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          onTap: () {
                             // 🔹 MODIFIED: Check if full data was found
                            if (fullSurahData != null) {
                              navigateToSurah(
                                fullSurahData['number'],
                                fullSurahData['name']!,
                                fullSurahData['arabic']!,
                                fullSurahData['type']!,   // Pass type
                                fullSurahData['verses'], // Pass verses
                              );
                            } else {
                              // Optional: Show an error message if surah not found
                              print("Error: Surah details not found for ${recentSurah['name']}");
                            }
                          },
                        ),
                      ),
                    );
                  }).toList(), // Add .toList() here

                  const SizedBox(height: 24),

                  // Date Section
                  Text(
                    'JUZ 30',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // All Surahs List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final surah = allSurahs[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      leading: SizedBox( // Use SizedBox for consistent spacing
                          width: 40,
                          height: 40,
                          child: Center( // Center the number
                            child: Text(
                              '${surah['number']}',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                          ),
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${surah['name']}',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${surah['type']} • ${surah['verses']} verses',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            surah['arabic'],
                            style: GoogleFonts.amiri(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF196580),
                            ),
                          ),
                        ],
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      onTap: () {
                        // 🔹 MODIFIED: Pass the type and verses count
                        navigateToSurah(
                          surah['number'],
                          surah['name'],
                          surah['arabic'],
                          surah['type'],   // Pass type
                          surah['verses'], // Pass verses
                        );
                      },
                    ),
                  ),
                );
              },
              childCount: allSurahs.length,
            ),
          ),

          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 80), // Space for bottom navigation
          ),
        ],
      ),
    );
  }
}
