// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'animated_fade_in.dart';
import 'stagger_animation.dart';

/// Hero section for modern portfolio
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
    with SingleTickerProviderStateMixin {
  late AnimationController _floatingController;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Underlying content column
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main heading
              AnimatedFadeIn(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 600),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Hello, I\'m\n',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(context).hintColor,
                                    ),
                              ),
                              TextSpan(
                                text: 'Devendiran Thiyagarajan',
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 32),
                    // Keep space for visual balance when overlay present
                    const SizedBox(width: 140),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Subtitle
              AnimatedFadeIn(
                delay: const Duration(milliseconds: 400),
                duration: const Duration(milliseconds: 600),
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.6),
                    ],
                  ).createShader(bounds),
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Description
              AnimatedFadeIn(
                delay: const Duration(milliseconds: 600),
                duration: const Duration(milliseconds: 600),
                child: SizedBox(
                  width: 500,
                  child: Text(
                    widget.subtitle,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).hintColor,
                          height: 1.8,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // CTA Buttons
              AnimatedFadeIn(
                delay: const Duration(milliseconds: 800),
                duration: const Duration(milliseconds: 600),
                child: Row(
                  children: [
                    ScaleOnHover(
                      onTap: widget.onViewWork,
                      child: ElevatedButton(
                        onPressed: widget.onViewWork,
                        child: const Text('View My Work'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ScaleOnHover(
                      onTap: widget.onGetInTouch,
                      child: OutlinedButton(
                        onPressed: widget.onGetInTouch,
                        child: const Text('Get In Touch'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Large overlay logo that visually covers the heading/role/CTAs
          Positioned(
            top: -10,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _floatingController,
                builder: (context, child) {
                  final v = _floatingController.value;
                  final floatY = (v - 0.5) * 30; // up to +/-15px
                  // Reduce rotation so logo doesn't cross the text sharply
                  final rotate = (math.sin(v * 2 * math.pi) * 0.01) -
                      0.05; // small oscillation
                  final scale = 3.2 + (math.sin(v * 2 * math.pi) * 0.06);
                  return Transform.translate(
                    offset: Offset(0, floatY),
                    child: Transform.rotate(
                      angle: rotate,
                      child: Center(
                        child: SizedBox(
                          width: 420 * scale / 3.2,
                          height: 420 * scale / 3.2,
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Skill card widget
class SkillCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final List<String> tags;

  const SkillCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleOnHover(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                  size: 28,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tags
                    .map((tag) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2),
                            ),
                          ),
                          child: Text(
                            tag,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Featured project card
class FeaturedProjectCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final List<String> tech;
  final VoidCallback? onTap;

  const FeaturedProjectCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.tech,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleOnHover(
      onTap: onTap,
      scaleFactor: 1.02,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).hintColor,
                      height: 1.6,
                    ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: tech
                    .map((t) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            t,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
