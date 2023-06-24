import 'package:bluetouch/auth/config/repository.dart';
import 'package:bluetouch/auth/config/state.dart';
import 'package:bluetouch/auth/domain/models/auth_user.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppDrawer extends ConsumerWidget {
  final AuthUser? authUser;

  const AppDrawer({super.key, this.authUser});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.watch(authStateProvider);

    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Center(
                      child:
                          Text(authUser?.firstName ?? authUser?.name ?? "Nom")),
                ),
                const ListTile(
                  leading: Icon(Icons.dashboard),
                  title: Text("Tableau de bord"),
                ),
                const ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Compagnies"),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Se déconnecter"),
            onTap: () {
              ref.read(authRepositoryProvider).logout();
            },
          ),
        ],
      ),
    );
  }
}
