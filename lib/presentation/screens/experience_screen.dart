import 'package:flutter/material.dart';
import '../../data/data_sources/experience_data.dart';
import '../widgets/section_title.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Experience")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SectionTitle(title: "Work Experience", useGradient: true),
          Expanded(
            child: ListView.builder(
              itemCount: experienceList.length,
              itemBuilder: (context, index) {
                final e = experienceList[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.company,
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 6),
                          Text("${e.role} • ${e.duration}",
                              style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 8),
                          ...e.highlights
                              .map((h) => Row(children: [
                                    const Text("•  "),
                                    Expanded(child: Text(h))
                                  ]))
                              .toList(),
                        ]),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
