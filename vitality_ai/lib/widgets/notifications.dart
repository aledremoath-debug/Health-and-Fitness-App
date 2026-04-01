import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({super.key});

  @override
  State<NotificationsWidget> createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  final List<_NotifData> _notifications = [
    _NotifData(
      id: 1,
      message: 'حان وقت شرب الماء! حافظ على رطوبة جسمك.',
      icon: Icons.water_drop_rounded,
      color: AppTheme.primaryBlue,
    ),
    _NotifData(
      id: 2,
      message: 'متبقي لك 30 دقيقة من تمرين اليوم.',
      icon: Icons.fitness_center_rounded,
      color: AppTheme.accentIndigo,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<UserProvider>().isDark;

    if (_notifications.isEmpty) return const SizedBox.shrink();

    return Positioned(
      bottom: 80,
      right: 16,
      left: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _notifications.map((n) => _buildNotifCard(n, isDark)).toList(),
      ),
    );
  }

  Widget _buildNotifCard(_NotifData notif, bool isDark) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF0F172A).withValues(alpha: 0.9)
            : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: notif.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(notif.icon, color: notif.color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'reminder',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                    letterSpacing: 0.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  notif.message,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _notifications.removeWhere((n) => n.id == notif.id);
              });
            },
            child: Icon(
              Icons.close_rounded,
              size: 16,
              color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotifData {
  final int id;
  final String message;
  final IconData icon;
  final Color color;

  _NotifData({
    required this.id,
    required this.message,
    required this.icon,
    required this.color,
  });
}
