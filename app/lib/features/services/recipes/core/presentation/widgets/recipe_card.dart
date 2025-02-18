import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/services/recipes/core/presentation/widgets/estimaded_timed_info.dart';
import 'package:app/features/services/recipes/core/presentation/widgets/recipe_difficulty.dart';
import 'package:app/features/services/recipes/item/presentation/pages/recipe_page.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.difficulty,
    required this.preparationTime,
  });

  final String id;
  final String imageUrl;
  final String title;
  final String difficulty;
  final int preparationTime;

  @override
  Widget build(final BuildContext context) => FnvCard(
    onTap: () async => context.pushNamed(RecipePage.name, pathParameters: {'id': id}),
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1w))),
              child: FnvImage.network(imageUrl),
            ),
            Text(title, style: const DsfrTextStyle.bodyMdBold(), maxLines: 3),
            const SizedBox(height: DsfrSpacings.s1w),
            Row(
              spacing: DsfrSpacings.s1v,
              children: [Flexible(child: RecipeDifficulty(value: difficulty)), EstimadedTimedInfo(text: '$preparationTime min')],
            ),
          ],
        ),
      ),
    ),
  );
}
