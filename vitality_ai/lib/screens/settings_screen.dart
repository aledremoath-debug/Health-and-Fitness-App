import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _activeTab = 'profile';
  bool _savedFeedback = false;

  void _handleSave() {
    setState(() => _savedFeedback = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _savedFeedback = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final isDark = provider.isDark;
    final t = provider.t;
    final isWide = MediaQuery.of(context).size.width >= 1024;

    final menuItems = [
      _MenuItem(id: 'profile', icon: Icons.person_rounded, label: t('profile')),
      _MenuItem(id: 'notifications', icon: Icons.notifications_rounded, label: t('notifications')),
      _MenuItem(id: 'appearance', icon: Icons.dark_mode_rounded, label: t('appearance')),
      _MenuItem(id: 'language', icon: Icons.language_rounded, label: t('language')),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t('settings'),
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Fine-tune your vitality experience.',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                    ),
                  ),
                ],
              ),
              if (_savedFeedback)
                Row(
                  children: [
                    const Icon(Icons.check_circle_rounded, color: AppTheme.emerald, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      t('savedSuccess'),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.emerald,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
            ],
          ),

          const SizedBox(height: 28),

          if (isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sidebar
                SizedBox(
                  width: 240,
                  child: Column(
                    children: menuItems.map((item) => _buildMenuButton(item, isDark)).toList(),
                  ),
                ),
                const SizedBox(width: 24),
                // Content
                Expanded(child: _buildContent(provider, isDark)),
              ],
            )
          else ...[
            // Mobile tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: menuItems.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _buildMenuButton(item, isDark),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            _buildContent(provider, isDark),
          ],
        ],
      ),
    );
  }

  Widget _buildMenuButton(_MenuItem item, bool isDark) {
    final isActive = _activeTab == item.id;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = item.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.primaryBlue
              : (isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.grey.shade100),
          borderRadius: BorderRadius.circular(20),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppTheme.primaryBlue.withValues(alpha: 0.3),
                    blurRadius: 12,
                  ),
                ]
              : null,
          border: !isActive
              ? Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.transparent,
                )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              size: 18,
              color: isActive
                  ? Colors.white
                  : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569)),
            ),
            const SizedBox(width: 10),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.05,
                color: isActive
                    ? Colors.white
                    : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(UserProvider provider, bool isDark) {
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
      child: _buildTabContent(provider, isDark),
    );
  }

  Widget _buildTabContent(UserProvider provider, bool isDark) {
    switch (_activeTab) {
      case 'profile':
        return _buildProfileTab(provider, isDark);
      case 'notifications':
        return _buildNotificationsTab(provider, isDark);
      case 'appearance':
        return _buildAppearanceTab(provider, isDark);
      case 'language':
        return _buildLanguageTab(provider, isDark);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildProfileTab(UserProvider provider, bool isDark) {
    final nameController = TextEditingController(text: provider.userData.name);
    final emailController = TextEditingController(text: provider.userData.email);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar row
        Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primaryBlue, AppTheme.accentIndigo],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(3),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.network(
                  'https://api.dicebear.com/7.x/avataaars/svg?seed=${provider.userData.name}',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: isDark ? const Color(0xFF0F172A) : Colors.grey.shade200,
                    child: const Icon(Icons.person, size: 36),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.userData.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  provider.t('premiumMember'),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryBlue,
                    letterSpacing: 0.1,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Update Avatar',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.primaryBlue,
                      letterSpacing: 0.05,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 28),
        Divider(color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey.shade200),
        const SizedBox(height: 20),

        // Name field
        _buildFieldLabel(provider.t('fullName'), isDark),
        const SizedBox(height: 8),
        TextField(
          controller: nameController,
          onSubmitted: (v) => provider.updateUserData({'name': v}),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
          decoration: InputDecoration(
            hintText: provider.userData.name,
          ),
        ),

        const SizedBox(height: 16),

        // Email field
        _buildFieldLabel(provider.t('email'), isDark),
        const SizedBox(height: 8),
        TextField(
          controller: emailController,
          onSubmitted: (v) => provider.updateUserData({'email': v}),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
          decoration: InputDecoration(
            hintText: provider.userData.email,
          ),
        ),

        const SizedBox(height: 24),

        // Save button
        ElevatedButton.icon(
          onPressed: _handleSave,
          icon: const Icon(Icons.save_rounded, size: 18),
          label: Text(
            provider.t('saveChanges'),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.05,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            elevation: 8,
            shadowColor: AppTheme.primaryBlue.withValues(alpha: 0.4),
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationsTab(UserProvider provider, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          provider.t('notifications'),
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 20),
        _buildNotifToggle(
          provider,
          'water',
          provider.t('hydrationEngine'),
          provider.t('hydrationDesc'),
          isDark,
        ),
        const SizedBox(height: 10),
        _buildNotifToggle(
          provider,
          'exercise',
          provider.t('activePerformance'),
          provider.t('performanceDesc'),
          isDark,
        ),
      ],
    );
  }

  Widget _buildNotifToggle(
    UserProvider provider,
    String key,
    String title,
    String desc,
    bool isDark,
  ) {
    final isEnabled = key == 'water'
        ? provider.userData.notifications.water
        : provider.userData.notifications.exercise;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.05,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => provider.toggleNotification(key),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 52,
              height: 28,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: isEnabled ? AppTheme.primaryBlue : const Color(0xFF334155),
                borderRadius: BorderRadius.circular(100),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                alignment: isEnabled ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppearanceTab(UserProvider provider, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          provider.t('appearance'),
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildThemeOption(
                provider,
                'dark',
                provider.t('darkMode'),
                isDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildThemeOption(
                provider,
                'light',
                provider.t('lightMode'),
                isDark,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildThemeOption(UserProvider provider, String theme, String label, bool isDark) {
    final isSelected = provider.userData.theme == theme;
    final isDarkOption = theme == 'dark';

    return GestureDetector(
      onTap: () => provider.updateUserData({'theme': theme}),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryBlue.withValues(alpha: 0.5)
                : (isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.black.withValues(alpha: 0.05)),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                    blurRadius: 8,
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: isDarkOption ? const Color(0xFF020617) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDarkOption
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.grey.shade200,
                ),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 80,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isDarkOption
                          ? Colors.white.withValues(alpha: 0.1)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.1,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageTab(UserProvider provider, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          provider.t('language'),
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 20),
        _buildLangOption(provider, 'ar', 'العربية', '🇸🇦', isDark),
        const SizedBox(height: 10),
        _buildLangOption(provider, 'en', 'English', '🇺🇸', isDark),
      ],
    );
  }

  Widget _buildLangOption(
    UserProvider provider,
    String lang,
    String label,
    String flag,
    bool isDark,
  ) {
    final isSelected = provider.userData.language == lang;

    return GestureDetector(
      onTap: () => provider.updateUserData({'language': lang}),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryBlue.withValues(alpha: 0.05)
              : (isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.grey.shade100),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryBlue.withValues(alpha: 0.5)
                : (isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.black.withValues(alpha: 0.05)),
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 14),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.05,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            const Spacer(),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.check_rounded, size: 18, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label, bool isDark) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w900,
        letterSpacing: 0.1,
        color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
      ),
    );
  }
}

class _MenuItem {
  final String id;
  final IconData icon;
  final String label;

  _MenuItem({required this.id, required this.icon, required this.label});
}
