import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/mieux_vous_connaitre/list/presentation/widgets/les_categories_tags.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class LesCategories extends StatelessWidget {
  const LesCategories({super.key});

  @override
  Widget build(final BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              Localisation.lesCategories,
              style: DsfrTextStyle.headline4(),
            ),
            SizedBox(height: DsfrSpacings.s2w),
            LesCategoriesTags(),
          ],
        ),
      );
}
