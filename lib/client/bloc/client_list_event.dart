import 'package:bluetouch/client/models/client_state.dart';

class ClientListEvent {
  const ClientListEvent();
}

class ClientListEventFetched extends ClientListEvent {}
class ClientListEventUpdateElement extends ClientListEvent {
  final String id;
  final ClientState state;

  ClientListEventUpdateElement(this.id, this.state);
}