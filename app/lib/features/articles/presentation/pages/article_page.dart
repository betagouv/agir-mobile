import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/features/articles/presentation/pages/article_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key, required this.id});

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
  Widget build(final context) => FnvScaffold(
        appBar: FnvAppBar(),
        body: ArticleView(id: id),
      );
}
