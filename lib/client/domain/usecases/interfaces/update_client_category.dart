import 'package:bluetouch/client/domain/models/client_category.dart';

abstract class UpdateClientCategory {
  Future<void> execute(String clientId, ClientCategory clientCategory);
}
