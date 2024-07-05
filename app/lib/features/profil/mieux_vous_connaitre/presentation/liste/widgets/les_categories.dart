import 'package:app/features/profil/mieux_vous_connaitre/presentation/liste/widgets/les_categories_tags.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class LesCategories extends StatelessWidget {
  const LesCategories({super.key});

  @override
  Widget build(final BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
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
