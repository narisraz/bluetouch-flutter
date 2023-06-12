class BranchementEvent {
  const BranchementEvent();
}

class BranchementEventGetOne extends BranchementEvent {
  final String clientId;

  BranchementEventGetOne({required this.clientId});
}
class BranchementEventAdd extends BranchementEvent {
  final String clientId;
  final DateTime date;
  final double startIndex;

  BranchementEventAdd(this.clientId, this.date, this.startIndex);
}