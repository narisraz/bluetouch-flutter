import 'package:bluetouch/client/domain/models/client_category.dart';
import 'package:bluetouch/client/presentation/components/dropdown_client_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddClientPage extends HookConsumerWidget {
  const AddClientPage({
    super.key,
    required this.nameController,
    required this.firstNameController,
    required this.referenceController,
    required this.contractNumberController,
    required this.rangController,
    required this.rueController,
    required this.addressController,
    required this.telController,
    required this.latController,
    required this.longController,
    required this.categoryController,
  });

  final TextEditingController nameController;
  final TextEditingController firstNameController;
  final TextEditingController referenceController;
  final TextEditingController contractNumberController;
  final TextEditingController rangController;
  final TextEditingController rueController;
  final TextEditingController addressController;
  final TextEditingController telController;
  final TextEditingController latController;
  final TextEditingController longController;
  final TextEditingController categoryController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientCategory = useState(categoryController.text);
    return Form(
      child: Wrap(
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              label: Text("Nom"),
            ),
          ),
          TextFormField(
            controller: firstNameController,
            decoration: const InputDecoration(
              label: Text("Prénom"),
            ),
          ),
          TextFormField(
            controller: contractNumberController,
            decoration: const InputDecoration(
              label: Text("Numéro de contrat"),
            ),
          ),
          TextFormField(
            controller: referenceController,
            decoration: const InputDecoration(
              label: Text("Référence client"),
            ),
          ),
          TextFormField(
            controller: rangController,
            decoration: const InputDecoration(
              label: Text("Rang dans la tournée"),
            ),
          ),
          TextFormField(
            controller: telController,
            decoration: const InputDecoration(
              label: Text("Téléphone"),
            ),
          ),
          TextFormField(
            controller: rueController,
            decoration: const InputDecoration(
              label: Text("Rue"),
            ),
          ),
          TextFormField(
            controller: addressController,
            decoration: const InputDecoration(
              label: Text("Adresse"),
            ),
          ),
          TextFormField(
            controller: longController,
            decoration: const InputDecoration(
              label: Text("Longitude"),
            ),
          ),
          TextFormField(
            controller: latController,
            decoration: const InputDecoration(
              label: Text("Latitude"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: DropdownClientCategory(
                onChanged: (value) {
                  clientCategory.value = value!.name;
                  categoryController.text = clientCategory.value;
                },
                selectedCategory:
                    ClientCategory.values.byName(clientCategory.value)),
          )
        ],
      ),
    );
  }
}
