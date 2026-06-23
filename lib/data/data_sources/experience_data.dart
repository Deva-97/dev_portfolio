import '../models/experience.dart';

final List<Experience> experienceList = [
  Experience(
    company: "Shakuniya Solutions Private Limited",
    role: "Flutter Developer",
    duration: "Feb 2026 – Jun 2026",
    location: "Chennai",
    type: "Full-time, On-site",
    highlights: [
      "Developed Flusso, a feature-rich live streaming & social messaging app (Android) supporting audio/video live streams, real-time chat, media uploads, in-app games, and PK battles.",
      "Architected Flusso with MVVM + GetX for reactive state management and consumed real-time REST APIs for streaming, payments, and messaging.",
      "Designed the full UI for a multi-role school management platform (admin, teacher, accountant, librarian, parent, student) across both web and Android with MVVM + GetX; website live in production, mobile app pending release.",
    ],
  ),
  Experience(
    company: "Onwords Smart Solutions",
    role: "Flutter App Developer",
    duration: "Jan 2023 – Dec 2025",
    location: "Coimbatore",
    type: "Full-time, On-site",
    highlights: [
      "Led end-to-end development of 4 production Flutter apps — from architecture to Play Store & App Store deployment — with a combined 10,500+ downloads.",
      "Individually architected and shipped Onwords Workspace (Android + iOS) from scratch; built Mudhal AI with the OpenAI ChatGPT API, published on the App Store.",
      "Implemented MQTT-based real-time communication for live IoT device control, plus Siri (HomeKit) & Alexa voice assistant integration.",
      "Applied Clean Architecture & MVVM with Provider, get_it & hive; integrated the full Firebase suite in cross-functional Agile teams via Jira & Git.",
    ],
  ),
];
