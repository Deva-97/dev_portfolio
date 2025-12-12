// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/responsive.dart';
import '../../data/data_sources/project_data.dart';
import '../widgets/responsive_appbar.dart';
import '../widgets/project_card.dart';
import '../widgets/animated_fade_in.dart';
import '../widgets/stagger_animation.dart';
import '../widgets/enhanced_widgets.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onToggleTheme;
  final ThemeMode themeMode;

  const HomeScreen({
    super.key,
    this.onToggleTheme,
    required this.themeMode,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showFAB = false;

  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateFAB);
  }

  void _updateFAB() {
    final show = _scrollController.offset > 300;
    if (show != _showFAB) {
      setState(() => _showFAB = show);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateFAB);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollToSection(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) return;

    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      alignment: 0.1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      appBar: ResponsiveAppBar(
        onToggleTheme: widget.onToggleTheme,
        themeMode: widget.themeMode,
        onAboutTap: () => _scrollToSection(_aboutKey),
        onExperienceTap: () => _scrollToSection(_skillsKey),
        onProjectsTap: () => _scrollToSection(_projectsKey),
        onContactTap: () => _scrollToSection(_contactKey),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Hero Section
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 48,
                vertical: 0,
              ),
              child: HeroSection(
                name: 'Devendiran Thiyagarajan',
                title: 'Flutter Developer',
                subtitle:
                    'I create high-quality Flutter apps with a focus on real-time capabilities, smooth UI interactions, and scalable architecture. My work spans smart home automation, enterprise systems, and AI-powered applications.',
                onViewWork: () => _scrollToSection(_projectsKey),
                onGetInTouch: () => _scrollToSection(_contactKey),
              ),
            ),

            // Statistics Section
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 48,
                vertical: 40,
              ),
              child: _buildStatsSection(context, isMobile),
            ),

            const Divider(height: 1),

            // About Section
            Container(
              key: _aboutKey,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 48,
                vertical: 60,
              ),
              child: _buildAboutSection(context, isMobile),
            ),

            const Divider(height: 1),

            // Skills Section
            Container(
              key: _skillsKey,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 48,
                vertical: 60,
              ),
              child: _buildSkillsSection(context, isMobile),
            ),

            const Divider(height: 1),

            // Projects Section
            Container(
              key: _projectsKey,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 48,
                vertical: 60,
              ),
              child: _buildProjectsSection(context, isMobile),
            ),

            const Divider(height: 1),

            // Contact Section
            Container(
              key: _contactKey,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 48,
                vertical: 60,
              ),
              child: _buildContactSection(context, isMobile),
            ),

            // Footer
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: _buildFooter(context),
            ),
          ],
        ),
      ),
      floatingActionButton: _showFAB
          ? AnimatedFAB(
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              icon: Icons.arrow_upward,
              tooltip: 'Scroll to top',
            )
          : null,
    );
  }

  Widget _buildStatsSection(BuildContext context, bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem(context, '2+', 'Years Experience'),
        _buildStatItem(context, '10+', 'Projects Completed'),
        _buildStatItem(context, '5+', 'Happy Clients'),
      ],
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context, bool isMobile) {
    return AboutSection(isMobile: isMobile);
  }

  Widget _buildSkillsSection(BuildContext context, bool isMobile) {
    final skills = _getSkills();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Skills & Technologies',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFF1F2937)
                    : null,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                isMobile ? 1 : (Responsive.isTablet(context) ? 2 : 3),
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            childAspectRatio: 0.95,
          ),
          itemCount: skills.length,
          itemBuilder: (context, index) {
            final skill = skills[index];
            return AnimatedFadeIn(
              delay: Duration(milliseconds: 100 * index),
              child: SkillCard(
                icon: skill['icon'] as IconData,
                title: skill['title'] as String,
                description: skill['description'] as String,
                tags: skill['tags'] as List<String>,
              ),
            );
          },
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getSkills() {
    return [
      {
        'icon': Icons.flutter_dash,
        'title': 'Flutter',
        'description':
            'Building beautiful, fast, and natively compiled multi-platform applications',
        'tags': ['Mobile', 'UI/UX', 'Cross-Platform']
      },
      {
        'icon': Icons.code,
        'title': 'Dart',
        'description':
            'Object-oriented programming with strong typing and async/await patterns',
        'tags': ['OOP', 'Async', 'Type Safe']
      },
      {
        'icon': Icons.cloud,
        'title': 'Firebase',
        'description':
            'Cloud infrastructure for authentication, real-time databases, and hosting',
        'tags': ['Backend', 'Database', 'Auth']
      },
      {
        'icon': Icons.storage,
        'title': 'State Management',
        'description':
            'Provider, Riverpod, BLoC patterns for scalable app architecture',
        'tags': ['Architecture', 'Performance', 'Scalability']
      },
      {
        'icon': Icons.api,
        'title': 'REST APIs',
        'description':
            'HTTP integration, JSON parsing, and API design patterns',
        'tags': ['Backend', 'Integration', 'Networking']
      },
      {
        'icon': Icons.build,
        'title': 'Git & CI/CD',
        'description': 'Version control and automated deployment pipelines',
        'tags': ['DevOps', 'Automation', 'Collaboration']
      },
    ];
  }

  Widget _buildProjectsSection(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Featured Projects',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFF1F2937)
                    : null,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        StaggeredAnimation(
          children: projectList.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: ProjectCard(
                project: entry.value,
                index: entry.key,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Get In Touch',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFF1F2937)
                    : null,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Text(
          'I\'m currently available for freelance work and exciting opportunities. Let\'s build something amazing together!',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).hintColor,
                height: 1.8,
              ),
        ),
        const SizedBox(height: 40),
        StaggeredAnimation(
          children: [
            _buildContactCard(
              context,
              icon: Icons.email_outlined,
              label: 'Email',
              value: 'devendiran03@gmail.com',
              url: 'mailto:devendiran03@gmail.com',
            ),
            _buildContactCard(
              context,
              icon: Icons.language,
              label: 'GitHub',
              value: 'github.com/devendiran',
              url: 'https://github.com',
            ),
            _buildContactCard(
              context,
              icon: Icons.work_outline,
              label: 'LinkedIn',
              value: 'linkedin.com/in/devendiran-t',
              url: 'https://linkedin.com/in/devendiran-t',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required String url,
  }) {
    return ScaleOnHover(
      onTap: () => _openUrl(url),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).dividerColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).hintColor,
                        ),
                  ),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_outward,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Text(
          'Built with Flutter Spirit',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Â© 2024 Devendiran Thiyagarajan. All rights reserved.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).hintColor,
              ),
        ),
      ],
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
