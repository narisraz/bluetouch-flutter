import 'package:bluetouch/client/config/use_case.dart';
import 'package:bluetouch/client/domain/models/branchement.dart';
import 'package:bluetouch/client/domain/models/client.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class IconInstallBranchement extends ConsumerWidget {
  const IconInstallBranchement({
    super.key,
    required this.client,
  });

  final Client client;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      message: 'Installation branchement',
      child: IconButton(
        onPressed: () {
          final formKey = GlobalKey<FormState>();

          TextEditingController dateController = TextEditingController();
          TextEditingController indexController = TextEditingController();
          final branchementFuture =
              ref.read(getBranchementProvider).execute(client.id!);
          final addBranchement = ref.read(addBranchementProvider);

          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("Installation branchement"),
                    content: Builder(builder: (context) {
                      return FutureBuilder(
                        future: branchementFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            final branchement = snapshot.data;
                            dateController.text = DateFormat("dd/MM/yyyy")
                                .format(branchement?.date ?? DateTime.now());
                            indexController.text =
                                (branchement?.index ?? 0).toString();
                            return Form(
                              key: formKey,
                              child: Wrap(
                                children: [
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        label: Text("Date d'installation"),
                                        icon: Icon(Icons.date_range)),
                                    readOnly: true,
                                    controller: dateController,
                                    onTap: () async {
                                      var pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate:
                                              DateTime(DateTime.now().year - 1),
                                          lastDate: DateTime(
                                              DateTime.now().year + 1));
                                      if (pickedDate != null) {
                                        String formattedDate =
                                            DateFormat("dd/MM/yyyy")
                                                .format(pickedDate);
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
                                        icon: Icon(Icons.numbers)),
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
                            );
                          }
                          return const Center();
                        },
                      );
                    }),
                    actions: [
                      TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              addBranchement.execute(
                                Branchement(
                                    clientId: client.id!,
                                    date: DateFormat("dd/MM/yyyy")
                                        .parse(dateController.text),
                                    insertDate: DateTime.now(),
                                    index:
                                        double.tryParse(indexController.text) ??
                                            0),
                              );
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text("Valider")),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Annuler"))
                    ],
                  ));
        },
        icon: const Icon(Icons.install_desktop),
        iconSize: 16,
      ),
    );
  }
}
