// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

/// Enhanced section divider with animated accent
class EnhancedDivider extends StatefulWidget {
  final double height;
  final Color? color;
  final bool animate;

  const EnhancedDivider({
    super.key,
    this.height = 1,
    this.color,
    this.animate = true,
  });

  @override
  State<EnhancedDivider> createState() => _EnhancedDividerState();
}

class _EnhancedDividerState extends State<EnhancedDivider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _controller = AnimationController(
        duration: const Duration(milliseconds: 2000),
        vsync: this,
      )..repeat();
    }
  }

  @override
  void dispose() {
    if (widget.animate) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).dividerColor;

    if (!widget.animate) {
      return Divider(
        height: widget.height,
        color: color,
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(double.infinity, widget.height),
          painter: _DividerPainter(
            color: color,
            animationValue: _controller.value,
          ),
        );
      },
    );
  }
}

class _DividerPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  _DividerPainter({
    required this.color,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Static divider line
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    canvas.drawLine(Offset.zero, Offset(size.width, 0), paint);

    // Animated accent line
    final accentPaint = Paint()
      ..color = color.withOpacity(0.6)
      ..strokeWidth = 2;

    final width = size.width * 0.15;
    final startX = (size.width - width) * animationValue;

    canvas.drawLine(
      Offset(startX, 0),
      Offset(startX + width, 0),
      accentPaint,
    );
  }

  @override
  bool shouldRepaint(_DividerPainter oldDelegate) => true;
}

/// Smooth page transition widget
class PageTransition extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const PageTransition({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<PageTransition> createState() => _PageTransitionState();
}

class _PageTransitionState extends State<PageTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}

/// Gradient text widget for professional styling
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? baseStyle;
  final List<Color> gradientColors;
  final TextAlign? textAlign;

  const GradientText(
    this.text, {
    super.key,
    this.baseStyle,
    this.gradientColors = const [],
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final colors = gradientColors.isNotEmpty
        ? gradientColors
        : [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.7),
          ];

    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        text,
        style: baseStyle?.copyWith(color: Colors.white) ??
            Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                ),
        textAlign: textAlign,
      ),
    );
  }
}

/// Animated counter for statistics
class AnimatedCounter extends StatefulWidget {
  final int end;
  final Duration duration;
  final TextStyle? style;
  final String suffix;

  const AnimatedCounter({
    super.key,
    required this.end,
    this.duration = const Duration(milliseconds: 2000),
    this.style,
    this.suffix = '',
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = IntTween(begin: 0, end: widget.end).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          '${_animation.value}${widget.suffix}',
          style: widget.style ?? Theme.of(context).textTheme.headlineMedium,
        );
      },
    );
  }
}

/// Floating action button with animation
class AnimatedFAB extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String tooltip;
  final Color? backgroundColor;

  const AnimatedFAB({
    super.key,
    required this.onPressed,
    required this.icon,
    this.tooltip = '',
    this.backgroundColor,
  });

  @override
  State<AnimatedFAB> createState() => _AnimatedFABState();
}

class _AnimatedFABState extends State<AnimatedFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
      ),
      child: FloatingActionButton(
        onPressed: widget.onPressed,
        backgroundColor: widget.backgroundColor,
        tooltip: widget.tooltip,
        child: Icon(widget.icon),
      ),
    );
  }
}
