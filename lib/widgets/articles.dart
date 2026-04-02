import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';
import '../utils/design_tokens.dart';

class Articles extends StatelessWidget {
  const Articles({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final isDark = provider.isDark;
    final articlesData = provider.articles;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.book_rounded, color: AppTokens.primaryBlue, size: 28),
            const SizedBox(width: AppTokens.space12),
            Text(
              provider.t('healthInsights'),
              style: TextStyle(
                fontFamily: AppTokens.fontFamily,
                fontSize: AppTokens.fontH3,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...articlesData.map((art) => _buildArticleCardFromMap(art, provider, isDark)),
      ],
    );
  }

  Widget _buildArticleCardFromMap(Map<String, String> art, UserProvider provider, bool isDark) {
    final title = provider.isArabic ? art['titleAr']! : art['titleEn']!;
    final category = provider.isArabic ? art['categoryAr']! : art['categoryEn']!;

    return Container(
      margin: const EdgeInsets.only(bottom: AppTokens.space12),
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
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.primaryBlue.withValues(alpha: 0.3),
                      AppTheme.accentIndigo.withValues(alpha: 0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: Icon(Icons.article, color: Colors.white, size: 48),
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
            padding: const EdgeInsets.all(AppTokens.space16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: AppTokens.fontFamily,
                      fontSize: AppTokens.fontBody,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppTokens.darkTextPrimary : AppTokens.lightTextPrimary,
                      height: 1.5,
                    ),
                  ),
                ),
                Icon(
                  provider.isArabic ? Icons.arrow_back_rounded : Icons.arrow_forward_rounded, 
                  size: 16, 
                  color: isDark ? AppTokens.darkTextSecondary : AppTokens.lightTextSecondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
