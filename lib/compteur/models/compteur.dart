import 'package:bluetouch/compteur/models/compteur_state.dart';

class Compteur {
  final String number;
  final String? brand;
  final DateTime? manufacturingDate;
  final String? classe;
  final CompteurState compteurState;

  Compteur(
      {required this.number,
      required this.compteurState,
      this.brand,
      this.classe,
      this.manufacturingDate});
}
