import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trail_tales/models/hotel_model.dart';
import 'package:trail_tales/models/place_models.dart';
import 'package:trail_tales/models/vehicle_model.dart';


class FirestoreService {
  final _mostPopularCollection = FirebaseFirestore.instance.collection('Most popular places');
  final _placesCollection = FirebaseFirestore.instance.collection('Places');
  final _hotelsCollection = FirebaseFirestore.instance.collection('Hotels');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Place>> fetchMostPopularPlaces() async {
    final snapshot = await _mostPopularCollection.get();
    return snapshot.docs.map((doc) => Place.fromMap(doc.data())).toList();
  }

  Future<List<Place>> fetchPlaces() async {
    final snapshot = await _placesCollection.get();
    return snapshot.docs.map((doc) => Place.fromMap(doc.data())).toList();
  }

  Future<List<HotelModel>> fetchHotels() async {
    final snapshot = await _hotelsCollection.get();
    return snapshot.docs.map((doc) => HotelModel.fromMap(doc.data())).toList();
  }

  Future<List<VehicleModel>> fetchVehicles(String collectionName) async {
    final snapshot = await _firestore.collection(collectionName).get();
    return snapshot.docs
    .map((doc) => VehicleModel.fromMap(doc.data()))
    .toList();
  }
}

