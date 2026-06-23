class Experience {
  final String company;
  final String role;
  final String duration;
  final String location;
  final String type;
  final List<String> highlights;

  Experience({
    required this.company,
    required this.role,
    required this.duration,
    this.location = '',
    this.type = 'Full-time, On-site',
    required this.highlights,
  });
}
