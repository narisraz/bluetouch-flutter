import 'package:bluetouch/client/domain/models/branchement.dart';

abstract class BranchementRepository {
  Future<Branchement?> getByClientId(String clientId);

  Future<void> add(Branchement branchement);
}
