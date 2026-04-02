# Changelog

## [1.1.0] - 2026-04-02

### Fixed

#### Settings - Profile Save
- **Critical**: Save button in settings profile tab was not saving name/email changes. `_handleSave()` only showed feedback UI but never called `provider.updateUserData()`.
- **Critical**: `TextEditingController` instances were created inside `build()` method, causing controllers to reset on every rebuild and losing user input.
- **Fix**: Extracted profile tab into separate `_ProfileTabContent` StatefulWidget with controllers initialized in `initState()`. Save button now reads controller values and calls `provider.updateUserData()`.

#### Language / Localization Persistence
- **Critical**: Language preference was not persisted. Changing language to Arabic would reset to default on app restart.
- **Fix**: Added `SharedPreferences` integration in `UserProvider` to persist `language`, `theme`, `name`, and `email` settings.
- **Fix**: Added `_loadPreferences()` to restore saved settings on app startup.
- **Fix**: Added `_persistPreferences()` called after every `updateUserData()` to save changes immediately.
- **Fix**: Replaced hardcoded English string `'Fine-tune your vitality experience.'` in settings screen with translated key `t('settingsSubtitle')`.
- Added Arabic and English translations for `settingsSubtitle`.

#### Reports Download
- **Critical**: "Download Report" button in Reports screen had empty `onPressed: () {}` handler.
- **Critical**: "Download Report" button in Progress section achievement card was a decorative Container with no interactivity.
- **Fix**: Implemented report generation as formatted text and sharing via `share_plus` package.
- **Fix**: Added `_downloadReport()` method to `ReportsScreen` that generates comprehensive report (BMI, TDEE, calories, macros, water, 7-day progress).
- **Fix**: Wrapped achievement card download button with `GestureDetector` that shares progress report.

#### Charts Reactivity
- **Issue**: Charts did not visually animate when data changed due to fl_chart widget recreation not being triggered.
- **Fix**: Added `ValueKey(data.length)` to all chart widgets (`WeightChart`, `CaloriesChart`, `BarChartWidget`, `PieChartWidget`) to force widget recreation when data length changes.

#### Progress Tracker Day Range Selection
- **Critical**: "Last 7 Days" label was static with no way to change the time range.
- **Fix**: Converted `UserProgress` from StatelessWidget to StatefulWidget.
- **Fix**: Added selectable range chips for 7, 14, and 30 days.
- **Fix**: Charts now use filtered progress data based on selected range.
- Added `getProgressData(int days)` method to `UserProvider`.

#### Meals & Exercises Data
- **Issue**: Only 3 meals and 3 exercises available - very limited data.
- **Fix**: Expanded to 6 meals (added Banana Honey Oatmeal, Grilled Salmon with Veggies, Chickpea Salad) and 6 exercises (added Deadlift, Ab Crunches, Swimming).
- **Fix**: Added `loadingBuilder` with progress indicator to meal and exercise image `Image.network` widgets.
- **Fix**: Improved `errorBuilder` with themed fallback icons and colors.

#### Articles
- **Issue**: Articles were hardcoded inside the widget `build` method and didn't respond to language changes.
- **Fix**: Moved articles data to `UserProvider` as a getter.
- **Fix**: Added 2 more articles (Sleep importance, Blood sugar management) for total of 4.
- **Fix**: Added `loadingBuilder` and improved `errorBuilder` for article images.
- **Fix**: Removed old `_ArticleData` class and `_buildArticleCard` method, replaced with `_buildArticleCardFromMap` that works with provider data.

#### RenderFlex Overflow (from v1.0.0 hotfix)
- **Critical**: `RenderFlex overflowed by 23 pixels` in `_buildCard` at `result_cards.dart:100`.
- **Fix**: Changed `MainAxisSize.max` to `MainAxisSize.min`.
- **Fix**: Replaced `Spacer()` with `SizedBox(height: 8)`.
- **Fix**: Wrapped `FittedBox` with `Flexible` for vertical compression.

### Added
- `shared_preferences: ^2.3.3` dependency for local persistence.
- `share_plus: ^10.1.4` dependency for report sharing.
- `_loadPreferences()` and `_persistPreferences()` methods in `UserProvider`.
- `getProgressData(int days)` method in `UserProvider`.
- `articles` getter in `UserProvider` with 4 localized articles.
- `_buildRangeChip()` method in `UserProgress` for day range selection.
- `settingsSubtitle` translation key in Arabic and English.

### Changed
- `UserProvider` constructor now calls `_loadPreferences()` instead of `_generateDynamicData()` directly.
- `updateUserData()` now calls `_persistPreferences()` before regenerating data.
- `UserProgress` changed from `StatelessWidget` to `StatefulWidget`.
- `Articles` widget now reads data from provider instead of hardcoded list.

### Removed
- Unused `_buildFieldLabel` method from `_SettingsScreenState` (duplicated in `_ProfileTabContentState`).
- Old `_ArticleData` class and `_buildArticleCard` method from `articles.dart`.

### Dependencies
| Package | Version | Purpose |
|---------|---------|---------|
| shared_preferences | ^2.3.3 | Persist language, theme, name, email |
| share_plus | ^10.1.4 | Share generated reports |
| provider | ^6.1.2 | State management (existing) |
| fl_chart | ^0.70.2 | Charts (existing) |

### Files Modified
| File | Changes |
|------|---------|
| `pubspec.yaml` | Added shared_preferences, share_plus |
| `lib/providers/user_provider.dart` | Added persistence, articles, getProgressData |
| `lib/screens/settings_screen.dart` | Fixed profile save, localized subtitle, removed unused method |
| `lib/screens/reports_screen.dart` | Implemented download report with share |
| `lib/widgets/user_progress.dart` | Added day range selection, fixed download button |
| `lib/widgets/progress_charts.dart` | Added ValueKey to all chart widgets |
| `lib/widgets/articles.dart` | Moved data to provider, improved image loading |
| `lib/widgets/meals_list.dart` | Added image loading/error builders |
| `lib/widgets/exercises_list.dart` | Added image loading/error builders |
| `lib/widgets/result_cards.dart` | Fixed overflow (v1.0.0 hotfix) |
| `lib/data/app_data.dart` | Expanded meals and exercises data |
| `lib/utils/translations.dart` | Added settingsSubtitle key |
