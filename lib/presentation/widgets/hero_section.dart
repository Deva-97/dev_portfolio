// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import '../../core/theme/app_colors.dart';
import 'animated_fade_in.dart';

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
  late AnimationController _orbController;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    )..repeat(reverse: true);

    _orbController = AnimationController(
      duration: const Duration(milliseconds: 8000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _orbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 28 : 64),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Clip orbs to prevent horizontal scroll overflow
          Positioned.fill(
            child: ClipRect(child: _buildBackgroundOrbs(isDark)),
          ),
          _buildContent(context, isMobile, isDesktop, isDark),
        ],
      ),
    );
  }

  Widget _buildBackgroundOrbs(bool isDark) {
    return AnimatedBuilder(
      animation: _orbController,
      builder: (context, _) {
        final v = _orbController.value;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -80,
              right: -60,
              child: Transform.translate(
                offset: Offset(
                    math.sin(v * math.pi) * 20, math.cos(v * math.pi) * 15),
                child: Container(
                  width: 360,
                  height: 360,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withOpacity(isDark ? 0.10 : 0.07),
                        AppColors.primary.withOpacity(0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              left: -80,
              child: Transform.translate(
                offset: Offset(
                    math.cos(v * math.pi) * 15, math.sin(v * math.pi) * 20),
                child: Container(
                  width: 360,
                  height: 360,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withOpacity(isDark ? 0.10 : 0.06),
                        AppColors.primary.withOpacity(0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    bool isMobile,
    bool isDesktop,
    bool isDark,
  ) {
    final textContent = _buildTextContent(context, isMobile, isDesktop, isDark);
    final logoWidget = _buildAnimatedLogo(context, isMobile, isDesktop);

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 55, child: textContent),
          const SizedBox(width: 48),
          Expanded(flex: 45, child: Center(child: logoWidget)),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        logoWidget,
        const SizedBox(height: 24),
        textContent,
      ],
    );
  }

  Widget _buildTextContent(
    BuildContext context,
    bool isMobile,
    bool isDesktop,
    bool isDark,
  ) {
    final crossAlign =
        isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center;
    final textAlign = isDesktop ? TextAlign.start : TextAlign.center;
    final wrapAlign = isDesktop ? WrapAlignment.start : WrapAlignment.center;

    return Column(
      crossAxisAlignment: crossAlign,
      children: [
        // Role badge
        AnimatedFadeIn(
          delay: const Duration(milliseconds: 50),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(isDark ? 0.15 : 0.08),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: AppColors.available,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.available.withOpacity(0.6),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Flutter Developer · 3+ Years',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: isMobile ? 12 : 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Greeting + Name — plain primary color, no ShaderMask
        AnimatedFadeIn(
          delay: const Duration(milliseconds: 120),
          child: Column(
            crossAxisAlignment: crossAlign,
            children: [
              Text(
                "Hello, I'm",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).hintColor,
                      fontWeight: FontWeight.w400,
                      fontSize: isMobile ? 16 : 20,
                    ),
                textAlign: textAlign,
              ),
              const SizedBox(height: 6),
              Text(
                widget.name,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: AppColors.primary,
                      fontSize: isMobile ? 32 : (isDesktop ? 54 : 44),
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                textAlign: textAlign,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Subtitle
        AnimatedFadeIn(
          delay: const Duration(milliseconds: 200),
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: isMobile ? double.infinity : 520),
            child: Text(
              widget.subtitle,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).hintColor,
                    height: 1.8,
                    fontSize: isMobile ? 15 : 17,
                  ),
              textAlign: textAlign,
            ),
          ),
        ),
        const SizedBox(height: 32),

        // CTA Buttons
        AnimatedFadeIn(
          delay: const Duration(milliseconds: 280),
          child: Wrap(
            spacing: 16,
            runSpacing: 12,
            alignment: wrapAlign,
            children: [
              _PrimaryButton(
                label: 'View My Work',
                onPressed: widget.onViewWork,
                isMobile: isMobile,
              ),
              _OutlineButton(
                label: 'Get In Touch',
                onPressed: widget.onGetInTouch,
                isMobile: isMobile,
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),

        // Tech strip
        AnimatedFadeIn(
          delay: const Duration(milliseconds: 360),
          child: _TechStrip(
            tags: const [
              'Flutter',
              'Dart',
              'GetX',
              'Firebase',
              'MQTT',
              'REST APIs',
              'Clean Arch',
              'MVVM',
            ],
            align: wrapAlign,
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedLogo(
      BuildContext context, bool isMobile, bool isDesktop) {
    final size = isDesktop ? 300.0 : (isMobile ? 200.0 : 260.0);

    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        final floatY = math.sin(_floatingController.value * math.pi) * 14;
        return Transform.translate(offset: Offset(0, floatY), child: child);
      },
      child: RepaintBoundary(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Simple border ring
            Container(
              width: size + 20,
              height: size + 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 2,
                ),
              ),
            ),
            // BG separator
            Container(
              width: size + 10,
              height: size + 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            // Photo
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 40,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppColors.darkSurface,
                    child: const Icon(Icons.person,
                        size: 80, color: AppColors.primary),
                  ),
                ),
              ),
            ),
            // Floating stat chips (desktop only)
            if (isDesktop) ...[
              const Positioned(
                top: 12,
                right: -12,
                child: _FloatingChip(
                  icon: Icons.download_rounded,
                  label: '10,500+',
                  sublabel: 'Downloads',
                ),
              ),
              const Positioned(
                bottom: 32,
                left: -24,
                child: _FloatingChip(
                  icon: Icons.apps_rounded,
                  label: '6 Apps',
                  sublabel: 'Production',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ---- Supporting widgets ----

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isMobile;

  const _PrimaryButton({
    required this.label,
    this.onPressed,
    required this.isMobile,
  });

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _ctrl.forward(),
      onExit: (_) => _ctrl.reverse(),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: _ctrl,
          builder: (context, _) {
            return Transform.scale(
              scale: 1.0 + _ctrl.value * 0.02,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: widget.isMobile ? double.infinity : null,
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                decoration: BoxDecoration(
                  color: Color.lerp(AppColors.primary, AppColors.primaryDark,
                      _ctrl.value * 0.3),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary
                          .withOpacity(0.3 + _ctrl.value * 0.15),
                      blurRadius: 16 + _ctrl.value * 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    widget.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
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

class _OutlineButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isMobile;

  const _OutlineButton({
    required this.label,
    this.onPressed,
    required this.isMobile,
  });

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovered = true);
        _ctrl.forward();
      },
      onExit: (_) {
        setState(() => _hovered = false);
        _ctrl.reverse();
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: _ctrl,
          builder: (context, _) {
            return Transform.scale(
              scale: 1.0 + _ctrl.value * 0.02,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: widget.isMobile ? double.infinity : null,
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                decoration: BoxDecoration(
                  color: _hovered
                      ? AppColors.primary.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _hovered
                        ? AppColors.primary
                        : (isDark
                            ? AppColors.darkBorder
                            : AppColors.borderLight),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      color: _hovered
                          ? AppColors.primary
                          : Theme.of(context).hintColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
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

class _TechStrip extends StatelessWidget {
  final List<String> tags;
  final WrapAlignment align;

  const _TechStrip({required this.tags, required this.align});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: align,
      children: tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.borderLight,
            ),
          ),
          child: Text(
            tag,
            style: TextStyle(
              color: Theme.of(context).hintColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _FloatingChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sublabel;

  const _FloatingChip({
    required this.icon,
    required this.label,
    required this.sublabel,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBg : AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.30 : 0.10),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 14, color: AppColors.primary),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  color:
                      isDark ? AppColors.darkModeText : AppColors.lightModeText,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  height: 1.2,
                ),
              ),
              Text(
                sublabel,
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 11,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Skill card used in the Skills section
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 600;
    final isDesktop = screenWidth > 900;
    final iconSize = isDesktop ? 48.0 : (isMobile ? 36.0 : 44.0);
    final titleFontSize = isDesktop ? 15.0 : (isMobile ? 13.0 : 14.0);
    final descFontSize = isDesktop ? 13.0 : (isMobile ? 11.0 : 12.0);

    return RepaintBoundary(
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: AnimatedBuilder(
          animation: _hoverController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, -6 * _hoverController.value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 8 : 14,
                  vertical: isMobile ? 10 : 16,
                ),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCardBg : AppColors.cardBg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: _isHovered
                        ? AppColors.primary.withOpacity(0.4)
                        : (isDark
                            ? AppColors.darkBorder
                            : AppColors.borderLight),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary
                          .withOpacity(0.10 * _hoverController.value),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: child,
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
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
                  : Icon(widget.icon, color: AppColors.primary, size: iconSize),
              SizedBox(height: isMobile ? 8 : 12),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: titleFontSize,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 6 : 8),
              Text(
                widget.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).hintColor,
                      height: 1.4,
                      fontSize: descFontSize,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
