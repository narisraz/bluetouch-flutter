import 'package:bluetouch/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatelessWidget {
  final String email;

  const AppDrawer({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Center(child: Text(email)),
                ),
                const ListTile(
                  leading: Icon(Icons.dashboard),
                  title: Text("Tableau de bord"),
                ),
                const ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Clients"),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Se déconnecter"),
            onTap: () {
              context.read<AuthBloc>().add(AuthEventLogout());
            },
          ),
        ],
      ),
    );
  }
}
