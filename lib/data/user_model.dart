class UserModel {
  int experiencePoints;
  int experienceGoals;
  bool streakCondition;
  int streakNumber;
  String username;
  int userPoints;
  int versesMemorized;
  int pointsEarned;

  UserModel({
    this.experiencePoints = 450,
    this.experienceGoals = 1000,
    this.streakCondition = false,
    this.streakNumber = 3,
    this.username = 'hafizvdn',
    this.userPoints = 450,
    this.versesMemorized = 0,
    this.pointsEarned = 0,
  });

  // Convert to JSON for Firebase
  Map<String, dynamic> toJson() => {
    'experiencePoints': experiencePoints,
    'experienceGoals': experienceGoals,
    'streakCondition': streakCondition,
    'streakNumber': streakNumber,
    'username': username,
    'userPoints': userPoints,
    'versesMemorized': versesMemorized,
    'pointsEarned': pointsEarned,
  };

  // Create from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    experiencePoints: json['experiencePoints'] ?? 450,
    experienceGoals: json['experienceGoals'] ?? 1000,
    streakCondition: json['streakCondition'] ?? false,
    streakNumber: json['streakNumber'] ?? 3,
    username: json['username'] ?? 'hafizvdn',
    userPoints: json['userPoints'] ?? 450,
    versesMemorized: json['versesMemorized'] ?? 0,
    pointsEarned: json['pointsEarned'] ?? 0,
  );
}