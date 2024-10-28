import 'package:app/features/theme/core/domain/content_id.dart';
import 'package:equatable/equatable.dart';

sealed class MissionEvent extends Equatable {
  const MissionEvent();

  @override
  List<Object> get props => [];
}

final class MissionRecuperationDemandee extends MissionEvent {
  const MissionRecuperationDemandee();

  @override
  List<Object> get props => [];
}

final class MissionGagnerPointsDemande extends MissionEvent {
  const MissionGagnerPointsDemande(this.id);

  final ObjectifId id;

  @override
  List<Object> get props => [id];
}

final class MissionTerminerDemande extends MissionEvent {
  const MissionTerminerDemande();

  @override
  List<Object> get props => [];
}
