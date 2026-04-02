import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';
import '../utils/design_tokens.dart';
import 'progress_charts.dart';

class UserProgress extends StatefulWidget {
  const UserProgress({super.key});

  @override
  State<UserProgress> createState() => _UserProgressState();
}

class _UserProgressState extends State<UserProgress> {
  int _selectedDays = 7;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final isDark = provider.isDark;
    final progressData = provider.progressData;
    final filteredProgress = progressData.length > _selectedDays
        ? progressData.sublist(progressData.length - _selectedDays)
        : progressData;

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTokens.emerald.withOpacity(0.1),
                      borderRadius: AppTokens.borderRadius16,
                    ),
                    child: const Icon(Icons.trending_up_rounded, color: AppTokens.emerald, size: 24),
                  ),
                  const SizedBox(width: AppTokens.space12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.t('progress'),
                        style: TextStyle(
                          fontFamily: AppTokens.fontFamily,
                          fontSize: AppTokens.fontH3,
                          fontWeight: FontWeight.w700,
                          color: isDark ? AppTokens.darkTextPrimary : AppTokens.lightTextPrimary,
                        ),
                      ),
                      Text(
                        provider.isArabic ? 'رؤية رحلة لياقتك' : 'Visualizing your fitness journey',
                        style: TextStyle(
                          fontFamily: AppTokens.fontFamily,
                          fontSize: AppTokens.fontBodySmall,
                          fontWeight: FontWeight.w500,
                          color: isDark ? AppTokens.darkTextSecondary : AppTokens.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      provider.updateUserData({'language': provider.isArabic ? 'en' : 'ar'});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(AppTokens.space8),
                      margin: const EdgeInsets.only(right: AppTokens.space12),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.shade100,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        provider.isArabic ? 'EN' : 'AR',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppTokens.fontCaption,
                          color: isDark ? AppTokens.darkTextPrimary : AppTokens.lightTextPrimary,
                        ),
                      ),
                    ),
                  ),
                  _buildRangeChip(7, provider.t('last7Days'), isDark),
                  const SizedBox(width: 6),
                  _buildRangeChip(14, provider.isArabic ? 'آخر 14 يوم' : 'Last 14 Days', isDark),
                  const SizedBox(width: 6),
                  _buildRangeChip(30, provider.isArabic ? 'آخر 30 يوم' : 'Last 30 Days', isDark),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: _buildChartCard(
                provider.t('weightTrend'),
                SizedBox(
                  height: 200,
                  child: WeightChart(data: filteredProgress),
                ),
                isDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildChartCard(
                provider.t('calorieTrend'),
                SizedBox(
                  height: 200,
                  child: CaloriesChart(data: filteredProgress),
                ),
                isDark,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(AppTokens.space20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTokens.primaryBlue, AppTokens.accentIndigo],
            ),
            borderRadius: AppTokens.borderRadius32,
            boxShadow: [
              BoxShadow(
                color: AppTokens.primaryBlue.withOpacity(0.3),
                blurRadius: 16,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.emoji_events_rounded, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      provider.t('achievement'),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      provider.achievementText,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  final progressData = provider.progressData;
                  final report = StringBuffer();
                  report.writeln('${provider.t('appName')} - ${provider.t('progress')}');
                  report.writeln('');
                  for (final day in progressData) {
                    report.writeln('${day['day']}: ${day['weight']}kg | ${day['calories']}kcal');
                  }
                  report.writeln('');
                  report.writeln('${provider.t('achievement')}: ${provider.achievementText}');
                  Share.share(report.toString());
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppTokens.space16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: AppTokens.borderRadius16,
                  ),
                  child: const Text(
                    'Download Report',
                    style: TextStyle(
                      fontFamily: AppTokens.fontFamily,
                      fontSize: AppTokens.fontCaption,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 0.05,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChartCard(String title, Widget chart, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppTokens.space16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  AppTokens.darkSurface.withOpacity(0.8),
                  AppTokens.darkBackground.withOpacity(0.8),
                ]
              : [
                  Colors.white.withOpacity(0.9),
                  AppTokens.lightBackground.withOpacity(0.9),
                ],
        ),
        borderRadius: AppTokens.borderRadius24,
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.05),
        ),
        boxShadow: isDark ? AppTokens.shadowDark : AppTokens.shadowLight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
              letterSpacing: 0.1,
            ),
          ),
          const SizedBox(height: 12),
          chart,
        ],
      ),
    );
  }

  Widget _buildRangeChip(int days, String label, bool isDark) {
    final isSelected = _selectedDays == days;
    return GestureDetector(
      onTap: () => setState(() => _selectedDays = days),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryBlue
              : (isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey.shade100),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryBlue
                : (isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05)),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_today_rounded,
              size: 12,
              color: isSelected ? Colors.white : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569)),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
