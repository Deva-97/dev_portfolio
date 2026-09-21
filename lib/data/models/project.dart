class Project {
  final String title;
  final String description;
  final List<String> tech;
  final String? playStore;
  final String? appStore;
  final List<String>? image;
  final String category;
  final List<String> features;
  final String contribution;
  final String implementation;
  final String? github;
  final String? icon;

  const Project({
    required this.title,
    required this.description,
    required this.tech,
    this.playStore,
    this.appStore,
    this.image,
    required this.category,
    this.features = const [],
    this.contribution = '',
    this.implementation = '',
    this.github,
    this.icon,
  });
}
