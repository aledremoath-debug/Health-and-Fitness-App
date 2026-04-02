class Calculations {
  static double calculateBMI(double weight, double height) {
    final heightInMeters = height / 100;
    final bmi = weight / (heightInMeters * heightInMeters);
    return double.parse(bmi.toStringAsFixed(1));
  }

  static int calculateBMR(String gender, double weight, double height, int age) {
    double bmr;
    if (gender.toLowerCase() == 'male' || gender == 'ذكر') {
      bmr = 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      bmr = 10 * weight + 6.25 * height - 5 * age - 161;
    }
    return bmr.round();
  }

  static int calculateTDEE(int bmr, String activityLevel) {
    const multipliers = {
      'sedentary': 1.2,
      'light': 1.375,
      'moderate': 1.55,
      'active': 1.725,
      'extra': 1.9,
      'خامل': 1.2,
      'خفيف': 1.375,
      'متوسط': 1.55,
      'نشيط': 1.725,
      'رياضي جدا': 1.9,
    };
    final multiplier = multipliers[activityLevel] ?? 1.2;
    return (bmr * multiplier).round();
  }

  static int calculateTargetCalories(int tdee, String goal) {
    const goalOffsets = {
      'loss': -500,
      'maintain': 0,
      'gain': 500,
      'تنحيف': -500,
      'محافظة': 0,
      'تضخيم': 500,
    };
    final offset = goalOffsets[goal] ?? 0;
    return (tdee + offset).round();
  }

  static Map<String, int> calculateMacros(int targetCalories, String dietType) {
    double proteinP, carbP, fatP;

    switch (dietType.toLowerCase()) {
      case 'keto':
      case 'كيتو':
        proteinP = 0.25;
        carbP = 0.05;
        fatP = 0.70;
        break;
      case 'vegan':
      case 'نباتي':
        proteinP = 0.20;
        carbP = 0.55;
        fatP = 0.25;
        break;
      case 'low_carb':
      case 'منخفض الكربوهيدرات':
        proteinP = 0.35;
        carbP = 0.25;
        fatP = 0.40;
        break;
      default:
        proteinP = 0.25;
        carbP = 0.45;
        fatP = 0.30;
    }

    final protein = (targetCalories * proteinP / 4).round();
    final carbs = (targetCalories * carbP / 4).round();
    final fat = (targetCalories * fatP / 9).round();

    return {'protein': protein, 'carbs': carbs, 'fat': fat};
  }

  static int calculateWaterIntake(double weight, String activityLevel) {
    double baseWater = weight * 35;
    if (['moderate', 'active', 'extra', 'متوسط', 'نشيط', 'رياضي جدا']
        .contains(activityLevel)) {
      baseWater += 500;
    }
    return baseWater.round();
  }
}

class HealthResults {
  final double bmi;
  final int bmr;
  final int tdee;
  final int targetCalories;
  final Map<String, int> macros;
  final int water;

  HealthResults({
    required this.bmi,
    required this.bmr,
    required this.tdee,
    required this.targetCalories,
    required this.macros,
    required this.water,
  });
}
