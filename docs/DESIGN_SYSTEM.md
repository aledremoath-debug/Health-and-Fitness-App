# Vitality AI - Design System

This design system specifies the UI rules, spacing properties, and typography to maintain consistency across the app. We follow **WCAG 2.1 AA** for accessibility.

## 1. Design Tokens (`AppTokens`)
All raw values must NOT be hardcoded in widgets. Import `lib/utils/design_tokens.dart` and use `AppTokens`.

### Colors
**Brand Palette:**
- Primary Blue: `#3B82F6` (`AppTokens.primaryBlue`)
- Primary Light: `#2563EB` (`AppTokens.primaryBlueLight`) - Used in Light Mode.
- Accent Indigo: `#4F46E5` (`AppTokens.accentIndigo`)
- Success Emerald: `#10B981` (`AppTokens.emerald`)

**Dark Theme:**
- Background: `#050508`
- Surface (Cards/Modals): `#0F172A`
- Text Primary: `#F8FAFC`
- Text Secondary: `#94A3B8`

**Light Theme:**
- Background: `#F3F4F6`
- Surface: `#FFFFFF`
- Text Primary: `#0F172A`
- Text Secondary: `#475569`

### Typography (Inter)
We use the **Inter** font family to ensure readability.
- **H1 (Hero):** 36px, `FontWeight.w900`, letterSpacing: -0.5
- **H2 (Section Header):** 28px, `FontWeight.w900`
- **H3 (Card Title):** 22px, `FontWeight.w700`
- **Body Large:** 16px, `FontWeight.w600`
- **Body:** 14px, `FontWeight.w500`
- **Body Small:** 12px, `FontWeight.w500`
- **Caption:** 10px, `FontWeight.w900`, letterSpacing: 0.1

### Spacing & Grid System
The layout is built on an **8-point grid base**.
- Space4: 4px
- Space8: 8px
- Space12: 12px
- Space16: 16px
- Space20: 20px
- Space24: 24px
- Space32: 32px

### Radii (Corners)
- Small components (Chips, Labels): `8px` to `12px`
- Interactive buttons: `16px` to `Max (Pill)`
- Cards & Modals: `24px` to `32px`

## 2. Accessibility Rules
1. **Contrast Ratio:** All primary text colors must meet a **4.5:1** contrast ratio against their background surfaces in BOTH light and dark themes.
2. **Hit/Touch Targets:** Any actionable button or icon MUST be at least **44x44px**. (E.g., `AppTokens.minTouchTarget`).
3. **i18n & Directionality:** The app enforces LTR/RTL switching natively in Flutter. UI elements like `back arrows` must flip dynamically.

## 3. Creating New Components
When creating a new widget:
1. Open `lib/utils/design_tokens.dart`.
2. Find the applicable generic `AppTokens` constant constraint.
3. Instead of `padding: EdgeInsets.all(16)`, use `EdgeInsets.all(AppTokens.space16)`.
