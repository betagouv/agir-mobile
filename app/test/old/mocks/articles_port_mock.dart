import 'package:app/features/articles/domain/article.dart';
import 'package:app/features/articles/domain/ports/articles_port.dart';
import 'package:fpdart/src/either.dart';

class ArticlesPortMock implements ArticlesPort {
  ArticlesPortMock(this.article);

  Article article;
  bool estMarquerCommeLuAppele = false;

  @override
  Future<Either<Exception, Article>> recupererArticle(final String id) async =>
      Right(article);

  @override
  Future<Either<Exception, void>> marquerCommeLu(final String id) async {
    estMarquerCommeLuAppele = true;

    return const Right(null);
  }

  @override
  Future<Either<Exception, void>> addToFavorites(final String id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, void>> removeToFavorites(final String id) {
    throw UnimplementedError();
  }
}
