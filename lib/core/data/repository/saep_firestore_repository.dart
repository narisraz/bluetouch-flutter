import 'package:bluetouch/core/domain/models/saep.dart';
import 'package:bluetouch/core/domain/repository/saep_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SaepFirestoreRepository extends SaepRepository {
  final FirebaseFirestore firebaseFirestore;

  SaepFirestoreRepository({required this.firebaseFirestore});

  @override
  Stream<Iterable<Saep>> getSaepFromListOfId(List<String> ids) {
    return firebaseFirestore
        .collection("saep")
        .where(FieldPath.documentId, whereIn: ids)
        .snapshots()
        .map((event) => event.docs.map(_dataWithId));
  }

  Saep _dataWithId(e) {
    Map<String, dynamic> data = e.data();
    data.putIfAbsent("id", () => e.id);
    return Saep.fromJson(data);
  }
}
