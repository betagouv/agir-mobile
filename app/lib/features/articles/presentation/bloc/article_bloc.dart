import 'package:app/features/articles/infrastructure/articles_repository.dart';
import 'package:app/features/articles/presentation/bloc/article_event.dart';
import 'package:app/features/articles/presentation/bloc/article_state.dart';
import 'package:app/features/gamification/infrastructure/gamification_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc({
    required final ArticlesRepository articlesRepository,
    required final GamificationRepository gamificationRepository,
  }) : super(const ArticleState.empty()) {
    on<ArticleRecuperationDemandee>((final event, final emit) async {
      final result = await articlesRepository.recupererArticle(event.id);
      await result.fold((final l) {}, (final r) async {
        emit(ArticleState(article: r));
        await gamificationRepository.refresh();
      });
    });
    on<ArticleAddToFavoritesPressed>((final event, final emit) async {
      await articlesRepository.addToFavorites(state.article.id);
      final article = state.article.copyWith(isFavorite: true);
      emit(state.copyWith(article: article));
    });

    on<ArticleRemoveToFavoritesPressed>((final event, final emit) async {
      await articlesRepository.removeToFavorites(state.article.id);
      final article = state.article.copyWith(isFavorite: false);
      emit(state.copyWith(article: article));
    });
  }
}
