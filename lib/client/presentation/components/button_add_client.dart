import 'package:bluetouch/client/presentation/views/add_client_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtonAddClient extends ConsumerWidget {
  const ButtonAddClient({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                final TextEditingController nameController =
                    TextEditingController();
                final TextEditingController firstNameController =
                    TextEditingController();
                final TextEditingController referenceController =
                    TextEditingController();
                final TextEditingController contractNumberController =
                    TextEditingController();
                final TextEditingController rangController =
                    TextEditingController();
                final TextEditingController rueController =
                    TextEditingController();
                final TextEditingController addressController =
                    TextEditingController();
                final TextEditingController telController =
                    TextEditingController();
                final TextEditingController latController =
                    TextEditingController();
                final TextEditingController longController =
                    TextEditingController();
                final TextEditingController categoryController =
                    TextEditingController();
                return AlertDialog(
                  title: const Text("Nouveau client"),
                  content: SizedBox(
                      width: 600,
                      child: Scrollbar(
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                            child: AddClientPage(
                          addressController: addressController,
                          categoryController: categoryController,
                          contractNumberController: contractNumberController,
                          firstNameController: firstNameController,
                          latController: latController,
                          longController: longController,
                          nameController: nameController,
                          rangController: rangController,
                          referenceController: referenceController,
                          rueController: rueController,
                          telController: telController,
                        )),
                      )),
                  actions: [
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Valider")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Annuler")),
                  ],
                );
              });
        },
        icon: const Icon(Icons.add),
        label: const Text("Nouveau"));
  }
}
