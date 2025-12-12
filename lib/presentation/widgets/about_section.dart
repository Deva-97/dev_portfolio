// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'animated_fade_in.dart';

/// Enhanced About Me section with animated content and visual elements
class AboutSection extends StatefulWidget {
  final bool isMobile;

  const AboutSection({
    super.key,
    required this.isMobile,
  });

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatingController;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(begin: 0, end: 20).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title
        AnimatedFadeIn(
          duration: const Duration(milliseconds: 600),
          child: Text(
            'About Me',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).brightness == Brightness.light
                      ? const Color(0xFF1F2937)
                      : null,
                ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 48),

        // Content with logo
        if (widget.isMobile)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAnimatedLogo(context),
              const SizedBox(height: 40),
              _buildAboutText(context),
            ],
          )
        else
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 400),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: _buildAnimatedLogo(context),
                ),
                const SizedBox(width: 60),
                Expanded(
                  child: _buildAboutText(context),
                ),
              ],
            ),
          ),

        const SizedBox(height: 60),

        // Key Points
        _buildKeyPoints(context),
      ],
    );
  }

  Widget _buildAnimatedLogo(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatingAnimation,
      builder: (context, child) {
        return Center(
          child: Transform.translate(
            offset: Offset(0, _floatingAnimation.value),
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.15),
                    Theme.of(context).primaryColor.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildRotatingFlutterIcon(context),
                    const SizedBox(height: 12),
                    Text(
                      'Flutter\nDeveloper',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRotatingFlutterIcon(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _floatingController.value * 6.28,
          child: Icon(
            Icons.flutter_dash,
            size: 70,
            color: Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }

  Widget _buildAboutText(BuildContext context) {
    return AnimatedFadeIn(
      delay: const Duration(milliseconds: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Crafting Beautiful & Functional Mobile Experiences',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'I\'m a dedicated Flutter developer with a passion for creating intuitive and visually appealing mobile applications. With expertise in Dart and the Flutter framework, I specialize in building cross-platform apps that deliver native-like performance on both iOS and Android.\n\n'
            'My approach combines clean architecture, efficient state management, and attention to UI/UX details to create apps that users love. I\'m constantly learning and staying updated with the latest Flutter developments to deliver cutting-edge solutions.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).hintColor,
                  height: 1.8,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyPoints(BuildContext context) {
    final points = [
      {
        'icon': Icons.code,
        'title': 'Clean Code',
        'description':
            'Well-structured, maintainable code following best practices'
      },
      {
        'icon': Icons.palette,
        'title': 'UI/UX Design',
        'description':
            'Beautiful interfaces with smooth animations and interactions'
      },
      {
        'icon': Icons.speed,
        'title': 'Performance',
        'description': 'Optimized apps that run smoothly on all devices'
      },
    ];

    if (widget.isMobile) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: points
            .map((point) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildKeyPointCard(context, point),
                ))
            .toList(),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: points
          .asMap()
          .entries
          .map((entry) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: _buildKeyPointCard(context, entry.value),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildKeyPointCard(
    BuildContext context,
    Map<String, dynamic> point,
  ) {
    return AnimatedFadeIn(
      delay: const Duration(milliseconds: 300),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).dividerColor,
          ),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                point['icon'] as IconData,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              point['title'] as String,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              point['description'] as String,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).hintColor,
                    height: 1.5,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
