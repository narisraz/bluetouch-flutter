import 'package:bluetouch/client/domain/models/client.dart';
import 'package:bluetouch/client/domain/models/client_category.dart';
import 'package:bluetouch/client/domain/models/client_state.dart';
import 'package:bluetouch/client/domain/repository/address_repository.dart';
import 'package:bluetouch/client/domain/repository/client_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientFirestoreRepository extends ClientRepository {
  final FirebaseFirestore firebaseFirestore;
  final AddressRepository addressRepository;

  ClientFirestoreRepository({
    required this.firebaseFirestore,
    required this.addressRepository,
  });

  @override
  Stream<Iterable<Client>> getAllBySaepId(String saepId) {
    return firebaseFirestore
        .collection("clients")
        .where("saepId", isEqualTo: saepId)
        .snapshots()
        .map((event) => event.docs.map(_dataWithId));
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

  @override
  Future<void> addClient(Client client) async {
    String addressId = "";
    if (client.address != null) {
      addressId = await addressRepository.addAddress(client.address!);
    }
    Map<String, dynamic> clientMap = client.toJson();
    clientMap['address'] = addressId;
    await firebaseFirestore.collection("clients").add(clientMap);
  }

  Client _dataWithId(e) {
    Map<String, dynamic> data = e.data();
    data.putIfAbsent("id", () => e.id);
    return Client.fromJson(data);
  }
}
