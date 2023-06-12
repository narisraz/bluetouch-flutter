import 'package:bluetouch/branchement/repository/branchement_repository.dart';
import 'package:bluetouch/client/models/branchement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BranchementFirestoreRepository extends BranchementRepository {

  late final FirebaseFirestore _firebaseFirestore;

  BranchementFirestoreRepository() {
    _firebaseFirestore = FirebaseFirestore.instance;
  }

  @override
  Future<Branchement?> getByClientId(String clientId) async {
    var branchements = await _firebaseFirestore.collection("branchements")
      .orderBy('insertDate', descending: true)
      .where(
        'clientId',
        isEqualTo: clientId
      ).get();
    if (branchements.docs.isNotEmpty) {
      var branchement = branchements.docs.first;
      return Branchement.fromJson(branchement.data());
    }
    return null;
  }

  @override
  Future<void> add(String clientId, DateTime date, double startIndex) {
    return _firebaseFirestore.collection('branchements').add({
      'clientId': clientId,
      'date': date.millisecondsSinceEpoch,
      'insertDate': DateTime.now(),
      'index': startIndex
    });
  }
}