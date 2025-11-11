import 'package:flutter/material.dart';
import 'package:learningflutter/screens/SplashPage/splash_screen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HifzAi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Clickable Image Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

// // --- NEW PAGE ---
// // This is the new page we will navigate to.
// // In a real app, you would likely put this in its own file
// // (e..g, 'game_page.dart') and import it here.
// class GamePage extends StatelessWidget {
//   const GamePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Game Page'),
//         backgroundColor: Colors.green.shade100,
//       ),
//       body: const Center(
//         child: Text(
//           'Welcome to the Game Page!',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }

// // --- Main Page (Modified) ---
// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Clickable Image Examples'),
//         backgroundColor: Colors.blue.shade100,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // --- Example 1: Using GestureDetector ---
//             // Now uses Image.asset and navigates to GamePage.
//             const Text(
//               'Using GestureDetector (Asset Image)',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             GestureDetector(
//               onTap: () {
//                 // --- ACTION CHANGED ---
//                 // This is the action that happens on click.
//                 // We now navigate to the GamePage.
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const GamePage()),
//                 );
//               },
//               child:
//                   // --- IMAGE CHANGED ---
//                   // Make sure 'assets/image1.png' exists and
//                   // you have added 'assets/' to your pubspec.yaml
//                   Image.asset(
//                 'assets/image/udin.jpeg',
//                 width: 300,
//                 height: 150,
//                 fit: BoxFit.cover,
//                 // Simple error handling if the asset isn't found
//                 errorBuilder: (context, error, stackTrace) {
//                   return Container(
//                     width: 300,
//                     height: 150,
//                     color: Colors.grey.shade200,
//                     child: const Center(
//                       child: Text('Error loading assets/image1.png'),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(height: 40),

//             // --- Example 2: Using InkWell ---
//             // Now uses Ink.image with an AssetImage and navigates.
//             const Text(
//               'Using InkWell (Asset Image)',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Card(
//               clipBehavior: Clip.antiAlias,
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: InkWell(
//                 onTap: () {
//                   // --- ACTION CHANGED ---
//                   // This is the action that happens on click.
//                   // We also navigate to the GamePage here.
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const GamePage()),
//                   );
//                 },
//                 // --- IMAGE CHANGED ---
//                 // For Ink.image, we provide an AssetImage directly.
//                 // Make sure 'assets/image2.png' exists.
//                 child: Ink.image(
//                   image: const AssetImage(
//                     'assets/image/udin.jpeg',
//                   ),
//                   width: 300,
//                   height: 150,
//                   fit: BoxFit.cover,
//                   onImageError: (error, stackTrace) {
//                     // This is the error builder for Ink.image
//                     // We can't return a widget, so we just log it.
//                     print("Error loading asset for Ink.image: $error");
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:sticky_grouped_list/sticky_grouped_list.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Sticky Header Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//       // Set the home to our new sticky page
//       home: const StickyChaptersPage(),
//     );
//   }
// }

// /// A simple class to hold our data.
// /// Each item has 'content' and a 'chapter' it belongs to.
// class _Element {
//   final String chapter;
//   final String content;

//   const _Element({required this.chapter, required this.content});
// }

// /// This is the list of all our items, grouped by chapter.
// /// We use List.generate to create 6 chapters with 8 items each.
// final List<_Element> _elements = List.generate(
//   48, // 6 chapters * 8 items/chapter = 48 total items
//   (index) => _Element(
//     chapter: 'Chapter ${index ~/ 8 + 1}', // Integer division groups them
//     content: 'Content Item ${index % 8 + 1}',
//   ),
// );

// class StickyChaptersPage extends StatelessWidget {
//   const StickyChaptersPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sticky Chapter Headers'),
//       ),
//       body: StickyGroupedListView<_Element, String>(
//         // The list of all items
//         elements: _elements,
        
//         // This function tells the list how to group the elements.
//         // We are grouping them by the 'chapter' property.
//         groupBy: (element) => element.chapter,

//         // This comparator is optional but helps keep items in order
//         // within their group.
//         itemComparator: (a, b) => a.content.compareTo(b.content),

//         // This builder creates the STICKY HEADER for each group (chapter).
//         groupSeparatorBuilder: (element) => _buildHeader(element.chapter),

//         // This builder creates the regular list item for each element.
//         itemBuilder: (context, element) => _buildItem(element.content),

//         // Optional:
//         order: StickyGroupedListOrder.ASC, // Keep groups in ascending order
//         floatingHeader: true, // This is the default, makes headers stick
//       ),
//     );
//   }

//   /// Builds the sticky header widget
//   Widget _buildHeader(String chapterTitle) {
//     return Container(
//       // This 'height' is important for the sticky header calculation
//       height: 60,
//       width: double.infinity,
//       color: Colors.blue.shade200,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       alignment: Alignment.centerLeft,
//       child: Text(
//         chapterTitle,
//         style: const TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: Colors.black87,
//         ),
//       ),
//     );
//   }

//   /// Builds the regular list item widget
//   Widget _buildItem(String content) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Text(
//           content,
//           style: const TextStyle(fontSize: 16),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sticky_grouped_list/sticky_grouped_list.dart';
// // Note: You must add 'google_fonts' to your pubspec.yaml
// // And also 'sticky_grouped_list'

// void main() {
//   runApp(const MyApp());
// }

// // --- Stub Pages for Navigation ---
// // (So the buttons in the AppBar and levels are clickable)

// class GameLevel extends StatelessWidget {
//   final String surahName;
//   final int levelNumber;
//   final String chapterTitle;

//   const GameLevel({
//     super.key,
//     required this.surahName,
//     required this.levelNumber,
//     required this.chapterTitle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('$surahName - Level $levelNumber')),
//       body: Center(
//         child: Text(
//           'Playing $chapterTitle\nLevel $levelNumber',
//           textAlign: TextAlign.center,
//           style: GoogleFonts.poppins(fontSize: 22),
//         ),
//       ),
//     );
//   }
// }

// class RankingPage extends StatelessWidget {
//   const RankingPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Ranking')),
//       body: Center(
//         child: Text(
//           'Ranking Page',
//           style: GoogleFonts.poppins(fontSize: 22),
//         ),
//       ),
//     );
//   }
// }
// // --- End Stub Pages ---

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Sticky Header Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//         // Set the background color to match the reference
//         scaffoldBackgroundColor: const Color(0xFFE8E8E8),
//       ),
//       home: const StickyChaptersPage(),
//     );
//   }
// }

// /// A simple class to hold our data for each level.
// class _Element {
//   final String chapterTitle; // e.g., "Chapter 1: Surah An Naba'"
//   final int levelIndex; // 0, 1, 2...
//   final bool isUnlocked;
//   final bool isCompleted;

//   const _Element({
//     required this.chapterTitle,
//     required this.levelIndex,
//     this.isUnlocked = false,
//     this.isCompleted = false,
//   });
// }

// // A list of chapter names
// final List<String> _chapterNames = [
//   "Chapter 1: Surah An Naba'",
//   "Chapter 2: Surah An Nazi'at",
//   "Chapter 3: 'Abasa",
//   "Chapter 4: At-Takwir",
//   "Chapter 5: Al-Infitar",
//   "Chapter 6: Al-Mutaffifin",
// ];

// // Generate the full list of all elements (levels) for all chapters
// final List<_Element> _elements = _chapterNames.expand((chapterName) {
//   // Create 5 levels for each chapter
//   return List.generate(5, (levelIndex) {
//     return _Element(
//       chapterTitle: chapterName,
//       levelIndex: levelIndex,
//       // Logic from reference: First level is always unlocked
//       isUnlocked: levelIndex == 0,
//       isCompleted: false, // You can add logic here to track completion
//     );
//   });
// }).toList();

// class StickyChaptersPage extends StatelessWidget {
//   const StickyChaptersPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Use a custom AppBar from the reference code
//       appBar: _buildCustomAppBar(context),
//       body: StickyGroupedListView<_Element, String>(
//         // The list of all items (all levels from all chapters)
//         elements: _elements,

//         // Group elements by their 'chapterTitle'
//         groupBy: (element) => element.chapterTitle,

//         // This builder creates the STICKY HEADER for each chapter.
//         // We adapt it from the reference code's header.
//         groupSeparatorBuilder: (element) =>
//             _buildChapterHeader(element.chapterTitle),

//         // This builder creates the regular list item (the level nodes).
//         // We adapt it from the reference code's _buildLevelNode.
//         itemBuilder: (context, element) => _buildLevelNode(context, element),

//         // Optional:
//         order: StickyGroupedListOrder.ASC, // Keep chapters in order
//         floatingHeader: true, // This makes the headers stick and swap
        
//         // Add padding so the items don't start right at the header
//         padding: const EdgeInsets.only(top: 20),
//       ),
//     );
//   }

//   /// Builds the custom AppBar from the reference code
//   PreferredSizeWidget _buildCustomAppBar(BuildContext context) {
//     return PreferredSize(
//       preferredSize: Size.fromHeight(kToolbarHeight + MediaQuery.of(context).padding.top + 8),
//       child: Container(
//         padding: EdgeInsets.only(
//           top: MediaQuery.of(context).padding.top + 8,
//           left: 16,
//           right: 16,
//           bottom: 16,
//         ),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 4,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Left side - Stats
//             Row(
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.local_fire_department,
//                         color: Colors.grey[600], size: 28),
//                     const SizedBox(width: 4),
//                     Text(
//                       '3',
//                       style: GoogleFonts.poppins(
//                         color: Colors.grey[600],
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(width: 16),
//                 Row(
//                   children: [
//                     const Icon(Icons.favorite, color: Colors.red, size: 28),
//                     const SizedBox(width: 4),
//                     Text(
//                       '5',
//                       style: GoogleFonts.poppins(
//                         color: Colors.red,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             // Right side - Trophy icon
//             IconButton(
//               icon: const Icon(Icons.emoji_events, size: 32),
//               color: Colors.black,
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const RankingPage(),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Builds the sticky chapter header widget
//   Widget _buildChapterHeader(String chapterTitleFull) {
//     // Split the title string "Chapter 1: Surah An Naba'"
//     String chapterNum = '';
//     String surahName = '';
//     if (chapterTitleFull.contains(':')) {
//       final parts = chapterTitleFull.split(':');
//       chapterNum = '${parts[0]}:'; // "Chapter 1:"
//       surahName = parts[1].trim(); // "Surah An Naba'"
//     } else {
//       surahName = chapterTitleFull; // Fallback
//     }

//     // --- MODIFICATION ---
//     // We use Padding instead of margin on the container.
//     // This ensures the sticky header and the in-line header are
//     // both rendered with the same horizontal spacing.
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
//       child: Container(
//         // This 'height' is important for the sticky header calculation
//         height: 100,
//         width: double.infinity, // Makes width match parent width
//         // margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10), // <-- REMOVED
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFF2C5F7C), Color(0xFF1E4A5F)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (chapterNum.isNotEmpty)
//               Text(
//           chapterNum,
//           style: GoogleFonts.poppins(
//             color: Colors.white.withOpacity(0.9),
//             fontSize: 14,
//           ),
//               ),
//             const SizedBox(height: 4),
//             Text(
//               surahName,
//               style: GoogleFonts.poppins(
//           color: Colors.white,
//           fontSize: 22,
//           fontWeight: FontWeight.bold,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Builds the regular list item (level node) widget
//   Widget _buildLevelNode(BuildContext context, _Element element) {
//     // Staggered path logic from reference code
//     final leftOffsets = [0.0, 60.0, 200.0, 100.0, 40.0];
//     final leftOffset = leftOffsets[element.levelIndex % leftOffsets.length];

//     final surahName = element.chapterTitle.contains(':')
//         ? element.chapterTitle.split(':')[1].trim()
//         : element.chapterTitle;

//     return Padding(
//       // Add padding to match the reference style
//       padding: EdgeInsets.only(left: leftOffset, bottom: 20, right: 20),
//       child: GestureDetector(
//         onTap: element.isUnlocked
//         ? () {
//           Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => GameLevel(
//             surahName: surahName,
//             levelNumber: element.levelIndex + 1,
//             chapterTitle: element.chapterTitle,
//           ),
//         ),
//           );
//           }
//         : null, // Disabled if not unlocked
//         child: Container(
//           width: 80,
//           height: 74,
//           decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         boxShadow: [
//           BoxShadow(
//           color: Colors.black.withOpacity(0.3),
//           blurRadius: 8,
//           offset: const Offset(0, 4),
//           ),
//         ],
//           ),
//           child: Center(
//         child: element.isCompleted
//           ? Container(
//           width: 80,
//           height: 74,
//           decoration: const BoxDecoration(
//             shape: BoxShape.circle,
//             color: Color(0xFF4CAF50),
//           ),
//           child: const Icon(Icons.check, color: Colors.white, size: 36),
//         )
//           : Image.asset(
//           element.isUnlocked
//         ? 'assets/image/unlock_level-01.png'
//         : 'assets/image/lock_level-01.png',
//           width: 80,
//           height: 74,
//           fit: BoxFit.cover,
//           errorBuilder: (context, error, stackTrace) {
//             // Fallback to colored container with icon if image fails to load
//             return Container(
//         width: 80,
//         height: 74,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: element.isUnlocked
//           ? const Color(0xFF2C5F7C)
//           : const Color(0xFFB8B8B8),
//         ),
//         child: Icon(
//           element.isUnlocked ? Icons.menu_book : Icons.lock,
//           color: Colors.white.withOpacity(element.isUnlocked ? 0.9 : 0.7),
//           size: 36,
//         ),
//             );
//           },
//         ),
//           ),
//         ),
//       ),
//     );
//   }
// }

