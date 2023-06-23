import 'package:bluetouch/client/domain/models/branchement.dart';
import 'package:bluetouch/client/domain/repository/branchement_repository.dart';
import 'package:bluetouch/client/domain/usecases/interfaces/get_branchement.dart';

class GetBranchementUseCase extends GetBranchement {
  final BranchementRepository branchementRepository;

  GetBranchementUseCase({required this.branchementRepository});

  @override
  Future<Branchement?> execute(String clientId) {
    return branchementRepository.getByClientId(clientId);
  }
}
