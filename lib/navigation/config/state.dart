import 'package:bluetouch/client/presentation/views/client_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state.g.dart';

class NavigationValue {
  final Widget currentPage;
  final int index;

  NavigationValue({
    required this.currentPage,
    required this.index,
  });
}

@riverpod
class NavigationState extends _$NavigationState {
  late NavigationValue value;

  @override
  NavigationValue? build() {
    value = NavigationValue(
      currentPage: const ClientListPage(),
      index: 1,
    );
    return value;
  }

  setCurrentPage(NavigationValue value) {
    state = value;
  }
}
