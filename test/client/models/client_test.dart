import 'package:bluetouch/client/models/client.dart';
import 'package:bluetouch/client/models/client_category.dart';
import 'package:bluetouch/client/models/client_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../stubs/client_stubs.dart';
import '../../compteur/stubs/compteur_stubs.dart';

void main() {
  group("Client", () {
    test("Change compteur", () {
      Client client = clientStub;
      client.changeCompteur(COMPTEUR_IN_STOCK);
      expect(client.compteur, equals(COMPTEUR_IN_STOCK));
    });

    test("Change client category", () {
      Client client = clientStub;
      client.changeCategory(ClientCategory.private);
      expect(client.category, equals(ClientCategory.private));
    });

    test("parse client from json", () {
      var client = Client.fromJson({
        'contractNumber': 1,
        'name': 'A Name',
        'firstName': 'First Name',
        'reference': 'REF01',
        'category': 'PRIVATE',
        'state': 'WAITING',
        'account': 512.2,
        'tel': '1234456',
        'rang': 1,
        'id': '0a01',
      });
      expect(client.name, 'A Name');
      expect(client.firstName, 'First Name');
      expect(client.contractNumber, 1);
      expect(client.reference, 'REF01');
      expect(client.category, ClientCategory.private);
      expect(client.state, ClientState.waiting);
      expect(client.account, 512.2);
      expect(client.tel, '1234456');
      expect(client.rang, 1);
      expect(client.id, '0a01');
    });
  });
}