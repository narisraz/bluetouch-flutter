import 'dart:async';

import 'package:bluetouch/branchement/bloc/branchement_event.dart';
import 'package:bluetouch/branchement/bloc/branchement_state.dart';
import 'package:bluetouch/branchement/repository/branchement_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BranchementBloc extends Bloc<BranchementEvent, BranchementState> {
  final BuildContext context;
  late final BranchementRepository branchementRepository;

  BranchementBloc(this.context): super(const BranchementState()) {
    branchementRepository = RepositoryProvider.of<BranchementRepository>(context);
    on<BranchementEventGetOne>(_onGetOneBranchement);
    on<BranchementEventAdd>(_onAddBranchement);
  }

  FutureOr<void> _onGetOneBranchement(BranchementEventGetOne event, Emitter<BranchementState> emit) async {
    try {
      var branchement = await branchementRepository.getByClientId(event.clientId);
      emit(BranchementState(
        branchementStatus: BranchementStatus.success,
        branchement: branchement
      ));
    } catch (e) {
      emit(const BranchementState(
        branchementStatus: BranchementStatus.failure
      ));
    }
  }

  FutureOr<void> _onAddBranchement(BranchementEventAdd event, Emitter<BranchementState> emit) async {
    try {
      await branchementRepository.add(event.clientId, event.date, event.startIndex);
    } catch (e) {
      emit(const BranchementState(
          branchementStatus: BranchementStatus.failure
      ));
    }
  }
}