// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import 'animated_fade_in.dart';

/// Hero section for modern portfolio - matching reference design
class HeroSection extends StatefulWidget {
  final String name;
  final String title;
  final String subtitle;
  final VoidCallback? onViewWork;
  final VoidCallback? onGetInTouch;

  const HeroSection({
    super.key,
    required this.name,
    required this.title,
    required this.subtitle,
    this.onViewWork,
    this.onGetInTouch,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    )..repeat(reverse: true);

    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 80),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth =
              constraints.maxWidth.isFinite ? constraints.maxWidth : 800.0;
          final contentMaxWidth =
              isMobile ? availableWidth : math.min(availableWidth * 0.65, 750);
          final boundedContentWidth =
              contentMaxWidth.clamp(0.0, availableWidth).toDouble();

          final showSideLogo = availableWidth >= 900;
          final logoSize = showSideLogo
              ? math.min(420.0, availableWidth * 0.42)
              : math.min(280.0, availableWidth * 0.55);

          Widget buildLogo() {
            return AnimatedBuilder(
              animation: _floatingController,
              builder: (context, child) {
                final v = _floatingController.value;
                final floatY = math.sin(v * math.pi) * 12;

                return Transform.translate(
                  offset: Offset(0, floatY),
                  child: RepaintBoundary(
                  child: Container(
                    width: logoSize,
                    height: logoSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: Theme.of(context).dividerColor.withOpacity(0.06),
                        width: 0.8,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF54C5F8).withOpacity(0.005),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                );
              },
            );
          }

          final content = ConstrainedBox(
            constraints: BoxConstraints(maxWidth: boundedContentWidth),
            child: Column(
              crossAxisAlignment: showSideLogo ? CrossAxisAlignment.start : CrossAxisAlignment.center,
              children: [
                // Greeting and Name
                AnimatedFadeIn(
                  delay: const Duration(milliseconds: 100),
                  duration: const Duration(milliseconds: 600),
                  child: Column(
                    crossAxisAlignment: showSideLogo ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Hello, I\'m',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: isDark ? AppColors.flutterLightBlue : AppColors.flutterDarkBlue,
                              fontWeight: FontWeight.w400,
                            ),
                        textAlign: showSideLogo ? TextAlign.start : TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: showSideLogo ? Alignment.centerLeft : Alignment.center,
                        child: Text(
                          widget.name,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                color: isDark ? Colors.white : const Color(0xFF0F172A),
                                fontSize: isMobile ? 32 : (availableWidth > 900 ? 56 : 42),
                                fontWeight: FontWeight.w800,
                              ),
                          textAlign: showSideLogo ? TextAlign.start : TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Flutter Developer Badge - below name, plain blue text
                AnimatedFadeIn(
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    'Flutter Developer',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: isDark 
                              ? AppColors.flutterLightBlue 
                              : AppColors.flutterDarkBlue,
                          fontWeight: FontWeight.w700,
                          fontSize: isMobile ? 20 : 28,
                        ),
                  ),
                ),
                const SizedBox(height: 24),

                // Subtitle description
                AnimatedFadeIn(
                  delay: const Duration(milliseconds: 250),
                  duration: const Duration(milliseconds: 600),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isMobile ? double.infinity : 520,
                    ),
                    child: Text(
                      widget.subtitle,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).hintColor,
                            height: 1.8,
                            // Match About Me description font size on mobile
                            fontSize: isMobile ? 17 : 18,
                          ),
                      textAlign: showSideLogo ? TextAlign.start : TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 36),

                // CTA Buttons with enhanced hover
                AnimatedFadeIn(
                  delay: const Duration(milliseconds: 300),
                  duration: const Duration(milliseconds: 600),
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 12,
                    children: [
                      _HoverElevatedButton(
                        onPressed: widget.onViewWork,
                        label: 'View My Work',
                      ),
                      _HoverOutlinedButton(
                        onPressed: widget.onGetInTouch,
                        label: 'Get In Touch',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );

          if (showSideLogo) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: content),
                const SizedBox(width: 60),
                SizedBox(
                  width: logoSize + 40,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: buildLogo(),
                  ),
                ),
              ],
            );
          }

          // For mobile/tablet: center everything
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildLogo(),
              const SizedBox(height: 40),
              content,
            ],
          );
        },
      ),
    );
  }
}

/// Elevated button with hover animation
class _HoverElevatedButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String label;

  const _HoverElevatedButton({
    this.onPressed,
    required this.label,
  });

  @override
  State<_HoverElevatedButton> createState() => _HoverElevatedButtonState();
}

class _HoverElevatedButtonState extends State<_HoverElevatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _elevationAnimation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: isMobile ? double.infinity : null,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary
                        .withOpacity(0.3 * _controller.value),
                    blurRadius: _elevationAnimation.value * 2,
                    offset: Offset(0, _elevationAnimation.value / 2),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: widget.onPressed,
                child: Text(widget.label),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Outlined button with hover animation
class _HoverOutlinedButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String label;

  const _HoverOutlinedButton({
    this.onPressed,
    required this.label,
  });

  @override
  State<_HoverOutlinedButton> createState() => _HoverOutlinedButtonState();
}

class _HoverOutlinedButtonState extends State<_HoverOutlinedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: SizedBox(
              width: isMobile ? double.infinity : null,
              child: OutlinedButton(
                onPressed: widget.onPressed,
                child: Text(widget.label),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Skill card widget with hover effects
class SkillCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final String? assetPath;

  const SkillCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.assetPath,
  });

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return RepaintBoundary(
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: AnimatedBuilder(
          animation: _hoverController,
          builder: (context, child) {
            // translateY effect like reference: transform: translateY(0px) -> translateY(-8px)
            final translateY = -8.0 * _hoverController.value;
            final screenWidth = MediaQuery.of(context).size.width;
            final isMobileOuter = screenWidth <= 600;
            // Reduce internal padding for mobile
            final contentPadding = EdgeInsets.symmetric(
              horizontal: isMobileOuter ? 8.0 : 16.0,
              vertical: isMobileOuter ? 8.0 : 16.0,
            );

            return Transform.translate(
              offset: Offset(0, translateY),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.12 * _hoverController.value),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: (isDark ? Colors.black : Colors.black12)
                          .withOpacity(isDark ? 0.28 : 0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: contentPadding,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCardBg : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isHovered
                        ? AppColors.primary.withOpacity(0.4)
                        : (isDark ? AppColors.borderDark : AppColors.borderLight),
                    width: 1,
                  ),
                ),
                child: Builder(
                  builder: (context) {
                    final screenWidth = MediaQuery.of(context).size.width;
                    // Responsive sizing: desktop > 900, tablet 600-900, mobile < 600
                    final isDesktop = screenWidth > 900;
                    final isTablet = screenWidth > 600 && screenWidth <= 900;
                    final isMobile = screenWidth <= 600;
                    
                    // Icon size - slightly reduced on mobile so two-column layout fits
                    final iconSize = isDesktop ? 56.0 : (isTablet ? 52.0 : 44.0);
                    // Title font size - slightly reduced on mobile so text fits two columns
                    final titleFontSize = isDesktop ? 17.0 : (isTablet ? 16.0 : 14.0);
                    // Description font size - slightly reduced on mobile
                    final descFontSize = isDesktop ? 14.0 : (isTablet ? 13.0 : 11.0);

                    // Responsive spacing - tighter for mobile
                    // Add more vertical gap below and between cards for mobile
                    final topSpacing = isMobile ? 10.0 : 16.0;
                    final iconTitleSpacing = isMobile ? 10.0 : 12.0;
                    final titleDescSpacing = isMobile ? 8.0 : 8.0;
                    final bottomSpacing = isMobile ? 14.0 : 12.0;

                    
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: topSpacing),
                        // Skill icon - responsive
                        widget.assetPath != null
                            ? widget.assetPath!.endsWith('.svg')
                                ? SvgPicture.asset(
                                    widget.assetPath!,
                                    width: iconSize,
                                    height: iconSize,
                                  )
                                : Image.asset(
                                    widget.assetPath!,
                                    width: iconSize,
                                    height: iconSize,
                                    fit: BoxFit.contain,
                                  )
                            : Icon(
                                widget.icon,
                                color: AppColors.primary,
                                size: iconSize,
                              ),
                        SizedBox(height: iconTitleSpacing),
                        // Title - responsive, no ellipsis
                        Text(
                          widget.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: titleFontSize,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: titleDescSpacing),
                        // Description - responsive, no ellipsis
                        Text(
                          widget.description,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: isDark 
                                    ? AppColors.darkModeHint 
                                    : const Color(0xFF64748B),
                                height: 1.4,
                                fontSize: descFontSize,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: bottomSpacing),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
          
        },
      ),
      ),
    );
  }
}

/// Featured project card with enhanced hover
class FeaturedProjectCard extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  final List<String> tech;
  final VoidCallback? onTap;

  const FeaturedProjectCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.tech,
    this.onTap,
  });

  @override
  State<FeaturedProjectCard> createState() => _FeaturedProjectCardState();
}

class _FeaturedProjectCardState extends State<FeaturedProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _hoverController,
          builder: (context, child) {
            final scale = 1.0 + (_hoverController.value * 0.02);
            final translateY = -8 * _hoverController.value;

            return Transform.translate(
              offset: Offset(0, translateY),
              child: Transform.scale(
                scale: scale,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary
                            .withOpacity(0.15 * _hoverController.value),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCardBg : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _isHovered
                            ? AppColors.primary.withOpacity(0.5)
                            : (isDark
                                ? AppColors.borderDark
                                : AppColors.borderLight),
                        width: _isHovered ? 2 : 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image with overlay on hover
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Stack(
                              children: [
                                Image.asset(
                                  widget.image,
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                                // Gradient overlay on hover
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 300),
                                  opacity: _isHovered ? 1 : 0,
                                  child: Container(
                                    width: double.infinity,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          AppColors.primary.withOpacity(0.3),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            widget.title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: _isHovered ? AppColors.primary : null,
                                  // Larger title font size on mobile
                                  fontSize: Responsive.isMobile(context) ? 20 : null,
                                ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            widget.description,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context).hintColor,
                                      height: 1.6,
                                      // Larger description font size on mobile
                                      fontSize: Responsive.isMobile(context) ? 16 : null,
                                    ),
                          ),
                          const SizedBox(height: 20),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: widget.tech
                                .map((t) => Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isDark 
                                            ? AppColors.primary.withOpacity(0.15) 
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: AppColors.primary
                                              .withOpacity(0.3),
                                        ),
                                      ),
                                      child: Text(
                                        t,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
