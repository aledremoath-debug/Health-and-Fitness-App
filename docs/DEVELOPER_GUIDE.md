# Developer Integration Guide

This document is to be read by any future developer or designer joining the `vitality_ai` team to ensure our unified UI architectural decisions stay coherent.

## Design Handoff (Figma/Sketch)
We do not explicitly commit `.fig` files into source control to prevent binary bloat. Instead, designers structure their Figma tokens to explicitly mirror `lib/utils/design_tokens.dart`.
### How to align with Design:
- **Spacing:** Inform your designer that all spacing increments match the `AppTokens.space(...)` multiples (4, 8, 12, 16, 20, 24, 32).
- **Themes:** Light/Dark modes are managed inherently by Flutter. `context.watch<UserProvider>().isDark` provides the boolean state. Reference `AppTokens.darkSurface` and `AppTokens.lightSurface` rather than static hex codes.

## Standard Lifecycle for a New Feature
1. **Define Feature State:** Place feature-specific business logic in a focused Provider or modify `user_provider.dart` if it scales globally.
2. **Translate First:** Add all visible Strings to `lib/utils/translations.dart` BEFORE writing UI code. Ensure an Arabic (`ar`) and English (`en`) pair.
3. **Draft the UI Component:** 
   - Extract padding values from `AppTokens`.
   - Never use `TextStyle(color: Colors.white)`. You MUST check boolean status for Theme brightness `isDark` or let the Theme Engine define implicit Text Colors.
4. **Interactive Bounds:** Any clickable `GestureDetector` or `InkWell` must enforce `minHeight`/`minWidth` of **44.0** per `QA_PLAN.md`. Keep accessible buttons explicit.

## Success Criteria / Definition of Done
Your PR / Feature is complete if and only if:
- [ ] No `Color(0xFF..)` or manual `TextStyle` anomalies exist outside `design_tokens.dart`.
- [ ] You tested the screen in Right-To-Left (`Locale('ar')`).
- [ ] Automated tests for formatting or UI regressions pass.
- [ ] Tap area targets satisfy 44x44.
