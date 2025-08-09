class VehicleModel {
  final String imageUrl;
  final String title;
  final String location;
  final String renter;
  final String price;
  final String rating;

  VehicleModel({
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.renter,
    required this.price,
    required this.rating,
  });

  factory VehicleModel.fromMap(Map<String, dynamic> map) {
    return VehicleModel(
      imageUrl: map['image'] ?? '',
      title: map['title'] ?? '',
      location: map['location'] ?? '',
      renter: map['renter'] ?? '',
      price: map['price'] ?? '',
      rating: map['rating'] ?? '',
    );
  }
}
