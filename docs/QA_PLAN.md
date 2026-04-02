# QA & Testing Plan (WCAG 2.1 AA & UI Redesign)

This document outlines the Quality Assurance boundaries and Acceptance Criteria for the new UI modifications.

## 1. Scope of Testing
- `ReportsScreen` (Responsive grid, Download Report button)
- `DashboardScreen` (Progress Cards, Layout alignments)
- `UserProgress` (Language toggles, dynamic chart views)
- `DetailModal` (Keyboard accessible exits, 44x44 active touch areas)
- Theming Engine & Accessibility standards.

## 2. Unit & Widget Tests (Proposed)
Developers should write automated Widget Tests enforcing:
- **`AppTokens` strictness check:** A linter/test that fails if hardcoded colors like `Color(0xFF...)` are used in UI screens instead of referencing `AppTokens`.
- **i18n Fallback Test:** Load the app in `Locale('ar')` and verify Arabic string generation, then flip to `Locale('en')`.

## 3. Accessibility Acceptance Criteria (WCAG 2.1 AA)
1. **Keyboard Accessibility:**
   - Go to any screen.
   - Using only the **Tab** and **Space/Enter** keys (or equivalent simulator hardware controls), navigate through:
     - Navigation Bar
     - Expandable Modules 
     - Filter Chips in the Progress Board
     - Modal Close Button
   - *Status: MUST PASS* (The user should not be trapped in any focus).

2. **Touch Targets (Mobile):**
   - Verify every standalone action link, icon button, or toggable widget on Mobile screens is no smaller than `44 x 44` logical pixels.
   
3. **Responsive Visual Regression:**
   - Execute the app on an Android Mobile Emulator (400px width).
   - Execute the app on a simulated Desktop environment/Web (>1000px width).
   - Verify the `ReportsScreen` forms a clean grid when `width > 1024`.

## 4. Manual QA Steps
1. Tap the newly designed Language Toggle (`EN` / `AR`) in the `UserProgress` widget. Verify strings change instantly globally.
2. Tap the "Download Report" button. Ensure the output is reliably in English across both UI languages.
3. Open a "Meal" or "Exercise" `DetailModal`. Verify the "X" close button has a large clickable invisible area padding.
