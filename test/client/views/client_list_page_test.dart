import 'package:bluetouch/client/bloc/client_list_bloc.dart';
import 'package:bluetouch/client/bloc/client_list_event.dart';
import 'package:bluetouch/client/models/client.dart';
import 'package:bluetouch/client/models/client_category.dart';
import 'package:bluetouch/client/models/client_state.dart';
import 'package:bluetouch/client/repository/client_repository.dart';
import 'package:bluetouch/client/views/client_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../stubs/client_repository_stubs.dart';
import '../stubs/client_stubs.dart';

void main() {
  testWidgets("should contains headers", (tester) async {
    await pumpWidget(tester, [clientStub]);

    await tester.idle();
    await tester.pump();

    expectContainsText("Numéro de contrat");
    expectContainsText("Nom");
    expectContainsText("Prénom");
    expectContainsText("Rue");
    expectContainsText("Adresse");
    expectContainsText("Téléphone");
    expectContainsText("GPS");
    expectContainsText("Référence client");
    expectContainsText("Compteur");
    expectContainsText("Rang");
    expectContainsText("Etat");
    expectContainsText("Catégorie d'abonnement");
    expectContainsText("Compte courent");
  });

  testWidgets("should contains data", (tester) async {
    await pumpWidget(tester, [clientStub]);

    await tester.idle();
    await tester.pump();

    expectContainsText(clientStub.contractNumber.toString());
    expectContainsText(clientStub.name);
    expectContainsText(clientStub.firstName);
    expectContainsText('${clientStub.address?.long};${clientStub.address?.lat}');
    expectContainsText(clientStub.reference);
    expectContainsText(clientStub.rang.toString());
    expectContainsText(clientStub.state.data.label);
    expectContainsText(clientStub.category.data.label);
    expectContainsText(clientStub.account.toString());
  });

  testWidgets("should contains no clients message", (tester) async {
    await pumpWidget(tester, []);

    await tester.idle();
    await tester.pump();

    expectContainsText('Il n\'y a pas encore de clients');
  });

  testWidgets("should udpate element", (tester) async {
    await pumpWidget(tester, [clientStub]);

    await tester.idle();
    await tester.pump();

    final updateSate = find.descendant(
        of: find.byKey(const Key('updateState_0')),
        matching: find.byIcon(Icons.change_circle)
    );
    await tester.tap(updateSate);
    await tester.pump();

    expect(const AlertDialog(), findsOneWidget);
  });
}

Future<void> pumpWidget(WidgetTester tester, List<Client> clients) async {
  await tester.pumpWidget(MaterialApp(
    home: MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ClientRepository>(create: (_) => FakeClientRepository(clients: clients))
      ],
      child: BlocProvider(
          create: (context) => ClientListBloc(context)..add(ClientListEventFetched()),
          child: const ClientListPage()
      ),
    ),
  ));
}

void expectContainsText(String value) {
  var contractNumber = find.text(value);

  expect(contractNumber, findsOneWidget);
}
