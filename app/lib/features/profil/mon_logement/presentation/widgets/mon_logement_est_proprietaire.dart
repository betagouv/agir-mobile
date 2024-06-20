// ignore_for_file: avoid-missing-enum-constant-in-map

import 'package:app/features/profil/mon_logement/presentation/blocs/mon_logement_bloc.dart';
import 'package:app/features/profil/mon_logement/presentation/blocs/mon_logement_event.dart';
import 'package:app/features/profil/mon_logement/presentation/widgets/mon_logement_titre_et_contenu.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonLogementEstProprietaire extends StatelessWidget {
  const MonLogementEstProprietaire({super.key});

  @override
  Widget build(final BuildContext context) {
    final estProprietaire = context.select<MonLogementBloc, bool?>(
      (final bloc) => bloc.state.estProprietaire,
    );

    return MonLogementTitreEtContenu(
      titre: Localisation.vousEtesProprietaireDeVotreLogement,
      contenu: DsfrRadioButtonSetHeadless(
        values: const {true: Localisation.oui, false: Localisation.non},
        onCallback: (final value) => context
            .read<MonLogementBloc>()
            .add(MonLogementEstProprietaireChange(value)),
        initialValue: estProprietaire,
      ),
    );
  }
}
