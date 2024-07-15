import 'package:app/features/articles/presentation/blocs/article_bloc.dart';
import 'package:app/features/articles/presentation/blocs/article_event.dart';
import 'package:app/features/articles/presentation/pages/article_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({required this.id, super.key});

  static const name = 'article';
  static const path = '$name/:id';

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => ArticlePage(
          id: state.pathParameters['id']!,
        ),
      );

  final String id;

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => ArticleBloc(articlesPort: context.read())
          ..add(ArticleRecuperationDemandee(id)),
        child: const ArticleView(),
      );
}
