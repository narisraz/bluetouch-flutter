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
}
