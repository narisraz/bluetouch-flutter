import 'package:bluetouch/client/bloc/client_list_bloc.dart';
import 'package:bluetouch/client/bloc/client_list_event.dart';
import 'package:bluetouch/client/bloc/client_list_state.dart';
import 'package:bluetouch/client/components/dropdown_client_category.dart';
import 'package:bluetouch/client/components/dropdown_client_state.dart';
import 'package:bluetouch/client/models/client.dart';
import 'package:bluetouch/client/models/client_category.dart';
import 'package:bluetouch/client/models/client_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ClientListPage extends StatelessWidget {

  const ClientListPage({
    super.key,
  });

  DataColumn buildTableTitle(String label, {bool numeric = false}) {
    return DataColumn(
      numeric: numeric,
      label: Text(
        label,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClientListBloc(context)..add(ClientListEventFetched()),
      child: Scrollbar(
        child: ListView(
          children: [
            BlocBuilder<ClientListBloc, ClientListState>(
                builder: (context, state) {
                  switch (state.clientListStatus) {
                    case ClientListStatus.failure:
                      return const Center(child: Text('Erreur lors de la récupération des clients'));
                    case ClientListStatus.initial:
                      return const Center(child: CircularProgressIndicator());
                    case ClientListStatus.success:
                      if (state.clients.isEmpty) {
                        return Column(
                          children: [
                            const Text('Il n\'y a pas encore de clients'),
                            const SizedBox(
                              height: 8,
                            ),
                            ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.add),
                                label: const Text("Nouveau")),
                          ],
                        );
                      }
                      return Scrollbar(
                        child: PaginatedDataTable(
                          showFirstLastButtons: true,
                          primary: true,
                          source: ClientListDataSource(state.clients, context),
                          header: const Text('Liste des clients'),
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
                }
            ),
          ],
        ),
      )
    );
  }
}

class ClientListDataSource extends DataTableSource {

  final List<Client> _clients;
  final BuildContext _context;

  ClientListDataSource(this._clients, this._context);

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_clients[index].contractNumber.toString())),
      DataCell(Text(_clients[index].name)),
      DataCell(Text(_clients[index].firstName)),
      DataCell(Text(_clients[index].address?.rue ?? "")),
      DataCell(Text(_clients[index].address?.address ?? "")),
      DataCell(Text(_clients[index].tel ?? "")),
      DataCell(Text('${_clients[index].address?.lat};${_clients[index].address?.long}')),
      DataCell(Text(_clients[index].reference)),
      DataCell(Text(_clients[index].compteur?.number ?? "")),
      DataCell(Text(_clients[index].rang.toString())),
      DataCell(DropdownClientState(
        key: Key('dropdown_state_$index'),
        selectedState: _clients[index].state,
        onChanged: (ClientState? state) {
          showDialog(context: _context, builder: (context) {
            return AlertDialog(
              title: const Text("Changement d'état"),
              content: Text("Souhaitez-vous vraiment changer l'état de ce client en ${state?.data.label} ?"),
              actions: [
                TextButton(onPressed: () {
                  _context.read<ClientListBloc>().add(ClientListEventUpdateState(_clients[index].id!, state!));
                  _clients[index].state = state;
                  notifyListeners();
                  Navigator.pop(context);
                }, child: const Text("Ok")),
                TextButton(onPressed: () {
                  Navigator.pop(context);
                }, child: const Text("Annuler")),
              ],
            );
          });
        },
      )),
      DataCell(DropdownClientCategory(
        key: Key('dropdown_category_$index'),
        selectedCategory: _clients[index].category,
        onChanged: (ClientCategory? category) {
          showDialog(context: _context, builder: (context) {
            return AlertDialog(
              title: const Text("Changement de catégorie"),
              content: Text("Souhaitez-vous vraiment changer la catégorie de ce client en ${category?.data.label} ?"),
              actions: [
                TextButton(onPressed: () {
                  _context.read<ClientListBloc>().add(ClientListEventUpdateCategory(_clients[index].id!, category!));
                  _clients[index].category = category;
                  notifyListeners();
                  Navigator.pop(context);
                }, child: const Text("Ok")),
                TextButton(onPressed: () {
                  Navigator.pop(context);
                }, child: const Text("Annuler")),
              ],
            );
          });
        },
      )),
      DataCell(Text(_clients[index].account.toString())),
      DataCell(Row(
        children: [
          Tooltip(
            message: 'Installation branchement',
            child: IconButton(
              onPressed: () {
                final formKey = GlobalKey<FormState>();

                TextEditingController dateController = TextEditingController();
                TextEditingController indexController = TextEditingController();

                showDialog(context: _context, builder: (context) => AlertDialog(
                  title: const Text("Installation branchement"),
                  content: Form(
                    key: formKey,
                    child: Wrap(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Date d'installation"),
                            icon: Icon(Icons.date_range)
                          ),
                          readOnly: true,
                          controller: dateController,
                          onTap: () async {
                            var pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year - 1),
                                lastDate: DateTime(DateTime.now().year + 1)
                            );
                            if (pickedDate != null) {
                              String formattedDate = DateFormat("dd/MM/yyyy").format(pickedDate);
                              dateController.text = formattedDate;
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ce champ est obligatoire';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              label: Text("Index de départ"),
                              icon: Icon(Icons.numbers)
                          ),
                          controller: indexController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ce champ est obligatoire';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _context.read<ClientListBloc>().add(
                              ClientListEventInstallBranchement(
                                  _clients[index].id!,
                                  DateFormat("dd/MM/yyyy").parse(dateController.text),
                                  double.tryParse(indexController.text) ?? 0
                              )
                          );
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text("Valider")
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Annuler")
                    )
                  ],
                ));
              },
              icon: const Icon(Icons.install_desktop),
              key: Key("installation_$index"),
              iconSize: 16,
            ),
          )
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _clients.length;

  @override
  int get selectedRowCount => 0;

}

