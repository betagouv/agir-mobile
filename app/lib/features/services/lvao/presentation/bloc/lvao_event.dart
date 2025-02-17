import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class LvaoEvent extends Equatable {
  const LvaoEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class LvaoLoadRequested extends LvaoEvent {
  const LvaoLoadRequested(this.category);

  final String category;

  @override
  List<Object> get props => [category];
}
