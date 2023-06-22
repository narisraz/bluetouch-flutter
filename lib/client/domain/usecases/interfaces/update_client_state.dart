import 'package:bluetouch/client/domain/models/client_state.dart';

abstract class UpdateClientState {
  Future<void> execute(String clientId, ClientState newState);
}
