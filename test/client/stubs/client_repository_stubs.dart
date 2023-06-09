import 'package:bluetouch/client/models/client.dart';
import 'package:bluetouch/client/models/client_state.dart';
import 'package:bluetouch/client/repository/client_repository.dart';

class FakeClientRepository implements ClientRequestRepository, ClientCommandRepository {

  final List<Client> clients;

  FakeClientRepository({
    this.clients = const []
  });

  @override
  Future<List<Client>> getAll() {
    return Future.value(clients);
  }

  @override
  Future<void> updateClientState(String id, ClientState state) {
    throw UnimplementedError();
  }
}