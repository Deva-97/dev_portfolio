import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../data/data_sources/project_data.dart';
import '../widgets/about_section.dart';
import '../widgets/experience_timeline.dart';
import '../widgets/hero_section.dart';
import '../widgets/project_card.dart';
import '../widgets/responsive_appbar.dart';
import '../widgets/section_title.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onToggleTheme;
  final ThemeMode themeMode;
  const HomeScreen({super.key, this.onToggleTheme, required this.themeMode});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scroll = ScrollController();
  final _about = GlobalKey();
  final _experience = GlobalKey();
  final _skills = GlobalKey();
  final _projects = GlobalKey();
  final _contact = GlobalKey();

  void _to(GlobalKey key) {
    final target = key.currentContext;
    if (target != null) {
      Scrollable.ensureVisible(target,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
          alignment: .04);
    }
  }

  Future<void> _resume() =>
      launchUrl(Uri.parse('Devendiran%20Flutter%20Developer%20Resume.pdf'));

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pad = Responsive.isMobile(context) ? 20.0 : 52.0;
    return Scaffold(
        appBar: ResponsiveAppBar(
            onToggleTheme: widget.onToggleTheme,
            themeMode: widget.themeMode,
            showName: true,
            onAboutTap: () => _to(_about),
            onExperienceTap: () => _to(_experience),
            onSkillsTap: () => _to(_skills),
            onProjectsTap: () => _to(_projects),
            onContactTap: () => _to(_contact),
            onResumeTap: _resume),
        body: SelectionArea(
            child: SingleChildScrollView(
                controller: _scroll,
                child: Center(
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1280),
                        child: Column(children: [
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: pad),
                              child: HeroSection(
                                  onViewWork: () => _to(_projects),
                                  onResume: _resume)),
                          _section(_projects, pad, _featured(context)),
                          _section(
                              _about,
                              pad,
                              AboutSection(
                                  isMobile: Responsive.isMobile(context))),
                          _section(
                              _experience,
                              pad,
                              const Column(children: [
                                SectionTitle(
                                    title: 'Experience', tag: 'CAREER'),
                                SizedBox(height: 34),
                                ExperienceTimeline()
                              ])),
                          _section(_skills, pad, _skillsView(context)),
                          _section(_contact, pad, _contactView(context)),
                          _footer(context),
                        ]))))));
  }

  Widget _section(GlobalKey key, double pad, Widget child) => Container(
      key: key,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(pad, 58, pad, 58),
      child: child);
  Widget _featured(BuildContext context) => Column(children: [
        const SectionTitle(
            title: 'Featured projects', tag: 'PRODUCT PORTFOLIO'),
        const SizedBox(height: 12),
        Text(
            'Production applications built for real users, workflows and devices.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).hintColor)),
        const SizedBox(height: 32),
        LayoutBuilder(builder: (_, box) {
          final count = box.maxWidth >= 820 ? 2 : 1;
          final width = (box.maxWidth - (count - 1) * 20) / count;
          return Wrap(
              spacing: 20,
              runSpacing: 20,
              children: List.generate(
                  6,
                  (i) => SizedBox(
                      width: width,
                      child: ProjectCard(project: projectList[i], index: i))));
        })
      ]);
  Widget _skillsView(BuildContext context) => const _SkillGroups();
  Widget _contactView(BuildContext context) => Column(children: [
        const SectionTitle(title: "Let's Connect", tag: 'CONTACT'),
        const SizedBox(height: 16),
        Text('For Flutter and mobile application opportunities, get in touch.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).hintColor)),
        const SizedBox(height: 28),
        Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final item in const [
                (
                  Icons.email_outlined,
                  'Email',
                  'mailto:devendiran03@gmail.com'
                ),
                (Icons.phone_outlined, 'Phone', 'tel:+919952583296'),
                (
                  Icons.link,
                  'LinkedIn',
                  'https://www.linkedin.com/in/devendiran-t'
                ),
                (Icons.code, 'GitHub', 'https://github.com/Deva-97')
              ])
                OutlinedButton.icon(
                    onPressed: () => launchUrl(Uri.parse(item.$3),
                        mode: LaunchMode.externalApplication),
                    icon: Icon(item.$1, size: 18),
                    label: Text(item.$2)),
              ElevatedButton(
                  onPressed: _resume, child: const Text('Download Resume'))
            ])
      ]);
  Widget _footer(BuildContext context) => Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 26, 20, 34),
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: Theme.of(context).dividerColor))),
      child: Column(children: [
        Text('Open to Flutter / Mobile Developer opportunities',
            style: TextStyle(color: Theme.of(context).hintColor)),
        const SizedBox(height: 10),
        Text('© 2026 Devendiran Thiyagarajan',
            style: TextStyle(
                color: Theme.of(context).hintColor.withAlpha(150),
                fontSize: 14)),
        const SizedBox(height: 10),
        Wrap(alignment: WrapAlignment.center, children: [
          _route('Ninaivu Privacy Policy', AppRoutes.ninaivuPrivacyPolicy),
          _route('Ninaivu Delete Account', AppRoutes.ninaivuDeleteAccount),
          _route(
              'AquaCare CRM Privacy Policy', AppRoutes.aquacarePrivacyPolicy),
          _route('AquaCare CRM Delete Account', AppRoutes.aquacareDeleteAccount)
        ])
      ]));
  Widget _route(String label, String route) => TextButton(
      onPressed: () => Navigator.of(context).pushNamed(route),
      child: Text(label, style: const TextStyle(fontSize: 12)));
}

class _SkillGroups extends StatelessWidget {
  const _SkillGroups();
  @override
  Widget build(BuildContext context) {
    const groups = {
      'Flutter & State Management': [
        'Flutter',
        'Dart',
        'Provider',
        'GetX',
        'ChangeNotifier'
      ],
      'Architecture': [
        'Clean Architecture',
        'MVVM',
        'Repository Pattern',
        'Use Cases',
        'Dependency Injection'
      ],
      'Backend & APIs': [
        'Firebase',
        'REST APIs',
        'Firestore',
        'Realtime Database',
        'Cloud Messaging',
        'Remote Config',
        'App Check'
      ],
      'Data & Storage': ['SQLite', 'Hive', 'SharedPreferences'],
      'IoT & Real-time': ['MQTT', 'Publish/Subscribe Communication'],
      'AI & Voice': [
        'OpenAI APIs',
        'Speech-to-Text',
        'Text-to-Speech',
        'AI Image Generation'
      ],
      'Mobile & Integrations': [
        'Android',
        'iOS',
        'Push Notifications',
        'Google Maps',
        'Location',
        'Method Channels'
      ],
      'Tools & Release': [
        'Git',
        'GitHub',
        'Android Studio',
        'Xcode',
        'Play Console',
        'App Store Connect',
        'TestFlight',
        'Jira'
      ]
    };
    return Column(children: [
      const SectionTitle(title: 'Engineering toolkit', tag: 'SKILLS'),
      const SizedBox(height: 34),
      LayoutBuilder(builder: (_, box) {
        final columns = box.maxWidth > 760 ? 2 : 1;
        final width = (box.maxWidth - (columns - 1) * 16) / columns;
        return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: groups.entries
                .map((e) => SizedBox(
                    width: width,
                    child: _SkillGroup(title: e.key, skills: e.value)))
                .toList());
      })
    ]);
  }
}

class _SkillGroup extends StatefulWidget {
  final String title;
  final List<String> skills;
  const _SkillGroup({required this.title, required this.skills});

  @override
  State<_SkillGroup> createState() => _SkillGroupState();
}

class _SkillGroupState extends State<_SkillGroup>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onHover(bool hovered) {
    setState(() => _isHovered = hovered);
    if (hovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _hoverController,
        builder: (context, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCardBg : AppColors.cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isHovered
                    ? AppColors.primary.withValues(alpha: 0.4)
                    : (isDark ? AppColors.darkBorder : AppColors.borderLight),
                width: _isHovered ? 1.5 : 1,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color:
                            Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: child,
          );
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 13),
          Wrap(
              spacing: 7,
              runSpacing: 7,
              children: widget.skills
                  .map((s) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 5),
                      decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: .09),
                          borderRadius: BorderRadius.circular(7)),
                      child: Text(s,
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.primary))))
                  .toList())
        ]),
      ),
    );
  }
}
