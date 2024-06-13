import 'package:equatable/equatable.dart';

sealed class ProfilEvent extends Equatable {
  const ProfilEvent();

  @override
  List<Object> get props => [];
}

final class ProfilRecuperationDemandee extends ProfilEvent {
  // TODO(lsaudon): à faire.
  // ignore: unused-code
  const ProfilRecuperationDemandee();
}
