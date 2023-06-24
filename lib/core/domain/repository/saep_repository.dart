import 'package:bluetouch/core/domain/models/saep.dart';

abstract class SaepRepository {
  Stream<Iterable<Saep>> getSaepFromListOfId(List<String> ids);
}
