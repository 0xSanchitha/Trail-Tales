class VehicleModel {
  final String image;
  final String? image2;
  final String? image3;
  final String title;
  final String location;
  final String bedrooms;
  final String price;
  final String rating;
  final String reviews;
  final String details;
  final String info;
  final String renter;

  VehicleModel({
    required this.image,
    this.image2,
    this.image3,
    required this.title,
    required this.location,
    required this.bedrooms,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.details,
    required this.info,
    required this.renter,
  });

  factory VehicleModel.fromMap(Map<String, dynamic> data) {
    return VehicleModel(
      image: data['image'] ?? '',
      image2: data['image 2'],
      image3: data['image 3'],
      title: data['title'] ?? '',
      location: data['location'] ?? '',
      bedrooms: data['bedrooms'] ?? '',
      price: data['price'] ?? '',
      rating: data['rating'] ?? '',
      reviews: data['reviews'] ?? '',
      details: data['details'] ?? '',
      info: data['info'] ?? '',
      renter: data['renter'] ?? '',
    );
  }
}
