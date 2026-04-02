import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';

class BodyVisualizer extends StatefulWidget {
  final double bmi;
  final double weight;
  final double height;

  const BodyVisualizer({
    super.key,
    required this.bmi,
    required this.weight,
    required this.height,
  });

  @override
  State<BodyVisualizer> createState() => _BodyVisualizerState();
}

class _BodyVisualizerState extends State<BodyVisualizer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    // Defer animation start to avoid overwhelming the first frame render
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => _isReady = true);
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final isDark = provider.isDark;

    final bodyThickness = (widget.bmi / 25.0).clamp(0.7, 1.5);
    final heightScale = (widget.height / 170.0).clamp(0.85, 1.15);

    return Container(
      height: 320,
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
      child: !_isReady
          ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
          : AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _BodyPainter(
              bodyThickness: bodyThickness,
              heightScale: heightScale,
              animationValue: _controller.value,
              isDark: isDark,
              primaryColor: AppTheme.primaryBlue,
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatChip(
                        Icons.monitor_weight_rounded,
                        '${widget.weight} kg',
                        isDark,
                      ),
                      _buildStatChip(
                        Icons.height_rounded,
                        '${widget.height.toInt()} cm',
                        isDark,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'BMI ${widget.bmi}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: const Color(0xFF94A3B8)),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }
}

class _BodyPainter extends CustomPainter {
  final double bodyThickness;
  final double heightScale;
  final double animationValue;
  final bool isDark;
  final Color primaryColor;

  _BodyPainter({
    required this.bodyThickness,
    required this.heightScale,
    required this.animationValue,
    required this.isDark,
    required this.primaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 - 10);
    final floatOffset = sin(animationValue * 2 * pi) * 4;

    final bodyPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;

    final glowPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);

    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.1)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

    final baseY = center.dy + floatOffset;

    // Contact shadow
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx, baseY + 130 * heightScale),
        width: 60 * bodyThickness,
        height: 8,
      ),
      shadowPaint,
    );

    // Head
    final headRadius = 22.0 * bodyThickness;
    final headCenter = Offset(center.dx, baseY - 95 * heightScale);
    canvas.drawCircle(headCenter, headRadius + 10, glowPaint);
    canvas.drawCircle(headCenter, headRadius, bodyPaint);

    // Neck
    final neckWidth = 10.0 * bodyThickness;
    _drawRoundedRect(canvas, bodyPaint,
      center.dx - neckWidth, baseY - 73 * heightScale,
      neckWidth * 2, 18 * heightScale,
    );

    // Torso
    final torsoWidth = 40.0 * bodyThickness;
    final torsoTop = baseY - 55 * heightScale;
    final torsoHeight = 85.0 * heightScale;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(center.dx - torsoWidth, torsoTop, torsoWidth * 2, torsoHeight),
        const Radius.circular(12),
      ),
      glowPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(center.dx - torsoWidth, torsoTop, torsoWidth * 2, torsoHeight),
        const Radius.circular(12),
      ),
      bodyPaint,
    );

    // Left arm
    _drawLimb(canvas, bodyPaint, glowPaint,
      Offset(center.dx - torsoWidth - 2, torsoTop + 5),
      const Offset(-28, 45),
      14 * bodyThickness,
    );

    // Right arm
    _drawLimb(canvas, bodyPaint, glowPaint,
      Offset(center.dx + torsoWidth + 2, torsoTop + 5),
      const Offset(28, 45),
      14 * bodyThickness,
    );

    // Left leg
    final legTop = torsoTop + torsoHeight;
    _drawLimb(canvas, bodyPaint, glowPaint,
      Offset(center.dx - 14, legTop),
      Offset(-12, 70 * heightScale),
      16 * bodyThickness,
    );

    // Right leg
    _drawLimb(canvas, bodyPaint, glowPaint,
      Offset(center.dx + 14, legTop),
      Offset(12, 70 * heightScale),
      16 * bodyThickness,
    );
  }

  void _drawRoundedRect(Canvas canvas, Paint paint, double x, double y, double w, double h) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, w, h),
        const Radius.circular(6),
      ),
      paint,
    );
  }

  void _drawLimb(Canvas canvas, Paint paint, Paint glowPaint, Offset start, Offset offset, double width) {
    final end = start + offset;
    final path = Path();
    final perpX = -offset.dy / offset.distance * width;
    final perpY = offset.dx / offset.distance * width;

    path.moveTo(start.dx + perpX, start.dy + perpY);
    path.lineTo(end.dx + perpX * 0.5, end.dy + perpY * 0.5);
    path.lineTo(end.dx - perpX * 0.5, end.dy - perpY * 0.5);
    path.lineTo(start.dx - perpX, start.dy - perpY);
    path.close();

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BodyPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.bodyThickness != bodyThickness ||
        oldDelegate.isDark != isDark;
  }
}
