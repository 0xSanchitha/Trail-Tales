import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trail_tales/models/place_models.dart';


class FirestoreService {
  final _mostPopularCollection = FirebaseFirestore.instance.collection('Most popular places');
  final _placesCollection = FirebaseFirestore.instance.collection('Places');

  Future<List<Place>> fetchMostPopularPlaces() async {
    final snapshot = await _mostPopularCollection.get();
    return snapshot.docs.map((doc) => Place.fromMap(doc.data())).toList();
  }

  Future<List<Place>> fetchPlaces() async {
    final snapshot = await _placesCollection.get();
    return snapshot.docs.map((doc) => Place.fromMap(doc.data())).toList();
  }
}

