import 'package:bluetouch/client/config/use_case.dart';
import 'package:bluetouch/client/domain/models/client_category.dart';
import 'package:bluetouch/client/domain/models/client_state.dart';
import 'package:bluetouch/client/domain/usecases/interfaces/update_client_category.dart';
import 'package:bluetouch/client/domain/usecases/interfaces/update_client_state.dart';
import 'package:bluetouch/client/presentation/components/dropdown_client_category.dart';
import 'package:bluetouch/client/presentation/components/dropdown_client_state.dart';
import 'package:bluetouch/client/presentation/components/icon_install_branchement.dart';
import 'package:bluetouch/client/presentation/extensions/client_state_extension.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/client.dart';

class ClientListPage extends ConsumerWidget {
  const ClientListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final name = authUser?.name ?? "";
    // debugPrint('ClientListPage ${authUser.toString()}');
    // TODO get current saep
    final clientsStream = ref.read(getAllSaepClientProvider).execute("saepId");
    final updateClientState = ref.read(updateClientStateProvider);
    final updateClientCategory = ref.read(updateClientCategoryProvider);

    return Scrollbar(
      child: ListView(
        children: [
          StreamBuilder(
            stream: clientsStream,
            builder: (builder, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.active) {
                return Scrollbar(
                  child: PaginatedDataTable(
                    showFirstLastButtons: true,
                    primary: true,
                    source: ClientListDataSource(
                      clients: snapshot.data!.toList(),
                      context: context,
                      updateClientState: updateClientState,
                      updateClientCategory: updateClientCategory,
                    ),
                    header: Text('Liste des clients'),
                    rowsPerPage: 10,
                    actions: [
                      ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          label: const Text("Nouveau")),
                    ],
                    columns: [
                      buildTableTitle("Numéro de contrat", numeric: true),
                      buildTableTitle("Nom"),
                      buildTableTitle("Prénom"),
                      buildTableTitle("Rue"),
                      buildTableTitle("Adresse"),
                      buildTableTitle("Téléphone"),
                      buildTableTitle("GPS"),
                      buildTableTitle("Référence client"),
                      buildTableTitle("Compteur"),
                      buildTableTitle("Rang", numeric: true),
                      buildTableTitle("Etat"),
                      buildTableTitle("Catégorie d'abonnement"),
                      buildTableTitle("Compte courent", numeric: true),
                      buildTableTitle("Actions"),
                    ],
                  ),
                );
              }
              return const Center();
            },
          )
        ],
      ),
    );
  }

  DataColumn buildTableTitle(String label, {bool numeric = false}) {
    return DataColumn(
        numeric: numeric,
        label: Text(
          label,
        ));
  }
}

class ClientListDataSource extends DataTableSource {
  final List<Client> clients;
  final BuildContext context;
  final UpdateClientState updateClientState;
  final UpdateClientCategory updateClientCategory;

  ClientListDataSource({
    required this.clients,
    required this.context,
    required this.updateClientState,
    required this.updateClientCategory,
  });

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(clients[index].contractNumber.toString())),
      DataCell(Text(clients[index].name)),
      DataCell(Text(clients[index].firstName)),
      DataCell(Text(clients[index].address?.rue ?? "")),
      DataCell(Text(clients[index].address?.address ?? "")),
      DataCell(Text(clients[index].tel ?? "")),
      DataCell(Text(
          '${clients[index].address?.lat};${clients[index].address?.long}')),
      DataCell(Text(clients[index].reference)),
      DataCell(Text(clients[index].compteur?.number ?? "")),
      DataCell(Text(clients[index].rang.toString())),
      DataCell(DropdownClientState(
        key: Key('dropdown_state_$index'),
        selectedState: clients[index].state,
        onChanged: (ClientState? state) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Changement d'état"),
                  content: Text(
                      "Souhaitez-vous vraiment changer l'état de ce client en ${state?.data.label} ?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          updateClientState
                              .execute(clients[index].id!, state!)
                              .then((_) => Navigator.pop(context));
                        },
                        child: const Text("Ok")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Annuler")),
                  ],
                );
              });
        },
      )),
      DataCell(DropdownClientCategory(
        key: Key('dropdown_category_$index'),
        selectedCategory: clients[index].category,
        onChanged: (ClientCategory? category) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Changement de catégorie"),
                  content: Text(
                      "Souhaitez-vous vraiment changer la catégorie de ce client en ${category?.data.label} ?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          updateClientCategory
                              .execute(clients[index].id!, category!)
                              .then((_) => Navigator.pop(context));
                        },
                        child: const Text("Ok")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Annuler")),
                  ],
                );
              });
        },
      )),
      DataCell(Text(clients[index].account.toString())),
      DataCell(Row(
        children: [IconInstallBranchement(client: clients[index])],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => clients.length;

  @override
  int get selectedRowCount => 0;
}
