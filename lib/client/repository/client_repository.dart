import 'package:bluetouch/client/models/client.dart';
import 'package:bluetouch/client/models/client_state.dart';

abstract class ClientRequestRepository {
  Future<List<Client>> getAll();
}

abstract class ClientCommandRepository {
  Future<void> updateClientState(String id, ClientState state);
}