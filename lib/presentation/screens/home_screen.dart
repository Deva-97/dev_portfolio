// ignore_for_file: deprecated_member_use

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../data/data_sources/project_data.dart';
import '../widgets/responsive_appbar.dart';
import '../widgets/project_card.dart';
import '../widgets/animated_fade_in.dart';
import '../widgets/enhanced_widgets.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/section_title.dart';
import '../widgets/experience_timeline.dart';

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
  bool _showAppBarName = false;

  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollState);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage('assets/images/logo.png'), context);
      for (final p in projectList) {
        if (p.image != null) {
          precacheImage(AssetImage(p.image!), context);
        }
      }
    });
  }

  void _updateScrollState() {
    final showFab = _scrollController.offset > 300;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 900;
    final isMobile = screenWidth < 600;
    final scrollThreshold = isDesktop ? 150.0 : (isMobile ? 420.0 : 0.0);
    final showName = _scrollController.offset > scrollThreshold;

    if (showFab != _showFAB || showName != _showAppBarName) {
      setState(() {
        _showFAB = showFab;
        _showAppBarName = showName;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollState);
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
      alignment: 0.05,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      appBar: ResponsiveAppBar(
        onToggleTheme: widget.onToggleTheme,
        themeMode: widget.themeMode,
        showName: _showAppBarName,
        onAboutTap: () => _scrollToSection(_aboutKey),
        onExperienceTap: () => _scrollToSection(_experienceKey),
        onSkillsTap: () => _scrollToSection(_skillsKey),
        onProjectsTap: () => _scrollToSection(_projectsKey),
        onContactTap: () => _scrollToSection(_contactKey),
      ),
      body: SelectionArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: Column(
                children: [
                  // ── Hero ──
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20 : 56,
                    ),
                    child: HeroSection(
                      name: 'Devendiran Thiyagarajan',
                      title: 'Flutter Developer',
                      subtitle:
                          'I build production-ready Flutter applications with a focus on real-time functionality, scalable architecture, and smooth user experience. 3+ years shipping cross-platform apps across Android, iOS, and Web.',
                      onViewWork: () => _scrollToSection(_projectsKey),
                      onGetInTouch: () => _scrollToSection(_contactKey),
                    ),
                  ),

                  // ── About ──
                  Container(
                    key: _aboutKey,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20 : 56,
                      vertical: isMobile ? 40 : 72,
                    ),
                    child: AboutSection(isMobile: isMobile),
                  ),

                  // ── Experience ──
                  Container(
                    key: _experienceKey,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20 : 56,
                      vertical: isMobile ? 40 : 72,
                    ),
                    child: _buildExperienceSection(context),
                  ),

                  // ── Skills ──
                  Container(
                    key: _skillsKey,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20 : 56,
                      vertical: isMobile ? 40 : 72,
                    ),
                    child: _buildSkillsSection(context, isMobile),
                  ),

                  // ── Projects ──
                  Container(
                    key: _projectsKey,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20 : 56,
                      vertical: isMobile ? 40 : 72,
                    ),
                    child: _buildProjectsSection(context, isMobile),
                  ),

                  // ── Contact ──
                  Container(
                    key: _contactKey,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20 : 56,
                      vertical: isMobile ? 40 : 72,
                    ),
                    child: _buildContactSection(context, isMobile),
                  ),

                  // ── Footer ──
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: _buildFooter(context, isMobile),
                  ),
                ],
              ),
            ),
          ),
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
              icon: Icons.arrow_upward_rounded,
              tooltip: 'Back to top',
            )
          : null,
    );
  }

  // ── EXPERIENCE ────────────────────────────────────────────────
  Widget _buildExperienceSection(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SectionTitle(
          title: 'Experience',
          useGradient: true,
          tag: 'WORK HISTORY',
        ),
        SizedBox(height: 48),
        ExperienceTimeline(),
      ],
    );
  }

  // ── SKILLS ────────────────────────────────────────────────────
  Widget _buildSkillsSection(BuildContext context, bool isMobile) {
    final skillGroups = _getSkillGroups();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SectionTitle(
          title: 'Skills & Tech',
          useGradient: true,
          tag: 'WHAT I WORK WITH',
        ),
        const SizedBox(height: 48),
        ...skillGroups.map((group) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: _buildSkillGroup(context, group, isMobile),
          );
        }),
      ],
    );
  }

  Widget _buildSkillGroup(
    BuildContext context,
    Map<String, dynamic> group,
    bool isMobile,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tags = group['tags'] as List<String>;
    final icon = group['icon'] as IconData;
    final label = group['label'] as String;

    return AnimatedFadeIn(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCardBg : AppColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.borderLight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 18),
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: tags.map((tag) => _SkillTag(tag: tag)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getSkillGroups() {
    return [
      {
        'label': 'Languages & Framework',
        'icon': Icons.flutter_dash,
        'tags': [
          'Flutter',
          'Dart',
          'Kotlin (Basic)',
          'Flutter Web',
          'Flutter Android',
          'Flutter iOS'
        ],
      },
      {
        'label': 'Architecture & State Management',
        'icon': Icons.architecture,
        'tags': [
          'Clean Architecture',
          'MVVM',
          'GetX',
          'Provider',
          'BLoC',
          'get_it',
          'hive'
        ],
      },
      {
        'label': 'Backend, Real-time & AI',
        'icon': Icons.cloud_outlined,
        'tags': [
          'Firebase (Firestore, Auth, FCM, Crashlytics, Storage, Remote Config)',
          'REST APIs',
          'MQTT',
          'LiveKit SDK',
          'Real-time Chat',
          'OpenAI ChatGPT API',
          'Text-to-Speech',
          'Speech-to-Text',
        ],
      },
      {
        'label': 'Mobile Features & Integrations',
        'icon': Icons.smartphone_outlined,
        'tags': [
          'Push Notifications',
          'Google Maps API',
          'Home Screen Widgets',
          'Siri (HomeKit)',
          'Alexa',
          'In-app Payments',
          'Media Uploads',
        ],
      },
      {
        'label': 'DevOps & Platforms',
        'icon': Icons.rocket_launch_outlined,
        'tags': [
          'Google Play Store',
          'Apple App Store',
          'TestFlight',
          'Firebase App Distribution',
          'GitHub',
          'Jira',
          'Android Studio',
          'VS Code',
          'Xcode',
        ],
      },
    ];
  }

  // ── PROJECTS ──────────────────────────────────────────────────
  Widget _buildProjectsSection(BuildContext context, bool isMobile) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SectionTitle(
          title: 'Projects',
          useGradient: true,
          tag: 'WHAT I\'VE BUILT',
        ),
        const SizedBox(height: 48),
        if (isDesktop)
          _buildProjectGrid(context)
        else
          _buildProjectList(context),
      ],
    );
  }

  Widget _buildProjectGrid(BuildContext context) {
    // 2-column grid on desktop
    final rows = <Widget>[];
    for (int i = 0; i < projectList.length; i += 2) {
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ProjectCard(project: projectList[i], index: i),
              ),
              const SizedBox(width: 24),
              if (i + 1 < projectList.length)
                Expanded(
                  child: ProjectCard(project: projectList[i + 1], index: i + 1),
                )
              else
                const Expanded(child: SizedBox()),
            ],
          ),
        ),
      );
    }
    return Column(children: rows);
  }

  Widget _buildProjectList(BuildContext context) {
    return Column(
      children: projectList.asMap().entries.map((e) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ProjectCard(project: e.value, index: e.key),
        );
      }).toList(),
    );
  }

  // ── CONTACT ───────────────────────────────────────────────────
  Widget _buildContactSection(BuildContext context, bool isMobile) {
    const resumeUrl = 'Devendiran Resume.pdf';
    final contactItems = [
      {
        'icon': Icons.email_outlined,
        'label': 'Email',
        'value': 'devendiran03@gmail.com',
        'url': 'mailto:devendiran03@gmail.com',
        'svgAsset': null,
      },
      {
        'icon': Icons.phone_outlined,
        'label': 'Phone',
        'value': '+91 9952583296',
        'url': 'tel:+919952583296',
        'svgAsset': null,
      },
      {
        'icon': null,
        'svgAsset': 'assets/images/linkedin.svg',
        'label': 'LinkedIn',
        'value': 'linkedin.com/in/devendiran-t',
        'url': 'https://linkedin.com/in/devendiran-t',
      },
      {
        'icon': null,
        'svgAsset': 'assets/images/resume.svg',
        'label': 'Resume',
        'value': 'Download PDF',
        'url': resumeUrl,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SectionTitle(
          title: "Let's Connect",
          useGradient: true,
          tag: 'GET IN TOUCH',
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            "I'm open to full-time Flutter developer roles and collaborative product teams. Whether you have a role, a project, or just want to say hi — reach out.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).hintColor,
                  height: 1.8,
                  fontSize: isMobile ? 15 : 17,
                ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 40),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = isMobile || constraints.maxWidth < 900 ? 1 : 2;
            const spacing = 16.0;
            final cardWidth = columns == 1
                ? constraints.maxWidth
                : (constraints.maxWidth - spacing) / 2;

            return Wrap(
              alignment: WrapAlignment.center,
              spacing: spacing,
              runSpacing: spacing,
              children: contactItems.map((item) {
                return SizedBox(
                  width: math.min(cardWidth, 520).toDouble(),
                  child: _ContactCard(
                    icon: item['icon'] as IconData?,
                    svgAsset: item['svgAsset'] as String?,
                    label: item['label'] as String,
                    value: item['value'] as String,
                    url: item['url'] as String,
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  // ── FOOTER ────────────────────────────────────────────────────
  Widget _buildFooter(BuildContext context, bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(
        children: [
          // Gradient divider
          Container(
            height: 1,
            margin: const EdgeInsets.only(bottom: 28),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.primary,
                  Colors.transparent
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.emerald,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.emerald.withOpacity(0.5),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Available · Full-time Flutter Developer',
                style: TextStyle(
                  color: AppColors.emerald,
                  fontSize: isMobile ? 13 : 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Open to roles in',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                  fontSize: isMobile ? 12 : 13,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            'Chennai · Bangalore · Hyderabad · Remote',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                  fontSize: isMobile ? 12 : 13,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            '© 2026 Devendiran Thiyagarajan',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                  fontSize: 12,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 4,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed(AppRoutes.ninaivuPrivacyPolicy),
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  foregroundColor: Theme.of(context).hintColor,
                  textStyle: const TextStyle(fontSize: 12),
                ),
                child: const Text('Ninaivu Privacy Policy'),
              ),
              Text('·', style: TextStyle(color: Theme.of(context).hintColor)),
              TextButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed(AppRoutes.ninaivuDeleteAccount),
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  foregroundColor: Theme.of(context).hintColor,
                  textStyle: const TextStyle(fontSize: 12),
                ),
                child: const Text('Ninaivu Delete Account'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── CONTACT CARD ──────────────────────────────────────────────────

class _ContactCard extends StatefulWidget {
  final IconData? icon;
  final String? svgAsset;
  final String label;
  final String value;
  final String url;

  const _ContactCard({
    this.icon,
    this.svgAsset,
    required this.label,
    required this.value,
    required this.url,
  }) : assert(icon != null || svgAsset != null, 'icon or svgAsset required');

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 180),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primary = AppColors.primary;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovered = true);
        _ctrl.forward();
      },
      onExit: (_) {
        setState(() => _hovered = false);
        _ctrl.reverse();
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _openUrl,
        child: AnimatedBuilder(
          animation: _ctrl,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, -3 * _ctrl.value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCardBg : AppColors.cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _hovered
                        ? primary.withOpacity(0.45)
                        : (isDark
                            ? AppColors.darkBorder
                            : AppColors.borderLight),
                    width: _hovered ? 1.5 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primary.withOpacity(0.10 * _ctrl.value),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                    if (!isDark)
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                  ],
                ),
                child: child,
              ),
            );
          },
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _hovered
                      ? primary
                      : primary.withOpacity(isDark ? 0.15 : 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: widget.svgAsset != null
                    ? SvgPicture.asset(
                        widget.svgAsset!,
                        width: 22,
                        height: 22,
                        colorFilter: ColorFilter.mode(
                          _hovered ? Colors.white : primary,
                          BlendMode.srcIn,
                        ),
                      )
                    : Icon(
                        widget.icon,
                        color: _hovered ? Colors.white : primary,
                        size: 22,
                      ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      widget.value,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: _hovered ? primary : null,
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color:
                      _hovered ? primary.withOpacity(0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.arrow_outward_rounded,
                  size: 18,
                  color: _hovered ? primary : primary.withOpacity(0.35),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openUrl() async {
    if (widget.url.contains('Devendiran Resume')) {
      html.window.open(widget.url, '_blank');
      return;
    }
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

// ── SKILL TAG ────────────────────────────────────────────────────

class _SkillTag extends StatefulWidget {
  final String tag;

  const _SkillTag({required this.tag});

  @override
  State<_SkillTag> createState() => _SkillTagState();
}

class _SkillTagState extends State<_SkillTag>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 150),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovered = true);
        _ctrl.forward();
      },
      onExit: (_) {
        setState(() => _hovered = false);
        _ctrl.reverse();
      },
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, _) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _hovered
                  ? AppColors.primary.withOpacity(0.15)
                  : (isDark ? AppColors.darkSurface : AppColors.lightSurface),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _hovered
                    ? AppColors.primary.withOpacity(0.4)
                    : (isDark ? AppColors.darkBorder : AppColors.borderLight),
              ),
            ),
            child: Text(
              widget.tag,
              style: TextStyle(
                color:
                    _hovered ? AppColors.primary : Theme.of(context).hintColor,
                fontSize: 12,
                fontWeight: _hovered ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          );
        },
      ),
    );
  }
}
