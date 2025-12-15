// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';

class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onToggleTheme;
  final ThemeMode themeMode;
  final bool showName;

  final VoidCallback? onAboutTap;
  final VoidCallback? onExperienceTap;
  final VoidCallback? onProjectsTap;
  final VoidCallback? onContactTap;

  const ResponsiveAppBar({
    super.key,
    this.onToggleTheme,
    required this.themeMode,
    this.showName = false,
    this.onAboutTap,
    this.onExperienceTap,
    this.onProjectsTap,
    this.onContactTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final icon =
        themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode;

    final themeIcon = _HoverIconButton(
      icon: icon,
      onTap: onToggleTheme,
      tooltip: 'Toggle theme',
    );

    Widget buildTitle() {
      return AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: showName ? 1.0 : 0.0,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 300),
          offset: showName ? Offset.zero : const Offset(0, -0.5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/images/flutter logo.svg',
                width: 28,
                height: 28,
              ),
              const SizedBox(width: 10),
              Text(
                'Devendiran Thiyagarajan',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: isDark ? AppColors.flutterLightBlue : AppColors.flutterDarkBlue,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    if (isDesktop) {
      return AppBar(
        elevation: 0,
        title: buildTitle(),
        centerTitle: false,
        actions: [
          _HoverNavButton(label: 'About', onTap: onAboutTap),
          _HoverNavButton(label: 'Skills', onTap: onExperienceTap),
          _HoverNavButton(label: 'Projects', onTap: onProjectsTap),
          _HoverNavButton(label: 'Contact', onTap: onContactTap),
          const SizedBox(width: 16),
          themeIcon,
          const SizedBox(width: 16),
        ],
      );
    }

    return AppBar(
      elevation: 0,
      title: buildTitle(),
      actions: [
        themeIcon,
        PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'about':
                onAboutTap?.call();
                break;
              case 'experience':
                onExperienceTap?.call();
                break;
              case 'projects':
                onProjectsTap?.call();
                break;
              case 'contact':
                onContactTap?.call();
                break;
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: 'about',
              child: Text('About'),
            ),
            PopupMenuItem(
              value: 'experience',
              child: Text('Skills'),
            ),
            PopupMenuItem(
              value: 'projects',
              child: Text('Projects'),
            ),
            PopupMenuItem(
              value: 'contact',
              child: Text('Contact'),
            ),
          ],
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}

/// Enhanced nav button with hover animation
class _HoverNavButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;

  const _HoverNavButton({
    required this.label,
    this.onTap,
  });

  @override
  State<_HoverNavButton> createState() => _HoverNavButtonState();
}

class _HoverNavButtonState extends State<_HoverNavButton>
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
          return Transform.scale(
            scale: 1.0 + (_controller.value * 0.05),
            child: TextButton(
              onPressed: widget.onTap,
              style: TextButton.styleFrom(
                foregroundColor: _isHovered
                    ? (Theme.of(context).brightness == Brightness.dark ? AppColors.flutterLightBlue : AppColors.flutterDarkBlue)
                    : Theme.of(context).hintColor,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              child: Text(
                widget.label,
                style: TextStyle(
                  fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Enhanced icon button with hover animation
class _HoverIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final String? tooltip;

  const _HoverIconButton({
    required this.icon,
    this.onTap,
    this.tooltip,
  });

  @override
  State<_HoverIconButton> createState() => _HoverIconButtonState();
}

class _HoverIconButtonState extends State<_HoverIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + (_controller.value * 0.1),
            child: IconButton(
              onPressed: widget.onTap,
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, anim) => RotationTransition(
                  turns: Tween<double>(begin: 0.7, end: 1).animate(anim),
                  child: FadeTransition(opacity: anim, child: child),
                ),
                child: Icon(
                  widget.icon,
                  key: ValueKey(widget.icon),
                  color: Color.lerp(
                    Theme.of(context).hintColor,
                    _getFlutterColor(context),
                    _controller.value,
                  ),
                ),
              ),
              tooltip: widget.tooltip,
            ),
          );
        },
      ),
    );
  }

  Color _getFlutterColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? AppColors.flutterLightBlue : AppColors.flutterDarkBlue;
  }
}
