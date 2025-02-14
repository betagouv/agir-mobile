import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class RecipeLoadRequested extends RecipeEvent {
  const RecipeLoadRequested({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}
