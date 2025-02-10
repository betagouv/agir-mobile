import 'package:app/features/aids/core/domain/aid.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class AidsHomeState extends Equatable {
  const AidsHomeState(this.aids);

  final List<Aid> aids;

  @override
  List<Object> get props => [aids];
}
