import 'package:equatable/equatable.dart';

abstract class ValueObject<T extends Object> extends Equatable {
  const ValueObject(this.value);

  final T value;

  @override
  List<Object?> get props => [value];
}
