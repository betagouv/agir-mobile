import 'package:app/features/mieux_vous_connaitre/presentation/liste/widgets/les_categories.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/liste/widgets/les_questions.dart';
import 'package:app/features/profil/presentation/widgets/profil_title.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class MieuxVousConnaitreView extends StatelessWidget {
  const MieuxVousConnaitreView({super.key});

  @override
  Widget build(final BuildContext context) => ListView(
        children: const [
          SizedBox(height: DsfrSpacings.s3w),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
            child: ProfilTitle(title: Localisation.mieuxVousConnaitre),
          ),
          LesCategories(),
          SizedBox(height: DsfrSpacings.s3w),
          LesQuestions(),
          SizedBox(height: DsfrSpacings.s3w),
        ],
      );
}
