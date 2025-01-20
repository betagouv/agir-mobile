import 'package:equatable/equatable.dart';

class Token extends Equatable {
  const Token(this.value);

  final String value;

  String get payload => value.split('.')[1];

  @override
  List<Object> get props => [value];
}
