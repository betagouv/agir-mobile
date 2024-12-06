import 'package:app/features/assistances/core/domain/aide.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class AidesAccueilState extends Equatable {
  const AidesAccueilState(this.aides);

  final List<Assistance> aides;

  @override
  List<Object> get props => [aides];
}
