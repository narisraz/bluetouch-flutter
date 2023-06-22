import 'package:bluetouch/client/domain/models/branchement.dart';

abstract class AddBranchement {
  Future<void> execute(Branchement branchement);
}
