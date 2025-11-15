import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// <-- 1. A dedicated class for your history data (better than a Map)
class _HistoryItem {
  final String surah;
  final String day;
  final int accuracy; // e.g., 80
  final String status;   // e.g., "Itqan Jayyid"

  _HistoryItem({
    required this.surah,
    required this.day,
    required this.accuracy,
    required this.status,
  });
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // <-- 2. Updated sample data using the new class
  final List<_HistoryItem> historyItems = [
    _HistoryItem(
        surah: 'Al-Ikhlas', day: 'Today', accuracy: 95, status: 'Itqan Mumtaz'),
    _HistoryItem(
        surah: 'An-Nas', day: 'Sunday', accuracy: 80, status: 'Itqan Jayyid'),
    _HistoryItem(
        surah: 'Al-Falaq', day: 'Sunday', accuracy: 75, status: 'Itqan Hasan'),
    _HistoryItem(
        surah: 'Al-Ikhlas', day: 'Sunday', accuracy: 60, status: 'Da\'if (Weak)'),
  ];

  // <-- 3. The new function to show your accuracy dialog
  void _showAccuracyDialog(_HistoryItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          // Title can be the Surah name
          title: Text(
            item.surah,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          // Content is the percentage and status
          content: Column(
            mainAxisSize: MainAxisSize.min, // Important!
            children: [
              Text(
                '${item.accuracy}%',
                style: GoogleFonts.poppins(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  // Bonus: Change color based on score
                  color: _getAccuracyColor(item.accuracy),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.status,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          // The "okay button"
          actions: [
            TextButton(
              child: Text(
                'Okay',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Closes the dialog
              },
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }

  // Helper function to change color based on score
  Color _getAccuracyColor(int accuracy) {
    if (accuracy >= 90) {
      return const Color.fromARGB(255, 74, 224, 96); // Green
    }
    if (accuracy >= 75) {
      return Colors.blue; // Blue
    }
    if (accuracy >= 50) {
      return Colors.orange; // Orange
    }
    return Colors.red; // Red
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text('History',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF196580),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 62, 163, 199),
                      Color(0xFF196580)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Surah memorized',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    Text(
                      '3/114',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 74, 224, 96),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Section Title
              Text(
                'Tasmik History',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),

              // History Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  itemCount: historyItems.length,
                  separatorBuilder: (context, index) => const Divider(
                    color: Color(0xFFF0F0F0),
                    thickness: 1,
                    height: 1,
                  ),
                  itemBuilder: (context, index) {
                    final item = historyItems[index];
                    return InkWell(
                      // <-- 4. This is the updated onTap
                      onTap: () {
                        // Call the new function and pass the item
                        _showAccuracyDialog(item);
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // Use item.surah (cleaner)
                                    item.surah,
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    // Use item.day
                                    item.day,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: const Color(0xFF999999),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              size: 28,
                              color: Color(0xFF333333),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}