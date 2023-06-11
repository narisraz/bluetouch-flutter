import 'package:bluetouch/client/bloc/client_list_bloc.dart';
import 'package:bluetouch/client/bloc/client_list_event.dart';
import 'package:bluetouch/client/models/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class IconInstallBranchement extends StatelessWidget {
  const IconInstallBranchement({
    super.key,
    required BuildContext context,
    required Client client,
  }) : _context = context, _client = client;

  final BuildContext _context;
  final Client _client;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
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
                              _client.id!,
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
        iconSize: 16,
      ),
    );
  }
}