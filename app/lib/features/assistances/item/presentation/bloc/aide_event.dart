import 'package:app/features/assistances/core/domain/aide.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class AideEvent extends Equatable {
  const AideEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class AideSelectionnee extends AideEvent {
  const AideSelectionnee(this.value);

  final Assistance value;
  @override
  List<Object> get props => [value];
}
