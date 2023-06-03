import 'package:bluetouch/client/views/client_list.dart';
import 'package:bluetouch/drawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Bluetouch"),
          actions: [
            DropdownButton(
              items: const [DropdownMenuItem(child: Text("Sabotsy Namehana"))],
              onChanged: (_) {},
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
        drawer: const AppDrawer(),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: const ClientList(),
        ),
      ),
    );
  }
}
