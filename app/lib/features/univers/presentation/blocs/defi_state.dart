import 'package:app/features/univers/domain/entities/defi.dart';
import 'package:app/features/univers/domain/entities/mission_defi.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

sealed class DefiState extends Equatable {
  const DefiState();

  @override
  List<Object?> get props => [];
}

final class DefiInitial extends DefiState {
  const DefiInitial();
}

final class DefiChargement extends DefiState {
  const DefiChargement();
}

final class DefiSucces extends DefiState {
  const DefiSucces({
    required this.defi,
    required this.status,
    required this.motif,
    required this.estMiseAJour,
  });

  final Defi defi;
  final Option<MissionDefiStatus> status;
  final String? motif;
  final bool estMiseAJour;

  @override
  List<Object?> get props => [defi, status, motif, estMiseAJour];
}

final class DefiError extends DefiState {
  const DefiError();
}
