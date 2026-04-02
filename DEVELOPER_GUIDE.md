# VitalityAI - Developer & QA Guide

## Project Architecture

```
vitality_ai/lib/
├── main.dart                    # App entry point, MaterialApp, MainShell with IndexedStack
├── data/
│   └── app_data.dart            # Static meals, exercises, mock progress data
├── models/
│   ├── user_data.dart           # UserData, Notifications models
│   ├── meal.dart                # Meal model
│   └── exercise.dart            # Exercise model
├── providers/
│   └── user_provider.dart       # UserProvider (ChangeNotifier) - single source of truth
├── screens/
│   ├── dashboard_screen.dart    # Main dashboard with responsive layout
│   ├── reports_screen.dart      # Reports with charts and download
│   └── settings_screen.dart     # Profile, notifications, appearance, language
├── utils/
│   ├── app_theme.dart           # ThemeData for dark/light modes
│   ├── calculations.dart        # BMI, BMR, TDEE, macros, water calculations
│   └── translations.dart        # Arabic/English translation maps
└── widgets/
    ├── app_navbar.dart           # Top nav + bottom nav
    ├── body_visualizer.dart      # Animated body figure
    ├── form_user_data.dart       # Health metrics input form
    ├── result_cards.dart         # BMI, calories, water, TDEE cards + macros
    ├── meals_list.dart           # Suggested meals list
    ├── exercises_list.dart       # Custom exercises list
    ├── user_progress.dart        # Progress charts + day range selector
    ├── progress_charts.dart      # LineChart, BarChart, PieChart widgets
    ├── challenges.dart           # Daily challenges with progress bars
    ├── articles.dart             # Health articles with images
    ├── notifications.dart        # Toast-style notifications
    └── detail_modal.dart         # Meal/exercise detail bottom sheet
```

## Tech Stack
- **Framework**: Flutter 3.x (Dart SDK ^3.8.1)
- **State Management**: Provider (ChangeNotifierProvider)
- **Charts**: fl_chart ^0.70.2
- **Persistence**: SharedPreferences
- **Sharing**: SharePlus

## Setup Instructions

```bash
# 1. Clone repository
git clone <repo-url>
cd vitality_ai

# 2. Install dependencies
flutter pub get

# 3. Run static analysis
flutter analyze

# 4. Run the app
flutter run

# 5. Run on specific device
flutter run -d chrome        # Web
flutter run -d windows       # Windows desktop
flutter run -d <device-id>   # Mobile (list with: flutter devices)
```

## Testing Checklist

### 1. Profile Save (Settings > Profile)
- [ ] Navigate to Settings > Profile tab
- [ ] Change name to a new value
- [ ] Change email to a new value
- [ ] Click "Save Changes" button
- [ ] Verify success feedback appears (green checkmark)
- [ ] Close and reopen the app
- [ ] Verify name and email persisted

### 2. Language Switching
- [ ] Navigate to Settings > Language tab
- [ ] Select "العربية" (Arabic)
- [ ] Verify all UI text changes to Arabic
- [ ] Verify RTL layout where applicable
- [ ] Close and reopen the app
- [ ] Verify language preference persisted
- [ ] Switch back to English and verify

### 3. Theme Switching
- [ ] Navigate to Settings > Appearance tab
- [ ] Toggle between Dark and Light mode
- [ ] Verify colors change throughout the app
- [ ] Close and reopen the app
- [ ] Verify theme preference persisted

### 4. Reports Download
- [ ] Navigate to Reports screen
- [ ] Click "Download Report" button
- [ ] Verify share sheet appears with formatted report text
- [ ] Verify report contains BMI, TDEE, calories, macros, water, progress data
- [ ] Navigate to Dashboard > Progress section
- [ ] Click "Download Report" in achievement card
- [ ] Verify share sheet appears with progress data

### 5. Charts
- [ ] Navigate to Dashboard - verify result cards show data
- [ ] Navigate to Reports - verify bar chart and pie chart render
- [ ] Change user data (weight, age) via form and click Calculate
- [ ] Verify charts update with new data

### 6. Progress Day Range Selection
- [ ] Navigate to Dashboard > Progress section
- [ ] Verify three range chips: "Last 7 Days", "Last 14 Days", "Last 30 Days"
- [ ] Click "Last 14 Days" chip
- [ ] Verify chip highlights and charts update
- [ ] Click "Last 30 Days" chip
- [ ] Verify charts update again
- [ ] Click "Last 7 Days" to reset

### 7. Meals & Exercises
- [ ] Navigate to Dashboard > Meals section
- [ ] Verify 4-6 meal cards are visible
- [ ] Verify meal images load (or show themed fallback)
- [ ] Tap a meal card - verify detail modal opens
- [ ] Verify modal shows image, name, calories, macros, ingredients, steps
- [ ] Close modal
- [ ] Navigate to Dashboard > Exercises section
- [ ] Verify 4-6 exercise cards are visible
- [ ] Tap an exercise - verify detail modal opens

### 8. Articles
- [ ] Navigate to Dashboard > Health Insights section
- [ ] Verify 4 article cards are visible
- [ ] Verify article images load (or show themed fallback)
- [ ] Verify article titles display in correct language

### 9. Challenges
- [ ] Navigate to Dashboard > Daily Challenges section
- [ ] Verify 3 challenge cards with progress bars
- [ ] Verify progress values match displayed numbers

### 10. Responsive Design
- [ ] Resize browser window to mobile width (< 768px)
- [ ] Verify bottom navigation appears
- [ ] Verify single-column layout
- [ ] Resize to tablet width (768-1024px)
- [ ] Verify 2-column layout where applicable
- [ ] Resize to desktop width (> 1024px)
- [ ] Verify 3-column dashboard layout

## Acceptance Criteria

| Feature | Criteria |
|---------|----------|
| Profile Save | Name and email persist across app restarts |
| Language | UI fully translates, preference persists |
| Reports | Share sheet opens with complete formatted report |
| Charts | Update when underlying data changes |
| Progress Range | Selecting range filters chart data correctly |
| Meals | 6 meals visible, images load/fallback, detail modal works |
| Exercises | 6 exercises visible, images load/fallback, detail modal works |
| Articles | 4 articles from provider, language-aware titles |
| Analysis | `flutter analyze` returns 0 issues |

## Rollback Plan

If issues arise after deployment:

1. **Git rollback**: `git revert HEAD` to undo last commit
2. **Dependency rollback**: Remove `shared_preferences` and `share_plus` from pubspec.yaml, run `flutter pub get`
3. **Provider rollback**: Revert `user_provider.dart` to remove `_loadPreferences()` and `_persistPreferences()`
4. **Settings rollback**: Revert `settings_screen.dart` to original StatelessWidget profile tab

### Critical Files Backup Points
- `user_provider.dart` - before persistence changes
- `settings_screen.dart` - before StatefulWidget conversion
- `user_progress.dart` - before day range selection
- `articles.dart` - before provider migration
