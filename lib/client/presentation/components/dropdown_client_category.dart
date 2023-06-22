import 'package:bluetouch/client/domain/models/client_category.dart';
import 'package:flutter/material.dart';

class DropdownClientCategory extends StatelessWidget {
  final ClientCategory selectedCategory;
  final void Function(ClientCategory?)? onChanged;

  const DropdownClientCategory(
      {super.key, required this.onChanged, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedCategory,
      items: ClientCategory.values
          .map((state) =>
              DropdownMenuItem(value: state, child: Text(state.data.label)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
