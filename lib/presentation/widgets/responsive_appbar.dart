// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../core/utils/responsive.dart';
import 'stagger_animation.dart';

class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onToggleTheme;
  final ThemeMode themeMode;

  final VoidCallback? onAboutTap;
  final VoidCallback? onExperienceTap;
  final VoidCallback? onProjectsTap;
  final VoidCallback? onContactTap;

  const ResponsiveAppBar({
    super.key,
    this.onToggleTheme,
    required this.themeMode,
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

    final icon =
        themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode;

    final themeIcon = ScaleOnHover(
      onTap: onToggleTheme,
      duration: const Duration(milliseconds: 300),
      child: IconButton(
        onPressed: onToggleTheme,
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, anim) => RotationTransition(
            turns: Tween<double>(begin: 0.8, end: 1).animate(anim),
            child: FadeTransition(opacity: anim, child: child),
          ),
          child: Icon(
            icon,
            key: ValueKey(icon),
          ),
        ),
        tooltip: 'Toggle theme',
      ),
    );

    if (isDesktop) {
      return AppBar(
        elevation: 0,
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.7),
            ],
          ).createShader(bounds),
          child: const Text('Devendiran T'),
        ),
        centerTitle: false,
        actions: [
          _buildNavButton(context, 'About', onAboutTap),
          _buildNavButton(context, 'Experience', onExperienceTap),
          _buildNavButton(context, 'Projects', onProjectsTap),
          _buildNavButton(context, 'Contact', onContactTap),
          const SizedBox(width: 12),
          themeIcon,
          const SizedBox(width: 12),
        ],
      );
    }

    return AppBar(
      elevation: 0,
      title: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.7),
          ],
        ).createShader(bounds),
        child: const Text('Devendiran T'),
      ),
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
              child: Text('Experience'),
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

  Widget _buildNavButton(
    BuildContext context,
    String label,
    VoidCallback? onTap,
  ) {
    return ScaleOnHover(
      onTap: onTap,
      duration: const Duration(milliseconds: 200),
      child: TextButton(
        onPressed: onTap,
        child: Text(label),
      ),
    );
  }
}
