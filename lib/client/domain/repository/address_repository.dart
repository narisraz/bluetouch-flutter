import 'package:bluetouch/client/domain/models/address.dart';

abstract class AddressRepository {
  Future<String> addAddress(Address address);

  Stream<Address?> getById(String id);
}
