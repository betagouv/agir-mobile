import 'package:app/features/aides/domain/entities/aide.dart';
import 'package:equatable/equatable.dart';

sealed class AideEvent extends Equatable {
  const AideEvent();

  @override
  List<Object> get props => [];
}

final class AideSelectionnee extends AideEvent {
  const AideSelectionnee(this.value);

  final Aide value;
  @override
  List<Object> get props => [value];
}
