import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class SurahDetailPage extends StatefulWidget {
  final int surahNumber;
  final String surahName;
  final String surahArabic;

  const SurahDetailPage({
    super.key,
    required this.surahNumber,
    required this.surahName,
    required this.surahArabic,
  });

  @override
  State<SurahDetailPage> createState() => _SurahDetailPageState();
}

class _SurahDetailPageState extends State<SurahDetailPage> with SingleTickerProviderStateMixin {
  List<dynamic> verses = [];
  bool isLoading = true;
  Map<String, dynamic>? surahInfo;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadSurahData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> loadSurahData() async {
    try {
      final String response = await rootBundle.loadString('assets/juz_amma_1.json');
      final data = json.decode(response);
      
      final surah = data['data']['surahs'].firstWhere(
        (s) => s['number'] == widget.surahNumber,
        orElse: () => null,
      );

      if (surah != null) {
        setState(() {
          surahInfo = surah;
          verses = surah['ayahs'];
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading surah data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Reading Mode - Mushaf Style (continuous text)
  Widget _buildReadingMode() {
    if (verses.isEmpty) {
      return Center(
        child: Text(
          'No verses available',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      );
    }

    // Combine all verses into one continuous text (Mushaf style)
    String fullSurahText = verses.map((verse) {
      String verseText = verse['text'];
      int verseNumber = verse['numberInSurah'];
      // Add verse number marker (you can customize this)
      return '$verseText ۝$verseNumber';
    }).join(' ');

    return SingleChildScrollView(
      child: Column(
        children: [
          // Bismillah (except for Surah 9 and 1)
          if (widget.surahNumber != 9 && widget.surahNumber != 1)
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
                  style: GoogleFonts.amiri(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF196580),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

          // Full Surah Text - Mushaf Style
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              fullSurahText,
              style: GoogleFonts.amiri(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                height: 2.0,
              ),
              textAlign: TextAlign.justify,
              textDirection: TextDirection.rtl,
            ),
          ),

          SizedBox(height: 80),
        ],
      ),
    );
  }

  // Memorize Mode - Verse by Verse
  Widget _buildMemorizeMode() {
    return CustomScrollView(
      slivers: [
        // Bismillah (except for Surah 9 and 1)
        if (widget.surahNumber != 9 && widget.surahNumber != 1)
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
                  style: GoogleFonts.amiri(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF196580),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

        // Verses List
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final verse = verses[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Verse number badge
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF196580).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${verse['numberInSurah']}',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF196580),
                            ),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.bookmark_border,
                            color: Color(0xFF196580),
                            size: 20,
                          ),
                          onPressed: () {
                            // Handle bookmark
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.share,
                            color: Color(0xFF196580),
                            size: 20,
                          ),
                          onPressed: () {
                            // Handle share
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    
                    // Arabic text
                    Text(
                      verse['text'],
                      style: GoogleFonts.amiri(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        height: 2.0,
                      ),
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                    
                    SizedBox(height: 16),
                    Divider(color: Colors.grey[300]),
                    SizedBox(height: 12),
                    
                    // Translation
                    Text(
                      'Translation will be displayed here',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              );
            },
            childCount: verses.length,
          ),
        ),

        // Bottom padding
        SliverToBoxAdapter(
          child: SizedBox(height: 80),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Color(0xFF196580),
              ),
            )
          : NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  // App Bar with Surah Info
                  SliverAppBar(
                    expandedHeight: 200,
                    floating: false,
                    pinned: true,
                    backgroundColor: Color(0xFF196580),
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.surahArabic,
                            style: GoogleFonts.amiri(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            widget.surahName,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF196580),
                              Color(0xFF1a7a9c),
                            ],
                          ),
                        ),
                      ),
                    ),
                    bottom: TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.white,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white70,
                      labelStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      unselectedLabelStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      tabs: [
                        Tab(
                          icon: Icon(Icons.menu_book),
                          text: 'Reading',
                        ),
                        Tab(
                          icon: Icon(Icons.school),
                          text: 'Memorize',
                        ),
                      ],
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  _buildReadingMode(),
                  _buildMemorizeMode(),
                ],
              ),
            ),
    );
  }
}