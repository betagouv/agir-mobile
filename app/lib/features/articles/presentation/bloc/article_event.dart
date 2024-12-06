import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class ArticleRecuperationDemandee extends ArticleEvent {
  const ArticleRecuperationDemandee(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

@immutable
final class ArticleAddToFavoritesPressed extends ArticleEvent {
  const ArticleAddToFavoritesPressed();
}

@immutable
final class ArticleRemoveToFavoritesPressed extends ArticleEvent {
  const ArticleRemoveToFavoritesPressed();
}
