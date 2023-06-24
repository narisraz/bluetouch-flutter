import 'package:bluetouch/core/domain/models/saep_type.dart';
import 'package:bluetouch/core/domain/models/water_resource.dart';

class Saep {
  final String? id;
  final String name;
  final int? populationSize;
  final double? reservoirSize;
  final WaterResource waterResource;
  final SaepType saepType;
  final String companyId;

  Saep(
      {this.id,
      this.populationSize,
      this.reservoirSize,
      required this.companyId,
      required this.name,
      required this.waterResource,
      required this.saepType});

  static fromJson(Map<String, dynamic> data) {
    return Saep(
        id: data["id"],
        reservoirSize: double.tryParse('${data['reservoirSize']}'),
        populationSize: int.tryParse('${data['populationSize']}'),
        companyId: data['companyId'],
        name: data["name"],
        waterResource: WaterResource.values.byName(data['waterResource']),
        saepType: SaepType.values.byName(data['saepType']));
  }
}
