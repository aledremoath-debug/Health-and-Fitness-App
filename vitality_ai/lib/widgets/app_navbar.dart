import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';

class AppNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final isDark = provider.isDark;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF050508).withValues(alpha: 0.7)
            : Colors.white.withValues(alpha: 0.7),
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.05),
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              _buildLogo(provider),
              const Spacer(),
              _buildDesktopNav(context, provider),
              const SizedBox(width: 16),
              _buildProfile(context, provider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(UserProvider provider) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.primaryBlue, AppTheme.accentIndigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryBlue.withValues(alpha: 0.3),
                blurRadius: 12,
              ),
            ],
          ),
          child: const Icon(Icons.favorite, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 12),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppTheme.primaryBlue, AppTheme.accentIndigo],
          ).createShader(bounds),
          child: Text(
            provider.t('appName'),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopNav(BuildContext context, UserProvider provider) {
    final items = [
      {'icon': Icons.dashboard_rounded, 'label': provider.t('dashboard')},
      {'icon': Icons.bar_chart_rounded, 'label': provider.t('reports')},
      {'icon': Icons.settings_rounded, 'label': provider.t('settings')},
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (MediaQuery.of(context).size.width < 768) {
          return const SizedBox.shrink();
        }
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Row(
            children: List.generate(items.length, (index) {
              final isActive = currentIndex == index;
              return GestureDetector(
                onTap: () => onTap(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(
                    color: isActive ? AppTheme.primaryBlue : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: AppTheme.primaryBlue.withValues(alpha: 0.3),
                              blurRadius: 12,
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        items[index]['icon'] as IconData,
                        size: 18,
                        color: isActive
                            ? Colors.white
                            : (provider.isDark
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF475569)),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        items[index]['label'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.05,
                          color: isActive
                              ? Colors.white
                              : (provider.isDark
                                  ? const Color(0xFF94A3B8)
                                  : const Color(0xFF475569)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Widget _buildProfile(BuildContext context, UserProvider provider) {
    return Row(
      children: [
        if (MediaQuery.of(context).size.width >= 640) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                provider.userData.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: provider.isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const Text(
                'Premium Member',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryBlue,
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
        ],
        GestureDetector(
          onTap: () => onTap(2),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://api.dicebear.com/7.x/avataaars/svg?seed=${provider.userData.name}',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 22),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final isDark = provider.isDark;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF050508).withValues(alpha: 0.9)
            : Colors.white.withValues(alpha: 0.9),
        border: Border(
          top: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.05),
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.dashboard_rounded, provider.t('dashboard'), provider),
              _buildNavItem(1, Icons.bar_chart_rounded, provider.t('reports'), provider),
              _buildNavItem(2, Icons.settings_rounded, provider.t('settings'), provider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, UserProvider provider) {
    final isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: isActive ? 20 : 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? Colors.white : const Color(0xFF94A3B8),
            ),
            if (isActive) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
