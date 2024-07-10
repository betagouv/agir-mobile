import 'package:app/features/articles/domain/article.dart';
import 'package:app/features/articles/domain/ports/articles_port.dart';
import 'package:fpdart/src/either.dart';

class ArticlesPortMock implements ArticlesPort {
  ArticlesPortMock(this.article);

  Article article;

  @override
  Future<Either<Exception, Article>> recupererArticle(final String id) async =>
      Right(article);
}
