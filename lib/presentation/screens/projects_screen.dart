import 'package:flutter/material.dart';
import '../../data/data_sources/project_data.dart';
import '../widgets/project_card.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Projects")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: projectList.length,
          itemBuilder: (context, index) =>
              ProjectCard(project: projectList[index], index: index),
        ),
      ),
    );
  }
}
