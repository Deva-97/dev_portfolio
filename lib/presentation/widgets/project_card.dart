// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/app_colors.dart';
import '../../data/models/project.dart';
import '../screens/project_detail_screen.dart';
import 'animated_fade_in.dart';

// Flutter Material Blue gradients for image-less project cards
const _cardGradients = [
  [Color(0xFF1565C0), Color(0xFF2196F3)],
  [Color(0xFF0D47A1), Color(0xFF1976D2)],
  [Color(0xFF1976D2), Color(0xFF42A5F5)],
  [Color(0xFF1565C0), Color(0xFF64B5F6)],
  [Color(0xFF0D47A1), Color(0xFF2196F3)],
  [Color(0xFF1976D2), Color(0xFF90CAF9)],
];

const _cardIcons = [
  Icons.live_tv_rounded,
  Icons.school_rounded,
  Icons.home_rounded,
  Icons.business_center_rounded,
  Icons.psychology_rounded,
  Icons.tablet_mac_rounded,
];

class ProjectCard extends StatefulWidget {
  final Project project;
  final int index;

  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
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

  void _setHover(bool value) {
    setState(() {
      _isHovered = value;
    });

    if (value) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  List<Color> get _gradient =>
      _cardGradients[widget.index % _cardGradients.length];

  IconData get _icon => _cardIcons[widget.index % _cardIcons.length];

  void _openProjectDetails() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProjectDetailScreen(
          project: widget.project,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedFadeIn(
      delay: Duration(milliseconds: 80 * widget.index),
      child: MouseRegion(
        onEnter: (_) => _setHover(true),
        onExit: (_) => _setHover(false),
        child: GestureDetector(
          onTap: _openProjectDetails,
          child: AnimatedBuilder(
            animation: _hoverController,
            builder: (context, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCardBg : AppColors.cardBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _isHovered
                        ? AppColors.primary.withOpacity(0.45)
                        : (isDark
                            ? AppColors.darkBorder
                            : AppColors.borderLight),
                    width: _isHovered ? 1.5 : 1,
                  ),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.12),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              isDark ? 0.20 : 0.04,
                            ),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                ),
                child: child,
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageHeader(context),
                _buildCardContent(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageHeader(BuildContext context) {
    final images = widget.project.image ?? const <String>[];
    final hasImages = images.isNotEmpty;

    final numberLabel = (widget.index + 1).toString().padLeft(2, '0');

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(20),
      ),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 220,
            child: hasImages
                ? _buildProjectPreview(images)
                : _buildGradientHeader(),
          ),

          // Number badge
          Positioned(
            top: 14,
            left: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.55),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.white.withOpacity(0.15),
                ),
              ),
              child: Text(
                '#$numberLabel',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),

          // Category badge
          Positioned(
            top: 14,
            right: 14,
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 260,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.90),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.project.category,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // Hover overlay
          IgnorePointer(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: _isHovered ? 1 : 0,
              child: Container(
                width: double.infinity,
                height: 230,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.primary.withOpacity(0.18),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectPreview(List<String> images) {
    final previewImages = images.take(3).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 8.0;

        final availableWidth = constraints.maxWidth;

        final imageWidth =
            (availableWidth - (gap * (previewImages.length - 1)) - 24) /
                previewImages.length;

        final width = imageWidth.clamp(100.0, 190.0);
        const height = 210.0;

        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Container(
          width: double.infinity,
          height: double.infinity,
          color: isDark ? const Color(0xFF0D1118) : const Color(0xFFF2F4F8),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (int i = 0; i < previewImages.length; i++) ...[
                if (i > 0) const SizedBox(width: gap),
                Expanded(
                  child: Center(
                    child: _buildPhonePreview(
                      previewImages[i],
                      width: width,
                      height: height,
                      prominent: i == 1,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildPhonePreview(
    String image, {
    required double width,
    required double height,
    bool prominent = false,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(
          prominent ? 14 : 12,
        ),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              Theme.of(context).brightness == Brightness.dark ? 0.28 : 0.10,
            ),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        image,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return const Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              color: Colors.white38,
            ),
          );
        },
      ),
    );
  }

  Widget _buildGradientHeader() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          _icon,
          size: 56,
          color: Colors.white.withOpacity(0.25),
        ),
      ),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.project.icon != null &&
                  widget.project.icon!.isNotEmpty) ...[
                Container(
                  width: isMobile ? 36 : 42,
                  height: isMobile ? 36 : 42,
                  padding: const EdgeInsets.all(4),
                  child: Image.asset(
                    widget.project.icon!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return const Icon(
                        Icons.apps_rounded,
                        color: AppColors.primary,
                        size: 20,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  widget.project.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: _isHovered ? AppColors.primary : null,
                        fontSize: isMobile ? 16 : 18,
                      ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            widget.project.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                  height: 1.65,
                  fontSize: isMobile ? 13 : 14,
                ),
          ),

          const SizedBox(height: 14),

          // Tech chips
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: widget.project.tech.map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(
                    isDark ? 0.12 : 0.07,
                  ),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.20),
                  ),
                ),
                child: Text(
                  tech,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 16),

          TextButton.icon(
            onPressed: _openProjectDetails,
            icon: const Icon(
              Icons.arrow_outward_rounded,
              size: 16,
            ),
            label: const Text('View Case Study'),
          ),
        ],
      ),
    );
  }

  // void _openUrl(String url) async {
  //   final uri = Uri.parse(url);

  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(
  //       uri,
  //       mode: LaunchMode.externalApplication,
  //     );
  //   }
  // }
}
