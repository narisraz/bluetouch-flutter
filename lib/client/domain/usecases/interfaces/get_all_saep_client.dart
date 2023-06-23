import 'package:bluetouch/client/domain/models/client.dart';

abstract class GetAllSaepClient {
  Stream<Iterable<Client>> execute(String saepId);
}
