import 'package:bluetouch/client/domain/models/branchement.dart';
import 'package:bluetouch/client/domain/repository/branchement_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BranchementFirestoreRepository extends BranchementRepository {
  final FirebaseFirestore firebaseFirestore;

  BranchementFirestoreRepository({required this.firebaseFirestore});

  @override
  Future<Branchement?> getByClientId(String clientId) async {
    var branchements = await firebaseFirestore
        .collection("branchements")
        .orderBy('insertDate', descending: true)
        .where('clientId', isEqualTo: clientId)
        .get();
    if (branchements.docs.isNotEmpty) {
      var branchement = branchements.docs.first;
      return Branchement.fromJson(branchement.data());
    }
    return null;
  }

  @override
  Future<void> add(Branchement branchement) {
    return firebaseFirestore.collection('branchements').add({
      'clientId': branchement.clientId,
      'date': branchement.date,
      'insertDate': branchement.insertDate,
      'index': branchement.index,
    });
  }
}
