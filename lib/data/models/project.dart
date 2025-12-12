class Project {
  final String title;
  final String description;
  final List<String> tech;
  final String? playStore;
  final String? appStore;
  final String image;

  Project({
    required this.title,
    required this.description,
    required this.tech,
    this.playStore,
    this.appStore,
    required this.image,
  });
}
