enum WaterResource { surfaceWater, source, drilling }

class WaterResourceData {
  final String label;

  WaterResourceData(this.label);
}

extension SaepTypeExtension on WaterResource {
  WaterResourceData get data {
    switch (this) {
      case WaterResource.surfaceWater:
        return WaterResourceData("Eau de surface");
      case WaterResource.source:
        return WaterResourceData("Source");
      case WaterResource.drilling:
        return WaterResourceData("Forage");
    }
  }
}
