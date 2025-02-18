import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class RecipesEvent extends Equatable {
  const RecipesEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class RecipesLoadRequested extends RecipesEvent {
  const RecipesLoadRequested();
}

@immutable
final class RecipesFilterSelected extends RecipesEvent {
  const RecipesFilterSelected(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}
