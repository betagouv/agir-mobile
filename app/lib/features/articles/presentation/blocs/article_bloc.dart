import 'dart:async';

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
  })  : _articlesPort = articlesPort,
        _gamificationPort = gamificationPort,
        super(const ArticleState.empty()) {
    on<ArticleRecuperationDemandee>(_onRecuperationDemandee);
  }

  final ArticlesPort _articlesPort;
  final GamificationPort _gamificationPort;

  Future<void> _onRecuperationDemandee(
    final ArticleRecuperationDemandee event,
    final Emitter<ArticleState> emit,
  ) async {
    final result = await _articlesPort.recupererArticle(event.id);
    if (result.isRight()) {
      final article = result.getRight().getOrElse(() => throw Exception());
      emit(ArticleState(article: article));
      await _articlesPort.marquerCommeLu(event.id);
      await _gamificationPort.mettreAJourLesPoints();
    }
  }
}
