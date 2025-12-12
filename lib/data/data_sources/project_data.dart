import '../models/project.dart';

final List<Project> projectList = [
  Project(
    title: "Onwords Smart Things",
    description:
        "Smart home automation app with MQTT-based real-time controls, scheduling, and device groups.",
    tech: ["Flutter", "MQTT", "Firebase"],
    playStore:
        "https://play.google.com/store/apps/details?id=com.onwords.smart_things&hl=en_IN",
    image: "assets/images/smart_things.png",
  ),
  Project(
    title: "Onwords Workspace",
    description:
        "Internal office management app streamlining Attendance, Leads, Finanace reporting & Refreshment details.",
    tech: ["Flutter", "Notification", "Firebase"],
    playStore:
        "https://play.google.com/store/apps/details?id=com.office.onwords&hl=en_IN",
    image: "assets/images/workspace.png",
  ),
  Project(
    title: "Mudhal AI",
    description:
        "AI assistant app integrating ChatGPT, voice-to-text, image processing and audio narration.",
    tech: ["Flutter", "OpenAI", "Firebase"],
    appStore: "https://apps.apple.com/au/app/mudhal-ai/id6462861310",
    image: "assets/images/mudhal_ai.png",
  ),
  Project(
    title: "Onwords ST (Tab app)",
    description:
        "Smart home automation app with MQTT-based real-time controls, scheduling, and device groups.",
    tech: ["Flutter", "MQTT", "Weather Api", "Firebase"],
    playStore:
        "https://play.google.com/store/apps/details?id=com.onwords.ost_tab_app&hl=en_IN",
    image: "assets/images/tab_app.png",
  ),
];
