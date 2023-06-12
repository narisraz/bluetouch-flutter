import 'dart:ui';

import 'package:bluetouch/auth/bloc/auth_bloc.dart';
import 'package:bluetouch/auth/models/auth_user.dart';
import 'package:bluetouch/auth/repository/auth_repository.dart';
import 'package:bluetouch/auth/views/login_page.dart';
import 'package:bluetouch/client/repository/client_repository.dart';
import 'package:bluetouch/client/views/client_list_page.dart';
import 'package:bluetouch/data/auth_firebase_provider.dart';
import 'package:bluetouch/data/client_firestore_repository.dart';
import 'package:bluetouch/drawer.dart';
import 'package:bluetouch/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      theme: ThemeData(useMaterial3: true),
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider<AuthProvider>(
        create: (BuildContext context) => AuthFirebaseProvider(),
        child: BlocProvider(
          create: (context) => AuthBloc(context),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              FirebaseAuth.instance.authStateChanges().listen((user) {
                if (user != null) {
                  context.read<AuthBloc>().add(AuthEventInitial(
                      authStatus: AuthStatus.loggedIn,
                      authUser: AuthUser(user.uid, user.email!)));
                }
              });
              if (state.authStatus != AuthStatus.loggedIn) {
                return const LoginPage();
              } else {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("Bluetouch"),
                    actions: [
                      DropdownButton(
                        items: const [
                          DropdownMenuItem(child: Text("Sabotsy Namehana"))
                        ],
                        onChanged: (_) {},
                      )
                    ],
                  ),
                  drawer: AppDrawer(email: state.authenticatedUser!.email),
                  body: MultiRepositoryProvider(
                    providers: [
                      RepositoryProvider<ClientRepository>(
                          create: (_) => ClientFirestoreRepository(firestore)),
                    ],
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: const ClientListPage(),
                    ),
                  ),
                );
              }
            },
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
