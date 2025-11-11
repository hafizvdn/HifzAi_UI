import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_database/firebase_database.dart'; // For future Firebase integration
import '../data/user_model.dart';

class UserRepository {
  // SharedPreferences implementation
  Future<UserModel> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return UserModel(
      experiencePoints: prefs.getInt('experiencePoints') ?? 450,
      experienceGoals: prefs.getInt('experienceGoals') ?? 1000,
      streakCondition: prefs.getBool('streakCondition') ?? false,
      streakNumber: prefs.getInt('streakNumber') ?? 3,
      username: prefs.getString('username') ?? 'hafizvdn',
      userPoints: prefs.getInt('userPoints') ?? 450,
      versesMemorized: prefs.getInt('versesMemorized') ?? 0,
      pointsEarned: prefs.getInt('pointsEarned') ?? 0,
    );
  }

  Future<void> saveUserData(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('experiencePoints', user.experiencePoints);
    await prefs.setInt('experienceGoals', user.experienceGoals);
    await prefs.setBool('streakCondition', user.streakCondition);
    await prefs.setInt('streakNumber', user.streakNumber);
    await prefs.setString('username', user.username);
    await prefs.setInt('userPoints', user.userPoints);
    await prefs.setInt('versesMemorized', user.versesMemorized);
    await prefs.setInt('pointsEarned', user.pointsEarned);
  }
  
  // TODO: Add Firebase methods here later
  // Future<UserModel> loadUserDataFromFirebase(String userId) async { ... }
  // Future<void> saveUserDataToFirebase(String userId, UserModel user) async { ... }
}