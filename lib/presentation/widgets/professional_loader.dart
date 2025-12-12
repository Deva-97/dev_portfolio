// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProfessionalLoader extends StatefulWidget {
  final double size;
  final Color? color;
  final bool fullScreen;

  const ProfessionalLoader({
    super.key,
    this.size = 100,
    this.color,
    this.fullScreen = false,
  });

  @override
  State<ProfessionalLoader> createState() => _ProfessionalLoaderState();
}

class _ProfessionalLoaderState extends State<ProfessionalLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If fullScreen is requested, expand and present a large centered logo
    if (widget.fullScreen) {
      final logoSize = MediaQuery.of(context).size.shortestSide * 0.45;
      return SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final v = _controller.value;
                final floatOffset = math.sin(v * 2 * math.pi) * 18;
                final rotate = (math.sin(v * 2 * math.pi) * 0.04) - 0.26;
                final scale = 1.0 + (math.sin(v * 2 * math.pi) * 0.05);
                return Transform.translate(
                  offset: Offset(0, floatOffset),
                  child: Transform.rotate(
                    angle: rotate,
                    child: Transform.scale(
                      scale: scale,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: logoSize + 40,
                            height: logoSize + 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.28),
                                  blurRadius: 60,
                                  spreadRadius: 18,
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            'assets/images/logo.png',
                            width: logoSize,
                            height: logoSize,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 18),
            Text(
              'Launching Portfolio',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(letterSpacing: 1.2),
            ),
          ],
        ),
      );
    }

    // Default compact loader
    return SizedBox(
      width: widget.size + 40,
      height: widget.size + 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Floating logo with glow effect
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final floatOffset =
                  math.sin(_controller.value * 2 * math.pi) * 12;
              return Transform.translate(
                offset: Offset(0, floatOffset),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Glow effect
                    Container(
                      width: widget.size + 20,
                      height: widget.size + 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                    ),
                    // Logo
                    Image.asset(
                      'assets/images/logo.png',
                      width: widget.size,
                      height: widget.size,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          // Loading text with fade pulse
          ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Curves.easeInOut,
              ),
            ),
            child: Text(
              'Launching Portfolio',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// Simple dot loader
class DotLoader extends StatefulWidget {
  final Color? color;
  final double dotSize;

  const DotLoader({
    super.key,
    this.color,
    this.dotSize = 8,
  });

  @override
  State<DotLoader> createState() => _DotLoaderState();
}

class _DotLoaderState extends State<DotLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).primaryColor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.6, end: 1.0).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Interval(
                index * 0.2,
                (index * 0.2) + 0.6,
                curve: Curves.easeInOut,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Container(
              width: widget.dotSize,
              height: widget.dotSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            ),
          ),
        );
      }),
    );
  }
}
