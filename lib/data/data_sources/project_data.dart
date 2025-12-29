import '../models/project.dart';

final List<Project> projectList = [
  Project(
    title: "Onwords Smart Things",
    description:
        "A smart home automation application focused on real-time device control and scheduling. Built MQTT-based communication and integrated Firebase services to ensure reliable, low-latency performance across platforms.",
    tech: ["Flutter", "Dart", "MQTT", "Firebase", "Firestore", "Crashlytics", "Authentication", "Remote config", "Messaging", "Kotlin", "Xcode", "Home Screen Widgets", "Clean Architecture", "Android", "iOS"],
    playStore:
        "https://play.google.com/store/apps/details?id=com.onwords.smart_things&hl=en_IN",
    appStore: "https://apps.apple.com/au/app/onwords-smart-things/id6449142647",
    image: "assets/images/smart_things.png",
  ),
  Project(
    title: "Onwords Workspace",
    description:
        "An enterprise mobile application designed to manage attendance, tasks, finance reporting, and lead workflows. Developed core modules and ensured smooth cross-platform performance for daily internal operations.",
    tech: ["Flutter", "Dart", "Firebase", "Storage", "App distribution", "Realtime Database", "Notification", "REST APIs", "MVVM", "Android", "Test Flight"],
    playStore:
        "https://play.google.com/store/apps/details?id=com.office.onwords&hl=en_IN",
    image: "assets/images/workspace.png",
  ),
  Project(
    title: "Mudhal AI",
    description:
        "An AI-powered mobile assistant integrating ChatGPT, voice-to-text, and image processing features. Designed and developed the Flutter application end-to-end with Firebase integration and App Store deployment.",
    tech: ["Flutter", "Dart", "AI Integration", "ChatGPT", "Firestore", "Authentication", "Storage", "Voice-to-Text", "iOS"],
    appStore: "https://apps.apple.com/au/app/mudhal-ai/id6462861310",
    image: "assets/images/mudhal_ai.png",
  ),
  Project(
    title: "Onwords ST (Tab app)",
    description:
        "A tablet-first smart automation application built for large-screen enterprise environments. Implemented adaptive Flutter layouts and real-time MQTT controls to support complex automation workflows.",
    tech: ["Flutter", "Dart", "Tablet App", "Firebase", "MQTT", "Storage", "Crashlytics", "Android", "iOS"],
    playStore:
        "https://play.google.com/store/apps/details?id=com.onwords.ost_tab_app&hl=en_IN",
    appStore: "https://apps.apple.com/au/app/onwords-st/id6538719536",
    image: "assets/images/tab_app.png",
  ),
];
