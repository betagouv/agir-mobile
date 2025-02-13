import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/services/recipes/presentation/bloc/recipes_bloc.dart';
import 'package:app/features/services/recipes/presentation/bloc/recipes_event.dart';
import 'package:app/features/services/recipes/presentation/bloc/recipes_state.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class RecipeHorizontalList extends StatelessWidget {
  const RecipeHorizontalList({super.key, required this.category});

  final String category;

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => RecipesBloc(repository: context.read())..add(RecipesLoadRequested(category)),
    child: const _Part(),
  );
}

class _Part extends StatelessWidget {
  const _Part();

  @override
  Widget build(final BuildContext context) => BlocBuilder<RecipesBloc, RecipesState>(
    builder:
        (final context, final state) => switch (state) {
          RecipesInitial() || RecipesLoadInProgress() || RecipesLoadFailure() => const SizedBox(),
          RecipesLoadSuccess() => _Success(state: state),
        },
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.state});

  final RecipesLoadSuccess state;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s1w,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
        child: MarkdownBody(
          data: "Besoin **d'inspiration** ?",
          styleSheet: MarkdownStyleSheet(p: const DsfrTextStyle(fontSize: 22)),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
        clipBehavior: Clip.none,
        child: IntrinsicHeight(
          child: Row(
            spacing: DsfrSpacings.s2w,
            children:
                state.recipes
                    .map(
                      (final e) => FnvCard(
                        child: SizedBox(
                          width: 173,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: DsfrSpacings.s1w,
                              top: DsfrSpacings.s1w,
                              right: DsfrSpacings.s1w,
                              bottom: DsfrSpacings.s2w,
                            ),
                            child: Column(
                              children: [
                                DecoratedBox(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1w)),
                                  ),
                                  child: FnvImage.network(e.imageUrl),
                                ),
                                Expanded(child: Text(e.title, style: const DsfrTextStyle.bodyMdBold(), maxLines: 3)),
                                const SizedBox(height: DsfrSpacings.s1w),
                                Row(
                                  spacing: DsfrSpacings.s1v,
                                  children: [
                                    Flexible(
                                      child: DsfrTag.sm(
                                        label: TextSpan(text: e.difficulty),
                                        backgroundColor: const Color(0xffEAEAEA),
                                        foregroundColor: const Color(0xff3F3F3F),
                                        textStyle: const DsfrTextStyle.bodyXsMedium(),
                                      ),
                                    ),
                                    _EstimadedTimedInfo(text: '${e.preparationTime} min'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
      ),
    ],
  );
}

class _EstimadedTimedInfo extends StatelessWidget {
  const _EstimadedTimedInfo({required this.text});

  final String text;

  @override
  Widget build(final context) {
    const color = Color(0xff6A6A6A);

    return Text.rich(
      TextSpan(
        children: [
          const WidgetSpan(child: Icon(DsfrIcons.systemTimerLine, size: 15, color: color)),
          TextSpan(text: text, style: const DsfrTextStyle.bodyXsMedium(color: color)),
        ],
      ),
    );
  }
}
