// ignore_for_file: deprecated_member_use

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import '../widgets/section_title.dart';

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
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollState);

    // Precache key images (logo + featured project images) after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage('assets/images/logo.png'), context);
      for (final p in projectList) {
        precacheImage(AssetImage(p.image), context);
      }
    });
  }

  void _updateScrollState() {
    final showFab = _scrollController.offset > 300;
    // Show name after hero name is scrolled out
    // Desktop (>=900): ~150px (padding + greeting + name on side layout)
    // Tablet (600-899): show immediately
    // Mobile (<600): ~420px (padding + logo ~280 + spacing 40 + greeting + name centered)
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktopLayout = screenWidth >= 900;
    final isMobileLayout = screenWidth < 600;
    final scrollThreshold = isDesktopLayout ? 150.0 : (isMobileLayout ? 420.0 : 0.0);
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
        showName: _showAppBarName,
        onAboutTap: () => _scrollToSection(_aboutKey),
        onExperienceTap: () => _scrollToSection(_skillsKey),
        onProjectsTap: () => _scrollToSection(_projectsKey),
        onContactTap: () => _scrollToSection(_contactKey),
      ),
      body: SelectionArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1240),
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
                        'I build production-ready Flutter applications with a strong focus on real-time functionality, scalable architecture, and smooth user experience. With 2+ years of hands-on experience, I\'ve worked on smart home automation systems, enterprise mobile solutions, and AI-powered applications across Android, iOS, and tablet platforms.',
                    onViewWork: () => _scrollToSection(_projectsKey),
                    onGetInTouch: () => _scrollToSection(_contactKey),
                  ),
                ),

                // About and Skills stacked full width on mobile
                if (isMobile) ...[
                  Container(
                    key: _aboutKey,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                    child: _buildAboutSection(context, isMobile),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    key: _skillsKey,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                    child: _buildSkillsSection(context, isMobile),
                  ),
                ] else ...[
                  Container(
                    key: _aboutKey,
                    padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 60),
                    child: _buildAboutSection(context, isMobile),
                  ),
                  Container(
                    key: _skillsKey,
                    padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 60),
                    child: _buildSkillsSection(context, isMobile),
                  ),
                ],

                // Projects Section
                Container(
                  key: _projectsKey,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 20 : 48,
                    vertical: 60,
                  ),
                  child: _buildProjectsSection(context, isMobile),
                ),

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
              icon: Icons.arrow_upward,
              tooltip: 'Scroll to top',
            )
          : null,
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
        const SectionTitle(title: 'Skills & Technologies', useGradient: true),
        const SizedBox(height: 32),
        LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final isMobile = maxWidth <= 600;
            // 3 columns on desktop (>900), 2 on tablet and mobile (<=900) to show two cards in a row on small screens
            final crossAxisCount = maxWidth > 900 ? 3 : 2;
            // Aspect ratio - desktop: short cards, tablet: medium, mobile: much taller cards to fit all content
            final aspectRatio = maxWidth > 900
                ? 1.4
                : maxWidth > 600
                  ? 1.9
                  : 0.80; // Slightly decrease aspect ratio for mobile to increase card height
            // Spacing - desktop 24, tablet 20, mobile 24 (more vertical gap for mobile)
            final spacing = maxWidth > 900 ? 24.0 : (maxWidth > 600 ? 20.0 : 24.0);
            return Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: spacing,
                    crossAxisSpacing: spacing,
                    childAspectRatio: aspectRatio,
                  ),
                  itemCount: skills.length,
                  itemBuilder: (context, index) {
                    final skill = skills[index];
                    return AnimatedFadeIn(
                      delay: Duration(milliseconds: 80 * index),
                      child: SkillCard(
                        icon: skill['icon'] as IconData,
                        title: skill['title'] as String,
                        description: skill['description'] as String,
                        assetPath: skill['asset'] as String?,
                      ),
                    );
                  },
                ),
                if (isMobile) const SizedBox(height: 24),
              ],
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
        'asset': 'assets/images/flutter logo.svg',
        'title': 'Flutter Development',
        'description': 'Cross-platform application development using Flutter with focus on performance and clean UI.',
      },
      {
        'icon': Icons.code,
        'asset': 'assets/images/dart.svg',
        'title': 'Dart Programming',
        'description': 'Writing clean and structured Dart code for scalable Flutter applications.',
      },
      {
        'icon': Icons.architecture,
        'asset': 'assets/images/architecture.png',
        'title': 'App Architecture',
        'description': 'Designing Flutter applications using Clean Architecture and MVVM patterns.',
      },
      {
        'icon': Icons.account_tree,
        'asset': 'assets/images/state_management.png',
        'title': 'State Management',
        'description': 'Managing application state using Provider and BLoC for predictable app behavior.',
      },
      {
        'icon': Icons.cloud,
        'asset': 'assets/images/firebase.svg',
        'title': 'Firebase Integration',
        'description': 'Using Firebase for authentication, databases, notifications, and crash monitoring.',
      },
      {
        'icon': Icons.sensors,
        'asset': 'assets/images/mqtt.svg',
        'title': 'Real-Time Communication',
        'description': 'Implementing real-time communication using MQTT for automation and IoT apps.',
      },
      {
        'icon': Icons.api,
        'asset': 'assets/images/api.svg',
        'title': 'API Integration',
        'description': 'Integrating REST APIs for asynchronous data handling and app communication.',
      },
      {
        'icon': Icons.devices,
        'asset': 'assets/images/devices.png',
        'title': 'Multi-Platform UI',
        'description': 'Building responsive and adaptive UI for Android, iOS, and tablet devices.',
      },
      {
        'icon': Icons.device_hub,
        'asset': 'assets/images/github_logo.svg',
        'title': 'Development Tools',
        'description': 'Using Git, GitHub, Android Studio, VS Code, and Xcode for development workflows.',
      },
      {
        'icon': Icons.upload,
        'asset': 'assets/images/app_deployment.png',
        'title': 'App Deployment',
        'description': 'Managing build configurations and deploying apps to Play Store and App Store.',
      },
    ];
  }

  Widget _buildProjectsSection(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SectionTitle(title: 'Featured Projects', useGradient: true),
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
    const resumeUrl = 'Devendiran_Thiyagarajan_Resume.pdf';
    final contactItems = [
      {
        'icon': Icons.email_outlined,
        'label': 'Email',
        'value': 'devendiran03@gmail.com',
        'url': 'mailto:devendiran03@gmail.com',
      },
      {
        'icon': Icons.phone,
        'label': 'Phone',
        'value': '+91 9952583296',
        'url': 'tel:+919952583296',
      },
      {
        'svgAsset': 'assets/images/linkedin.svg',
        'label': 'LinkedIn',
        'value': 'linkedin.com/in/devendiran-t',
        'url': 'https://linkedin.com/in/devendiran-t',
      },
      {
        'svgAsset': 'assets/images/resume.svg',
        'label': 'Resume',
        'value': 'View Resume PDF',
        'url': resumeUrl,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SectionTitle(title: 'Get In Touch', useGradient: true),
        const SizedBox(height: 24),
        Text(
          'I\'m currently open to full-time Flutter developer opportunities and team-based product roles. Feel free to reach out if you\'d like to connect or discuss a role.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).hintColor,
                height: 1.8,
                fontSize: Responsive.isMobile(context) ? 17 : null,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            const spacing = 20.0;
            final columns = isMobile || maxWidth < 900 ? 1 : 2;
            final cardWidth = math.min(
              (maxWidth - spacing * (columns - 1)) / columns,
              520,
            ).toDouble();

            return Wrap(
              alignment: WrapAlignment.center,
              spacing: spacing,
              runSpacing: spacing,
              children: contactItems.map((item) {
                final icon = item['icon'] as IconData?;
                final svgAsset = item['svgAsset'] as String?;
                return SizedBox(
                  width: cardWidth,
                  child: _buildContactCard(
                    context,
                    icon: icon,
                    svgAsset: svgAsset,
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

  Widget _buildContactCard(
    BuildContext context, {
    IconData? icon,
    String? svgAsset,
    required String label,
    required String value,
    required String url,
  }) {
    return _ContactCardHover(
      icon: icon,
      svgAsset: svgAsset,
      label: label,
      value: value,
      url: url,
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        children: [
          Text(
            'Availability: Full-time Flutter Developer',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                  // Reduce font size on mobile so each line stays inline
                  fontSize: Responsive.isMobile(context) ? 13 : 18,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            'Locations: Chennai | Bangalore | Hyderabad',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                  fontSize: Responsive.isMobile(context) ? 13 : 18,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            '© 2025 Devendiran Thiyagarajan',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ContactCardHover extends StatefulWidget {
  final IconData? icon;
  final String? svgAsset;
  final String label;
  final String value;
  final String url;

  const _ContactCardHover({
    this.icon,
    this.svgAsset,
    required this.label,
    required this.value,
    required this.url,
  }) : assert(icon != null || svgAsset != null, 'Either icon or svgAsset must be provided');

  @override
  State<_ContactCardHover> createState() => _ContactCardHoverState();
}

class _ContactCardHoverState extends State<_ContactCardHover>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool hovered) {
    setState(() => _isHovered = hovered);
    if (hovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _openUrl(),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final scale = 1.0 + (_controller.value * 0.02);
            final translateY = -3 * _controller.value;

            return Transform.translate(
              offset: Offset(0, translateY),
              child: Transform.scale(
                scale: scale,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF1E293B)
                        : Colors.white,
                    border: Border.all(
                      color: _isHovered
                          ? primaryColor.withOpacity(0.5)
                          : (isDark
                              ? const Color(0xFF334155)
                              : const Color(0xFFE2E8F0)),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.1 * _controller.value),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                      if (!isDark)
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                    ],
                  ),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _isHovered
                              ? primaryColor
                              : primaryColor.withOpacity(isDark ? 0.15 : 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: widget.svgAsset != null
                            ? SvgPicture.asset(
                                widget.svgAsset!,
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                  _isHovered ? Colors.white : primaryColor,
                                  BlendMode.srcIn,
                                ),
                              )
                            : Icon(
                                widget.icon,
                                color: _isHovered ? Colors.white : primaryColor,
                                size: 24,
                              ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.label,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).hintColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Responsive.isMobile(context) ? 14 : null,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.value,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: _isHovered ? primaryColor : null,
                                      fontSize: Responsive.isMobile(context) ? 14 : null,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _isHovered
                              ? primaryColor.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.arrow_outward_rounded,
                          color: _isHovered
                              ? primaryColor
                              : primaryColor.withOpacity(0.4),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _openUrl() async {
    // Check if it's a resume PDF
    if (widget.url.contains('Devendiran_Thiyagarajan_Resume')) {
      // Open PDF in new browser tab for viewing/printing/downloading
      html.window.open(widget.url, '_blank');
    } else {
      final uri = Uri.parse(widget.url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      }
    }
  }
}
