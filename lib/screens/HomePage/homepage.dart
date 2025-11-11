import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../SurahPage/surah_page.dart';
import '../HistoryPage/History_page.dart';
import '../GamePage/Game_page.dart';
import '../ProfilePage/profile_page.dart';

// Model for Daily Goal
class DailyGoal {
  final String id;
  final String title;
  final IconData icon;
  final int targetValue;
  final int currentValue;
  final String unit;

  DailyGoal({
    required this.id,
    required this.title,
    required this.icon,
    required this.targetValue,
    required this.currentValue,
    required this.unit,
  });

  double get progress => currentValue / targetValue;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  // TODO: Replace with Firebase)
  // User data
    // User data
    int experiencePoints = 450;
    int experienceGoals = 1000;
    bool streakCondition = false;
    int streakNumber = 3;
    String username = 'hafizvdn';
    int userPoints = 450;
    int versesMemorized = 0;
    int pointsEarned = 0;

    @override
    void initState() {
      super.initState();
      _loadUserData();
    }

    // Load data from SharedPreferences
    Future<void> _loadUserData() async {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        experiencePoints = prefs.getInt('experiencePoints') ?? 450;
        experienceGoals = prefs.getInt('experienceGoals') ?? 1000;
        streakCondition = prefs.getBool('streakCondition') ?? false;
        streakNumber = prefs.getInt('streakNumber') ?? 3;
        username = prefs.getString('username') ?? 'hafizvdn';
        userPoints = prefs.getInt('userPoints') ?? 450;
        versesMemorized = prefs.getInt('versesMemorized') ?? 0;
        pointsEarned = prefs.getInt('pointsEarned') ?? 0;
      });
    }

    // Save data to SharedPreferences
    Future<void> _saveUserData() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('experiencePoints', experiencePoints);
      await prefs.setInt('experienceGoals', experienceGoals);
      await prefs.setBool('streakCondition', streakCondition);
      await prefs.setInt('streakNumber', streakNumber);
      await prefs.setString('username', username);
      await prefs.setInt('userPoints', userPoints);
      await prefs.setInt('versesMemorized', versesMemorized);
      await prefs.setInt('pointsEarned', pointsEarned);
    }
  
  List<DailyGoal> dailyGoals = [
    DailyGoal(
      id: '1',
      title: 'Memorize 6 verses',
      icon: Icons.menu_book,
      targetValue: 6,
      currentValue: 0,
      unit: 'verses',
    ),
    DailyGoal(
      id: '2',
      title: 'Earn 105 points',
      icon: Icons.bolt,
      targetValue: 105,
      currentValue: 0,
      unit: 'points',
    ),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildCurrentScreen() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return SurahPage();
      case 2:
        return HistoryPage();
      case 3:
        return GamePage();
      case 4:
        return ProfilePage();
      default:
        return _buildHomeContent();
    }
  }

  String _getCurrentMonth() {
    final months = [
      'JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE',
      'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'
    ];
    return months[DateTime.now().month - 1];
  }

  int _getRemainingDaysInMonth() {
    final now = DateTime.now();
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    return lastDayOfMonth.day - now.day;
  }

  void _showGoalInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2B6B7F), // or any color you want
        title: Text('Daily Goals Information', 
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 238, 183, 3),
              fontWeight: FontWeight.bold)),
        content: Text(
          'Complete your daily goals to earn points and level up!\n\n'
          '• Memorizing verses helps you progress in your Quran journey\n'
          '• Earning points unlocks achievements and rewards\n'
          '• Consistency is key to building a strong habit',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        actions: [
          TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('Got it', style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showEditGoalsDialog() {
    final controllers = dailyGoals.map((goal) => 
      TextEditingController(text: goal.targetValue.toString())
    ).toList();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Edit Daily Goals', style: GoogleFonts.poppins()),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(dailyGoals.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextField(
                  controller: controllers[index],
                  style: GoogleFonts.poppins(),
                  decoration: InputDecoration(
                    labelText: dailyGoals[index].title,
                    labelStyle: GoogleFonts.poppins(),
                    suffixText: dailyGoals[index].unit,
                    suffixStyle: GoogleFonts.poppins(),
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              );
            }),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.poppins()),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                dailyGoals = List.generate(dailyGoals.length, (index) {
                  return DailyGoal(
                    id: dailyGoals[index].id,
                    title: dailyGoals[index].title,
                    icon: dailyGoals[index].icon,
                    targetValue: int.tryParse(controllers[index].text) ?? dailyGoals[index].targetValue,
                    currentValue: dailyGoals[index].currentValue,
                    unit: dailyGoals[index].unit,
                  );
                });
              });
              _saveUserData();
              Navigator.pop(context);
            },
            child: Text('Save', style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return Column(
      children: [
        // Top Section with User Info
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF2B6B7F),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 10,
              ),
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // User Profile
                  Row(
                    children: [
                      GestureDetector(
                      onTap: () {
                        setState(() {
                        _selectedIndex = 4;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        ),
                        child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: Image.asset(
                          'assets/image/udin.jpeg',// TODO :will using firebase in the future
                          fit: BoxFit.cover,
                          width: 70,
                          height: 70,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.person, size: 40);
                          },
                          ),
                        ),
                        ),
                      ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  color: streakCondition //TODO: will be dynamic from firebase
                                      ? const Color.fromARGB(255, 255, 153, 19) 
                                      : Colors.grey,
                                  size: 30,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '$streakNumber',
                                  style: GoogleFonts.poppins(
                                    color: streakCondition 
                                        ? const Color.fromARGB(255, 255, 153, 19) 
                                        : Colors.grey,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Assalamualaikum, $username',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Month and Days Remaining
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _getCurrentMonth(),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              color: Colors.white70, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '${_getRemainingDaysInMonth()} Days',
                            style: GoogleFonts.poppins(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Experience Points Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Earn 1000 Points',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF2B6B7F),
                                ),
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: experiencePoints / experienceGoals,
                                  backgroundColor: Colors.grey[300],
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                    Color(0xFF4CAF50),
                                  ),
                                  minHeight: 24,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$experiencePoints / $experienceGoals XP',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Image.asset(
                              'assets/achievements/treasure.png',
                              width: 34,
                              height: 34,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.card_giftcard,
                                  color: Colors.white,
                                  size: 34,
                                );
                              },
                            ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),

        // Daily Goals Section (White Background)
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Daily ',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2B6B7F),
                            ),
                          ),
                          Text(
                            'Goals',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: _showGoalInfo,
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
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: _showEditGoalsDialog,
                        tooltip: 'Edit Goals',
                      ),
                    ],
                  ),
                ),

                // Daily Goals List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: dailyGoals.length,
                    itemBuilder: (context, index) {
                      final goal = dailyGoals[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              goal.icon,
                              size: 32,
                              color:  Color(0xFF2B6B7F),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    goal.title,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: LinearProgressIndicator(
                                      value: goal.progress,
                                      backgroundColor: Colors.grey[200],
                                      valueColor: const AlwaysStoppedAnimation<Color>(
                                        Color.fromARGB(255, 112, 211, 116),
                                      ),
                                      minHeight: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${goal.currentValue}/${goal.targetValue} ${goal.unit}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Image.asset(
                              'assets/achievements/treasure.png',
                              width: 34,
                              height: 34,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.card_giftcard,
                                  color: Colors.white,
                                  size: 34,
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCurrentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF196580),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Surah'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.games), label: 'Game'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}