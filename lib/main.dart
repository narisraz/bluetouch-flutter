import 'dart:ui';

import 'package:bluetouch/client/repository/client_repository.dart';
import 'package:bluetouch/client/views/client_list_page.dart';
import 'package:bluetouch/data/client_firestore_repository.dart';
import 'package:bluetouch/drawer.dart';
import 'package:bluetouch/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;

    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Bluetouch"),
          actions: [
            DropdownButton(
              items: const [DropdownMenuItem(child: Text("Sabotsy Namehana"))],
              onChanged: (_) {},
            )
          ],
        ),
        drawer: const AppDrawer(),
        body: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<ClientRepository>(create: (_) => ClientFirestoreRepository(firestore)),
          ],
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: const ClientListPage(),
          ),
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
