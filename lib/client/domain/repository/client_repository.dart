import 'package:bluetouch/client/domain/models/client.dart';
import 'package:bluetouch/client/domain/models/client_category.dart';
import 'package:bluetouch/client/domain/models/client_state.dart';

abstract class ClientRepository {
  Stream<Iterable<Client>> getAllBySaepId(String saepId);

  Future<void> updateClientState(String id, ClientState state);

  Future<void> updateClientCategory(String id, ClientCategory category);
}
