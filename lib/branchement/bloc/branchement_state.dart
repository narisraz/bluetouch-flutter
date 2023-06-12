import 'package:bluetouch/client/models/branchement.dart';
import 'package:equatable/equatable.dart';

enum BranchementStatus {initial, success, failure}

class BranchementState extends Equatable {

  final BranchementStatus branchementStatus;
  final Branchement? branchement;

  const BranchementState({
    this.branchement,
    this.branchementStatus = BranchementStatus.initial
  });

  @override
  List<Object?> get props => [];
}