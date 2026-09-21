import '../models/project.dart';

final List<Project> projectList = [
  const Project(
    title: 'AquaCare CRM',
    category: 'CRM / Offline-first / Android',
    description:
        'CRM application for a water-filter business, built end-to-end from architecture and UI through backend integration and Play Store deployment.',
    tech: [
      'Flutter',
      'Dart',
      'GetX',
      'Clean Architecture',
      'Firebase',
      'SQLite'
    ],
    features: [
      'Google Sign-In and role-based access',
      'Offline-first SQLite workflows with queued Firestore sync',
      'Customer, installation, service and audit workflows',
      'Search, filter, sort, pagination and contact export',
      'Remote Config version enforcement, App Check and Play Integrity'
    ],
    contribution:
        'Owned application architecture, mobile UI, data workflows, Firebase integration and Android release delivery.',
    implementation:
        'Designed for 12K+ records with pagination and optimized Firestore usage. Local SQLite data supports field work while queued synchronization preserves a reliable offline-first flow.',
    playStore:
        'https://play.google.com/store/apps/details?id=com.aquacare.crm&hl=en',
    github: 'https://github.com/Deva-97/aquacare_crm',
    image: [
      'assets/images/projects/aquacare_1.webp',
      'assets/images/projects/aquacare_2.webp',
      'assets/images/projects/aquacare_3.webp',
    ],
    icon: "assets/images/aquacare_crm.png",
  ),
  const Project(
    title: 'Onwords Smart Things',
    category: 'IoT / Smart Home',
    description:
        'Real-time smart home automation application using MQTT for low-latency device control and automation workflows.',
    tech: [
      'Flutter',
      'Dart',
      'MQTT',
      'Firebase',
      'Provider',
      'Clean Architecture'
    ],
    features: [
      'MQTT publish/subscribe communication',
      'Smart-device control and scheduled automation',
      'Sunrise and sunset automation',
      'Firebase services and production Android/iOS deployment',
      '10K+ Android downloads'
    ],
    contribution:
        'Developed the Flutter client for responsive device control, automation journeys and production releases.',
    implementation:
        'MQTT provides low-latency state updates while Firebase supports the connected product experience. The application also integrates Siri/HomeKit and Alexa workflows.',
    playStore:
        'https://play.google.com/store/apps/details?id=com.onwords.smart_things&hl=en_IN',
    appStore: 'https://apps.apple.com/au/app/onwords-smart-things/id6449142647',
    image: [
      'assets/images/projects/onwords_smart_things_1.webp',
      'assets/images/projects/onwords_smart_things_2.webp',
      'assets/images/projects/onwords_smart_things_3.webp'
    ],
    icon: "assets/images/smart_things.png",
  ),
  const Project(
    title: 'Onwords Workspace',
    category: 'Enterprise',
    description:
        'Enterprise mobile application for attendance, location tracking, sales and marketing, R&D, leave management and daily work tracking.',
    tech: [
      'Flutter',
      'Dart',
      'Firebase',
      'REST APIs',
      'Realtime Database',
      'Provider'
    ],
    features: [
      'Role-based access and attendance workflows',
      'Location, sales, marketing and R&D workflows',
      'Leave and daily work tracking',
      'Voice notes, document uploads and invoice generation',
      'Android and iOS releases'
    ],
    contribution:
        'Built and maintained the mobile experience across complex enterprise modules and release workflows.',
    implementation:
        'Combines Firebase services, Realtime Database and REST APIs to support role-aware workflows and timely operational updates.',
    playStore:
        'https://play.google.com/store/apps/details?id=com.office.onwords&hl=en_IN',
    image: [
      'assets/images/projects/onwords_workspace_1.webp',
      'assets/images/projects/onwords_workspace_2.webp',
      'assets/images/projects/onwords_workspace_3.webp',
    ],
    icon: "assets/images/workspace.png",
  ),
  const Project(
    title: 'Mudhal AI',
    category: 'AI / Productivity',
    description:
        'AI-powered application using OpenAI APIs for intelligent chat, image generation and voice features.',
    tech: [
      'Flutter',
      'Dart',
      'OpenAI APIs',
      'Firebase',
      'Provider',
      'Speech-to-Text'
    ],
    features: [
      'AI chat with conversational UI',
      'AI image generation',
      'Speech-to-text and text-to-speech',
      'Firebase-backed application services',
      'iOS App Store release'
    ],
    contribution:
        'Developed the Flutter product experience and AI/voice integrations for an approachable productivity app.',
    implementation:
        'A conversational interface brings together OpenAI APIs, voice input and spoken responses while preserving a focused mobile interaction model.',
    appStore: 'https://apps.apple.com/au/app/mudhal-ai/id6462861310',
    image: [
      'assets/images/projects/mudhal_ai_1.webp',
      'assets/images/projects/mudhal_ai_2.webp',
      'assets/images/projects/mudhal_ai_3.webp',
    ],
    icon: "assets/images/mudhal_ai.png",
  ),
  const Project(
    title: 'Onwords ST',
    category: 'IoT / Smart Home / Tablet',
    description:
        'Responsive tablet and control-panel application for smart-home device management with real-time MQTT control on Android and iOS.',
    tech: ['Flutter', 'Dart', 'MQTT', 'Firebase', 'Provider'],
    features: [
      'Tablet-first responsive layouts',
      'Smart-device control',
      'MQTT real-time communication'
    ],
    contribution:
        'Contributed responsive control-panel UI and production IoT workflows.',
    implementation:
        'Adaptive Flutter layouts support always-on tablet control surfaces alongside MQTT device communication.',
    playStore:
        'https://play.google.com/store/apps/details?id=com.onwords.ost_tab_app&hl=en_IN',
    appStore: 'https://apps.apple.com/au/app/onwords-st/id6538719536',
    image: [
      'assets/images/projects/onwords_st_1.webp',
      'assets/images/projects/onwords_st_2.webp',
      'assets/images/projects/onwords_st_3.webp',
    ],
    icon: "assets/images/tab_app.png",
  ),
  const Project(
    title: 'Ninaivu',
    category: 'Insurance / Offline-first / Personal Project',
    description:
        'Offline-first insurance renewal application for managing policies and reminders for agents and customers.',
    tech: [
      'Flutter',
      'Dart',
      'GetX',
      'Clean Architecture',
      'SQLite',
      'Firebase'
    ],
    features: [
      'Insurance policy management',
      'Local storage and scheduled reminders',
      'Firebase synchronization',
      'Agent and customer workflows'
    ],
    contribution:
        'Independently designed and built the product workflows and offline-first foundation.',
    implementation:
        'Local storage keeps core insurance workflows dependable, while Firebase supports synchronization and reminders.',
    playStore:
        'https://play.google.com/store/apps/details?id=com.devendiran.ninaivu',
    github: 'https://github.com/Deva-97/ninaivu',
    image: [
      'assets/images/projects/ninaivu_1.webp',
      'assets/images/projects/ninaivu_2.webp',
      'assets/images/projects/ninaivu_3.webp',
    ],
    icon: "assets/images/ninaivu.png",
  ),
];
