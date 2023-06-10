import 'package:bluetouch/client/models/address.dart';
import 'package:bluetouch/client/models/client.dart';
import 'package:bluetouch/client/models/client_state.dart';
import 'package:bluetouch/client/repository/client_repository.dart';
import 'package:bluetouch/compteur/models/compteur.dart';
import 'package:bluetouch/compteur/models/compteur_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientFirestoreRepository implements ClientRepository {

  final FirebaseFirestore firebaseFirestore;

  ClientFirestoreRepository(this.firebaseFirestore);

  @override
  Future<List<Client>> getAll() async {
    var clientsCollections = firebaseFirestore.collection("clients");
    var querySnapshot = await clientsCollections.get();
    List<Client> clients = [];
    for (var e in querySnapshot.docChanges) {
      final data = e.doc.data();

      Address? address = await getAddress(data);
      Compteur? compteur = await getCompteur(data);

      var client = Client.fromJson(data!)
        ..id = e.doc.id
        ..compteur = compteur
        ..address = address;

      clients.add(client);
    }
    return clients;
  }

  @override
  Future<void> updateClientState(String id, ClientState state) {
    return firebaseFirestore.collection('clients').doc(id).update({
      'state': state.name
    });
  }

  Future<Address?> getAddress(Map<String, dynamic>? data) async {
    if (data?.containsKey("address") == false) {
      return Future.value();
    }
    final DocumentReference addressReference = data?['address'];
    DocumentSnapshot addressSnapshot = await addressReference.get();
    String rue = addressSnapshot.get("rue");
    String address = addressSnapshot.get("address");
    String lat = addressSnapshot.get("lat");
    String long = addressSnapshot.get("long");
    return Address(
      long: long,
      lat: lat,
      address: address,
      rue: rue
    );
  }

  Future<Compteur?> getCompteur(Map<String, dynamic>? data) async {
    if (data?.containsKey("compteur") == false) {
      return Future.value();
    }
    final DocumentReference compteurReference = data?['compteur'];
    DocumentSnapshot compteurSnapshot = await compteurReference.get();
    String number = compteurSnapshot.get("number");
    String compteurState = compteurSnapshot.get("compteurState");
    return Compteur(number, CompteurState.values.byName(compteurState));
  }
}
