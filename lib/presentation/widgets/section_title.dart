// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'animated_fade_in.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Duration delay;
  final TextAlign textAlign;
  final bool useGradient;
  final String? tag;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.delay = const Duration(milliseconds: 100),
    this.textAlign = TextAlign.center,
    this.useGradient = false,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 600;

    return AnimatedFadeIn(
      duration: const Duration(milliseconds: 600),
      delay: delay,
      child: Column(
        crossAxisAlignment: textAlign == TextAlign.center
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          if (tag != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(isDark ? 0.15 : 0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primary.withOpacity(0.25)),
              ),
              child: Text(
                tag!,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
          // Plain primary color — no ShaderMask (avoids white text artifacts on web)
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                  fontSize: isMobile ? 28 : null,
                ),
            textAlign: textAlign,
          ),
          const SizedBox(height: 14),
          if (textAlign == TextAlign.center)
            const Center(child: _AccentBar())
          else
            const _AccentBar(),
          if (subtitle != null) ...[
            const SizedBox(height: 20),
            Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).hintColor,
                    height: 1.7,
                  ),
              textAlign: textAlign,
            ),
          ],
        ],
      ),
    );
  }
}

class _AccentBar extends StatelessWidget {
  const _AccentBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 3,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
