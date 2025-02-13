import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/action/presentation/bloc/action_bloc.dart';
import 'package:app/features/action/presentation/bloc/action_event.dart';
import 'package:app/features/action/presentation/bloc/action_state.dart';
import 'package:app/features/services/lvao/presentation/widgets/lvao_horizontal_list.dart';
import 'package:app/features/services/recipes/presentation/widgets/recipe_horizontal_list.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

class ActionPage extends StatelessWidget {
  const ActionPage({super.key, required this.id});

  static const name = 'action';

  static const path = 'action/:titre/:id';
  static Map<String, String> pathParameters({
    required final String title,
    required final String id,
  }) => {'titre': title, 'id': id};

  final String id;

  static GoRoute get route => GoRoute(
    path: path,
    name: name,
    builder:
        (final context, final state) =>
            ActionPage(id: state.pathParameters['id']!),
  );

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create:
        (final context) =>
            ActionBloc(repository: context.read())
              ..add(ActionLoadRequested(id)),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => FnvScaffold(
    appBar: FnvAppBar(),
    body: BlocBuilder<ActionBloc, ActionState>(
      builder:
          (final context, final state) => switch (state) {
            ActionInitial() || ActionLoadInProgress() => const Center(
              child: CircularProgressIndicator(),
            ),
            ActionLoadSuccess() => _Success(state),
            ActionLoadFailure() => const Center(
              child: Text("Erreur lors du chargement de l'action"),
            ),
          },
    ),
  );
}

class _Success extends StatelessWidget {
  const _Success(this.state);

  final ActionLoadSuccess state;

  @override
  Widget build(final BuildContext context) {
    final action = state.action;

    const pagePadding = EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w);

    return ListView(
      children: [
        Padding(
          padding: pagePadding,
          child: MarkdownBody(
            data: action.title,
            styleSheet: MarkdownStyleSheet(
              p: const DsfrTextStyle(fontSize: 28),
            ),
          ),
        ),
        const SizedBox(height: DsfrSpacings.s2w),
        Padding(
          padding: pagePadding,
          child: Text(action.subTitle, style: const DsfrTextStyle.bodyLg()),
        ),
        const SizedBox(height: DsfrSpacings.s4w),
        DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: actionOmbre,
          ),
          child: Column(
            children: [
              const SizedBox(height: DsfrSpacings.s2w),
              Padding(padding: pagePadding, child: _Markdown(data: action.why)),
              if (action.hasLvaoService) ...[
                const SizedBox(height: DsfrSpacings.s4w),
                LvaoHorizontalList(category: action.lvaoService.category),
              ],
              if (action.hasRecipesService) ...[
                const SizedBox(height: DsfrSpacings.s4w),
                RecipeHorizontalList(category: action.recipesService.category),
              ],
              const SizedBox(height: DsfrSpacings.s4w),
              Padding(padding: pagePadding, child: _Markdown(data: action.how)),
              const SizedBox(height: DsfrSpacings.s2w),
            ],
          ),
        ),
      ],
    );
  }
}

class _Markdown extends StatelessWidget {
  const _Markdown({required this.data});

  final String data;

  @override
  Widget build(final BuildContext context) => MarkdownBody(
    data: data,
    styleSheet: MarkdownStyleSheet(
      p: const DsfrTextStyle(fontSize: 16),
      h1: const DsfrTextStyle(fontSize: 22),
    ),
    imageBuilder:
        (final uri, final title, final alt) =>
            FnvImage.network(uri.toString(), semanticLabel: alt),
  );
}
