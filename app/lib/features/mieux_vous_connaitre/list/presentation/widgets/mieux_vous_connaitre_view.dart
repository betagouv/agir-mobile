import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/mieux_vous_connaitre/list/presentation/widgets/les_categories.dart';
import 'package:app/features/mieux_vous_connaitre/list/presentation/widgets/les_questions.dart';
import 'package:app/features/profil/profil/presentation/widgets/profil_title.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class MieuxVousConnaitreView extends StatelessWidget {
  const MieuxVousConnaitreView({super.key});

  @override
  Widget build(final BuildContext context) => ListView(
        padding: const EdgeInsets.symmetric(vertical: paddingVerticalPage),
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
            child: ProfilTitle(title: Localisation.mieuxVousConnaitre),
          ),
          LesCategories(),
          SizedBox(height: DsfrSpacings.s3w),
          LesQuestions(),
        ],
      );
}
