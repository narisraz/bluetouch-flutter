import 'package:bluetouch/branchement/bloc/branchement_bloc.dart';
import 'package:bluetouch/branchement/bloc/branchement_event.dart';
import 'package:bluetouch/branchement/bloc/branchement_state.dart';
import 'package:bluetouch/branchement/repository/branchement_repository.dart';
import 'package:bluetouch/client/models/client.dart';
import 'package:bluetouch/data/branchement_firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class IconInstallBranchement extends StatelessWidget {
  const IconInstallBranchement({
    super.key,
    required Client client,
  }) : _client = client;

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

            showDialog(context: context, builder: (context) => RepositoryProvider<BranchementRepository>(
              create: (BuildContext context) => BranchementFirestoreRepository(),
              child: BlocProvider(
                create: (BuildContext context) => BranchementBloc(context)..add(BranchementEventGetOne(clientId: _client.id!)),
                child: BlocBuilder<BranchementBloc, BranchementState>(
                  builder: (context, state) {
                    return AlertDialog(
                      title: const Text("Installation branchement"),
                      content: Builder(
                        builder: (context) {
                          switch (state.branchementStatus) {
                            case BranchementStatus.initial:
                              return Wrap(
                                children: const [
                                  Center(child: CircularProgressIndicator()),
                                ],
                              );
                            case BranchementStatus.failure:
                              return const Center(child: Text(
                                  'Erreur lors de la récupération du branchement'));
                            case BranchementStatus.success:
                              dateController.text = DateFormat("dd/MM/yyyy").format(state.branchement?.date ?? DateTime.now());
                              indexController.text = (state.branchement?.index ?? 0).toString();
                              return Form(
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
                                            firstDate: DateTime(DateTime
                                                .now()
                                                .year - 1),
                                            lastDate: DateTime(DateTime
                                                .now()
                                                .year + 1)
                                        );
                                        if (pickedDate != null) {
                                          String formattedDate = DateFormat(
                                              "dd/MM/yyyy").format(pickedDate);
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
                              );
                          }
                        }
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<BranchementBloc>().add(
                                    BranchementEventAdd(
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
                    );
                  }
                ),
              ),
            ));
          },
          icon: const Icon(Icons.install_desktop),
          iconSize: 16,
        ),
      );
    }
}