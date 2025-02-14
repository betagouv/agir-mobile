import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/services/recipes/core/presentation/widgets/estimaded_timed_info.dart';
import 'package:app/features/services/recipes/core/presentation/widgets/recipe_difficulty.dart';
import 'package:app/features/services/recipes/item/presentation/bloc/recipe_bloc.dart';
import 'package:app/features/services/recipes/item/presentation/bloc/recipe_event.dart';
import 'package:app/features/services/recipes/item/presentation/bloc/recipe_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key, required this.id});

  static const name = 'recette';
  static const path = 'recettes/:id';

  static GoRoute get route =>
      GoRoute(path: path, name: name, builder: (final context, final state) => RecipePage(id: state.pathParameters['id']!));

  final String id;

  @override
  Widget build(final context) => BlocProvider(
    create: (final context) => RecipeBloc(repository: context.read())..add(RecipeLoadRequested(id: id)),
    child: FnvScaffold(appBar: FnvAppBar(), body: const _Body()),
  );
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(final BuildContext context) => BlocBuilder<RecipeBloc, RecipeState>(
    builder:
        (final context, final state) => switch (state) {
          RecipeInitial() || RecipeLoadInProgress() => const Center(child: CircularProgressIndicator()),
          RecipeLoadSuccess() => _Success(state),
          RecipeLoadFailure() => const Center(child: Text('Erreur lors du chargement de la recette')),
        },
  );
}

class _Success extends StatelessWidget {
  const _Success(this.state);

  final RecipeLoadSuccess state;

  @override
  Widget build(final BuildContext context) {
    final recipe = state.recipe;

    return ListView(
      children: [
        FnvImage.network(recipe.imageUrl, height: 94, fit: BoxFit.cover),
        Padding(
          padding: const EdgeInsets.all(paddingVerticalPage),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(alignment: Alignment.centerLeft, child: RecipeDifficulty(value: recipe.difficulty)),
              const SizedBox(height: DsfrSpacings.s1v),
              Text(recipe.title, style: const DsfrTextStyle.headline2()),
              const SizedBox(height: DsfrSpacings.s1v),
              EstimadedTimedInfo(text: Localisation.tempsDePreparation(recipe.preparationTime)),
              const SizedBox(height: DsfrSpacings.s2w),
              const Text(Localisation.ingredients, style: DsfrTextStyle.headline4()),
              const SizedBox(height: DsfrSpacings.s2w),
              ...recipe.ingredients
                  .map((final e) => Text('• ${e.quantity} ${e.unit} ${e.name}', style: const DsfrTextStyle.bodyMd()))
                  .separator(const SizedBox(height: DsfrSpacings.s1w)),
              const SizedBox(height: DsfrSpacings.s2w),
              const Text(Localisation.etapes, style: DsfrTextStyle.headline4()),
              const SizedBox(height: DsfrSpacings.s2w),
              ...recipe.steps
                  .map(
                    (final e) => Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: '${e.order}. ', style: const DsfrTextStyle.bodyMdBold()),
                          TextSpan(text: e.description),
                        ],
                      ),
                      style: const DsfrTextStyle.bodyMd(),
                    ),
                  )
                  .separator(const SizedBox(height: DsfrSpacings.s1w)),
            ],
          ),
        ),
      ],
    );
  }
}
