class Branchement {
  final String clientId;
  final String date;
  final double index;
  final DateTime insertDate;

  Branchement(
      {required this.clientId,
      required this.date,
      required this.insertDate,
      this.index = 0});

  static Branchement fromJson(Map<String, dynamic> json) {
    return Branchement(
        clientId: json['clientId'],
        date: json['date'],
        insertDate:
            DateTime.tryParse('${json['insertDate']}') ?? DateTime.now(),
        index: double.tryParse('${json['index']}') ?? 0);
  }
}
