import 'package:bluetouch/client/models/client.dart';
import 'package:bluetouch/client/repository/client_repository.dart';

import 'client_stubs.dart';

class FakeClientRepository extends ClientRepository {
  @override
  Future<List<Client>> getAll() {
    return Future.value(clientsStub);
  }
}

class NoClientRepository extends ClientRepository {
  @override
  Future<List<Client>> getAll() {
    return Future.value([]);
  }
}

class FailedClientRepository extends ClientRepository {
  @override
  Future<List<Client>> getAll() {
    throw UnimplementedError();
  }
}