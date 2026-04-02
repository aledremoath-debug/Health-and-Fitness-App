import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_data.dart';
import '../models/meal.dart';
import '../models/exercise.dart';
import '../utils/translations.dart';
import '../utils/calculations.dart';
import '../data/app_data.dart';

class UserProvider extends ChangeNotifier {
  UserData _userData = UserData();
  List<Map<String, dynamic>> _progressData = [];
  List<Map<String, dynamic>> _weeklyCalories = [];
  List<Map<String, dynamic>> _challenges = [];
  List<Map<String, dynamic>> _notifications = [];

  UserProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString('language');
    final savedTheme = prefs.getString('theme');
    final savedName = prefs.getString('name');
    final savedEmail = prefs.getString('email');

    if (savedName != null || savedEmail != null || savedLang != null || savedTheme != null) {
      _userData = _userData.copyWith(
        language: savedLang ?? _userData.language,
        theme: savedTheme ?? _userData.theme,
        name: savedName ?? _userData.name,
        email: savedEmail ?? _userData.email,
      );
    }
    _generateDynamicData();
    notifyListeners();
  }

  Future<void> _persistPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', _userData.language);
    await prefs.setString('theme', _userData.theme);
    if (_userData.name != 'محمد أحمد') {
      await prefs.setString('name', _userData.name);
    }
    if (_userData.email != 'user@example.com') {
      await prefs.setString('email', _userData.email);
    }
  }

  UserData get userData => _userData;

  String t(String key) => Translations.t(key, _userData.language);

  bool get isArabic => _userData.language == 'ar';
  bool get isDark => _userData.theme == 'dark';

  List<Map<String, dynamic>> get progressData => _progressData;
  List<Map<String, dynamic>> get weeklyCalories => _weeklyCalories;

  List<Map<String, dynamic>> getProgressData(int days) {
    if (_progressData.length <= days) return _progressData;
    return _progressData.sublist(_progressData.length - days);
  }

  List<Map<String, dynamic>> get challenges => _challenges;

  List<Map<String, dynamic>> get notifications => _notifications;

  List<Map<String, String>> get articles => [
    {
      'titleAr': 'كيف تزيد من معدل حرق الدهون؟',
      'titleEn': 'How to increase your metabolic rate?',
      'categoryAr': 'تغذية',
      'categoryEn': 'Nutrition',
      'image': 'https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=500',
    },
    {
      'titleAr': 'أفضل 5 تمارين لتقوية الظهر',
      'titleEn': 'Top 5 back strength exercises',
      'categoryAr': 'تمارين',
      'categoryEn': 'Workouts',
      'image': 'https://images.unsplash.com/photo-1541534741688-6078c65b5a33?w=500',
    },
    {
      'titleAr': 'أهمية النوم لصحة الجسم',
      'titleEn': 'The importance of sleep for body health',
      'categoryAr': 'صحة عامة',
      'categoryEn': 'General Health',
      'image': 'https://images.unsplash.com/photo-1541781774459-bb2af2f05b55?w=500',
    },
    {
      'titleAr': 'كيف تحافظ على معدل سكر صحي؟',
      'titleEn': 'How to maintain healthy blood sugar levels',
      'categoryAr': 'تغذية',
      'categoryEn': 'Nutrition',
      'image': 'https://images.unsplash.com/photo-1498837167922-ddd27525d352?w=500',
    },
  ];

  Map<String, dynamic> get calculatedResults {
    final bmi = Calculations.calculateBMI(_userData.weight, _userData.height);
    final bmr = Calculations.calculateBMR(_userData.gender, _userData.weight, _userData.height, _userData.age);
    final tdee = Calculations.calculateTDEE(bmr, _userData.activityLevel);
    final targetCalories = Calculations.calculateTargetCalories(tdee, _userData.goal);
    final macros = Calculations.calculateMacros(targetCalories, _userData.dietType);
    final water = Calculations.calculateWaterIntake(_userData.weight, _userData.activityLevel);

    return {
      'bmi': bmi,
      'bmr': bmr,
      'tdee': tdee,
      'targetCalories': targetCalories,
      'macros': macros,
      'water': water,
    };
  }

  List<Meal> get filteredMeals {
    return mealsData.where(
      (meal) => meal.type.contains(_userData.dietType) || meal.type.contains('default'),
    ).toList();
  }

  List<Exercise> get filteredExercises {
    return exercisesData.where(
      (ex) => ex.goal.contains(_userData.goal),
    ).toList();
  }

  List<Map<String, dynamic>> get macroChartData {
    final macros = calculatedResults['macros'] as Map<String, int>;
    final total = macros['protein']! + macros['carbs']! + macros['fat']!;
    if (total == 0) return [];
    return [
      {'name': t('protein'), 'value': ((macros['protein']! / total) * 100).round(), 'color': const Color(0xFF10B981)},
      {'name': t('carbs'), 'value': ((macros['carbs']! / total) * 100).round(), 'color': const Color(0xFF3B82F6)},
      {'name': t('fats'), 'value': ((macros['fat']! / total) * 100).round(), 'color': const Color(0xFFF59E0B)},
    ];
  }

  String get achievementText {
    if (_progressData.length < 2) return '';
    final firstWeight = (_progressData.first['weight'] as num).toDouble();
    final lastWeight = (_progressData.last['weight'] as num).toDouble();
    final diff = firstWeight - lastWeight;
    if (diff > 0) {
      return isArabic
          ? 'لقد خسرت ${diff.toStringAsFixed(1)} كجم هذا الأسبوع. استمر في هذا الالتزام!'
          : 'You lost ${diff.toStringAsFixed(1)}kg this week. Keep it up!';
    } else if (diff < 0) {
      return isArabic
          ? 'لقد زدت ${(-diff).toStringAsFixed(1)} كجم. عدل خطتك!'
          : 'You gained ${(-diff).toStringAsFixed(1)}kg. Adjust your plan!';
    }
    return isArabic
        ? 'وزنك مستقر. حافظ على نظامك!'
        : 'Your weight is stable. Keep it up!';
  }

  void _generateDynamicData() {
    final random = Random();
    final baseWeight = _userData.weight;
    final results = calculatedResults;
    final baseCalories = results['targetCalories'] as int;

    final days = isArabic
        ? ['السبت', 'الأحد', 'الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة']
        : ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

    _progressData = List.generate(7, (i) {
      final weightDelta = (random.nextDouble() - 0.4) * 0.5;
      final caloriesDelta = (random.nextInt(400) - 200);
      return {
        'day': days[i],
        'weight': double.parse((baseWeight - (i * 0.15) + weightDelta).toStringAsFixed(1)),
        'calories': baseCalories + caloriesDelta,
      };
    });

    _weeklyCalories = List.generate(7, (i) {
      return {
        'name': days[i],
        'value': baseCalories + (random.nextInt(600) - 300),
      };
    });

    final stepsTarget = 10000;
    final stepsCurrent = 4000 + random.nextInt(6000);
    final waterTarget = (results['water'] as int);
    final waterCurrent = (waterTarget * (0.5 + random.nextDouble() * 0.5)).round();
    final calorieBurnTarget = 500;
    final calorieBurnCurrent = 200 + random.nextInt(350);

    _challenges = [
      {
        'titleAr': 'تحدي الخطوات',
        'titleEn': 'Step Challenge',
        'target': '$stepsTarget',
        'current': '$stepsCurrent',
        'icon': Icons.directions_walk_rounded,
        'color': const Color(0xFF10B981),
        'progress': (stepsCurrent / stepsTarget).clamp(0.0, 1.0),
      },
      {
        'titleAr': 'شرب المياه',
        'titleEn': 'Hydration Goal',
        'target': '${(waterTarget / 1000).toStringAsFixed(1)}L',
        'current': '${(waterCurrent / 1000).toStringAsFixed(1)}L',
        'icon': Icons.water_drop_rounded,
        'color': const Color(0xFF3B82F6),
        'progress': (waterCurrent / waterTarget).clamp(0.0, 1.0),
      },
      {
        'titleAr': 'حرق السعرات',
        'titleEn': 'Calorie Burn',
        'target': '$calorieBurnTarget',
        'current': '$calorieBurnCurrent',
        'icon': Icons.local_fire_department_rounded,
        'color': const Color(0xFFF59E0B),
        'progress': (calorieBurnCurrent / calorieBurnTarget).clamp(0.0, 1.0),
      },
    ];

    _notifications = [
      {
        'id': 1,
        'message': isArabic
            ? 'حان وقت شرب الماء! حافظ على رطوبة جسمك.'
            : 'Time to drink water! Keep your body hydrated.',
        'icon': Icons.water_drop_rounded,
        'color': const Color(0xFF3B82F6),
      },
      {
        'id': 2,
        'message': isArabic
            ? 'متبقي لك 30 دقيقة من تمرين اليوم.'
            : 'You have 30 mins of workout left today.',
        'icon': Icons.fitness_center_rounded,
        'color': const Color(0xFF4F46E5),
      },
    ];
  }

  void updateUserData(Map<String, dynamic> newData) {
    _userData = _userData.copyWith(
      name: newData['name'],
      email: newData['email'],
      phone: newData['phone'],
      age: newData['age'],
      gender: newData['gender'],
      weight: newData['weight']?.toDouble(),
      height: newData['height']?.toDouble(),
      activityLevel: newData['activityLevel'],
      dietType: newData['dietType'],
      goal: newData['goal'],
      notifications: newData['notifications'] != null
          ? Notifications(
              water: newData['notifications']['water'] ?? _userData.notifications.water,
              exercise: newData['notifications']['exercise'] ?? _userData.notifications.exercise,
              meals: newData['notifications']['meals'] ?? _userData.notifications.meals,
              sleep: newData['notifications']['sleep'] ?? _userData.notifications.sleep,
            )
          : null,
      language: newData['language'],
      theme: newData['theme'],
    );
    _persistPreferences();
    _generateDynamicData();
    notifyListeners();
  }

  void toggleNotification(String key) {
    final notifs = _userData.notifications;
    final newNotifs = Notifications(
      water: key == 'water' ? !notifs.water : notifs.water,
      exercise: key == 'exercise' ? !notifs.exercise : notifs.exercise,
      meals: key == 'meals' ? !notifs.meals : notifs.meals,
      sleep: key == 'sleep' ? !notifs.sleep : notifs.sleep,
    );
    _userData = _userData.copyWith(notifications: newNotifs);
    notifyListeners();
  }

  void dismissNotification(int id) {
    _notifications.removeWhere((n) => n['id'] == id);
    notifyListeners();
  }

  void refreshData() {
    _generateDynamicData();
    notifyListeners();
  }
}
