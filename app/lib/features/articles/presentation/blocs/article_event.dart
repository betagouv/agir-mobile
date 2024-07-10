import 'package:equatable/equatable.dart';

sealed class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

final class ArticleRecuperationDemandee extends ArticleEvent {
  const ArticleRecuperationDemandee(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}
