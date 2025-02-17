import 'package:app/features/articles/domain/article.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class ArticleState extends Equatable {
  const ArticleState({required this.article});

  const ArticleState.empty()
    : this(
        article: const Article(
          id: '',
          titre: '',
          sousTitre: null,
          contenu: '',
          partner: null,
          sources: [],
          isFavorite: false,
          isRead: false,
        ),
      );

  final Article article;

  ArticleState copyWith({final Article? article}) => ArticleState(article: article ?? this.article);

  @override
  List<Object> get props => [article];
}
