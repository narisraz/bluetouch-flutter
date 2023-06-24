import 'dart:ui';

import 'package:bluetouch/auth/config/state.dart';
import 'package:bluetouch/auth/presentation/views/login_page.dart';
import 'package:bluetouch/client/presentation/views/client_list_page.dart';
import 'package:bluetouch/core/presentation/views/dropdown_saep.dart';
import 'package:bluetouch/drawer.dart';
import 'package:bluetouch/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedIn = useState(false);
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        loggedIn.value = true;
        ref.read(authStateProvider.notifier).setLoggedIn();
      } else {
        loggedIn.value = false;
      }
    });

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
      ],
      title: 'Bluetouch',
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Builder(builder: (context) {
        if (!loggedIn.value) {
          return const Scaffold(body: LoginPage());
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Bluetouch"),
            actions: const [
              DropdownSaep(),
              SizedBox(
                width: 16,
              )
            ],
          ),
          drawer: const AppDrawer(),
          body: Container(
            padding: const EdgeInsets.all(16.0),
            child: const ClientListPage(),
          ),
        );
      }),
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
