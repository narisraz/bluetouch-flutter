import 'package:bluetouch/client/models/client.dart';
import 'package:bluetouch/client/models/client_state.dart';

abstract class ClientRepository {
  Future<List<Client>> getAll();
  Future<void> updateClientState(String id, ClientState state);
}