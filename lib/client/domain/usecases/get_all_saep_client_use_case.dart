import 'package:bluetouch/client/domain/models/client.dart';
import 'package:bluetouch/client/domain/repository/client_repository.dart';
import 'package:bluetouch/client/domain/usecases/interfaces/get_all_saep_client.dart';

class GetAllSaepClientUseCase extends GetAllSaepClient {
  final ClientRepository clientRepository;

  GetAllSaepClientUseCase({required this.clientRepository});

  @override
  Stream<Iterable<Client>> execute(String saepId) {
    return clientRepository.getAllBySaepId(saepId);
  }
}
