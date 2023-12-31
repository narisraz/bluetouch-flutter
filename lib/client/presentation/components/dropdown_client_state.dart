import 'package:bluetouch/client/domain/models/client_state.dart';
import 'package:bluetouch/client/presentation/extensions/client_state_extension.dart';
import 'package:flutter/material.dart';

class DropdownClientState extends StatelessWidget {
  final ClientState selectedState;
  final void Function(ClientState?)? onChanged;

  const DropdownClientState(
      {super.key, required this.onChanged, required this.selectedState});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedState,
      selectedItemBuilder: (BuildContext context) => ClientState.values
          .map((item) => Row(
                children: [
                  Text(
                    item.data.label,
                    style: TextStyle(color: selectedState.data.color),
                  ),
                ],
              ))
          .toList(),
      items: ClientState.values
          .map((state) =>
              DropdownMenuItem(value: state, child: Text(state.data.label)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
