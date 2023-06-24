import 'package:bluetouch/auth/domain/models/auth_user.dart';
import 'package:bluetouch/core/domain/models/saep.dart';

abstract class GetAllSaepByUser {
  Stream<Iterable<Saep>> execute(AuthUser authUser);
}
