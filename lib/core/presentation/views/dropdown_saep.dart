import 'package:bluetouch/auth/config/state.dart';
import 'package:bluetouch/core/config/state.dart';
import 'package:bluetouch/core/config/use_case.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DropdownSaep extends ConsumerWidget {
  const DropdownSaep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.watch(authStateProvider);
    if (authUser != null) {
      final saepAsyncValue = ref.watch(getAllSaepByUserProvider(authUser));

      return saepAsyncValue.when(
        data: (data) {
          final coreState = ref.watch(coreStateProvider);
          Future(() {
            if (coreState.currentSaep == null) {
              return ref
                  .read(coreStateProvider.notifier)
                  .setCurrentSaep(data.first);
            }
          });
          return Row(
            children: [
              const Text("SAEP : "),
              DropdownButton(
                value: coreState.currentSaep?.id,
                items: data.map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                  );
                }).toList(),
                onChanged: (value) {
                  final saep =
                      data.singleWhere((element) => element.id == value);

                  ref.read(coreStateProvider.notifier).setCurrentSaep(saep);
                },
              ),
            ],
          );
        },
        error: (_, error) =>
            const Text("Erreur lors de la récupération des saep"),
        loading: () => const CircularProgressIndicator(),
      );
    }
    return const Center();
  }
}
