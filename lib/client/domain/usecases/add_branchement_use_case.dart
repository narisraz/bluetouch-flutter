import 'package:bluetouch/client/domain/models/branchement.dart';
import 'package:bluetouch/client/domain/repository/branchement_repository.dart';
import 'package:bluetouch/client/domain/usecases/interfaces/add_branchement.dart';

class AddBranchementUseCase extends AddBranchement {
  final BranchementRepository branchementRepository;

  AddBranchementUseCase({required this.branchementRepository});

  @override
  Future<void> execute(Branchement branchement) {
    return branchementRepository.add(branchement);
  }
}
