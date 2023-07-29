import 'package:bluetouch/client/domain/models/client.dart';

abstract class AddClient {
  Future<void> execute(Client client);
}
