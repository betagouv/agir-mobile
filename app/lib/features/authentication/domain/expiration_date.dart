import 'package:equatable/equatable.dart';

class ExpirationDate extends Equatable {
  const ExpirationDate(this.value);

  final DateTime value;

  @override
  List<Object> get props => [value];
}
