import 'package:bluetouch/compteur/models/compteur_state.dart';

class Compteur {
  late final String number;
  late final String brand;
  late DateTime manufacturingDate;
  late String classe;
  late CompteurState compteurState;

  Compteur(this.number, this.compteurState);
}