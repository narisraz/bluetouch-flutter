import 'package:bluetouch/client/domain/models/client_state.dart';
import 'package:flutter/material.dart';

class ClientStateData {
  final String label;
  final Color color;
  final Color textColor;

  ClientStateData(
      {required this.label,
      required this.color,
      this.textColor = Colors.white});
}

extension ClientStateExtension on ClientState {
  ClientStateData get data {
    switch (this) {
      case ClientState.waiting:
        return ClientStateData(label: "En attente", color: Colors.redAccent);
      case ClientState.active:
        return ClientStateData(label: "Active", color: Colors.green);
      case ClientState.suspended:
        return ClientStateData(
            label: "Suspendu", color: Colors.grey, textColor: Colors.black);
    }
  }
}
