import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';
import '../utils/design_system.dart';
import '../widgets/progress_charts.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int _selectedTimeRange = 7;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final isDark = provider.isDark;
    final t = provider.t;

    final progressData = provider.getProgressData(_selectedTimeRange);
    final weeklyData = provider.weeklyCalories;
    final macroData = provider.macroChartData;

    final isWide = MediaQuery.of(context).size.width >= DesignSystem.breakpointLg;
    final isTablet = MediaQuery.of(context).size.width >= DesignSystem.breakpointMd && !isWide;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 48 : (isTablet ? 32 : 16),
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(t, isDark, isWide, provider),
          const SizedBox(height: 32),
          _buildTimeRangeSelector(t, isDark, isWide),
          const SizedBox(height: 28),
          if (isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildBarChartCard(t, isDark, weeklyData, isWide),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: _buildPieChartCard(t, isDark, macroData, isWide),
                ),
              ],
            )
          else ...[
            _buildBarChartCard(t, isDark, weeklyData, isWide),
            const SizedBox(height: 24),
            _buildPieChartCard(t, isDark, macroData, isWide),
          ],
          const SizedBox(height: 28),
          _buildSummaryCards(t, isDark, provider, progressData),
        ],
      ),
    );
  }

  Widget _buildHeader(String Function(String) t, bool isDark, bool isWide, UserProvider provider) {
    return Row(
      mainAxisAlignment: isWide ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                header: true,
                child: Text(
                  t('reports'),
                  style: DesignSystem.h1Text(isDark),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                t('deepDive'),
                style: DesignSystem.bodySmallText(isDark),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        _buildDownloadButton(t, isDark, provider, isWide),
      ],
    );
  }

  Widget _buildDownloadButton(String Function(String) t, bool isDark, UserProvider provider, bool isWide) {
    return Semantics(
      button: true,
      label: t('downloadReport'),
      child: ElevatedButton.icon(
        onPressed: () => _downloadReport(provider),
        icon: const Icon(Icons.download_rounded, size: 20),
        label: const Text('Download Report'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.orange,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? 32 : 24,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignSystem.radius3xl),
          ),
          elevation: 8,
          shadowColor: DesignSystem.primary500.withValues(alpha: 0.4),
          textStyle: const TextStyle(
            fontFamily: DesignSystem.fontFamily,
            fontSize: DesignSystem.textSm,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildTimeRangeSelector(String Function(String) t, bool isDark, bool isWide) {
    final ranges = [
      {'value': 7, 'label': t('last7DaysFilter')},
      {'value': 30, 'label': t('last30DaysFilter')},
      {'value': 90, 'label': t('last90DaysFilter')},
    ];

    return Semantics(
      label: t('progress'),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isDark 
              ? DesignSystem.darkSurfaceElevated 
              : DesignSystem.lightSurfaceElevated,
          borderRadius: BorderRadius.circular(DesignSystem.radiusLg),
          border: Border.all(
            color: isDark ? DesignSystem.darkBorder : DesignSystem.lightBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: ranges.map((range) {
            final isSelected = _selectedTimeRange == range['value'];
            return GestureDetector(
              onTap: () => setState(() => _selectedTimeRange = range['value'] as int),
              child: AnimatedContainer(
                duration: DesignSystem.durationFast,
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 20 : 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? DesignSystem.primary500 
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
                  boxShadow: isSelected ? DesignSystem.shadowPrimary : null,
                ),
                child: Text(
                  range['label'] as String,
                  style: TextStyle(
                    fontFamily: DesignSystem.fontFamily,
                    fontSize: DesignSystem.textSm,
                    fontWeight: FontWeight.w700,
                    color: isSelected 
                        ? Colors.white 
                        : (isDark ? DesignSystem.darkTextSecondary : DesignSystem.lightTextSecondary),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildBarChartCard(String Function(String) t, bool isDark, List<Map<String, dynamic>> data, bool isWide) {
    return Container(
      padding: const EdgeInsets.all(DesignSystem.space6),
      decoration: BoxDecoration(
        gradient: DesignSystem.getSurfaceGradient(isDark),
        borderRadius: BorderRadius.circular(DesignSystem.radius2xl),
        border: Border.all(
          color: isDark ? DesignSystem.darkBorder : DesignSystem.lightBorder,
        ),
        boxShadow: DesignSystem.getCardShadow(isDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t('calorieTrend'),
                style: DesignSystem.h3Text(isDark),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: DesignSystem.primary500.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
                ),
                child: Text(
                  t('weeklyOverview'),
                  style: DesignSystem.captionText(isDark).copyWith(
                    color: DesignSystem.primary500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: isWide ? 280 : 220,
            child: data.isNotEmpty
                ? BarChartWidget(data: data)
                : _buildEmptyState(t, isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChartCard(String Function(String) t, bool isDark, List<Map<String, dynamic>> macroData, bool isWide) {
    return Container(
      padding: const EdgeInsets.all(DesignSystem.space6),
      decoration: BoxDecoration(
        gradient: DesignSystem.getSurfaceGradient(isDark),
        borderRadius: BorderRadius.circular(DesignSystem.radius2xl),
        border: Border.all(
          color: isDark ? DesignSystem.darkBorder : DesignSystem.lightBorder,
        ),
        boxShadow: DesignSystem.getCardShadow(isDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t('macrosDistribution'),
                style: DesignSystem.h3Text(isDark),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: DesignSystem.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
                ),
                child: const Icon(
                  Icons.pie_chart_rounded, 
                  size: 20, 
                  color: DesignSystem.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: isWide ? 180 : 150,
            child: macroData.isNotEmpty
                ? PieChartWidget(data: macroData)
                : _buildEmptyState(t, isDark),
          ),
          const SizedBox(height: 20),
          ...macroData.map((item) => _buildMacroLegend(item, isDark)),
        ],
      ),
    );
  }

  Widget _buildMacroLegend(Map<String, dynamic> item, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark 
            ? Colors.white.withValues(alpha: 0.05) 
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(DesignSystem.radiusLg),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: item['color'] as Color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: (item['color'] as Color).withValues(alpha: 0.5),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item['name'] as String,
              style: TextStyle(
                fontFamily: DesignSystem.fontFamily,
                fontSize: DesignSystem.textSm,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.1,
                color: isDark ? DesignSystem.darkTextSecondary : DesignSystem.lightTextSecondary,
              ),
            ),
          ),
          Text(
            '${item['value']}%',
            style: TextStyle(
              fontFamily: DesignSystem.fontFamily,
              fontSize: DesignSystem.textLg,
              fontWeight: FontWeight.w900,
              color: isDark ? DesignSystem.darkTextPrimary : DesignSystem.lightTextPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(String Function(String) t, bool isDark, UserProvider provider, List<Map<String, dynamic>> progressData) {
    final results = provider.calculatedResults;
    
    return Container(
      padding: const EdgeInsets.all(DesignSystem.space6),
      decoration: BoxDecoration(
        gradient: DesignSystem.getSurfaceGradient(isDark),
        borderRadius: BorderRadius.circular(DesignSystem.radius2xl),
        border: Border.all(
          color: isDark ? DesignSystem.darkBorder : DesignSystem.lightBorder,
        ),
        boxShadow: DesignSystem.getCardShadow(isDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t('results'),
            style: DesignSystem.h3Text(isDark),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildSummaryItem(
                icon: Icons.analytics_rounded,
                color: DesignSystem.primary500,
                label: t('bmi'),
                value: results['bmi'].toString(),
                isDark: isDark,
              ),
              _buildSummaryItem(
                icon: Icons.local_fire_department_rounded,
                color: AppTheme.orange,
                label: t('tdee'),
                value: '${results['tdee']} kcal',
                isDark: isDark,
              ),
              _buildSummaryItem(
                icon: Icons.water_drop_rounded,
                color: AppTheme.cyan,
                label: t('water'),
                value: '${((results['water'] as int) / 1000).toStringAsFixed(1)}L',
                isDark: isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required IconData icon,
    required Color color,
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(DesignSystem.radiusLg),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: DesignSystem.textXs,
                  fontWeight: FontWeight.w700,
                  color: isDark ? DesignSystem.darkTextTertiary : DesignSystem.lightTextTertiary,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: DesignSystem.textBase,
                  fontWeight: FontWeight.w900,
                  color: isDark ? DesignSystem.darkTextPrimary : DesignSystem.lightTextPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String Function(String) t, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bar_chart_rounded,
            size: 48,
            color: isDark ? DesignSystem.darkTextTertiary : DesignSystem.lightTextTertiary,
          ),
          const SizedBox(height: 12),
          Text(
            t('noDataYet'),
            style: TextStyle(
              color: isDark ? DesignSystem.darkTextSecondary : DesignSystem.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  void _downloadReport(UserProvider provider) {
    final results = provider.calculatedResults;
    final t = provider.t;
    final isArabic = provider.isArabic;
    final progressData = provider.getProgressData(_selectedTimeRange);
    
    final bmi = results['bmi'];
    final tdee = results['tdee'];
    final targetCalories = results['targetCalories'];
    final macros = results['macros'] as Map<String, int>;
    final water = results['water'];

    final report = StringBuffer();
    report.writeln('═══════════════════════════════════════');
    report.writeln('  ${t('appName')} - ${t('reports')}');
    report.writeln('═══════════════════════════════════════');
    report.writeln('');
    report.writeln('📊 ${t('results')}:');
    report.writeln('  • ${t('bmi')}: $bmi');
    report.writeln('  • ${t('tdee')}: $tdee kcal');
    report.writeln('  • ${t('calories')}: $targetCalories kcal');
    report.writeln('  • ${t('water')}: ${(water / 1000).toStringAsFixed(1)}L');
    report.writeln('');
    report.writeln('🥗 ${isArabic ? 'الماكرو' : 'Macros'}:');
    report.writeln('  • ${t('protein')}: ${macros['protein']}g');
    report.writeln('  • ${t('carbs')}: ${macros['carbs']}g');
    report.writeln('  • ${t('fats')}: ${macros['fat']}g');
    report.writeln('');
    report.writeln('📈 ${t('progress')} (${_getTimeRangeLabel(_selectedTimeRange, isArabic)}):');
    for (final day in progressData) {
      report.writeln('  ${day['day']}: ${day['weight']}kg | ${day['calories']}kcal');
    }
    report.writeln('');
    report.writeln('═══════════════════════════════════════');
    report.writeln('  ${isArabic ? 'تاريخ التقرير' : t('reportDate')}: ${DateTime.now().toString().split('.')[0]}');
    report.writeln('═══════════════════════════════════════');

    Share.share(report.toString(), subject: '${t('appName')} - ${t('reports')}');
  }

  String _getTimeRangeLabel(int days, bool isArabic) {
    switch (days) {
      case 7:
        return isArabic ? 'آخر 7 أيام' : 'Last 7 Days';
      case 30:
        return isArabic ? 'آخر 30 يوم' : 'Last 30 Days';
      case 90:
        return isArabic ? 'آخر 90 يوم' : 'Last 90 Days';
      default:
        return '';
    }
  }
}