import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Note: You must add 'google_fonts' to your pubspec.yaml

// --- Data Models for Questions ---

/// A simple class to hold verse data
class Verse {
  final String text;
  final int numberInSurah;
  Verse({required this.text, required this.numberInSurah});

  // Add equals operator to compare Verse objects
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Verse &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          numberInSurah == other.numberInSurah;

  @override
  int get hashCode => text.hashCode ^ numberInSurah.hashCode;
}

/// A base class for all question types
abstract class GameQuestion {
  final String prompt;
  final String guidelineTitle; // Added for dialog title
  final String guidelineContent; // Added for dialog content
  GameQuestion({
    required this.prompt,
    required this.guidelineTitle,
    required this.guidelineContent,
  });
}

/// Question 1: Arrange Ayahs
class ArrangeAyahsQuestion extends GameQuestion {
  final List<Verse> correctOrder;
  ArrangeAyahsQuestion({required String prompt, required this.correctOrder})
      : super(
          prompt: prompt,
          guidelineTitle: "How to Play: Arrange the Verses",
          guidelineContent:
              "• Tap the verse chips at the bottom in the correct order.\n"
              "• They will appear in the blue box above, filling from right to left.\n"
              "• Tap a verse in the blue box to send it back if you make a mistake.\n"
              "• Press 'Continue' when the box is full.",
        );
}

/// Question 2: Find the Next Verse
class FindNextVerseQuestion extends GameQuestion {
  final Verse currentVerse;
  final List<Verse> options;
  final Verse correctVerse;
  FindNextVerseQuestion({
    required String prompt,
    required this.currentVerse,
    required this.options,
    required this.correctVerse,
  }) : super(
          prompt: prompt,
          guidelineTitle: "How to Play: Find the Next Verse",
          guidelineContent:
              "• Read the verse displayed at the top.\n"
              "• Tap the correct verse from the choices below that comes immediately after it.\n"
              "• Press 'Continue' to check.",
        );
}

/// Question 3: Fill in the Blank
class FillInTheBlankQuestion extends GameQuestion {
  final String verseTemplate; // e.g., "أَلَمْ نَجْعَلِ ٱلْأَرْضَ ________ ؟"
  final List<String> options;
  final String correctOption;
  FillInTheBlankQuestion({
    required String prompt,
    required this.verseTemplate,
    required this.options,
    required this.correctOption,
  }) : super(
          prompt: prompt,
          guidelineTitle: "How to Play: Fill in the Blank",
          guidelineContent:
              "• Read the verse with the blank space (____).\n"
              "• Tap the word chip below that correctly completes the verse.\n"
              "• Press 'Continue' to check.",
        );
}

/// Question 4: Spot the Error
class SpotTheErrorQuestion extends GameQuestion {
  final String verseWithMistake;
  final String wrongWord;
  SpotTheErrorQuestion({
    required String prompt,
    required this.verseWithMistake,
    required this.wrongWord,
  }) : super(
          prompt: prompt,
          guidelineTitle: "How to Play: Spot the Error",
          guidelineContent:
              "• Carefully read the verse displayed in the white box.\n"
              "• One word in the verse is incorrect.\n"
              "• Tap directly on the incorrect word.\n"
              "• Press 'Continue' to check.",
        );
}

// --- Main Application (for preview) ---

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Level Preview',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const GameLevel(
        surahName: "An-Naba'",
        levelNumber: 1,
        chapterTitle: "Chapter 78: An-Naba'",
        chapterNumber: 78,
        ayahs: [], // This is ignored, we will use internal mock data
      ),
    );
  }
}

// --- The Refactored GameLevel Widget ---

class GameLevel extends StatefulWidget {
  final String surahName;
  final int levelNumber;
  final String chapterTitle;
  final int chapterNumber;
  final List<dynamic> ayahs; // The ayahs for this *entire* level

  const GameLevel({
    super.key,
    required this.surahName,
    required this.levelNumber,
    required this.chapterTitle,
    required this.chapterNumber,
    required this.ayahs,
  });

  @override
  State<GameLevel> createState() => _GameLevelState();
}

class _GameLevelState extends State<GameLevel> {
  int lives = 5;
  late List<GameQuestion> _questions;
  int _currentQuestionIndex = 0;

  // --- State for each game type ---
  List<Verse> _arrange_available = [];
  List<Verse> _arrange_selected = [];
  Verse? _findNext_selectedOption;
  String? _fillBlank_selectedOption;
  String? _spotError_selectedWord;

  @override
  void initState() {
    super.initState();
    _questions = _createMockQuestions();
    _setupQuestion(_currentQuestionIndex);
  }

  /// Creates a mock list of questions for this level
  List<GameQuestion> _createMockQuestions() {
    // Mock Verses (Same as before)
    final v1 = Verse(text: "عَمَّ يَتَسَآءَلُونَ", numberInSurah: 1);
    final v2 = Verse(text: "عَنِ ٱلنَّبَإِ ٱلْعَظِيمِ", numberInSurah: 2);
    final v3 = Verse(text: "ٱلَّذِى هُمْ فِيهِ مُخْتَلِفُونَ", numberInSurah: 3);
    final v4 = Verse(text: "كَلَّا سَيَعْلَمُونَ", numberInSurah: 4);
    final v6 = Verse(text: "أَلَمْ نَجْعَلِ ٱلْأَرْضَ مِهَٰدًۭا", numberInSurah: 6);
    final v7 = Verse(text: "وَٱلْجِبَالَ أَوْتَادًۭا", numberInSurah: 7);
    final v8 = Verse(text: "وَخَلَقْنَٰكُمْ أَزْوَٰجًۭا", numberInSurah: 8);

    return [
      ArrangeAyahsQuestion(prompt: "Arrange the verses below.", correctOrder: [v1, v2, v3, v4]),
      FindNextVerseQuestion(prompt: "Which verse comes next?", currentVerse: v7, options: [v6, v8, v1], correctVerse: v8),
      FillInTheBlankQuestion(prompt: "Fill in the blank.", verseTemplate: "أَلَمْ نَجْعَلِ ٱلْأَرْضَ ________ ؟", options: ["مِهَٰدًۭا", "أَوْتَادًۭا", "سُبَاتًۭا"], correctOption: "مِهَٰدًۭا"),
      SpotTheErrorQuestion(prompt: "Find the mistake in this verse:", verseWithMistake: "وَأَنزَلْنَا مِنَ ٱلْمُعْصِرَٰتِ مَآءًۭ مَلِيًّا", wrongWord: "مَلِيًّا"),
    ];
  }

  /// Sets up the state for the question at the given index
  void _setupQuestion(int index) {
    if (index < 0 || index >= _questions.length) return;
    setState(() {
      _currentQuestionIndex = index;
      final question = _questions[index];
      _arrange_available = [];
      _arrange_selected = [];
      _findNext_selectedOption = null;
      _fillBlank_selectedOption = null;
      _spotError_selectedWord = null;
      if (question is ArrangeAyahsQuestion) {
        if (question.correctOrder.isNotEmpty) {
          _arrange_available = List.from(question.correctOrder)..shuffle();
        }
      }
    });
  }

  /// Checks if the current answer is complete
  bool _isCurrentQuestionComplete() {
    if (_currentQuestionIndex < 0 || _currentQuestionIndex >= _questions.length) return false;
    final question = _questions[_currentQuestionIndex];
    if (question is ArrangeAyahsQuestion) return _arrange_selected.length == question.correctOrder.length;
    if (question is FindNextVerseQuestion) return _findNext_selectedOption != null;
    if (question is FillInTheBlankQuestion) return _fillBlank_selectedOption != null;
    if (question is SpotTheErrorQuestion) return _spotError_selectedWord != null;
    return false;
  }

  /// Checks the answer when the "Continue" button is pressed
  void _checkAnswer() {
    if (_currentQuestionIndex < 0 || _currentQuestionIndex >= _questions.length) return;
    final question = _questions[_currentQuestionIndex];
    bool isCorrect = false;
    if (question is ArrangeAyahsQuestion) {
      isCorrect = _arrange_selected.length == question.correctOrder.length;
      if (isCorrect) {
        for (int i = 0; i < question.correctOrder.length; i++) {
          if (_arrange_selected[i] != question.correctOrder[i]) {
            isCorrect = false;
            break;
          }
        }
      }
    } else if (question is FindNextVerseQuestion) {
      isCorrect = (_findNext_selectedOption == question.correctVerse);
    } else if (question is FillInTheBlankQuestion) {
      isCorrect = (_fillBlank_selectedOption == question.correctOption);
    } else if (question is SpotTheErrorQuestion) {
      isCorrect = (_spotError_selectedWord == question.wrongWord);
    }
    _showResultDialog(isCorrect); // Show result
  }

  /// Shows the result dialog and handles navigation/state updates
  void _showResultDialog(bool isCorrect) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isCorrect ? const Color.fromARGB(255, 46, 230, 111) : const Color.fromARGB(255, 233, 92, 92),
        title: Text(isCorrect ? "Correct!" : "Try Again" , style: const TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 255, 255, 255))),
        
        content: Text(isCorrect ? "Masha'Allah! Well done." : "That's not quite right. Try again." ,style: const TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 255, 255, 255))),
        actions: [
          TextButton(
            child: const Text('OK',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
            onPressed: () {
              Navigator.of(ctx).pop();
              if (isCorrect) {
                if (_currentQuestionIndex < _questions.length - 1) {
                  _setupQuestion(_currentQuestionIndex + 1);
                } else {
                  _showLevelCompleteDialog();
                }
              } else {
                if (!mounted) return;
                setState(() {
                  if (lives > 0) lives--;
                  if (lives > 0) {
                    _setupQuestion(_currentQuestionIndex); // Reset current question
                  } else {
                    _showGameOverDialog();
                  }
                });
              }
            },
          )
        ],
      ),
    );
  }

  /// Shows the Level Complete dialog
  void _showLevelCompleteDialog() {
     showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text("Level Complete!"),
        content: const Text("Masha'Allah! You've completed all questions for this level."),
        actions: [
          TextButton(
            child: const Text('Back to Map'),
            onPressed: () {
              Navigator.of(ctx).pop();
              if (mounted) Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  /// Shows the Game Over dialog
  void _showGameOverDialog() {
     showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text("Game Over"),
        content: const Text("You've run out of lives!"),
        actions: [
          TextButton(
            child: const Text('Back to Map'),
            onPressed: () {
              Navigator.of(ctx).pop();
              if (mounted) Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  /// ---- NEW ----
  /// Shows the guideline dialog based on the current question
  void _showGuidelineDialog() {
    if (_currentQuestionIndex < 0 || _currentQuestionIndex >= _questions.length) return;
    final question = _questions[_currentQuestionIndex];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(question.guidelineTitle), // Use title from question
        content: Text(question.guidelineContent), // Use content from question
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
  /// ---- END NEW ----


  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty || _currentQuestionIndex < 0 || _currentQuestionIndex >= _questions.length) {
      return Scaffold(appBar: AppBar(title: const Text("Loading...")), body: const Center(child: CircularProgressIndicator()));
    }

    final bool isComplete = _isCurrentQuestionComplete();
    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: _buildCustomAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Prompt Row with Info Icon ---
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 16, top: 16, bottom: 16), // Adjust padding
            child: Row( // Wrap in a Row
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out text and icon
              children: [
                // Flexible prompt text to prevent overflow
                Flexible(
                  child: Text(
                    question.prompt,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(width: 8), // Space between text and icon
                // Info Icon Button
                InkWell(
                  onTap: _showGuidelineDialog, // Call the new dialog method
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.info_outline,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // --- End Prompt Row ---

          Expanded(child: _buildCurrentQuestionUI(question)),
          _buildContinueButton(isComplete),
        ],
      ),
    );
  }

  /// Builds the dynamic UI based on the current question type
  Widget _buildCurrentQuestionUI(GameQuestion question) {
     switch (question.runtimeType) {
      case ArrangeAyahsQuestion:
        return _buildArrangeAyahsUI(question as ArrangeAyahsQuestion);
      case FindNextVerseQuestion:
        return _buildFindNextVerseUI(question as FindNextVerseQuestion);
      case FillInTheBlankQuestion:
        return _buildFillInTheBlankUI(question as FillInTheBlankQuestion);
      case SpotTheErrorQuestion:
        return _buildSpotTheErrorUI(question as SpotTheErrorQuestion);
      default:
        return const Center(child: Text("Unknown question type"));
    }
  }

  // --- UI Builders for each question type (Mostly unchanged, added mounted checks) ---

  // UI Builder for: Arrange Ayahs
  Widget _buildArrangeAyahsUI(ArrangeAyahsQuestion question) {
     return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF2C5F7C).withOpacity(1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Wrap(
            spacing: 8.0, runSpacing: 8.0, textDirection: TextDirection.rtl,
            children: _arrange_selected.map((verse) {
              return _buildVerseChip(verse, isSelected: true, onTap: () {
                if (!mounted) return; // Add mounted check
                setState(() { _arrange_selected.remove(verse); _arrange_available.add(verse); });
              });
            }).toList(),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Wrap(
              spacing: 12.0, runSpacing: 12.0, alignment: WrapAlignment.center,
              children: _arrange_available.map((verse) {
                return _buildVerseChip(verse, isSelected: false, onTap: () {
                  if (!mounted) return; // Add mounted check
                  setState(() { _arrange_available.remove(verse); _arrange_selected.add(verse); });
                });
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  // UI Builder for: Find the Next Verse
  Widget _buildFindNextVerseUI(FindNextVerseQuestion question) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          _buildVerseChip(question.currentVerse, isSelected: true, onTap: null),
          const SizedBox(height: 24), const Divider(), const SizedBox(height: 24),
          Column(
            children: question.options.map((option) {
              final bool isSelected = (_findNext_selectedOption == option);
              return _buildOptionChip(
                text: option.text, isSelected: isSelected,
                onTap: () {
                  if (!mounted) return; // Add mounted check
                  setState(() { _findNext_selectedOption = option; });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // UI Builder for: Fill in the Blank
  Widget _buildFillInTheBlankUI(FillInTheBlankQuestion question) {
     return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20), width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Text(question.verseTemplate, textAlign: TextAlign.center, style: GoogleFonts.amiri(fontSize: 24, color: Colors.black87, height: 1.8)),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 12.0, runSpacing: 12.0, alignment: WrapAlignment.center,
            children: question.options.map((option) {
              final bool isSelected = (_fillBlank_selectedOption == option);
              return _buildOptionChip(
                text: option, isSelected: isSelected,
                onTap: () {
                  if (!mounted) return; // Add mounted check
                  setState(() { _fillBlank_selectedOption = option; });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // UI Builder for: Spot the Error
  Widget _buildSpotTheErrorUI(SpotTheErrorQuestion question) {
    final List<String> words = question.verseWithMistake.split(' ');
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Wrap(
          alignment: WrapAlignment.center, textDirection: TextDirection.rtl,
          children: words.map((word) {
            final bool isSelected = (_spotError_selectedWord == word);
            return GestureDetector(
              onTap: () {
                if (!mounted) return; // Add mounted check
                setState(() { _spotError_selectedWord = word; });
              },
              child: Container(
                margin: const EdgeInsets.all(4), padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.red.withOpacity(0.3) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: isSelected ? Colors.red : Colors.transparent, width: 2),
                ),
                child: Text(word, style: GoogleFonts.amiri(fontSize: 24, color: Colors.black87, height: 1.8)),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // --- Helper Widgets (Unchanged) ---

  PreferredSizeWidget _buildCustomAppBar(BuildContext context) {
    double progress = (_questions.isEmpty) ? 0.0 : (_currentQuestionIndex + 1).toDouble() / _questions.length.toDouble();
    progress = progress.clamp(0.0, 1.0);
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 10),
      child: AppBar(
        backgroundColor: Colors.transparent, elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black54),
          onPressed: () { if (mounted) Navigator.of(context).pop(); },
        ),
        title: Column(
          children: [
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(value: progress, backgroundColor: Colors.grey[300], color: const Color(0xFF2C5F7C), minHeight: 12),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: Row(
              children: [
                const Icon(Icons.favorite, color: Colors.red, size: 28),
                const SizedBox(width: 4),
                Text('$lives', style: GoogleFonts.poppins(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerseChip(Verse verse, {required bool isSelected, required VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Text(verse.text, style: GoogleFonts.amiri(fontSize: 20, color: Colors.black87, height: 1.5), textAlign: TextAlign.right),
      ),
    );
  }

  Widget _buildOptionChip({required String text, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2C5F7C) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? const Color(0xFF2C5F7C) : Colors.grey[300]!, width: 2),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Text(text, textAlign: TextAlign.center, style: GoogleFonts.amiri(fontSize: 20, color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildContinueButton(bool isComplete) {
    return Container(
      padding: const EdgeInsets.all(24), width: double.infinity,
      child: ElevatedButton(
        onPressed: isComplete ? _checkAnswer : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: isComplete ? const Color(0xFF2C5F7C) : Colors.grey[300],
          foregroundColor: isComplete ? Colors.white : Colors.grey[500],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Text('Continue', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

