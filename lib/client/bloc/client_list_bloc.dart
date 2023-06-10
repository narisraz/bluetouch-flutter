import 'dart:async';
import 'package:bluetouch/client/bloc/client_list_event.dart';
import 'package:bluetouch/client/bloc/client_list_state.dart';
import 'package:bluetouch/client/repository/client_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientListBloc extends Bloc<ClientListEvent, ClientListState> {
  late final BuildContext context;
  late final ClientRepository clientRepository;

  ClientListBloc(this.context): super(const ClientListState()) {
    clientRepository = RepositoryProvider.of<ClientRepository>(context);
    on<ClientListEventFetched>(_onClientFetched);
    on<ClientListEventUpdateElement>(_onUpdateElement);
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

  FutureOr<void> _onUpdateElement(ClientListEventUpdateElement event, Emitter<ClientListState> emit) async {
    try {
      await clientRepository.updateClientState(event.id, event.state);
    } catch(e) {
      emit(const ClientListState(
          clientListStatus: ClientListStatus.failure
      ));
    }
  }
}