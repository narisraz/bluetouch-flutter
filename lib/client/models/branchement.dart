

class Branchement {
  final String clientId;
  final DateTime date;
  final double index;

  Branchement({required this.clientId, required this.date, this.index = 0});

  static Branchement fromJson(Map<String, dynamic> json) {
    return Branchement(
      clientId: json['clientId'],
      date: DateTime.fromMillisecondsSinceEpoch(int.tryParse('${json['date']}') ?? 0),
      index: double.tryParse('${json['index']}') ?? 0
    );
  }
}