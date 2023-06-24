import 'package:bluetouch/auth/domain/models/auth_user.dart';
import 'package:bluetouch/core/domain/models/saep.dart';
import 'package:bluetouch/core/domain/repository/saep_repository.dart';
import 'package:bluetouch/core/domain/usecases/interface/get_all_saep_by_user.dart';

class GetAllSaepByUserUseCase extends GetAllSaepByUser {
  final SaepRepository saepRepository;

  GetAllSaepByUserUseCase({required this.saepRepository});

  @override
  Stream<Iterable<Saep>> execute(AuthUser authUser) {
    return saepRepository.getSaepFromListOfId(authUser.saepList);
  }
}
