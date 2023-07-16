import 'package:bluetouch/client/domain/models/client.dart';
import 'package:bluetouch/client/domain/repository/client_repository.dart';
import 'package:bluetouch/client/domain/usecases/interfaces/add_client.dart';

class AddClientUseCase implements AddClient {
  AddClientUseCase({required this.clientRepository});

  final ClientRepository clientRepository;

  @override
  Future<void> execute(Client client) {
    return clientRepository.addClient(client);
  }
}
