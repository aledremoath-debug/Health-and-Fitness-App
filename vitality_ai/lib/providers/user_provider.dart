import 'package:flutter/material.dart';
import '../models/user_data.dart';
import '../utils/translations.dart';

class UserProvider extends ChangeNotifier {
  UserData _userData = UserData();

  UserData get userData => _userData;

  String t(String key) => Translations.t(key, _userData.language);

  bool get isArabic => _userData.language == 'ar';
  bool get isDark => _userData.theme == 'dark';

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
}
