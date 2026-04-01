import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';

class Articles extends StatelessWidget {
  const Articles({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final isDark = provider.isDark;

    final articles = [
      _ArticleData(
        titleAr: 'كيف تزيد من معدل حرق الدهون؟',
        titleEn: 'How to increase your metabolic rate?',
        categoryAr: 'تغذية',
        categoryEn: 'Nutrition',
        image: 'https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=500',
      ),
      _ArticleData(
        titleAr: 'أفضل 5 تمارين لتقوية الظهر',
        titleEn: 'Top 5 back strength exercises',
        categoryAr: 'تمارين',
        categoryEn: 'Workouts',
        image: 'https://images.unsplash.com/photo-1541534741688-6078c65b5a33?w=500',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.book_rounded, color: AppTheme.primaryBlue, size: 28),
            const SizedBox(width: 10),
            Text(
              provider.t('healthInsights'),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...articles.map((art) => _buildArticleCard(art, provider, isDark)),
      ],
    );
  }

  Widget _buildArticleCard(_ArticleData art, UserProvider provider, bool isDark) {
    final title = provider.isArabic ? art.titleAr : art.titleEn;
    final category = provider.isArabic ? art.categoryAr : art.categoryEn;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                art.image,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 140,
                  color: Colors.grey.shade800,
                  child: const Icon(Icons.image, color: Colors.white, size: 48),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.6),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: provider.isArabic ? null : 12,
                left: provider.isArabic ? 12 : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                      height: 1.5,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_rounded, size: 16, color: Color(0xFF94A3B8)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ArticleData {
  final String titleAr;
  final String titleEn;
  final String categoryAr;
  final String categoryEn;
  final String image;

  _ArticleData({
    required this.titleAr,
    required this.titleEn,
    required this.categoryAr,
    required this.categoryEn,
    required this.image,
  });
}
