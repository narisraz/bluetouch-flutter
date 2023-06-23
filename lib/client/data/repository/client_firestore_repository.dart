import 'package:bluetouch/client/domain/models/client.dart';
import 'package:bluetouch/client/domain/models/client_category.dart';
import 'package:bluetouch/client/domain/models/client_state.dart';
import 'package:bluetouch/client/domain/repository/client_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientFirestoreRepository extends ClientRepository {
  final FirebaseFirestore firebaseFirestore;

  ClientFirestoreRepository({required this.firebaseFirestore});

  @override
  Stream<Iterable<Client>> getAllBySaepId(String saepId) {
    return firebaseFirestore
        .collection("clients")
        .where("saepId", isEqualTo: saepId)
        .snapshots()
        .map((event) => event.docs.map((e) => Client.fromJson(e.data())));
  }

  @override
  Future<void> updateClientCategory(String id, ClientCategory category) {
    return firebaseFirestore
        .collection("clients")
        .doc(id)
        .update({'category': category.name});
  }

  @override
  Future<void> updateClientState(String id, ClientState state) {
    return firebaseFirestore
        .collection("clients")
        .doc(id)
        .update({'state': state.name});
  }
}
