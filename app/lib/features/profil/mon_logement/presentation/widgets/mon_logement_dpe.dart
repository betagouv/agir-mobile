import 'package:app/features/profil/mon_logement/presentation/blocs/mon_logement_bloc.dart';
import 'package:app/features/profil/mon_logement/presentation/blocs/mon_logement_event.dart';
import 'package:app/features/profil/mon_logement/presentation/blocs/mon_logement_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/alert_info.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MonLogementDpe extends StatelessWidget {
  const MonLogementDpe({super.key});

  Future<void> _handleTapLink(
    final String text,
    final String? href,
    final String title,
  ) async {
    if (href != null) {
      await launchUrlString(href);
    }
  }

  @override
  Widget build(final BuildContext context) {
    final dpe = context.select<MonLogementBloc, Dpe?>(
      (final bloc) => bloc.state.dpe,
    );

    return Column(
      children: [
        DsfrRadioButtonSet(
          title: Localisation.legendePourLEnsembleDesElements,
          values: const {
            Dpe.a: Localisation.dpeA,
            Dpe.b: Localisation.dpeB,
            Dpe.c: Localisation.dpeC,
            Dpe.d: Localisation.dpeD,
            Dpe.e: Localisation.dpeE,
            Dpe.f: Localisation.dpeF,
            Dpe.g: Localisation.dpeG,
            Dpe.jeNeSaisPas: Localisation.dpeJeNeSaisPas,
          },
          onCallback: (final value) =>
              context.read<MonLogementBloc>().add(MonLogementDpeChange(value)),
          initialValue: dpe,
        ),
        const SizedBox(height: DsfrSpacings.s2w),
        FnvAlertInfo(
          label: Localisation.dpeExplication,
          content: MarkdownBody(
            data:
                "Le DPE, c'est le **Diagnostic de Performance Énergétique de votre logement**. Il mesure d'un côté l'énergie nécessaire pour y maintenir une température standard, et de l'autre l'empreinte climat associée. Le DPE est exprimé comme une note de A (très bon) à G (passoire thermique). Vous pouvez obtenir une estimation de votre DPE en 2 clics avec le service [Go Renov](https://particulier.gorenove.fr/).",
            styleSheet: MarkdownStyleSheet(
              a: const DsfrTextStyle(fontSize: 15, lineHeight: 24)
                  .copyWith(color: DsfrColors.blueFranceSun113),
              p: const DsfrTextStyle(fontSize: 15, lineHeight: 24),
            ),
            onTapLink: _handleTapLink,
          ),
        ),
      ],
    );
  }
}
