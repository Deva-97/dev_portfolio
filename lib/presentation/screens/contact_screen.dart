import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Email", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () => _openUrl('mailto:devendiran03@gmail.com'),
            child: const Text("devendiran03@gmail.com",
                style: TextStyle(decoration: TextDecoration.underline)),
          ),
          const SizedBox(height: 12),
          Text("LinkedIn", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          GestureDetector(
              onTap: () => _openUrl('https://www.linkedin.com/in/devendiran-t'),
              child: const Text("linkedin.com/in/devendiran-t",
                  style: TextStyle(decoration: TextDecoration.underline))),
          const SizedBox(height: 12),
          // Text("GitHub", style: Theme.of(context).textTheme.titleLarge),
          // const SizedBox(height: 6),
          // GestureDetector(
          //     onTap: () => _openUrl('https://github.com/yourusername'),
          //     child: const Text("github.com/yourusername",
          //         style: TextStyle(decoration: TextDecoration.underline))),
        ]),
      ),
    );
  }

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
