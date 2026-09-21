import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/app_colors.dart';
import '../../data/models/project.dart';

class ProjectDetailScreen extends StatefulWidget {
  final Project project;

  const ProjectDetailScreen({
    super.key,
    required this.project,
  });

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  Future<void> _open(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 650;

    final screenshots = widget.project.image ?? const <String>[];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.title),
      ),
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1040,
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  mobile ? 20 : 48,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (widget.project.icon != null &&
                            widget.project.icon!.isNotEmpty) ...[
                          Container(
                            width: mobile ? 64 : 84,
                            height: mobile ? 64 : 84,
                            padding: const EdgeInsets.all(6),
                            child: Image.asset(
                              widget.project.icon!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) {
                                return Icon(
                                  Icons.apps_rounded,
                                  size: mobile ? 28 : 38,
                                  color: AppColors.primary,
                                );
                              },
                            ),
                          ),
                          SizedBox(width: mobile ? 14 : 20),
                        ],
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.project.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: mobile ? 32 : null,
                                    ),
                              ),
                              if (widget.project.category.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Text(
                                  widget.project.category,
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // Screenshots
                    if (screenshots.isNotEmpty)
                      _buildScreenshotGallery(
                        context,
                        screenshots,
                        mobile,
                      ),

                    const SizedBox(height: 40),

                    _block(
                      context,
                      'Overview',
                      widget.project.description,
                    ),

                    _block(
                      context,
                      'My Contribution',
                      widget.project.contribution,
                    ),

                    Text(
                      'Key Features',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),

                    const SizedBox(height: 14),

                    ...widget.project.features.map(
                      (feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 7),
                              child: Icon(
                                Icons.circle,
                                size: 7,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 11),
                            Expanded(
                              child: Text(
                                feature,
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    _block(
                      context,
                      'Technical Implementation',
                      widget.project.implementation,
                    ),

                    Text(
                      'Technology Stack',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),

                    const SizedBox(height: 14),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.project.tech
                          .map(
                            (item) => Chip(
                              label: Text(item),
                            ),
                          )
                          .toList(),
                    ),

                    const SizedBox(height: 30),

                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        if (widget.project.playStore != null &&
                            widget.project.playStore!.isNotEmpty)
                          OutlinedButton.icon(
                            onPressed: () => _open(
                              widget.project.playStore!,
                            ),
                            icon: const Icon(
                              Icons.shop_outlined,
                            ),
                            label: const Text('Play Store'),
                          ),
                        if (widget.project.appStore != null &&
                            widget.project.appStore!.isNotEmpty)
                          OutlinedButton.icon(
                            onPressed: () => _open(
                              widget.project.appStore!,
                            ),
                            icon: const Icon(
                              Icons.apple,
                            ),
                            label: const Text('App Store'),
                          ),
                        if (widget.project.github != null &&
                            widget.project.github!.isNotEmpty)
                          ElevatedButton.icon(
                            onPressed: () => _open(
                              widget.project.github!,
                            ),
                            icon: const Icon(
                              Icons.code,
                            ),
                            label: const Text('GitHub'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScreenshotGallery(
    BuildContext context,
    List<String> screenshots,
    bool mobile,
  ) {
    final visibleScreenshots = screenshots.take(3).toList();

    return Container(
      width: double.infinity,
      height: mobile ? 430 : 560,
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? 12 : 24,
        vertical: mobile ? 18 : 24,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF0D1118)
            : const Color(0xFFF2F4F8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < visibleScreenshots.length; i++) ...[
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mobile ? 4 : 8,
                ),
                child: Center(
                  child: _buildDetailScreenshot(
                    visibleScreenshots[i],
                    context,
                    mobile,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailScreenshot(
    String image,
    BuildContext context,
    bool mobile,
  ) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: mobile ? 390 : 500,
        maxWidth: mobile ? 150 : 220,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha:
                  Theme.of(context).brightness == Brightness.dark ? 0.30 : 0.10,
            ),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        image,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) {
          return const Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              color: Colors.white38,
              size: 36,
            ),
          );
        },
      ),
    );
  }

  Widget _block(
    BuildContext context,
    String title,
    String content,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              color: Theme.of(context).hintColor,
              height: 1.7,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
