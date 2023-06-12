import 'package:bluetouch/client/models/branchement.dart';

abstract class BranchementRepository {
  Future<Branchement?> getByClientId(String clientId);
  Future<void> add(String clientId, DateTime date, double startIndex);
}