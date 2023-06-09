import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bluetouch/client/bloc/client_list_event.dart';
import 'package:bluetouch/client/bloc/client_list_state.dart';
import 'package:bluetouch/client/repository/client_repository.dart';

class ClientListBloc extends Bloc<ClientListEvent, ClientListState> {
  late final ClientRepository clientRepository;

  ClientListBloc(this.clientRepository): super(const ClientListState()) {
    on<ClientListEventFetched>(_onClientFetched);
  }

  FutureOr<void> _onClientFetched(ClientListEventFetched event, emit) async {
    try {
      var clients = await clientRepository.getAll();
      if (state.clientListStatus == ClientListStatus.initial) {
        emit(ClientListState(
            clientListStatus: ClientListStatus.success,
            clients: clients
        ));
      }
    } catch(e) {
      emit(const ClientListState(
        clientListStatus: ClientListStatus.failure
      ));
    }
  }
}