import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class MissionHomeState extends Equatable {
  const MissionHomeState();

  @override
  List<Object> get props => [];
}

@immutable
final class MissionHomeInitial extends MissionHomeState {
  const MissionHomeInitial();
}

@immutable
final class MissionHomeLoadSuccess extends MissionHomeState {
  const MissionHomeLoadSuccess(this.missions);

  final List<MissionListe> missions;

  @override
  List<Object> get props => [missions];
}
