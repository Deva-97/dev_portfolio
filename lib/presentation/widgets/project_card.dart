import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/project.dart';
import 'animated_fade_in.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final int index;

  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedFadeIn(
      delay: Duration(milliseconds: 120 * index),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      project.image,
                      width: 96,
                      height: 96,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          project.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: project.tech
                              .map((t) => Chip(label: Text(t)))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  if (project.playStore != null &&
                      project.playStore!.isNotEmpty)
                    OutlinedButton.icon(
                      onPressed: () => _openUrl(project.playStore!),
                      icon: const Icon(Icons.shop),
                      label: const Text('Play Store'),
                    ),
                  if (project.appStore != null && project.appStore!.isNotEmpty)
                    OutlinedButton.icon(
                      onPressed: () => _openUrl(project.appStore!),
                      icon: const Icon(Icons.apple),
                      label: const Text('App Store'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
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
