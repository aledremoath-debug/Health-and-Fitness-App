class Notifications {
  final bool water;
  final bool exercise;
  final bool meals;
  final bool sleep;

  Notifications({
    this.water = true,
    this.exercise = true,
    this.meals = false,
    this.sleep = true,
  });

  Notifications copyWith({
    bool? water,
    bool? exercise,
    bool? meals,
    bool? sleep,
  }) {
    return Notifications(
      water: water ?? this.water,
      exercise: exercise ?? this.exercise,
      meals: meals ?? this.meals,
      sleep: sleep ?? this.sleep,
    );
  }
}

class UserData {
  final String name;
  final String email;
  final String phone;
  final int age;
  final String gender;
  final double weight;
  final double height;
  final String activityLevel;
  final String dietType;
  final String goal;
  final Notifications notifications;
  final String language;
  final String theme;

  UserData({
    this.name = 'محمد أحمد',
    this.email = 'user@example.com',
    this.phone = '+966 50 000 0000',
    this.age = 25,
    this.gender = 'male',
    this.weight = 70,
    this.height = 170,
    this.activityLevel = 'moderate',
    this.dietType = 'default',
    this.goal = 'maintain',
    Notifications? notifications,
    this.language = 'ar',
    this.theme = 'dark',
  }) : notifications = notifications ?? Notifications();

  UserData copyWith({
    String? name,
    String? email,
    String? phone,
    int? age,
    String? gender,
    double? weight,
    double? height,
    String? activityLevel,
    String? dietType,
    String? goal,
    Notifications? notifications,
    String? language,
    String? theme,
  }) {
    return UserData(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      activityLevel: activityLevel ?? this.activityLevel,
      dietType: dietType ?? this.dietType,
      goal: goal ?? this.goal,
      notifications: notifications ?? this.notifications,
      language: language ?? this.language,
      theme: theme ?? this.theme,
    );
  }
}
