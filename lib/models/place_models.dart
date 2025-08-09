class Place {
  final String title;
  final String description;
  final String image;

  Place({
    required this.title,
    required this.description,
    required this.image,
  });

  factory Place.fromMap(Map<String, dynamic> data) {
    return Place(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      image: data['image'] ?? '',
    );
  }
}
