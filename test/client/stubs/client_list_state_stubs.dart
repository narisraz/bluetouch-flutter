import 'package:bluetouch/client/bloc/client_list_state.dart';

import 'client_stubs.dart';

const clientListInitialState = ClientListState(
    clients: [],
    clientListStatus: ClientListStatus.initial
);

final clientListSuccessState = ClientListState(
    clients: clientsStub,
    clientListStatus: ClientListStatus.success
);