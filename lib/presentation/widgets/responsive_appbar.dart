import 'package:flutter/material.dart';
import '../../core/utils/responsive.dart';

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
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    final icon =
        themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode;

    final themeIcon = IconButton(
      onPressed: onToggleTheme,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
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
    );

    if (isDesktop) {
      return AppBar(
        title: const Text('Devendiran T'),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: onAboutTap,
            child: const Text('About'),
          ),
          TextButton(
            onPressed: onExperienceTap,
            child: const Text('Experience'),
          ),
          TextButton(
            onPressed: onProjectsTap,
            child: const Text('Projects'),
          ),
          TextButton(
            onPressed: onContactTap,
            child: const Text('Contact'),
          ),
          themeIcon,
          const SizedBox(width: 8),
        ],
      );
    }

    return AppBar(
      title: const Text('Devendiran T'),
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
}
