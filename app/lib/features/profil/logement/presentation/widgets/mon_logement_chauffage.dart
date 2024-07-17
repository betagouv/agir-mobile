import 'package:app/features/profil/logement/presentation/blocs/mon_logement_bloc.dart';
import 'package:app/features/profil/logement/presentation/blocs/mon_logement_event.dart';
import 'package:app/features/profil/logement/presentation/blocs/mon_logement_state.dart';
import 'package:app/features/profil/logement/presentation/widgets/mon_logement_titre_et_contenu.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonLogementChauffage extends StatelessWidget {
  const MonLogementChauffage({super.key});

  @override
  Widget build(final BuildContext context) {
    final chauffage = context.select<MonLogementBloc, Chauffage?>(
      (final bloc) => bloc.state.chauffage,
    );

    return MonLogementTitreEtContenu(
      titre: Localisation.quelleEstVotreModeDeChauffagePrincipal,
      contenu: DsfrRadioButtonSetHeadless(
        values: const {
          Chauffage.electricite: DsfrRadioButtonItem(Localisation.electricite),
          Chauffage.boisPellets: DsfrRadioButtonItem(Localisation.boisPellets),
          Chauffage.fioul: DsfrRadioButtonItem(Localisation.fioul),
          Chauffage.gaz: DsfrRadioButtonItem(Localisation.gaz),
          Chauffage.autre: DsfrRadioButtonItem(Localisation.autreJeNeSaisPas),
        },
        onCallback: (final value) => context
            .read<MonLogementBloc>()
            .add(MonLogementChauffageChange(value)),
        initialValue: chauffage,
      ),
    );
  }
}
