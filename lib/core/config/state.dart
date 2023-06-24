import 'package:bluetouch/core/domain/models/saep.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state.g.dart';

class Value {
  final Saep? currentSaep;

  Value({this.currentSaep});
}

@riverpod
class CoreState extends _$CoreState {
  @override
  Value build() => Value();

  setCurrentSaep(Saep saep) {
    state = Value(
      currentSaep: saep,
    );
  }
}
