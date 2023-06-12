import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:bluetouch/client/bloc/client_list_bloc.dart';
import 'package:bluetouch/client/bloc/client_list_event.dart';
import 'package:bluetouch/client/bloc/client_list_state.dart';

class ClientListBlocMock extends MockBloc<ClientListEvent, ClientListState> implements ClientListBloc {
  ClientListBlocMock(): super() {
    on<ClientListEventFetched>(_onClientFetched);
  }

  FutureOr<void> _onClientFetched(event, emit) => {
    emit(const ClientListState(
      clientListStatus: ClientListStatus.success,
      clients: []
    ))
  };
}