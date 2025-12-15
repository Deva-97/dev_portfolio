// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/project.dart';
import 'animated_fade_in.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  final int index;

  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _setHover(bool isHovered) {
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedFadeIn(
      delay: Duration(milliseconds: 120 * widget.index),
      child: MouseRegion(
        onEnter: (_) => _setHover(true),
        onExit: (_) => _setHover(false),
        child: AnimatedBuilder(
          animation: _hoverController,
          builder: (context, child) {
            final scale = 1.0 + (_hoverController.value * 0.02);
            final translateY = -6 * _hoverController.value;

            return Transform.translate(
              offset: Offset(0, translateY),
              child: Transform.scale(
                scale: scale,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: (isDark ? AppColors.flutterLightBlue : AppColors.flutterDarkBlue)
                            .withOpacity(0.12 * _hoverController.value),
                        blurRadius: 25,
                        offset: const Offset(0, 12),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.25 : 0.06),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCardBg : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _isHovered
                            ? (isDark ? AppColors.flutterLightBlue : AppColors.flutterDarkBlue).withOpacity(0.5)
                            : (isDark
                                ? AppColors.borderDark
                                : AppColors.borderLight),
                        width: 1,
                      ),
                    ),
                    child: child,
                  ),
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isDark ? null : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              widget.project.image,
                              width: 140,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.project.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: _isHovered
                                  ? (isDark ? AppColors.flutterLightBlue : AppColors.flutterDarkBlue)
                                  : null,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.project.description,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).hintColor,
                              height: 1.6,
                            ),
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.project.tech
                            .map((t) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (isDark ? AppColors.flutterLightBlue : AppColors.flutterDarkBlue)
                                        .withOpacity(isDark ? 0.15 : 0.08),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: (isDark ? AppColors.flutterLightBlue : AppColors.flutterDarkBlue).withOpacity(0.2),
                                    ),
                                  ),
                                  child: Text(
                                    t,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          color: isDark ? AppColors.flutterLightBlue : AppColors.flutterDarkBlue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          if (widget.project.playStore != null &&
                              widget.project.playStore!.isNotEmpty)
                            _buildActionButton(
                              context,
                              icon: Icons.shop,
                              label: 'Play Store',
                              onTap: () => _openUrl(widget.project.playStore!),
                            ),
                          if (widget.project.appStore != null &&
                              widget.project.appStore!.isNotEmpty)
                            _buildActionButton(
                              context,
                              icon: Icons.apple,
                              label: 'App Store',
                              onTap: () => _openUrl(widget.project.appStore!),
                            ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isDark ? null : Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                widget.project.image,
                                width: 110,
                                height: 110,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.project.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: _isHovered
                                            ? (isDark ? AppColors.flutterLightBlue : AppColors.flutterDarkBlue)
                                            : null,
                                      ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  widget.project.description,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: Theme.of(context).hintColor,
                                        height: 1.6,
                                      ),
                                ),
                                const SizedBox(height: 14),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: widget.project.tech
                                      .map((t) => Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: (isDark ? AppColors.flutterLightBlue : AppColors.flutterDarkBlue)
                                                  .withOpacity(isDark ? 0.15 : 0.08),
                                              borderRadius: BorderRadius.circular(6),
                                              border: Border.all(
                                                color: (isDark ? AppColors.flutterLightBlue : AppColors.flutterDarkBlue).withOpacity(0.2),
                                              ),
                                            ),
                                            child: Text(
                                              t,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium
                                                  ?.copyWith(
                                                    color: isDark ? AppColors.flutterLightBlue : AppColors.flutterDarkBlue,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          if (widget.project.playStore != null &&
                              widget.project.playStore!.isNotEmpty)
                            _buildActionButton(
                              context,
                              icon: Icons.shop,
                              label: 'Play Store',
                              onTap: () => _openUrl(widget.project.playStore!),
                            ),
                          if (widget.project.appStore != null &&
                              widget.project.appStore!.isNotEmpty)
                            _buildActionButton(
                              context,
                              icon: Icons.apple,
                              label: 'App Store',
                              onTap: () => _openUrl(widget.project.appStore!),
                            ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return _HoverActionButton(
      icon: icon,
      label: label,
      onTap: onTap,
    );
  }

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}

/// Enhanced action button with hover animation
class _HoverActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _HoverActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_HoverActionButton> createState() => _HoverActionButtonState();
}

class _HoverActionButtonState extends State<_HoverActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final buttonColor = isDark ? AppColors.flutterLightBlue : AppColors.flutterDarkBlue;
    
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final scale = 1.0 + (_controller.value * 0.03);
          return Transform.scale(
            scale: scale,
            child: OutlinedButton.icon(
              onPressed: widget.onTap,
              icon: Icon(widget.icon, size: 18),
              label: Text(widget.label),
              style: OutlinedButton.styleFrom(
                foregroundColor: _isHovered ? Colors.white : buttonColor,
                backgroundColor: _isHovered ? buttonColor : Colors.transparent,
                side: BorderSide(
                  color: buttonColor,
                  width: 2,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          );
        },
      ),
    );
  }
}
