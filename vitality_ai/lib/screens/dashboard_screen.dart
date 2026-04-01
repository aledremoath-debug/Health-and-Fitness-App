import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/calculations.dart';
import '../widgets/form_user_data.dart';
import '../widgets/result_cards.dart';
import '../widgets/body_visualizer.dart';
import '../widgets/meals_list.dart';
import '../widgets/exercises_list.dart';
import '../widgets/challenges.dart';
import '../widgets/articles.dart';
import '../widgets/user_progress.dart';
import '../widgets/notifications.dart';

class DashboardScreen extends StatelessWidget {
  final ScrollController scrollController;

  const DashboardScreen({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final ud = provider.userData;

    final bmi = Calculations.calculateBMI(ud.weight, ud.height);
    final bmr = Calculations.calculateBMR(ud.gender, ud.weight, ud.height, ud.age);
    final tdee = Calculations.calculateTDEE(bmr, ud.activityLevel);
    final targetCalories = Calculations.calculateTargetCalories(tdee, ud.goal);
    final macros = Calculations.calculateMacros(targetCalories, ud.dietType);
    final water = Calculations.calculateWaterIntake(ud.weight, ud.activityLevel);

    final results = {
      'bmi': bmi,
      'bmr': bmr,
      'tdee': tdee,
      'targetCalories': targetCalories,
      'macros': macros,
      'water': water,
    };

    final isWide = MediaQuery.of(context).size.width >= 1024;

    return Stack(
      children: [
        if (isWide)
          _buildDesktopLayout(context, provider, results, bmi)
        else
          _buildMobileLayout(context, provider, results, bmi),
        const NotificationsWidget(),
      ],
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    UserProvider provider,
    Map<String, dynamic> results,
    double bmi,
  ) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left sidebar
          Expanded(
            flex: 3,
            child: Column(
              children: [
                _buildHeroTitle(provider),
                const SizedBox(height: 20),
                BodyVisualizer(
                  bmi: bmi,
                  weight: provider.userData.weight,
                  height: provider.userData.height,
                ),
                const SizedBox(height: 20),
                const Challenges(),
              ],
            ),
          ),
          const SizedBox(width: 24),
          // Center content
          Expanded(
            flex: 6,
            child: Column(
              children: [
                ResultCards(results: results),
                const SizedBox(height: 24),
                const UserProgress(),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Expanded(child: MealsList()),
                    SizedBox(width: 20),
                    Expanded(child: ExercisesList()),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          // Right sidebar
          Expanded(
            flex: 3,
            child: Column(
              children: [
                FormUserData(
                  onCalculate: () {
                    // Auto-scroll after calculation
                    Scrollable.ensureVisible(
                      context,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Articles(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    UserProvider provider,
    Map<String, dynamic> results,
    double bmi,
  ) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          _buildHeroTitle(provider),
          const SizedBox(height: 20),
          ResultCards(results: results),
          const SizedBox(height: 20),
          BodyVisualizer(
            bmi: bmi,
            weight: provider.userData.weight,
            height: provider.userData.height,
          ),
          const SizedBox(height: 20),
          FormUserData(
            onCalculate: () {
              Scrollable.ensureVisible(
                context,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
          const SizedBox(height: 20),
          const UserProgress(),
          const SizedBox(height: 20),
          const MealsList(),
          const SizedBox(height: 20),
          const ExercisesList(),
          const SizedBox(height: 20),
          const Challenges(),
          const SizedBox(height: 20),
          const Articles(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildHeroTitle(UserProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (provider.isArabic)
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'صحتك، ',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
                TextSpan(
                  text: 'بذكاء.',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                    color: provider.isDark ? const Color(0xFF3B82F6) : const Color(0xFF2563EB),
                  ),
                ),
              ],
            ),
          )
        else
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Health, ',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
                TextSpan(
                  text: 'Smarter.',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                    color: provider.isDark ? const Color(0xFF3B82F6) : const Color(0xFF2563EB),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
