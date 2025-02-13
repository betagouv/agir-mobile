import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class RecipesEvent extends Equatable {
  const RecipesEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class RecipesLoadRequested extends RecipesEvent {
  const RecipesLoadRequested(this.category);

  final String category;

  @override
  List<Object> get props => [category];
}
