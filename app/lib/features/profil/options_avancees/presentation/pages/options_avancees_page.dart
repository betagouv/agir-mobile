import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/profil/changer_mot_de_passe/presentation/widgets/changer_mot_de_passe.dart';
import 'package:app/features/profil/profil/presentation/widgets/profil_title.dart';
import 'package:app/features/profil/supprimer_compte/presentation/widgets/supprimer_compte.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OptionsAvanceesPage extends StatelessWidget {
  const OptionsAvanceesPage({super.key});

  static const name = 'options-avancees';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const OptionsAvanceesPage(),
      );

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: const FnvAppBar(),
        body: ListView(
          padding: const EdgeInsets.all(paddingVerticalPage),
          children: const [
            ProfilTitle(title: Localisation.optionsAvancees),
            ChangerMotDePasse(),
            SizedBox(height: DsfrSpacings.s5w),
            SupprimerCompte(),
          ],
        ),
        backgroundColor: FnvColors.aidesFond,
      );
}
