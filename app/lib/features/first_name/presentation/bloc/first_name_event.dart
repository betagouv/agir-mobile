import 'package:app/features/first_name/domain/first_name.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class FirstNameEvent extends Equatable {
  const FirstNameEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class FirstNameChanged extends FirstNameEvent {
  const FirstNameChanged(this.value);

  final FirstName value;

  @override
  List<Object> get props => [value];
}

@immutable
final class FirstNameSubmitted extends FirstNameEvent {
  const FirstNameSubmitted();
}
