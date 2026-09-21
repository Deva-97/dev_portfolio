// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'animated_fade_in.dart';
import 'section_title.dart';

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
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(
          const AssetImage('assets/images/dev_portfolio.png'), context);
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
        const SectionTitle(title: 'About Me', useGradient: true),
        const SizedBox(height: 48),
        if (widget.isMobile)
          _buildMobileLayout(context)
        else if (isTablet)
          _buildTabletLayout(context)
        else
          _buildDesktopLayout(context),
        const SizedBox(height: 48),
        _buildStatsRow(context),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPhoto(context, 240),
        const SizedBox(height: 32),
        _buildAboutText(context, TextAlign.center),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildPhoto(context, 260),
        const SizedBox(height: 36),
        _buildAboutText(context, TextAlign.center),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPhoto(context, 300),
        const SizedBox(width: 56),
        Expanded(child: _buildAboutText(context, TextAlign.start)),
      ],
    );
  }

  Widget _buildPhoto(BuildContext context, double size) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 40,
            spreadRadius: 4,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.4 : 0.12),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/dev_portfolio.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.darkSurface,
                alignment: Alignment.center,
                child: const Icon(Icons.person,
                    size: 60, color: AppColors.primary),
              ),
            ),
            // Subtle gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.primary.withOpacity(0.15),
                  ],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),
            // Border
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutText(BuildContext context, TextAlign align) {
    final crossAlign = align == TextAlign.start
        ? CrossAxisAlignment.start
        : CrossAxisAlignment.center;

    return AnimatedFadeIn(
      delay: const Duration(milliseconds: 200),
      child: Column(
        crossAxisAlignment: crossAlign,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Flutter Developer with 3+ years of experience building and deploying production Android and iOS applications. Hands-on experience with Flutter, Dart, Firebase, REST APIs, Clean Architecture, MVVM, Provider and GetX, with additional experience in IoT/MQTT, AI integrations and offline-first applications.\n\n"
            "I build maintainable mobile UI for production applications, real-time systems and Firebase-backed workflows, with product-minded attention to architecture, reliability and the details that make an app feel finished.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).hintColor,
                  height: 1.85,
                  fontSize: widget.isMobile ? 15 : 16,
                ),
            textAlign: align,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    final stats = [
      {
        'value': '3+',
        'label': 'Years Experience',
        'sub': 'Professional Flutter Dev',
        'icon': Icons.workspace_premium_outlined,
      },
      {
        'value': '10K+',
        'label': 'Android Downloads',
        'sub': 'Onwords Smart Things',
        'icon': Icons.download_outlined,
      },
      {
        'value': 'Android + iOS',
        'label': 'Production Apps',
        'sub': 'Built and deployed',
        'icon': Icons.rocket_launch_outlined,
      },
    ];

    if (widget.isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: stats
            .map((s) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _StatCard(
                    value: s['value'] as String,
                    label: s['label'] as String,
                    sub: s['sub'] as String,
                    icon: s['icon'] as IconData,
                  ),
                ))
            .toList(),
      );
    }

    return Row(
      children: stats
          .map((s) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: _StatCard(
                    value: s['value'] as String,
                    label: s['label'] as String,
                    sub: s['sub'] as String,
                    icon: s['icon'] as IconData,
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class _StatCard extends StatefulWidget {
  final String value;
  final String label;
  final String sub;
  final IconData icon;

  const _StatCard({
    required this.value,
    required this.label,
    required this.sub,
    required this.icon,
  });

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 180),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onHover(bool hovered) {
    setState(() => _hovered = hovered);
    if (hovered) {
      _ctrl.forward();
    } else {
      _ctrl.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCardBg : AppColors.cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _hovered
                    ? AppColors.primary.withOpacity(0.4)
                    : (isDark ? AppColors.darkBorder : AppColors.borderLight),
                width: _hovered ? 1.5 : 1,
              ),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.12),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: child,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(widget.icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              widget.value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 27,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              widget.sub,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).hintColor,
                    fontSize: 13,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
