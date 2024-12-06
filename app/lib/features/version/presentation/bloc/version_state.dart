import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class VersionState extends Equatable {
  const VersionState(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}
