import 'package:bluetouch/client/models/client.dart';

abstract class ClientRepository {
  Future<List<Client>> getAll();
}