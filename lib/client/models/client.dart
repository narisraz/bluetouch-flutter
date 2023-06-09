import 'package:bluetouch/client/models/address.dart';
import 'package:bluetouch/client/models/client_category.dart';
import 'package:bluetouch/client/models/client_state.dart';
import 'package:bluetouch/compteur/models/compteur.dart';
import 'package:equatable/equatable.dart';

class Client extends Equatable {
  late final int contractNumber;
  late final String name;
  late final String firstName;
  late final String reference;
  late String? id = "";
  late String? tel = "";
  late ClientCategory category;
  late int rang = 0;
  late ClientState state = ClientState.waiting;
  late double account = 0;
  Address? address;
  Compteur? compteur;

  Client(
      this.contractNumber,
      this.name, this.firstName,
      this.reference,
      this.category
      );

  void changeCompteur(Compteur newCompteur) {
    compteur = newCompteur;
  }

  void changeCategory(ClientCategory newCategory) {
    category = newCategory;
  }

  Map<String, dynamic> toJson() => {
    'contractNumber': contractNumber,
    'name': name,
    'firstName': firstName,
    'reference': reference,
    'category': category.name
  };

  static Client fromJson(Map<String, dynamic> data) {
    return Client(
      data['contractNumber'],
      data['name'],
      data['firstName'],
      data['reference'],
      ClientCategory.values.byName(data['category'])
    )
        ..tel = data['tel']
        ..id = data['id']
        ..rang = int.tryParse('${data['rang']}') ?? 0
        ..state = ClientState.values.byName(data['state'] ?? ClientState.waiting.name)
        ..account = double.tryParse('${data['account']}') ?? 0;
  }

  @override
  List<Object?> get props => [id];
}