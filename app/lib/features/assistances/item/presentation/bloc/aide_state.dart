import 'package:app/features/assistances/core/domain/aide.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class AideState extends Equatable {
  const AideState(this.aide);

  final Assistance aide;

  @override
  List<Object> get props => [aide];
}
