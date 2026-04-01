# Health & Fitness App - تطبيق الصحة واللياقة البدنية 🏋️‍♂️

تطبيق متكامل للصحة واللياقة البدنية يتوفر بنسخة **ويب** (Next.js) ونسخة **هاتف/سطح مكتب** (Flutter).

---

## ✨ المميزات الرئيسية

- حساب مؤشر كتلة الجسم (BMI)، معدل الأيض (BMR)، ونفقات الطاقة اليومية (TDEE)
- متخيل الجسم ثلاثي الأبعاد (Body Visualizer)
- خطط وجبات وتمارين رياضية مقترحة
- تتبع التقدم برسوم بيانية تفاعلية
- تحديات ومقالات تعليمية
- دعم الوضع المظلم
- ثنائي اللغة (عربي / إنجليزي)
- تصميم متجاوب لجميع الأجهزة

---

## 📂 هيكل المشروع

```
├── src/                    # تطبيق الويب (Next.js)
│   ├── app/
│   ├── components/
│   ├── context/
│   └── utils/
│
└── vitality_ai/            # تطبيق الهاتف (Flutter)
    ├── lib/
    │   ├── models/
    │   ├── providers/
    │   ├── screens/
    │   └── widgets/
    └── ...
```

---

## 🛠 التقنيات المستخدمة

| النسخة | التقنيات |
|--------|----------|
| **Web** | Next.js, React, Tailwind CSS, Recharts |
| **Mobile** | Flutter, Dart, Provider, fl_chart |

---

## 🚀 التشغيل

### تطبيق الويب (Next.js)

```bash
npm install
npm run dev
```

### تطبيق الهاتف (Flutter)

```bash
cd vitality_ai
flutter pub get
flutter run
```

---

## 📝 License

تم التطوير بواسطة فريق VitalityAI
