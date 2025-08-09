class Place {
  final String title;
  final String description;
  final String image;
  final List<String> images;

  Place({
    required this.title,
    required this.description,
    required this.image,
    required this.images,
  });

  factory Place.fromMap(Map<String, dynamic> data) {
    // Collect images from multiple fields
    List<String> imageList = [];

    // Add main image (if exists)
    if (data['image'] != null && data['image'].toString().isNotEmpty) {
      imageList.add(data['image']);
    }

    // Add 'images' field (seems duplicate of 'image', but add if different)
    if (data['images'] != null && data['images'].toString().isNotEmpty) {
      if (!imageList.contains(data['images'])) {
        imageList.add(data['images']);
      }
    }

    // Add 'image 2' field if present
    if (data['image 2'] != null && data['image 2'].toString().isNotEmpty) {
      imageList.add(data['image 2']);
    }

    // Add 'image 3' field if present
    if (data['image 3'] != null && data['image 3'].toString().isNotEmpty) {
      imageList.add(data['image 3']);
    }

    // You can add more images similarly if needed...

    return Place(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      image: data['image'] ?? '',
      images: imageList,
    );
  }
}
