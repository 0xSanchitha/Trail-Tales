class Place {
  final String title;
  final String description;
  final String image;
  final String? image2;
  final String? image3;
  final List<String> images; // optional combined list
  final String details;
  final String location;

  Place({
    required this.title,
    required this.description,
    required this.image,
    this.image2,
    this.image3,
    required this.images,
    required this.details,
    required this.location,
  });

  factory Place.fromMap(Map<String, dynamic> data) {
    List<String> imageList = [];

    if (data['image'] != null && data['image'].toString().isNotEmpty) {
      imageList.add(data['image']);
    }
    if (data['image 2'] != null && data['image 2'].toString().isNotEmpty) {
      imageList.add(data['image 2']);
    }
    if (data['image 3'] != null && data['image 3'].toString().isNotEmpty) {
      imageList.add(data['image 3']);
    }

    return Place(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      image: data['image'] ?? '',
      image2: data['image 2'],
      image3: data['image 3'],
      images: imageList,
      details: data['details'] ?? '',
      location: data['location'] ?? '',
    );
  }
}
