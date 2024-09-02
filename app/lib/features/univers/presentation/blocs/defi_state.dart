import 'package:app/features/univers/domain/entities/defi.dart';
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
    required this.veutRelever,
    required this.motif,
    required this.estMiseAJour,
  });

  final Defi defi;
  final Option<bool> veutRelever;
  final String? motif;
  final bool estMiseAJour;

  @override
  List<Object?> get props => [defi, veutRelever, motif, estMiseAJour];
}

final class DefiError extends DefiState {
  const DefiError();
}
