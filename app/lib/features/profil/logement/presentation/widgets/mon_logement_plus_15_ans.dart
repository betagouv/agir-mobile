import 'package:app/features/profil/logement/presentation/bloc/mon_logement_bloc.dart';
import 'package:app/features/profil/logement/presentation/bloc/mon_logement_event.dart';
import 'package:app/features/profil/logement/presentation/widgets/mon_logement_titre_et_contenu.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonLogementPlus15Ans extends StatelessWidget {
  const MonLogementPlus15Ans({super.key});

  @override
  Widget build(final context) {
    final plusDe15ans = context.select<MonLogementBloc, bool?>(
      (final bloc) => bloc.state.plusDe15Ans,
    );

    return MonLogementTitreEtContenu(
      titre: Localisation.monLogementPlusDe15Ans,
      contenu: DsfrRadioButtonSetHeadless(
        values: const {
          true: DsfrRadioButtonItem(Localisation.oui),
          false: DsfrRadioButtonItem(Localisation.non),
        },
        onCallback:
            (final value) => context.read<MonLogementBloc>().add(
              MonLogementPlusDe15AnsChange(value),
            ),
        initialValue: plusDe15ans,
      ),
    );
  }
}
