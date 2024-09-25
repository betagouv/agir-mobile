import 'package:equatable/equatable.dart';

class ActionId extends Equatable {
  const ActionId(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}
