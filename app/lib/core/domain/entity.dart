import 'package:equatable/equatable.dart';

abstract class Entity<T extends Object> extends Equatable {
  const Entity({required this.id});

  final T id;

  @override
  List<Object> get props => [id];
}
