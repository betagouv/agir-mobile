import 'package:app/features/articles/domain/article.dart';
import 'package:equatable/equatable.dart';

final class ArticleState extends Equatable {
  const ArticleState({required this.article});

  const ArticleState.empty()
      : this(
          article: const Article(
            titre: '',
            sousTitre: null,
            contenu: '',
            partenaire: null,
          ),
        );

  final Article article;

  @override
  List<Object> get props => [article];
}
