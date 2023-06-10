import 'package:bluetouch/client/models/client.dart';
import 'package:bluetouch/client/models/client_category.dart';
import 'package:bluetouch/client/models/client_state.dart';

final clientStub = Client(1, "Raz", "Naris", "SN01", ClientCategory.borneFontaine)
  ..state = ClientState.suspended
  ..id = "001";

final clientsStub = [clientStub];