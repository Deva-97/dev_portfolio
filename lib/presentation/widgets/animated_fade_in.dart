import 'package:flutter/material.dart';

class AnimatedFadeIn extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  const AnimatedFadeIn({
    super.key,
    required this.child,
    this.delay = const Duration(milliseconds: 100),
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<AnimatedFadeIn> createState() => _AnimatedFadeInState();
}

class _AnimatedFadeInState extends State<AnimatedFadeIn> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(vsync: this, duration: widget.duration);
  late final Animation<double> _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _anim, child: SlideTransition(position: Tween<Offset>(begin: const Offset(0, 0.02), end: Offset.zero).animate(_anim), child: widget.child));
  }
}
