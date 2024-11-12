import 'package:app/features/first_name/domain/first_name.dart';
import 'package:equatable/equatable.dart';

sealed class FirstNameState extends Equatable {
  const FirstNameState();

  @override
  List<Object> get props => [];
}

final class FirstNameInitial extends FirstNameState {
  const FirstNameInitial();
}

final class FirstNameEntered extends FirstNameState {
  const FirstNameEntered(this.firstName);

  final FirstName firstName;

  @override
  List<Object> get props => [firstName];
}

final class FirstNameLoading extends FirstNameState {
  const FirstNameLoading();
}

final class FirstNameSuccess extends FirstNameState {
  const FirstNameSuccess(this.dateTime);

  final DateTime dateTime;

  @override
  List<Object> get props => [dateTime];
}

final class FirstNameFailure extends FirstNameState {
  const FirstNameFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
