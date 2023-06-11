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
    on<ClientListEventUpdateState>(_onUpdateState);
    on<ClientListEventUpdateCategory>(_onUpdateCategory);
    on<ClientListEventInstallBranchement>(_onInstallBranchement);
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

  FutureOr<void> _onUpdateState(ClientListEventUpdateState event, Emitter<ClientListState> emit) async {
    try {
      await clientRepository.updateClientState(event.id, event.state);
    } catch(e) {
      emit(const ClientListState(
          clientListStatus: ClientListStatus.failure
      ));
    }
  }

  FutureOr<void> _onUpdateCategory(ClientListEventUpdateCategory event, Emitter<ClientListState> emit) async {
    try {
      await clientRepository.updateClientCategory(event.id, event.category);
    } catch(e) {
      emit(const ClientListState(
          clientListStatus: ClientListStatus.failure
      ));
    }
  }

  FutureOr<void> _onInstallBranchement(ClientListEventInstallBranchement event, Emitter<ClientListState> emit) async {
    try {
      await clientRepository.installBranchement(event.clientId, event.date, event.startIndex);
    } catch(e) {
      emit(const ClientListState(
          clientListStatus: ClientListStatus.failure
      ));
    }
  }
}