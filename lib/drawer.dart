import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          DrawerHeader(
            child: Center(child: Text("mail@gmail.com")),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text("Tableau de bord"),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Clients"),
          ),
        ],
      ),
    );
  }
}
