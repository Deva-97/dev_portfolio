import '../models/project.dart';

final List<Project> projectList = [
  Project(
    title: "Flusso",
    description:
        "A feature-rich live streaming & social messaging app supporting audio/video live streams, real-time chat, media uploads, in-app games, and PK battles with real-time scoring.",
    tech: ["Flutter", "Dart", "GetX", "MVVM", "LiveKit SDK", "REST APIs", "Real-time Chat", "Android"],
    image: "assets/images/ic_logo.jpeg",
    playStore: "https://play.google.com/store/apps/details?id=com.chasinghazel.flusso&hl=en_IN",
    category: "Live Streaming",
  ),
  Project(
    title: "School Management Platform",
    description:
        "Complete UI for a multi-role school management system with dedicated dashboards for admin, teacher, accountant, librarian, parent, and student. Responsive layouts for web and Android from a shared Flutter codebase.",
    tech: ["Flutter", "Dart", "GetX", "MVVM", "REST APIs", "Web", "Android", "Responsive UI"],
    image: "assets/images/mighty_school.png",
    category: "EdTech",
  ),
  Project(
    title: "Onwords Smart Things",
    description:
        "Real-time smart home automation app with MQTT for instant, low-latency device control. Features scene automation engine with scheduling, sunrise/sunset triggers, guest access sharing, and Siri & Alexa integration.",
    tech: ["Flutter", "Dart", "MQTT", "Firebase", "Firestore", "Crashlytics", "FCM", "Auth", "HomeKit", "Alexa", "Clean Architecture", "Android", "iOS"],
    playStore: "https://play.google.com/store/apps/details?id=com.onwords.smart_things&hl=en_IN",
    appStore: "https://apps.apple.com/au/app/onwords-smart-things/id6449142647",
    image: "assets/images/smart_things.png",
    category: "IoT / Smart Home",
  ),
  Project(
    title: "Onwords Workspace",
    description:
        "Sole owner of architecture, development & deployment for a multi-module enterprise app covering attendance, leave, task tracking, finance reporting, and lead management with role-based access control.",
    tech: ["Flutter", "Dart", "Firebase", "Firestore", "Auth", "FCM", "Crashlytics", "REST APIs", "MVVM", "Android", "iOS", "TestFlight"],
    playStore: "https://play.google.com/store/apps/details?id=com.office.onwords&hl=en_IN",
    image: "assets/images/workspace.png",
    category: "Enterprise",
  ),
  Project(
    title: "Mudhal AI",
    description:
        "AI-powered productivity assistant integrating OpenAI ChatGPT API for intelligent text generation, AI image generation, bidirectional voice features, and a conversational chat-style UI. Successfully launched on the App Store.",
    tech: ["Flutter", "Dart", "OpenAI ChatGPT API", "Text-to-Speech", "Speech-to-Text", "Firebase", "Provider", "iOS"],
    appStore: "https://apps.apple.com/au/app/mudhal-ai/id6462861310",
    image: "assets/images/mudhal_ai.png",
    category: "AI / Productivity",
  ),
  Project(
    title: "Onwords ST",
    description:
        "Tablet-first Flutter app for wall-mounted smart home control panels, digitally replacing physical switch panels. Engineered fully adaptive large-screen layouts with MQTT real-time control optimised for always-on usage.",
    tech: ["Flutter", "Dart", "MQTT", "Firebase", "Provider", "Adaptive Layouts", "REST APIs", "Android", "iOS"],
    playStore: "https://play.google.com/store/apps/details?id=com.onwords.ost_tab_app&hl=en_IN",
    appStore: "https://apps.apple.com/au/app/onwords-st/id6538719536",
    image: "assets/images/tab_app.png",
    category: "IoT / Smart Home",
  ),
];
