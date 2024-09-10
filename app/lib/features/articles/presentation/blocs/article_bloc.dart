import 'package:app/features/articles/domain/ports/articles_port.dart';
import 'package:app/features/articles/presentation/blocs/article_event.dart';
import 'package:app/features/articles/presentation/blocs/article_state.dart';
import 'package:app/features/gamification/domain/ports/gamification_port.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc({
    required final ArticlesPort articlesPort,
    required final GamificationPort gamificationPort,
  }) : super(const ArticleState.empty()) {
    on<ArticleRecuperationDemandee>((final event, final emit) async {
      final result = await articlesPort.recupererArticle(event.id);
      if (result.isRight()) {
        final article = result.getRight().getOrElse(() => throw Exception());
        emit(ArticleState(article: article));
        await articlesPort.marquerCommeLu(event.id);
        await gamificationPort.mettreAJourLesPoints();
      }
    });
  }
}
