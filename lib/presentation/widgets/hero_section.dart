import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'animated_fade_in.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onViewWork;
  final VoidCallback? onResume;
  const HeroSection({super.key, this.onViewWork, this.onResume});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final desktop = screenWidth >= 1000;
    final mobile = screenWidth < 600;
    final centered = !desktop;
    final text = Column(
        crossAxisAlignment:
            centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          AnimatedFadeIn(
              delay: const Duration(milliseconds: 80), child: _Badge()),
          const SizedBox(height: 22),
          AnimatedFadeIn(
              delay: const Duration(milliseconds: 140),
              child: Text('Flutter Developer',
                  textAlign: centered ? TextAlign.center : TextAlign.start,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.primary, fontWeight: FontWeight.w500))),
          const SizedBox(height: 10),
          AnimatedFadeIn(
              delay: const Duration(milliseconds: 200),
              child: Text('Devendiran\nThiyagarajan',
                  textAlign: centered ? TextAlign.center : TextAlign.start,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: mobile ? 42 : 62,
                      height: 1.02,
                      letterSpacing: -2,
                      fontWeight: FontWeight.w700))),
          const SizedBox(height: 20),
          ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 590),
              child: Text(
                  '3+ years building and shipping production Android and iOS applications with Flutter, Dart, Firebase and scalable application architecture.',
                  textAlign: centered ? TextAlign.center : TextAlign.start,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).hintColor, height: 1.65))),
          const SizedBox(height: 28),
          mobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                      _button(context, 'View Projects', onViewWork, true),
                      const SizedBox(height: 12),
                      _button(context, 'Download Resume', onResume, false)
                    ])
              : Wrap(spacing: 12, children: [
                  _button(context, 'View Projects', onViewWork, true),
                  _button(context, 'Download Resume', onResume, false)
                ]),
          const SizedBox(height: 26),
          Text(
              'Flutter  ·  Dart  ·  Firebase  ·  GetX  ·  Provider  ·  Clean Architecture',
              textAlign: centered ? TextAlign.center : TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Theme.of(context).hintColor)),
        ]);
    const visual = _DeviceShowcase();
    return Padding(
        padding: EdgeInsets.symmetric(vertical: desktop ? 76 : 38),
        child: desktop
            ? Row(children: [
                Expanded(flex: 56, child: text),
                const SizedBox(width: 36),
                const Expanded(flex: 44, child: _DeviceShowcase())
              ])
            : Column(children: [text, const SizedBox(height: 46), visual]));
  }

  Widget _button(BuildContext context, String label, VoidCallback? callback,
          bool primary) =>
      primary
          ? ElevatedButton(onPressed: callback, child: Text(label))
          : OutlinedButton(onPressed: callback, child: Text(label));
}

class _Badge extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
          color: AppColors.available.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.available.withValues(alpha: .3))),
      child: const Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.circle, size: 8, color: AppColors.available),
        SizedBox(width: 8),
        Text('MOBILE APPLICATION ENGINEER',
            style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1))
      ]));
}

class _DeviceShowcase extends StatelessWidget {
  const _DeviceShowcase();
  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final deviceWidth = (width * .32).clamp(96.0, 158.0).toDouble();
      final deviceHeight = deviceWidth / .49;
      final showcaseHeight = math.max(
        280.0,
        math.min(390.0, math.max(deviceHeight + 30, width * .72)),
      );

      Widget phone(String asset,
              {required double top,
              required double? left,
              required double? right}) =>
          Positioned(
              top: top,
              left: left,
              right: right,
              child: Container(
                  height: deviceHeight,
                  width: deviceWidth,
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: dark ? const Color(0xFF222832) : Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      border:
                          Border.all(color: Theme.of(context).dividerColor)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(asset, fit: BoxFit.cover))));

      return SizedBox(
        height: showcaseHeight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: .08),
                        borderRadius: BorderRadius.circular(32)))),
            phone('assets/images/projects/onwords_smart_things_1.webp',
                top: showcaseHeight - deviceHeight, left: null, right: null),
            phone('assets/images/projects/mudhal_ai_2.webp',
                top: 0, left: (width - deviceWidth) / 2, right: null),
            phone('assets/images/projects/aquacare_3.webp',
                top: showcaseHeight - deviceHeight,
                left: null,
                right: width * 0),
            const Positioned(
              bottom: 4,
              left: 0,
              right: 0,
              child: Center(
                child: _Caption('Production apps', Icons.phone_iphone),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _Caption extends StatelessWidget {
  final String text;
  final IconData icon;
  const _Caption(this.text, this.icon);
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).dividerColor)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 7),
        Text(text, style: const TextStyle(fontWeight: FontWeight.w600))
      ]));
}
