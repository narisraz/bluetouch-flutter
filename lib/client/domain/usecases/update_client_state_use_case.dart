import 'package:bluetouch/client/domain/models/client_state.dart';
import 'package:bluetouch/client/domain/repository/client_repository.dart';
import 'package:bluetouch/client/domain/usecases/interfaces/update_client_state.dart';

class UpdateClientStateUseCase extends UpdateClientState {
  final ClientRepository clientRepository;

  UpdateClientStateUseCase({required this.clientRepository});

  @override
  Future<void> execute(String clientId, ClientState newState) {
    return clientRepository.updateClientState(clientId, newState);
  }
}
