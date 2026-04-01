import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';

class ResultCards extends StatelessWidget {
  final Map<String, dynamic> results;

  const ResultCards({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final isDark = provider.isDark;

    final cards = [
      _CardData(
        title: provider.t('bmi'),
        value: results['bmi'].toString(),
        unit: '',
        icon: Icons.analytics_rounded,
        color: AppTheme.primaryBlue,
        gradientColors: [AppTheme.primaryBlue, AppTheme.accentIndigo],
      ),
      _CardData(
        title: provider.t('calories'),
        value: results['targetCalories'].toString(),
        unit: 'kcal',
        icon: Icons.local_fire_department_rounded,
        color: AppTheme.orange,
        gradientColors: [AppTheme.orange, AppTheme.red],
      ),
      _CardData(
        title: provider.t('water'),
        value: (results['water'] / 1000).toStringAsFixed(1),
        unit: 'L',
        icon: Icons.water_drop_rounded,
        color: AppTheme.cyan,
        gradientColors: [AppTheme.cyan, AppTheme.primaryBlue],
      ),
      _CardData(
        title: provider.t('tdee'),
        value: results['tdee'].toString(),
        unit: 'kcal',
        icon: Icons.bolt_rounded,
        color: AppTheme.amber,
        gradientColors: [AppTheme.amber, AppTheme.orange],
      ),
    ];

    final macros = results['macros'] as Map<String, int>;
    final totalMacros = macros['protein']! + macros['carbs']! + macros['fat']!;

    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.4,
          ),
          itemCount: cards.length,
          itemBuilder: (context, index) {
            return _buildCard(cards[index], isDark);
          },
        ),
        const SizedBox(height: 20),
        _buildMacrosCard(provider, macros, totalMacros, isDark),
      ],
    );
  }

  Widget _buildCard(_CardData card, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF1E293B).withValues(alpha: 0.4),
                  const Color(0xFF0F172A).withValues(alpha: 0.4),
                ]
              : [
                  Colors.white.withValues(alpha: 0.9),
                  Colors.grey.shade50.withValues(alpha: 0.9),
                ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: card.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(card.icon, color: card.color, size: 22),
          ),
          const Spacer(),
          Text(
            card.title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
              letterSpacing: 0.1,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                card.value,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              if (card.unit.isNotEmpty) ...[
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    card.unit,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacrosCard(UserProvider provider, Map<String, int> macros, int total, bool isDark) {
    final macroItems = [
      _MacroData(label: provider.t('protein'), value: macros['protein']!, color: AppTheme.emerald),
      _MacroData(label: provider.t('carbs'), value: macros['carbs']!, color: AppTheme.primaryBlue),
      _MacroData(label: provider.t('fats'), value: macros['fat']!, color: AppTheme.amber),
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF1E293B).withValues(alpha: 0.4),
                  const Color(0xFF0F172A).withValues(alpha: 0.4),
                ]
              : [
                  Colors.white.withValues(alpha: 0.9),
                  Colors.grey.shade50.withValues(alpha: 0.9),
                ],
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${provider.t('results')} ${provider.t('protein').toLowerCase() == 'protein' ? 'Macros' : 'الماكرو'}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              Text(
                provider.t('gramsPerDay'),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...macroItems.map((macro) => _buildMacroBar(macro, total, isDark)),
        ],
      ),
    );
  }

  Widget _buildMacroBar(_MacroData macro, int total, bool isDark) {
    final percentage = total > 0 ? macro.value / total : 0.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                macro.label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                  letterSpacing: 0.05,
                ),
              ),
              Text(
                '${macro.value}g',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: percentage),
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 10,
                  backgroundColor: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(macro.color),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CardData {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;
  final List<Color> gradientColors;

  _CardData({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    required this.gradientColors,
  });
}

class _MacroData {
  final String label;
  final int value;
  final Color color;

  _MacroData({required this.label, required this.value, required this.color});
}
