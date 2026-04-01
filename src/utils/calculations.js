/**
 * Health & Fitness Calculation Utilities
 */

// BMI Calculation: weight (kg) / (height(m)^2)
export const calculateBMI = (weight, height) => {
  const heightInMeters = height / 100;
  const bmi = weight / (heightInMeters * heightInMeters);
  return parseFloat(bmi.toFixed(1));
};

// BMR Calculation (Mifflin-St Jeor Equation)
// Men: BMR = 10 * weight (kg) + 6.25 * height (cm) – 5 * age (y) + 5
// Women: BMR = 10 * weight (kg) + 6.25 * height (cm) – 5 * age (y) – 161
export const calculateBMR = (gender, weight, height, age) => {
  let bmr;
  if (gender.toLowerCase() === 'male' || gender.toLowerCase() === 'ذكر') {
    bmr = 10 * weight + 6.25 * height - 5 * age + 5;
  } else {
    bmr = 10 * weight + 6.25 * height - 5 * age - 161;
  }
  return Math.round(bmr);
};

// Daily Caloric Needs (TDEE - Total Daily Energy Expenditure)
// Based on activity level:
// 1.2: Sedentary (office job, little exercise)
// 1.375: Lightly active (light exercise 1-3 days/week)
// 1.55: Moderately active (moderate exercise 3-5 days/week)
// 1.725: Very active (hard exercise 6-7 days/week)
// 1.9: Extra active (very hard exercise & physical job)
export const calculateTDEE = (bmr, activityLevel) => {
  const multipliers = {
    sedentary: 1.2,
    light: 1.375,
    moderate: 1.55,
    active: 1.725,
    extra: 1.9,
    'خامل': 1.2,
    'خفيف': 1.375,
    'متوسط': 1.55,
    'نشيط': 1.725,
    'رياضي جدا': 1.9
  };
  const multiplier = multipliers[activityLevel] || 1.2;
  return Math.round(bmr * multiplier);
};

// Target Calories based on goal
// lose: -500 kcal, maintain: 0, gain: +500 kcal
export const calculateTargetCalories = (tdee, goal) => {
  const goalOffsets = {
    lose: -500,
    maintain: 0,
    gain: 500,
    'تنحيف': -500,
    'محافظة': 0,
    'تضخيم': 500
  };
  const offset = goalOffsets[goal] || 0;
  return Math.round(tdee + offset);
};

// Macro Distribution
// Default (Moderate Carb): Protein: 25%, Carbs: 45%, Fat: 30%
// Keto: Protein: 25%, Carbs: 5%, Fat: 70%
// Vegan (High Carb): Protein: 20%, Carbs: 55%, Fat: 25%
export const calculateMacros = (targetCalories, dietType = 'default') => {
  let proteinP, carbP, fatP;

  switch (dietType.toLowerCase()) {
    case 'keto':
    case 'كيتو':
      proteinP = 0.25; carbP = 0.05; fatP = 0.70;
      break;
    case 'vegan':
    case 'نباتي':
      proteinP = 0.20; carbP = 0.55; fatP = 0.25;
      break;
    case 'low_carb':
    case 'منخفض الكربوهيدرات':
      proteinP = 0.35; carbP = 0.25; fatP = 0.40;
      break;
    default:
      proteinP = 0.25; carbP = 0.45; fatP = 0.30;
  }

  // Energy values: Protein: 4 cal/g, Carbs: 4 cal/g, Fat: 9 cal/g
  const protein = Math.round((targetCalories * proteinP) / 4);
  const carbs = Math.round((targetCalories * carbP) / 4);
  const fat = Math.round((targetCalories * fatP) / 9);

  return { protein, carbs, fat };
};

// Water Intake (ml)
// Base: 35ml per kg of body weight
// Add 500ml for activity or hot weather
export const calculateWaterIntake = (weight, activityLevel) => {
  let baseWater = weight * 35;
  if (['moderate', 'active', 'extra', 'متوسط', 'نشيط', 'رياضي جدا'].includes(activityLevel)) {
    baseWater += 500;
  }
  return Math.round(baseWater);
};
