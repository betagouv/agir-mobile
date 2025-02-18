import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class ActionRecipesEvent extends Equatable {
  const ActionRecipesEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class ActionRecipesLoadRequested extends ActionRecipesEvent {
  const ActionRecipesLoadRequested(this.category);

  final String category;

  @override
  List<Object> get props => [category];
}
