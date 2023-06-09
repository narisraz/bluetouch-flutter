import 'package:flutter/material.dart';

enum ClientState {
  active, suspended, waiting
}

class ClientStateData {
  final String label;
  final Color color;
  final Color textColor;

  ClientStateData(this.label, this.color, {this.textColor = Colors.white});
}

extension ClientStateExtension on ClientState {
  ClientStateData get data {
    switch (this) {
      case ClientState.waiting:
        return ClientStateData("En attente", Colors.redAccent);
      case ClientState.active:
        return ClientStateData("Active", Colors.green);
      case ClientState.suspended:
        return ClientStateData("Suspendu", Colors.grey, textColor: Colors.black);
    }
  }
}