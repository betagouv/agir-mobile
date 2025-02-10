import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class AidsHomeEvent extends Equatable {
  const AidsHomeEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class AidsHomeLoadRequested extends AidsHomeEvent {
  const AidsHomeLoadRequested();
}
