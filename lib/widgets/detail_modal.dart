import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';
import '../utils/design_tokens.dart';

class DetailModal extends StatelessWidget {
  final dynamic data;
  final String type;

  const DetailModal({super.key, required this.data, required this.type});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final isDark = provider.isDark;
    final lang = provider.userData.language;

    if (data == null) return const SizedBox.shrink();

    final name = (data.name[lang] ?? data.name['en']) as String;
    final calories = data.calories as int;

    List<String> items = [];
    String itemsTitle = '';
    List<String> steps = [];
    String stepsTitle = '';

    if (type == 'meal') {
      items = List<String>.from(data.ingredients[lang] ?? data.ingredients['en'] ?? []);
      itemsTitle = provider.t('ingredients');
      steps = List<String>.from(data.steps[lang] ?? data.steps['en'] ?? []);
      stepsTitle = provider.t('steps');
    } else {
      itemsTitle = provider.t('muscle');
      steps = List<String>.from(data.instructions[lang] ?? data.instructions['en'] ?? []);
      stepsTitle = provider.t('instructions');
    }

    final muscleName = type == 'exercise' ? (data.muscle[lang] ?? data.muscle['en']) as String : '';
    final duration = type == 'exercise' ? data.duration as String : '';

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Semantics(
          label: provider.isArabic ? 'نافذة تفاصيل' : 'Detail Modal',
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? AppTokens.darkSurface : AppTokens.lightSurface,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(AppTokens.radius32)),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.08)
                    : Colors.black.withOpacity(0.05),
              ),
              boxShadow: isDark ? AppTokens.shadowDark : AppTokens.shadowLight,
            ),
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.zero,
              children: [
                // Header image
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(AppTokens.radius32)),
                      child: Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: type == 'meal'
                                ? [AppTheme.primaryBlue.withValues(alpha: 0.4), AppTheme.emerald.withValues(alpha: 0.4)]
                                : [AppTheme.accentIndigo.withValues(alpha: 0.4), AppTheme.primaryBlue.withValues(alpha: 0.4)],
                          ),
                        ),
                        child: Icon(
                          type == 'meal' ? Icons.restaurant : Icons.fitness_center,
                          color: Colors.white,
                          size: 64,
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            isDark ? const Color(0xFF0F172A) : Colors.white,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: AppTokens.space16,
                    right: provider.isArabic ? null : AppTokens.space16,
                    left: provider.isArabic ? AppTokens.space16 : null,
                    child: Semantics(
                      label: provider.t('close'),
                      button: true,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: AppTokens.minTouchTarget,
                          height: AppTokens.minTouchTarget,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: AppTokens.borderRadius16,
                          ),
                          child: const Icon(Icons.close_rounded, color: Colors.white, size: 24),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and meta
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.local_fire_department_rounded, size: 16, color: AppTheme.orange),
                                  const SizedBox(width: 6),
                                  Text(
                                    '$calories ${provider.t('caloriesBurn')}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                                      letterSpacing: 0.1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (type == 'exercise')
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppTheme.accentIndigo.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              duration,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                color: AppTheme.accentIndigo,
                              ),
                            ),
                          ),
                        if (type == 'meal') ...[
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'P:${data.macros['p']} C:${data.macros['c']} F:${data.macros['f']}',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                color: AppTheme.primaryBlue,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),

                    const SizedBox(height: 28),

                    // Two-column layout
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left: Ingredients/Muscle
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionHeader(itemsTitle, Icons.restaurant_rounded, isDark),
                              const SizedBox(height: 12),
                              if (type == 'meal')
                                ...items.map((item) => _buildBulletItem(item, isDark))
                              else
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryBlue.withValues(alpha: 0.05),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: AppTheme.primaryBlue.withValues(alpha: 0.1)),
                                  ),
                                  child: Text(
                                    muscleName,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                      color: AppTheme.primaryBlue,
                                      letterSpacing: 0.1,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Right: Steps
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionHeader(stepsTitle, Icons.schedule_rounded, isDark),
                              const SizedBox(height: 12),
                              ...steps.asMap().entries.map((entry) =>
                                  _buildStepItem(entry.key + 1, entry.value, isDark)),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Close button
                    SizedBox(
                      width: double.infinity,
                      height: AppTokens.minTouchTarget,
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: isDark
                                ? Colors.white.withOpacity(0.1)
                                : Colors.black.withOpacity(0.1),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: AppTokens.borderRadius32,
                          ),
                        ),
                        child: Text(
                          provider.t('close'),
                          style: TextStyle(
                            fontFamily: AppTokens.fontFamily,
                            fontSize: AppTokens.fontBody,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.1,
                            color: isDark ? AppTokens.darkTextPrimary : AppTokens.lightTextPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, bool isDark) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 14, color: AppTheme.primaryBlue),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : const Color(0xFF0F172A),
              letterSpacing: 0.1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBulletItem(String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppTheme.primaryBlue,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x803B82F6),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(int number, String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x4D3B82F6),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
