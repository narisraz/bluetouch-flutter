import 'package:bluetouch/client/domain/models/address.dart';
import 'package:bluetouch/client/domain/repository/address_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddressFirestoreRepository implements AddressRepository {
  AddressFirestoreRepository({required this.firebaseFirestore});

  final FirebaseFirestore firebaseFirestore;

  @override
  Future<String> addAddress(Address address) async {
    final newAddress =
        await firebaseFirestore.collection("address").add(address.toJson());
    return newAddress.id;
  }

  @override
  Stream<Address?> getById(String? id) {
    if (id == null || id.isEmpty) {
      return const Stream.empty();
    }
    return firebaseFirestore
        .collection("address")
        .doc(id)
        .snapshots()
        .map(_dataWithId);
  }

  Address _dataWithId(e) {
    Map<String, dynamic> data = e.data();
    data.putIfAbsent("id", () => e.id);
    return Address.fromJson(data);
  }
}
