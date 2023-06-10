import 'package:bluetouch/client/bloc/client_list_bloc.dart';
import 'package:bluetouch/client/bloc/client_list_event.dart';
import 'package:bluetouch/client/repository/client_repository.dart';
import 'package:bluetouch/client/views/client_list_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientListPage extends StatelessWidget {
  final ClientRepository clientRepository;

  const ClientListPage({
    super.key,
    required this.clientRepository,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ClientListBloc(clientRepository)..add(ClientListEventFetched()),
      child: const ClientListTable()
    );
  }
}
