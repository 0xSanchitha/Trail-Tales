class HotelModel {
  final String imageUrl;
  final String title;
  final String location;
  final String bedrooms;
  final String price;
  final String rating;

  HotelModel({
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.bedrooms,
    required this.price,
    required this.rating,
  });

  factory HotelModel.fromMap(Map<String, dynamic> map) {
    return HotelModel(
      imageUrl: map['image'] ?? '',
      title: map['title'] ?? '',
      location: map['location'] ?? '',
      bedrooms: map['bedrooms'] ?? '',
      price: map['price'] ?? '',
      rating: map['rating'] ?? '',
    );
  }
}
