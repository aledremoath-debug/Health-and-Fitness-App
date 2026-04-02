import '../models/meal.dart';
import '../models/exercise.dart';

final List<Meal> mealsData = [
  Meal(
    id: 1,
    name: {'ar': 'بيض بالأفوكادو', 'en': 'Avocado Toast with Eggs'},
    calories: 450,
    macros: {'p': 20, 'c': 15, 'f': 30},
    type: ['default', 'keto', 'low_carb'],
    image: 'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=500',
    ingredients: {
      'ar': ['بيضتان', 'حبة أفوكادو', 'شريحة خبز حبوب', 'ملح وفلفل'],
      'en': ['2 Eggs', '1 Avocado', '1 Slice multi-grain bread', 'Salt & Pepper'],
    },
    steps: {
      'ar': ['قم بتحميص الخبز', 'هرس الأفوكادو ووضعه فوق الخبز', 'طهي البيض ووضعه في الأعلى'],
      'en': ['Toast the bread', 'Mash avocado and spread on toast', 'Cook eggs and place on top'],
    },
  ),
  Meal(
    id: 2,
    name: {'ar': 'صدور دجاج مشوية', 'en': 'Grilled Chicken Breast'},
    calories: 380,
    macros: {'p': 45, 'c': 0, 'f': 8},
    type: ['default', 'keto', 'low_carb'],
    image: 'https://images.unsplash.com/photo-1532550907401-a500c9a57435?w=500',
    ingredients: {
      'ar': ['200 جرام صدر دجاج', 'زيت زيتون', 'بهارات دجاج'],
      'en': ['200g Chicken breast', 'Olive oil', 'Chicken seasoning'],
    },
    steps: {
      'ar': ['تبريل الدجاج بالبهارات', 'شوي الدجاج على نار متوسطة لمدة 15 دقيقة'],
      'en': ['Season chicken', 'Grill over medium heat for 15 mins'],
    },
  ),
  Meal(
    id: 3,
    name: {'ar': 'سلطة كينوا', 'en': 'Quinoa Salad'},
    calories: 320,
    macros: {'p': 12, 'c': 50, 'f': 10},
    type: ['default', 'vegan'],
    image: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=500',
    ingredients: {
      'ar': ['كوب كينوا مطبوخة', 'طماطم وخيار', 'عصير ليمون'],
      'en': ['1 cup Cooked quinoa', 'Tomato & Cucumber', 'Lemon juice'],
    },
    steps: {
      'ar': ['خلط الكينوا مع الخضار المقطعة', 'إضافة التبيلة'],
      'en': ['Mix quinoa with chopped veggies', 'Add dressing'],
    },
  ),
  Meal(
    id: 4,
    name: {'ar': 'شوفان بالموز والعسل', 'en': 'Banana Honey Oatmeal'},
    calories: 350,
    macros: {'p': 10, 'c': 60, 'f': 8},
    type: ['default', 'vegan'],
    image: 'https://images.unsplash.com/photo-1517673400267-0251440c45dc?w=500',
    ingredients: {
      'ar': ['كوب شوفان', 'حبة موز', 'ملعقة عسل', 'كوب حليب'],
      'en': ['1 cup oats', '1 banana', '1 tbsp honey', '1 cup milk'],
    },
    steps: {
      'ar': ['سلق الشوفان بالحليب', 'قطع الموز فوقه', 'إضافة العسل'],
      'en': ['Cook oats in milk', 'Slice banana on top', 'Drizzle honey'],
    },
  ),
  Meal(
    id: 5,
    name: {'ar': 'سلمون مشوي مع خضار', 'en': 'Grilled Salmon with Veggies'},
    calories: 520,
    macros: {'p': 40, 'c': 15, 'f': 32},
    type: ['default', 'keto', 'low_carb'],
    image: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=500',
    ingredients: {
      'ar': ['قطعة سلمون', 'بروكلي', 'كوسة', 'زيت زيتون'],
      'en': ['Salmon fillet', 'Broccoli', 'Zucchini', 'Olive oil'],
    },
    steps: {
      'ar': ['تتبيل السلمون', 'شويه في الفرن 20 دقيقة', 'طهي الخضار بالبخار'],
      'en': ['Season salmon', 'Bake for 20 minutes', 'Steam vegetables'],
    },
  ),
  Meal(
    id: 6,
    name: {'ar': 'سلطة الحمص', 'en': 'Chickpea Salad'},
    calories: 280,
    macros: {'p': 14, 'c': 35, 'f': 10},
    type: ['default', 'vegan'],
    image: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=500',
    ingredients: {
      'ar': ['كوب حمص مسلوق', 'خيار', 'طماطم', 'بقدونس', 'ليمون'],
      'en': ['1 cup chickpeas', 'Cucumber', 'Tomato', 'Parsley', 'Lemon'],
    },
    steps: {
      'ar': ['خلط جميع المكونات', 'إضافة الليمون والزيت'],
      'en': ['Mix all ingredients', 'Add lemon and oil'],
    },
  ),
];

final List<Exercise> exercisesData = [
  Exercise(
    id: 1,
    name: {'ar': 'ضغط الصدر', 'en': 'Chest Press'},
    goal: ['maintain', 'gain'],
    muscle: {'ar': 'الصدر', 'en': 'Chest'},
    duration: '45 دقيقة',
    calories: 300,
    image: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=500',
    instructions: {
      'ar': ['استلقِ على المقعد', 'ادفع الأوزان لأعلى ببطء', 'حافظ على استقامة الظهر'],
      'en': ['Lie on the bench', 'Press weights up slowly', 'Keep back flat'],
    },
  ),
  Exercise(
    id: 2,
    name: {'ar': 'سكوات (قرفصاء)', 'en': 'Squats'},
    goal: ['loss', 'maintain', 'gain'],
    muscle: {'ar': 'الأرجل', 'en': 'Legs'},
    duration: '30 دقيقة',
    calories: 250,
    image: 'https://images.unsplash.com/photo-1566241440091-ec10de8db2e1?w=500',
    instructions: {
      'ar': ['باعد بين قدميك', 'انزل ببطء كأنك تجلس', 'ادفع لأعلى من كعب القدم'],
      'en': ['Feet shoulder-width apart', 'Lower slowly as if sitting', 'Push up through heels'],
    },
  ),
  Exercise(
    id: 3,
    name: {'ar': 'مشي سريع', 'en': 'Brisk Walk'},
    goal: ['loss'],
    muscle: {'ar': 'كامل الجسم', 'en': 'Full Body'},
    duration: '45 دقيقة',
    calories: 350,
    image: 'https://images.unsplash.com/photo-1552674605-db6ffd4facb5?w=500',
    instructions: {
      'ar': ['المشي بسرعة منتظمة', 'تحريك الذراعين', 'التنفس بعمق'],
      'en': ['Walk at steady pace', 'Move arms', 'Breathe deeply'],
    },
  ),
  Exercise(
    id: 4,
    name: {'ar': 'ديدليفت', 'en': 'Deadlift'},
    goal: ['gain', 'maintain'],
    muscle: {'ar': 'الظهر والأرجل', 'en': 'Back & Legs'},
    duration: '40 دقيقة',
    calories: 350,
    image: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=500',
    instructions: {
      'ar': ['قف أمام البار', 'انزل وامسك البار', 'ارفع للخلف بقوة'],
      'en': ['Stand before the bar', 'Grip and lift', 'Drive through heels'],
    },
  ),
  Exercise(
    id: 5,
    name: {'ar': 'تمارين البطن', 'en': 'Ab Crunches'},
    goal: ['loss', 'maintain', 'gain'],
    muscle: {'ar': 'البطن', 'en': 'Core'},
    duration: '20 دقيقة',
    calories: 150,
    image: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=500',
    instructions: {
      'ar': ['استلقِ على ظهرك', 'اثني ركبتيك', 'ارفع صدرك نحو الركب'],
      'en': ['Lie on your back', 'Bend your knees', 'Curl chest toward knees'],
    },
  ),
  Exercise(
    id: 6,
    name: {'ar': 'سباحة', 'en': 'Swimming'},
    goal: ['loss', 'maintain'],
    muscle: {'ar': 'كامل الجسم', 'en': 'Full Body'},
    duration: '45 دقيقة',
    calories: 400,
    image: 'https://images.unsplash.com/photo-1530549387789-4c1017266635?w=500',
    instructions: {
      'ar': ['ادخل الماء ببطء', 'ابدأ بالسباحة الخفيفة', 'حافظ على التنفس المنتظم'],
      'en': ['Enter water slowly', 'Start with light laps', 'Maintain steady breathing'],
    },
  ),
];

final List<Map<String, dynamic>> mockProgress = [
  {'day': 'Sat', 'weight': 75.0, 'calories': 2100},
  {'day': 'Sun', 'weight': 74.8, 'calories': 1950},
  {'day': 'Mon', 'weight': 74.5, 'calories': 2050},
  {'day': 'Tue', 'weight': 74.6, 'calories': 2200},
  {'day': 'Wed', 'weight': 74.2, 'calories': 1800},
  {'day': 'Thu', 'weight': 74.0, 'calories': 1900},
  {'day': 'Fri', 'weight': 73.8, 'calories': 2000},
];

final List<Map<String, dynamic>> weeklyCalories = [
  {'name': 'Sat', 'value': 2100},
  {'name': 'Sun', 'value': 1900},
  {'name': 'Mon', 'value': 2200},
  {'name': 'Tue', 'value': 2000},
  {'name': 'Wed', 'value': 1800},
  {'name': 'Thu', 'value': 2400},
  {'name': 'Fri', 'value': 1700},
];
