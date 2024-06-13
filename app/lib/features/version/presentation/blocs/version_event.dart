import 'package:equatable/equatable.dart';

sealed class VersionEvent extends Equatable {
  const VersionEvent();

  @override
  List<Object> get props => [];
}

final class VersionDemandee extends VersionEvent {
  const VersionDemandee();
}
