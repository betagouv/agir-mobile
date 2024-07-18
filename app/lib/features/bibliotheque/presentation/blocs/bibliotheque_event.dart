import 'package:equatable/equatable.dart';

sealed class BibliothequeEvent extends Equatable {
  const BibliothequeEvent();

  @override
  List<Object> get props => [];
}

final class BibliothequeRecuperationDemandee extends BibliothequeEvent {
  const BibliothequeRecuperationDemandee();
}
