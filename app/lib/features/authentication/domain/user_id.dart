import 'package:equatable/equatable.dart';

class UserId extends Equatable {
  const UserId(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}
