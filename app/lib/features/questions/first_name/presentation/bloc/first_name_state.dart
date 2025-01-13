import 'package:app/features/questions/first_name/domain/first_name.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class FirstNameState extends Equatable {
  const FirstNameState();

  @override
  List<Object> get props => [];
}

@immutable
final class FirstNameInitial extends FirstNameState {
  const FirstNameInitial();
}

@immutable
final class FirstNameEntered extends FirstNameState {
  const FirstNameEntered(this.firstName);

  final FirstName firstName;

  @override
  List<Object> get props => [firstName];
}

@immutable
final class FirstNameLoading extends FirstNameState {
  const FirstNameLoading();
}

@immutable
final class FirstNameSuccess extends FirstNameState {
  const FirstNameSuccess(this.dateTime);

  final DateTime dateTime;

  @override
  List<Object> get props => [dateTime];
}

@immutable
final class FirstNameFailure extends FirstNameState {
  const FirstNameFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
