import 'package:bluetouch/client/models/client_category.dart';
import 'package:bluetouch/client/models/client_state.dart';

class ClientListEvent {
  const ClientListEvent();
}

class ClientListEventFetched extends ClientListEvent {}
class ClientListEventUpdateState extends ClientListEvent {
  final String id;
  final ClientState state;

  ClientListEventUpdateState(this.id, this.state);
}
class ClientListEventUpdateCategory extends ClientListEvent {
  final String id;
  final ClientCategory category;

  ClientListEventUpdateCategory(this.id, this.category);
}
class ClientListEventInstallBranchement extends ClientListEvent {
  final String clientId;
  final DateTime date;
  final double startIndex;

  ClientListEventInstallBranchement(this.clientId, this.date, this.startIndex);
}