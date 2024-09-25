import 'package:app/features/first_name/domain/first_name.dart';
import 'package:equatable/equatable.dart';

sealed class FirstNameEvent extends Equatable {
  const FirstNameEvent();

  @override
  List<Object> get props => [];
}

final class FirstNameChanged extends FirstNameEvent {
  const FirstNameChanged(this.value);

  final FirstName value;

  @override
  List<Object> get props => [value];
}

final class FirstNameUpdatePressed extends FirstNameEvent {
  const FirstNameUpdatePressed();
}
