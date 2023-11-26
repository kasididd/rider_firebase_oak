import 'package:rider_firebase_oak/logic/class/collection_class.dart';
import 'package:rider_firebase_oak/main.dart';

CollectionReference _collectionRider = Firestore(projectId).collection(keyCollectionRiders);
Future<Document> create(RiderModel r) => _collectionRider.add(r.toJson());
Future<Iterable<Map<String, dynamic>>> read() => _collectionRider.get().then((value) => value.map((element) => {"id": element.id, ...element.map}));
Future<List<RiderModel>> getData(Future<Iterable<Map<String, dynamic>>> api) async {
  return await api.then((value) => value.map((e) => RiderModel.fromJson(e)).toList());
}

Future<void> update(RiderModel r) => _collectionRider.document(r.id).update(r.toJson());
Future<void> delete(RiderModel r) => _collectionRider.document(r.id).delete();
