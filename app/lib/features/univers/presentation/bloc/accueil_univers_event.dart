import 'package:equatable/equatable.dart';

sealed class AccueilUniversEvent extends Equatable {
  const AccueilUniversEvent();

  @override
  List<Object> get props => [];
}

final class AccueilUniversRecuperationDemandee extends AccueilUniversEvent {
  const AccueilUniversRecuperationDemandee();
}
