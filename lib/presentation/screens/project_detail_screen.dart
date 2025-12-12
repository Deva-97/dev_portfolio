import 'package:flutter/material.dart';
import '../../data/models/project.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailScreen extends StatefulWidget {
  final Project project;
  const ProjectDetailScreen({super.key, required this.project});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.92);
  int _current = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenshots = [widget.project.image];
    return Scaffold(
      appBar: AppBar(title: Text(widget.project.title)),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: ListView(
          children: [
            SizedBox(
              height: 220,
              child: PageView.builder(
                controller: _pageController,
                itemCount: screenshots.length,
                onPageChanged: (i) => setState(() => _current = i),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(screenshots[index],
                          width: 20.0, fit: BoxFit.contain),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            // simple indicator
            if (screenshots.length > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(screenshots.length, (i) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _current == i ? 18 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _current == i
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).dividerColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }),
              ),
            const SizedBox(height: 16),
            Text(widget.project.description,
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 12),
            Wrap(
                spacing: 8,
                children: widget.project.tech
                    .map((t) => Chip(label: Text(t)))
                    .toList()),
            const SizedBox(height: 18),
            Row(children: [
              const SizedBox(width: 12),
              if (widget.project.playStore != null &&
                  widget.project.playStore!.isNotEmpty)
                OutlinedButton.icon(
                    onPressed: () => _openUrl(widget.project.playStore!),
                    icon: const Icon(Icons.shop),
                    label: const Text("Play Store")),
              if (widget.project.appStore != null &&
                  widget.project.appStore!.isNotEmpty)
                OutlinedButton.icon(
                    onPressed: () => _openUrl(widget.project.appStore!),
                    icon: const Icon(Icons.apple_sharp),
                    label: const Text("App Store")),
            ]),
          ],
        ),
      ),
    );
  }
}
