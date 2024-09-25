import 'package:app/features/articles/domain/articles_port.dart';
import 'package:app/features/articles/presentation/bloc/article_event.dart';
import 'package:app/features/articles/presentation/bloc/article_state.dart';
import 'package:app/features/gamification/domain/gamification_port.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc({
    required final ArticlesPort articlesPort,
    required final GamificationPort gamificationPort,
  }) : super(const ArticleState.empty()) {
    on<ArticleRecuperationDemandee>((final event, final emit) async {
      final result = await articlesPort.recupererArticle(event.id);
      await result.fold((final l) {}, (final r) async {
        emit(ArticleState(article: r));
        await articlesPort.marquerCommeLu(event.id);
        await gamificationPort.mettreAJourLesPoints();
      });
    });
    on<ArticleAddToFavoritesPressed>((final event, final emit) async {
      await articlesPort.addToFavorites(state.article.id);
      final article = state.article.copyWith(isFavorite: true);
      emit(state.copyWith(article: article));
    });

    on<ArticleRemoveToFavoritesPressed>((final event, final emit) async {
      await articlesPort.removeToFavorites(state.article.id);
      final article = state.article.copyWith(isFavorite: false);
      emit(state.copyWith(article: article));
    });
  }
}
