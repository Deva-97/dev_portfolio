// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'animated_fade_in.dart';
import 'section_title.dart';

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

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    // Pre-cache the about image for all views to avoid loading issues
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage('assets/images/dev_portfolio.png'), context);
    });
  }

  @override
  void dispose() {
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600 && screenWidth < 900;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title with underline
        const SectionTitle(title: 'About Me', useGradient: true),
        const SizedBox(height: 40),

        // Content with logo
        if (widget.isMobile)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAnimatedLogo(context, size: 260),
              const SizedBox(height: 32),
              _buildAboutText(context),
              const SizedBox(height: 32),
              _buildStatsRow(context, isMobile: true),
            ],
          )
        else if (isTablet)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildAnimatedLogo(context, size: 280),
              const SizedBox(height: 40),
              _buildAboutText(context),
              const SizedBox(height: 40),
              _buildStatsRow(context, isMobile: false),
            ],
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: _buildAnimatedLogo(context, size: 300),
                  ),
                  const SizedBox(width: 48),
                  Expanded(
                    child: _buildAboutText(context),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              // Stats Row
              _buildStatsRow(context, isMobile: false),
            ],
          ),
      ],
    );
  }

  Widget _buildStatsRow(BuildContext context, {required bool isMobile}) {
    final stats = [
      {'title': 'Experience', 'value': '2+ Years', 'label': 'Professional Flutter Developer'},
      {'title': 'App Delivery', 'value': 'Production Apps', 'label': 'Android · iOS · Tablet'},
      {'title': 'Core Focus', 'value': 'Real-Time Systems', 'label': 'IoT · Automation · Enterprise Apps'},
    ];

    if (isMobile) {
      return Column(
        children: stats.map((stat) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _StatCard(title: stat['title']!, value: stat['value']!, label: stat['label']!),
          );
        }).toList(),
      );
    }

    return Row(
      children: stats.map((stat) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _StatCard(title: stat['title']!, value: stat['value']!, label: stat['label']!),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAnimatedLogo(BuildContext context, {double size = 320}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderRadius = size > 280 ? 28.0 : 24.0;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.15),
            blurRadius: 30,
            offset: const Offset(0, 15),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: AppColors.primary.withOpacity(0.15),
            blurRadius: 40,
            spreadRadius: 4,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/dev_portfolio.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[200],
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.4),
                  ],
                ),
              ),
            ),
            // Decorative border
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.25),
                  width: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobileOrTablet = screenWidth < 900;
    
    return AnimatedFadeIn(
      delay: const Duration(milliseconds: 200),
      child: Column(
        crossAxisAlignment: isMobileOrTablet ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'I\'m a Flutter Developer with over 3 years of professional experience building cross-platform mobile applications for Android, iOS, and tablet devices. I\'ve worked on real-world products including enterprise internal systems, smart home automation apps, and AI-powered mobile solutions used in production environments.\n\n'
            'My development approach focuses on clean, maintainable code and well-structured architecture. I regularly work with patterns such as Clean Architecture and MVVM, and I have hands-on experience integrating Firebase services, real-time communication using MQTT, and REST APIs to build reliable, scalable applications.\n\n'
            'I enjoy collaborating with designers, backend developers, and QA teams to translate complex requirements into stable, user-friendly Flutter applications that perform well in real usage.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).hintColor.withOpacity(0.9),
                  height: 1.8,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
            textAlign: isMobileOrTablet ? TextAlign.center : TextAlign.start,
          ),
        ],
      ),
    );
  }

}

/// Stat card widget with hover animation for About section
class _StatCard extends StatefulWidget {
  final String title;
  final String value;
  final String label;

  const _StatCard({
    required this.title,
    required this.value,
    required this.label,
  });

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool hovered) {
    setState(() => _isHovered = hovered);
    if (hovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;
    final screenWidth = MediaQuery.of(context).size.width;
    final cardHeight = screenWidth < 600 ? 150.0 : 140.0;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final scale = 1.0 + (_controller.value * 0.03);
          final translateY = -4 * _controller.value;

          return Transform.translate(
            offset: Offset(0, translateY),
            child: Transform.scale(
              scale: scale,
              child: Container(
                height: cardHeight,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1E293B)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isHovered
                        ? primaryColor.withOpacity(0.5)
                        : (isDark
                            ? const Color(0xFF334155)
                            : const Color(0xFFE2E8F0)),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.1 * _controller.value),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                    if (!isDark)
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).hintColor,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.value,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              color: isDark ? AppColors.flutterLightBlue : AppColors.flutterDarkBlue,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.label,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).hintColor,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}