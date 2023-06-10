import 'package:bluetouch/client/models/client.dart';
import 'package:bluetouch/client/models/client_state.dart';
import 'package:flutter/material.dart';

class DropdownClientState extends StatelessWidget {
  final Client client;
  final void Function(ClientState?)? onChanged;

  const DropdownClientState({
    super.key,
    required this.onChanged,
    required this.client
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: client.state,
      selectedItemBuilder: (BuildContext context) =>
          ClientState.values.map((item) =>
              Row(
                children: [
                  Text(
                    item.data.label,
                    style: TextStyle(
                        color: client.state.data.color
                    ),
                  ),
                ],
              )
          ).toList(),
      items: ClientState.values.map((state) =>
          DropdownMenuItem(
              value: state,
              child: Text(state.data.label)
          )
      ).toList(),
      onChanged: onChanged,
    );
  }
}