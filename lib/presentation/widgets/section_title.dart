import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'animated_fade_in.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Duration delay;
  final TextAlign textAlign;
  final bool useGradient;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.delay = const Duration(milliseconds: 200),
    this.textAlign = TextAlign.center,
    this.useGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedFadeIn(
      duration: const Duration(milliseconds: 600),
      delay: delay,
      child: Column(
        crossAxisAlignment: textAlign == TextAlign.center
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          // No gradient on section title text - solid color only
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : AppColors.lightModeText,
                ),
            textAlign: textAlign,
          ),
          const SizedBox(height: 16),
          Container(
            width: 80,
            height: 4,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0553B1), Color(0xFF54C5F8)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          if (subtitle != null) const SizedBox(height: 20),
          if (subtitle != null)
            Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).hintColor,
                    height: 1.6,
                  ),
              textAlign: textAlign,
            ),
        ],
      ),
    );
  }
}
