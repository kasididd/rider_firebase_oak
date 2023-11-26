import 'package:rider_firebase_oak/logic/class/collection_class.dart';
import 'package:rider_firebase_oak/main.dart';

CollectionReference _collectionRider = Firestore(projectId).collection(keyCollectionRiders);

Future<Document> create(RiderModel r) => _collectionRider.add(r.toJson());

Future<Iterable<Map<String, dynamic>>> read([String name = '']) {
  QueryReference condition = _collectionRider.orderBy('timeCreate', descending: false);
  if (name.isNotEmpty) {
    condition = _collectionRider.where('name', isGreaterThanOrEqualTo: name, isLessThan: '${name}z');
  }
  return condition.limit(10).get().then((value) {
    var res = value.map((element) => {"id": element.id, ...element.map});
    if (name.isNotEmpty) res.toList().sort((a, b) => a['timeCreate'].toString().compareTo(b['timeCreate'].toString()));
    return res;
  });
}

Future<void> update(RiderModel r) => _collectionRider.document(r.id).update((r..modifyOn = DateTime.now()).toJson());
Future<void> delete(RiderModel r) => _collectionRider.document(r.id).delete();

Future<List<RiderModel>> getData(Future<Iterable<Map<String, dynamic>>> api) async {
  return await api.then((value) => value.map((e) => RiderModel.fromJson(e)).toList());
}
