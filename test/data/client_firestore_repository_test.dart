import 'package:bluetouch/client/models/client_category.dart';
import 'package:bluetouch/client/models/client_state.dart';
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

  test("update client state", () async {
    final firestore = FakeFirebaseFirestore();
    var beforeUpdate = await firestore.collection("clients").add(clientStub.toJson());

    final ClientRepository clientRepository = ClientFirestoreRepository(firestore);
    await clientRepository.updateClientState(beforeUpdate.id, ClientState.active);

    var afterUpdate = await firestore.collection("clients").doc(beforeUpdate.id).get();
    expect(afterUpdate['state'], ClientState.active.name);
  });

  test("update client category", () async {
    final firestore = FakeFirebaseFirestore();
    var beforeUpdate = await firestore.collection("clients").add(clientStub.toJson());

    final ClientRepository clientRepository = ClientFirestoreRepository(firestore);
    await clientRepository.updateClientCategory(beforeUpdate.id, ClientCategory.borneFontaine);

    var afterUpdate = await firestore.collection("clients").doc(beforeUpdate.id).get();
    expect(afterUpdate['category'], ClientCategory.borneFontaine.name);
  });
}