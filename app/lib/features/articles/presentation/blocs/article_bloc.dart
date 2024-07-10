import 'dart:async';

import 'package:app/features/articles/domain/ports/articles_port.dart';
import 'package:app/features/articles/presentation/blocs/article_event.dart';
import 'package:app/features/articles/presentation/blocs/article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc({required final ArticlesPort articlesPort})
      : _articlesPort = articlesPort,
        super(const ArticleState.empty()) {
    on<ArticleRecuperationDemandee>(_onRecuperationDemandee);
  }

  final ArticlesPort _articlesPort;

  Future<void> _onRecuperationDemandee(
    final ArticleRecuperationDemandee event,
    final Emitter<ArticleState> emit,
  ) async {
    final result = await _articlesPort.recupererArticle(event.id);
    if (result.isRight()) {
      final article = result.getRight().getOrElse(() => throw Exception());
      emit(ArticleState(article: article));
    }
  }
}
