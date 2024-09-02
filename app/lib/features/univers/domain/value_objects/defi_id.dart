import 'package:equatable/equatable.dart';

class DefiId extends Equatable {
  const DefiId(this.value);
  final String value;

  @override
  List<Object?> get props => [value];
}
