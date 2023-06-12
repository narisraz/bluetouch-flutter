import 'package:bluetouch/client/models/client.dart';
import 'package:bluetouch/client/models/client_category.dart';
import 'package:bluetouch/client/models/client_state.dart';
import 'package:bluetouch/client/repository/client_repository.dart';

class FakeClientRepository implements ClientRepository {

  final List<Client> clients;

  FakeClientRepository({
    required this.clients
  });

  @override
  Future<List<Client>> getAll() {
    return Future.value(clients);
  }

  @override
  Future<void> updateClientState(String id, ClientState state) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateClientCategory(String id, ClientCategory category) {
    throw UnimplementedError();
  }

  @override
  Future<void> installBranchement(String clientId, DateTime date, double index) {
    throw UnimplementedError();
  }
}