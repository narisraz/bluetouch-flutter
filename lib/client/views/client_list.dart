import 'package:flutter/material.dart';

class ClientList extends StatelessWidget {
  const ClientList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text("Nouveau")),
      const SizedBox(
        height: 16,
      ),
      DataTable(
          headingRowColor:
              MaterialStateProperty.all(Theme.of(context).primaryColor),
          columns: const [
            DataColumn(
                label: Text(
              "Numéro de contrat",
              style: TextStyle(color: Colors.white),
            )),
            DataColumn(
                label: Text(
              "Nom",
              style: TextStyle(color: Colors.white),
            )),
            DataColumn(
                label: Text(
              "Prénom",
              style: TextStyle(color: Colors.white),
            ))
          ],
          rows: [])
    ]);
  }
}
