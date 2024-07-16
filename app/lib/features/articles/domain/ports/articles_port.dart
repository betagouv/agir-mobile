import 'package:app/features/articles/domain/article.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ArticlesPort {
  Future<Either<Exception, Article>> recupererArticle(final String id);
  Future<Either<Exception, void>> marquerCommeLu(final String id);
}
