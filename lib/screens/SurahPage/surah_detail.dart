import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

// 🔹 NEW: Enum to manage the reading view mode
enum ReadingMode { mushaf, list }

class SurahDetailPage extends StatefulWidget {
  final int surahNumber;
  final String surahName;
  final String surahArabic;
  // 🔹 ADDED THESE TWO FIELDS 🔹
  final String surahType;
  final int totalVerses;

  const SurahDetailPage({
    super.key,
    required this.surahNumber,
    required this.surahName,
    required this.surahArabic,
    // 🔹 ADDED THESE TO CONSTRUCTOR 🔹
    required this.surahType,
    required this.totalVerses,
  });

  @override
  State<SurahDetailPage> createState() => _SurahDetailPageState();
}

class _SurahDetailPageState extends State<SurahDetailPage>
    with SingleTickerProviderStateMixin {
  List<dynamic> verses = [];
  bool isLoading = true;
  // We keep surahInfo for ayah data, but header info comes from widget properties now
  Map<String, dynamic>? surahInfo;
  late TabController _tabController;

  // 🔹 NEW: State variable for the SegmentedButton
  ReadingMode _readingMode = ReadingMode.mushaf;

  // For Memorize Mode: Keeps track of which verses are hidden
  Map<int, bool> _verseVisibility = {};

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
    // This function remains the same, loading only verse data
    try {
      final String response =
          await rootBundle.loadString('assets/juz_amma_1.json');
      final data = json.decode(response);

      final surah = data['data']['surahs'].firstWhere(
        (s) => s['number'] == widget.surahNumber,
        orElse: () => null,
      );

      if (surah != null) {
        setState(() {
          surahInfo = surah; // Still store this for 'ayahs' key
          verses = surah['ayahs'];
          // Initialize all verses to be visible
          for (var verse in verses) {
            _verseVisibility[verse['numberInSurah']] = true;
          }
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

  // -----------------------------------------------------------------
  // 🔹 WIDGETS 🔹
  // -----------------------------------------------------------------


  /// 🔹 A beautiful ornamental frame for the Surah title
  Widget _buildSurahTitleOrnament() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // This Icon simulates a beautiful Islamic star/ornament
        Icon(
          Icons.brightness_low_outlined, // You can use a custom SVG here
          color: Colors.white.withOpacity(0.15), // Corrected: Use withOpacity
          size: 130,
        ),
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(0.3), // Corrected: Use withOpacity
              width: 2,
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.surahArabic,
              style: GoogleFonts.amiri(
                fontSize: 32, // Larger
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.surahName,
              style: GoogleFonts.poppins(
                fontSize: 16, // Larger
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.8), // Corrected: Use withOpacity
              ),
            ),
            const SizedBox(height: 8),
            // 🔹 MODIFIED: Use widget properties here 🔹
            Text(
              '${widget.surahType} - ${widget.totalVerses} Verses', // Use passed data
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Colors.white.withOpacity(0.6), // Corrected: Use withOpacity
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 🔹 Cleaner Bismillah, shared by both tabs
  Widget _buildBismillah() {
   // ... (no changes needed here) ...
   // No Bismillah for Surah At-Tawbah (9) or Al-Fatihah (1)
    if (widget.surahNumber == 9 || widget.surahNumber == 1) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Text(
            'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
            style: GoogleFonts.amiri(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF196580),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  /// 🔹 RESTORED: User's original Mushaf-style view (continuous text)
  /// This now returns a Widget, not a Sliver
  Widget _buildMushafView() {
    // ... (no changes needed here) ...
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
    

    return Column(
      children: [
        // Bismillah is handled by the parent CustomScrollView
        // Full Surah Text - Mushaf Style
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            fullSurahText,
            style: GoogleFonts.amiri(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              height: 2.5, // Increased from 2.0 to add more space between lines
              letterSpacing: 0.5, // Optional: adds horizontal spacing between characters
            ),
            textAlign: TextAlign.justify,
            textDirection: TextDirection.rtl,
          ),
        ),
      ],
    );
  }

  /// 🔹 NEW: List-style view for Reading tab
  Widget _buildReadingListSliver() {
    // ... (no changes needed here) ...
     return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final verse = verses[index];
          return _buildReadingVerseCard(verse); // New widget for this card
        },
        childCount: verses.length,
      ),
    );
  }

  /// 🔹 NEW: A simple card for the "Reading" list view
  Widget _buildReadingVerseCard(Map<String, dynamic> verse) {
   // ... (no changes needed here) ...
    final int verseNum = verse['numberInSurah'];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Card Header with Verse Number ONLY
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF196580).withOpacity(0.05), // Corrected: Use withOpacity
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              '${widget.surahName}: $verseNum',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF196580),
              ),
            ),
          ),
          // Verse Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  verse['text'],
                  style: GoogleFonts.amiri(
                    fontSize: 22, //TODO font size
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 2.0,
                  ),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 16),
                Divider(color: Colors.grey[300]),
                const SizedBox(height: 12),
                // Translation
                Text(
                  verse['verseTranslation'] ?? 'Translation not available',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    height: 1.6,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //TODO --- (Memorize Mode Widgets - UNCHANGED) ------------------------------------------------------------

  /// 🔹 Memorize Mode - Verse by Verse with Hifz Tools
  Widget _buildMemorizeMode() {
   // ... (no changes needed here) ...
    return CustomScrollView(
      slivers: [
        _buildBismillah(), // This widget is now used by both tabs
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final verse = verses[index];
              final int verseNum = verse['numberInSurah'];
              final bool isVerseVisible = _verseVisibility[verseNum] ?? true;

              return _buildVerseCard(verse, verseNum, isVerseVisible);
            },
            childCount: verses.length,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
      ],
    );
  }

  /// 🔹 Dedicated widget for the verse card in Memorize Mode
  Widget _buildVerseCard(
      Map<String, dynamic> verse, int verseNum, bool isVerseVisible) {
    // ... (no changes needed here) ...
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Card Header with Verse Number and Hifz Tools
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF196580).withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.surahName}: $verseNum',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF196580),
                  ),
                ),
                Row(
                  children: [
                    _buildHifzButton(Icons.play_arrow, () {
                      // TODO: Add audio play logic
                      print('Play verse $verseNum');
                    }),
                    _buildHifzButton(Icons.repeat, () {
                      // TODO: Add loop logic (e.g., show menu 3x, 5x, 7x)
                      print('Loop verse $verseNum');
                    }),
                    _buildHifzButton(
                      isVerseVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      () {
                        setState(() {
                          _verseVisibility[verseNum] = !isVerseVisible;
                        });
                      },
                    ),
                    _buildHifzButton(Icons.bookmark_border, () {
                      // TODO: Add bookmark logic
                      print('Bookmark verse $verseNum');
                    }),
                  ],
                ),
              ],
            ),
          ),

          // Verse Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Arabic text (conditionally visible)
                if (isVerseVisible)
                  Text(
                    verse['text'],
                    style: GoogleFonts.amiri(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 2.0,
                    ),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  )
                else
                  // Placeholder for hidden verse
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Icon(
                      Icons.visibility_off_outlined,
                      color: Colors.grey[400],
                      size: 32,
                    ),
                  ),

                const SizedBox(height: 16),
                Divider(color: Colors.grey[300]),
                const SizedBox(height: 12),

                // Translation
                Text(
                  // TODO: Get real translation from your JSON
                  'Translation for verse ${verse['numberInSurah']} will be displayed here. The user reads this, recites, then checks.',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.6,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Helper widget for the Hifz buttons
  Widget _buildHifzButton(IconData icon, VoidCallback onPressed) {
   // ... (no changes needed here) ...
    return SizedBox(
      width: 36,
      height: 36,
      child: IconButton(
        icon: Icon(icon, color: const Color(0xFF196580), size: 20),
        onPressed: onPressed,
      ),
    );
  }

  // -----------------------------------------------------------------
  // 🔹 MAIN BUILD METHOD 🔹
  // -----------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // ... (no changes needed here) ...
     return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: const Color(0xFF196580),
              ),
            )
          : NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  // App Bar with Surah Info
                  SliverAppBar(
                    expandedHeight: 250, // Increased height
                    floating: false,
                    pinned: true,
                    backgroundColor: const Color(0xFF196580),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      titlePadding: const EdgeInsets.only(bottom: 60), // Adjust
                      title: innerBoxIsScrolled
                          ? Text(
                              widget.surahName, // Show simple title when scrolled
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            )
                          : null, // Hide simple title when expanded
                      background: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF196580),
                              Color(0xFF1a7a9c),
                            ],
                          ),
                        ),
                        // Use the new Ornamental Title
                        child: SafeArea(
                          child: Center(
                            child: _buildSurahTitleOrnament(),
                          ),
                        ),
                      ),
                    ),
                    bottom: TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.white,
                      indicatorWeight: 3.0,
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
                      tabs: const [
                        Tab(
                          icon: Icon(
                              Icons.chrome_reader_mode_outlined), // Better icon
                          text: 'Reading',
                        ),
                        Tab(
                          icon: Icon(Icons.school_outlined), // Better icon
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
                  // 🔹 MODIFIED: This is now a CustomScrollView with the toggle
                  CustomScrollView(
                    slivers: [
                      // 1. The new Toggle Button
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: Center(
                            child: SegmentedButton<ReadingMode>(
                              segments: const [
                                ButtonSegment(
                                  value: ReadingMode.mushaf,
                                  label: Text('Mushaf'),
                                  icon: Icon(Icons.chrome_reader_mode_outlined),
                                ),
                                ButtonSegment(
                                  value: ReadingMode.list,
                                  label: Text('List'),
                                  icon: Icon(Icons.list_alt),
                                ),
                              ],
                              selected: {_readingMode},
                              onSelectionChanged:
                                  (Set<ReadingMode> newSelection) {
                                setState(() {
                                  _readingMode = newSelection.first;
                                });
                              },
                              style: SegmentedButton.styleFrom(
                                backgroundColor: Colors.white,
                                selectedBackgroundColor:
                                    const Color(0xFF196580).withOpacity(0.1), // Corrected: Use withOpacity
                                selectedForegroundColor:
                                    const Color(0xFF196580),
                                foregroundColor: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // 2. The Bismillah
                      _buildBismillah(),
                      // 3. Conditional Content (Mushaf or List)
                      if (_readingMode == ReadingMode.mushaf)
                        // 🔹 MODIFIED: Wraps your original widget in a Sliver
                        SliverToBoxAdapter(child: _buildMushafView())
                      else
                        _buildReadingListSliver(),
                      // Bottom padding
                      const SliverToBoxAdapter(child: SizedBox(height: 80)),
                    ],
                  ),
                  // "Memorize" tab is UNCHANGED
                  _buildMemorizeMode(),
                ],
              ),
            ),
    );
  }
}

