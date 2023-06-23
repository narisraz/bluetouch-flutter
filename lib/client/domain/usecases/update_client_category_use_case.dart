import 'package:bluetouch/client/domain/models/client_category.dart';
import 'package:bluetouch/client/domain/repository/client_repository.dart';
import 'package:bluetouch/client/domain/usecases/interfaces/update_client_category.dart';

class UpdateClientCategoryUseCase extends UpdateClientCategory {
  final ClientRepository clientRepository;

  UpdateClientCategoryUseCase({required this.clientRepository});

  @override
  Future<void> execute(String clientId, ClientCategory clientCategory) {
    return clientRepository.updateClientCategory(clientId, clientCategory);
  }
}
