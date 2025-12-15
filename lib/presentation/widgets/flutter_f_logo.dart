// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

/// Animated developer mark that now uses the asset logo for the splash/hero animation.
class FlutterFLogo extends StatefulWidget {
  final double size;
  final bool loop;

  const FlutterFLogo({
    super.key,
    this.size = 120,
    this.loop = true,
  });

  @override
  State<FlutterFLogo> createState() => _FlutterFLogoState();
}

class _FlutterFLogoState extends State<FlutterFLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotation;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 6000),
      vsync: this,
    );

    _rotation = TweenSequence<double>(
      [
        TweenSequenceItem(tween: Tween(begin: -0.04, end: 0.04), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 0.04, end: -0.02), weight: 1),
        TweenSequenceItem(tween: Tween(begin: -0.02, end: 0), weight: 1),
      ],
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _scale = Tween<double>(begin: 0.98, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.loop) {
      _controller.repeat(reverse: true);
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotation.value,
            child: Transform.scale(
              scale: _scale.value,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.size * 0.2),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
