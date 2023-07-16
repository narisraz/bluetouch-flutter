import 'package:bluetouch/client/domain/models/address.dart';
import 'package:bluetouch/client/domain/models/client_category.dart';
import 'package:bluetouch/client/domain/models/client_state.dart';
import 'package:bluetouch/compteur/models/compteur.dart';
import 'package:equatable/equatable.dart';

class Client extends Equatable {
  final int contractNumber;
  final String saepId;
  final String name;
  final String firstName;
  final String reference;
  final ClientCategory category;
  final ClientState state;
  final String? id;
  final String? tel;
  final int? rang;
  final double? account;
  final Address? address;
  final Compteur? compteur;

  const Client({
    required this.saepId,
    required this.contractNumber,
    required this.name,
    required this.firstName,
    required this.reference,
    required this.category,
    required this.state,
    this.id,
    this.tel,
    this.rang,
    this.account,
    this.compteur,
    this.address,
  });

  Map<String, dynamic> toJson() => {
        'contractNumber': contractNumber,
        'name': name,
        'firstName': firstName,
        'reference': reference,
        'category': category.name,
        'state': state.name,
        'saepId': saepId
      };

  static Client fromJson(Map<String, dynamic> data) {
    return Client(
      saepId: data['saepId'],
      state: ClientState.values.byName(data['state']),
      contractNumber: data['contractNumber'],
      name: data['name'],
      firstName: data['firstName'],
      reference: data['reference'],
      category: ClientCategory.values.byName(data['category']),
      tel: data['tel'],
      id: data['id'],
      rang: int.tryParse('${data['rang']}') ?? 0,
      account: double.tryParse('${data['account']}') ?? 0,
    );
  }

  @override
  List<Object?> get props => [id];
}
