import 'package:bluetouch/auth/config/repository.dart';
import 'package:bluetouch/auth/config/state.dart';
import 'package:bluetouch/auth/domain/models/auth_user.dart';
import 'package:bluetouch/client/presentation/views/client_list_page.dart';
import 'package:bluetouch/navigation/config/state.dart';
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
                ListTile(
                  leading: const Icon(Icons.dashboard),
                  title: const Text("Tableau de bord"),
                  onTap: () => ref
                      .read(navigationStateProvider.notifier)
                      .setCurrentPage(NavigationValue(
                        currentPage: Container(),
                        index: 0,
                      )),
                  selected: ref.watch(navigationStateProvider)?.index == 0,
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Clients"),
                  onTap: () => ref
                      .read(navigationStateProvider.notifier)
                      .setCurrentPage(NavigationValue(
                        currentPage: const ClientListPage(),
                        index: 1,
                      )),
                  selected: ref.watch(navigationStateProvider)?.index == 1,
                ),
                ListTile(
                  leading: const Icon(Icons.numbers),
                  title: const Text("Compteurs"),
                  onTap: () => ref
                      .read(navigationStateProvider.notifier)
                      .setCurrentPage(NavigationValue(
                        currentPage: Container(),
                        index: 2,
                      )),
                  selected: ref.watch(navigationStateProvider)?.index == 2,
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
