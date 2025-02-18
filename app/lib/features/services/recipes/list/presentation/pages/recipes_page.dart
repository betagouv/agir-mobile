import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/dropdown_button.dart';
import 'package:app/core/presentation/widgets/composants/partner_card.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/features/services/recipes/core/presentation/widgets/recipe_card.dart';
import 'package:app/features/services/recipes/list/presentation/bloc/recipes_bloc.dart';
import 'package:app/features/services/recipes/list/presentation/bloc/recipes_event.dart';
import 'package:app/features/services/recipes/list/presentation/bloc/recipes_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  static const name = 'recettes';
  static const path = name;

  static GoRoute get route => GoRoute(path: path, name: name, builder: (final context, final state) => const RecipesPage());

  @override
  Widget build(final context) => BlocProvider(
    create: (final context) => RecipesBloc(repository: context.read())..add(const RecipesLoadRequested()),
    child: FnvScaffold(appBar: FnvAppBar(), body: const _Body()),
  );
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(final BuildContext context) => BlocBuilder<RecipesBloc, RecipesState>(
    builder:
        (final context, final state) => switch (state) {
          RecipesInitial() || RecipesLoadInProgress() || RecipesLoadFailure() => const SizedBox(),
          RecipesLoadSuccess() => _Success(value: state),
        },
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.value});

  final RecipesLoadSuccess value;

  @override
  Widget build(final BuildContext context) {
    final items = [
      _Header(value: value),
      ...value.recipes.map(
        (final e) => RecipeCard(
          id: e.id,
          imageUrl: e.imageUrl,
          title: e.title,
          difficulty: e.difficulty,
          preparationTime: e.preparationTime,
        ),
      ),
      const PartnerCard(
        image: AssetImages.mangerBouger,
        name: Localisation.mangerBougerNom,
        description: Localisation.mangerBougerDescription,
        url: Localisation.mangerBougerUrl,
        logo: AssetImages.mangerBougerLogo,
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s3w, horizontal: DsfrSpacings.s2w),
      itemBuilder: (final context, final index) => items[index],
      separatorBuilder: (final context, final index) => const SizedBox(height: DsfrSpacings.s4w),
      itemCount: items.length,
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.value});

  final RecipesLoadSuccess value;

  @override
  Widget build(final BuildContext context) => Text.rich(
    TextSpan(
      style: const DsfrTextStyle(fontSize: 28, fontWeight: FontWeight.w500),
      children: [
        const TextSpan(text: '${Localisation.recettes} '),
        WidgetSpan(
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          child: FnvDropdown(
            items: Map.fromEntries(value.filters.map((final e) => MapEntry(e.code, e.label))),
            value: value.filterSelected,
            onChanged: (final value) => context.read<RecipesBloc>().add(RecipesFilterSelected(value)),
          ),
        ),
      ],
    ),
  );
}
