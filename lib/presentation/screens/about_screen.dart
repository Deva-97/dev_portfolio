import 'package:flutter/material.dart';
import '../../data/data_sources/experience_data.dart';
import '../widgets/section_title.dart';
import '../widgets/skill_chip.dart';
import '../widgets/animated_fade_in.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SectionTitle(title: "About Me"),
              const Text(
                "Flutter Developer with 2+ years of experience building high-performance apps. Passionate about clean architecture, realtime systems, and AI features.",
              ),
              const SizedBox(height: 18),
              const SectionTitle(title: "Skills"),
              const Wrap(spacing: 8, runSpacing: 8, children: [
                SkillChip(label: "Flutter"),
                SkillChip(label: "Dart"),
                SkillChip(label: "Provider / BLoC"),
                SkillChip(label: "Firebase"),
                SkillChip(label: "MQTT"),
                SkillChip(label: "CI/CD"),
                SkillChip(label: "Unit Testing"),
                SkillChip(label: "ChatGPT Integration"),
              ]),
              const SizedBox(height: 18),
              const SectionTitle(title: "Experience Snapshot"),
              ...experienceDataToWidgets(),
            ]),
          ),
        ),
      ),
    );
  }

  List<Widget> experienceDataToWidgets() {
    return experienceList.map((e) {
      return AnimatedFadeIn(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(e.company,
                  style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text("${e.role} • ${e.duration}",
                  style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              ...e.highlights
                  .map((h) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("•  ", style: TextStyle(fontSize: 18)),
                          Expanded(child: Text(h)),
                        ],
                      ))
                  .toList(),
            ]),
          ),
        ),
      );
    }).toList();
  }
}
