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
  final VoidCallback? onSkillsTap;
  final VoidCallback? onProjectsTap;
  final VoidCallback? onContactTap;

  const ResponsiveAppBar({
    super.key,
    this.onToggleTheme,
    required this.themeMode,
    this.showName = false,
    this.onAboutTap,
    this.onExperienceTap,
    this.onSkillsTap,
    this.onProjectsTap,
    this.onContactTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final themeIcon = _HoverIconButton(
      icon: themeMode == ThemeMode.dark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
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
                width: Responsive.isMobile(context) ? 18 : 24,
                height: Responsive.isMobile(context) ? 18 : 24,
                colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ),
              const SizedBox(width: 10),
              Text(
                'Devendiran Thiyagarajan',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: isDark ? AppColors.darkModeText : AppColors.lightModeText,
                      fontWeight: FontWeight.w700,
                      fontSize: Responsive.isMobile(context) ? 16 : 18,
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
        toolbarHeight: 60,
        title: buildTitle(),
        centerTitle: false,
        actions: [
          _HoverNavButton(label: 'About', onTap: onAboutTap),
          _HoverNavButton(label: 'Experience', onTap: onExperienceTap),
          _HoverNavButton(label: 'Skills', onTap: onSkillsTap),
          _HoverNavButton(label: 'Projects', onTap: onProjectsTap),
          _HoverNavButton(label: 'Contact', onTap: onContactTap),
          const SizedBox(width: 8),
          themeIcon,
          const SizedBox(width: 16),
        ],
      );
    }

    return AppBar(
      elevation: 0,
      toolbarHeight: 60,
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
              case 'skills':
                onSkillsTap?.call();
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
            PopupMenuItem(value: 'about', child: Text('About')),
            PopupMenuItem(value: 'experience', child: Text('Experience')),
            PopupMenuItem(value: 'skills', child: Text('Skills')),
            PopupMenuItem(value: 'projects', child: Text('Projects')),
            PopupMenuItem(value: 'contact', child: Text('Contact')),
          ],
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}

class _HoverNavButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;

  const _HoverNavButton({required this.label, this.onTap});

  @override
  State<_HoverNavButton> createState() => _HoverNavButtonState();
}

class _HoverNavButtonState extends State<_HoverNavButton>
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
    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovered = true);
        _ctrl.forward();
      },
      onExit: (_) {
        setState(() => _hovered = false);
        _ctrl.reverse();
      },
      child: TextButton(
        onPressed: widget.onTap,
        style: TextButton.styleFrom(
          foregroundColor: _hovered ? AppColors.primary : Theme.of(context).hintColor,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            fontWeight: _hovered ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _HoverIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final String? tooltip;

  const _HoverIconButton({required this.icon, this.onTap, this.tooltip});

  @override
  State<_HoverIconButton> createState() => _HoverIconButtonState();
}

class _HoverIconButtonState extends State<_HoverIconButton>
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
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + _ctrl.value * 0.1,
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
                    AppColors.primary,
                    _ctrl.value,
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
}
