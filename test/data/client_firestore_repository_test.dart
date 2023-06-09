import 'package:bluetouch/client/repository/client_repository.dart';
import 'package:bluetouch/data/client_firestore_repository.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import '../client/stubs/client_stubs.dart';

void main() {
  test("get all clients", () async {
    final firestore = FakeFirebaseFirestore();
    await firestore.collection("clients").add(clientStub.toJson());

    final ClientRepository clientRepository = ClientFirestoreRepository(firestore);
    var clients = await clientRepository.getAll();

    expect(clients.length, equals(1));
  });
}