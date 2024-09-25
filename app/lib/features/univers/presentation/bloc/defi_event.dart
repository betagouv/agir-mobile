import 'package:app/features/univers/core/domain/defi_id.dart';
import 'package:equatable/equatable.dart';

sealed class DefiEvent extends Equatable {
  const DefiEvent();

  @override
  List<Object> get props => [];
}

final class DefiRecuperationDemande extends DefiEvent {
  const DefiRecuperationDemande(this.defiId);

  final DefiId defiId;

  @override
  List<Object> get props => [defiId];
}

final class DefiReleveDemande extends DefiEvent {
  const DefiReleveDemande();
}

final class DefiNeRelevePasDemande extends DefiEvent {
  const DefiNeRelevePasDemande();
}

final class DefiRealiseDemande extends DefiEvent {
  const DefiRealiseDemande();
}

final class DefiAbandonDemande extends DefiEvent {
  const DefiAbandonDemande();
}

final class DefiNeRelevePasMotifChange extends DefiEvent {
  const DefiNeRelevePasMotifChange(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

final class DefiValidationDemande extends DefiEvent {
  const DefiValidationDemande();
}
