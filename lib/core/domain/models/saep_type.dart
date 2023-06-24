enum SaepType { byPumping, gravity, hybrid }

class SaepTypeData {
  final String label;

  SaepTypeData(this.label);
}

extension SaepTypeExtension on SaepType {
  SaepTypeData get data {
    switch (this) {
      case SaepType.byPumping:
        return SaepTypeData("Par pompage");
      case SaepType.gravity:
        return SaepTypeData("Gravitaire");
      case SaepType.hybrid:
        return SaepTypeData("Hybride");
    }
  }
}
