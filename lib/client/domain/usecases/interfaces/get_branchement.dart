import 'package:bluetouch/client/domain/models/branchement.dart';

abstract class GetBranchement {
  Future<Branchement?> execute(String clientId);
}
