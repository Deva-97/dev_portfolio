import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/responsive.dart';
import '../../data/data_sources/project_data.dart';
import '../../data/data_sources/experience_data.dart';
import '../widgets/responsive_appbar.dart';
import '../widgets/section_title.dart';
import '../widgets/project_card.dart';
import '../widgets/animated_fade_in.dart';

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

  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
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
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      appBar: ResponsiveAppBar(
        onToggleTheme: widget.onToggleTheme,
        themeMode: widget.themeMode,
        onAboutTap: () => _scrollToSection(_aboutKey),
        onExperienceTap: () => _scrollToSection(_experienceKey),
        onProjectsTap: () => _scrollToSection(_projectsKey),
        onContactTap: () => _scrollToSection(_contactKey),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: isMobile
                ? _buildMobileLayout(context)
                : _buildDesktopLayout(context, isDesktop: isDesktop),
          ),
        ),
      ),
    );
  }

  // ----------------- LAYOUTS -----------------

  Widget _buildDesktopLayout(BuildContext context, {required bool isDesktop}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // First row: profile + intro
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: isDesktop ? 260 : 220,
              child: _buildProfileColumn(context, isDesktop: isDesktop),
            ),
            const SizedBox(width: 28),
            Expanded(child: _buildIntro(context)),
          ],
        ),
        const SizedBox(height: 32),

        // About
        Container(
          key: _aboutKey,
          child: _buildAboutSection(context),
        ),
        const SizedBox(height: 32),

        // Experience
        Container(
          key: _experienceKey,
          child: _buildExperienceSection(context),
        ),
        const SizedBox(height: 32),

        // Projects
        Container(
          key: _projectsKey,
          child: _buildSelectedProjectsSection(context),
        ),
        const SizedBox(height: 32),

        // Contact + Footer
        Container(
          key: _contactKey,
          child: _buildContactSection(context),
        ),
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 12),
        _buildFooter(context),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProfileColumn(context, isDesktop: false),
        const SizedBox(height: 24),
        _buildIntro(context),
        const SizedBox(height: 32),
        Container(
          key: _aboutKey,
          child: _buildAboutSection(context),
        ),
        const SizedBox(height: 32),
        Container(
          key: _experienceKey,
          child: _buildExperienceSection(context),
        ),
        const SizedBox(height: 32),
        Container(
          key: _projectsKey,
          child: _buildSelectedProjectsSection(context),
        ),
        const SizedBox(height: 32),
        Container(
          key: _contactKey,
          child: _buildContactSection(context),
        ),
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 12),
        _buildFooter(context),
      ],
    );
  }

  // ----------------- SECTIONS -----------------

  Widget _buildProfileColumn(BuildContext context, {required bool isDesktop}) {
    final imageSize = isDesktop ? 220.0 : 140.0;

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/profile.jpg',
            width: imageSize,
            height: imageSize,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            OutlinedButton.icon(
              icon: const Icon(Icons.link),
              onPressed: () =>
                  _openUrl('https://www.linkedin.com/in/devendiran-t'),
              label: const Text('LinkedIn'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIntro(BuildContext context) {
    return AnimatedFadeIn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello, I'm",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 6),
          Text(
            'Devendiran T',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 6),
          Text(
            'Flutter Developer • Cross-platform App Developer',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Text(
            'I build production-ready Flutter apps with clean architecture, '
            'real-time features (MQTT/Firebase), and AI integrations.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              OutlinedButton(
                onPressed: () => _openUrl('/Devendiran_resume_2025.pdf'),
                child: const Text('Resume'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'About'),
        Text(
          'Flutter Developer with 2+ years of experience building high-performance apps. '
          'Passionate about clean architecture, realtime systems, and AI features integrated '
          'into practical products like smart home and workspace apps.',
        ),
      ],
    );
  }

  Widget _buildExperienceSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Experience'),
        ...experienceList.map((e) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.company,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${e.role} • ${e.duration}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  ...e.highlights.map(
                    (h) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('•  '),
                        Expanded(child: Text(h)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSelectedProjectsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'My Projects',
          subtitle: 'A few projects that demonstrate my work',
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: projectList.length,
          itemBuilder: (context, index) {
            return ProjectCard(
              project: projectList[index],
              index: index,
            );
          },
        ),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Contact'),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () => _openUrl('mailto:devendiran03@gmail.com'),
          child: Text(
            'Email: devendiran03@gmail.com',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(decoration: TextDecoration.underline),
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _openUrl('https://www.linkedin.com/in/devendiran-t'),
          child: Text(
            'LinkedIn: linkedin.com/in/devendiran-t',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(decoration: TextDecoration.underline),
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _openUrl('tel:+919952583296'),
          child: Text(
            'Mobile: +91-99525-83296',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Center(
      child: Text(
        'Built with Flutter • © 2025 Devendiran T',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  // ----------------- UTIL -----------------

  void _openUrl(String url) async {
    Uri uri;
    if (url.startsWith('/')) {
      final origin = Uri.base.origin;
      uri = Uri.parse(origin + url);
    } else {
      uri = Uri.parse(url);
    }

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
