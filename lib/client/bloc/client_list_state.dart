import 'package:bluetouch/client/models/client.dart';
import 'package:equatable/equatable.dart';

enum ClientListStatus { initial, success, failure }

class ClientListState extends Equatable {

  final ClientListStatus clientListStatus;
  final List<Client> clients;


  const ClientListState({
    this.clientListStatus = ClientListStatus.initial,
    this.clients = const <Client>[]
  });

  @override
  List<Object?> get props => [clientListStatus, clients];

}