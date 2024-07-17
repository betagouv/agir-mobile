import 'package:app/features/profil/logement/presentation/blocs/mon_logement_bloc.dart';
import 'package:app/features/profil/logement/presentation/blocs/mon_logement_event.dart';
import 'package:app/features/profil/logement/presentation/blocs/mon_logement_state.dart';
import 'package:app/features/profil/logement/presentation/widgets/mon_logement_titre_et_contenu.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonLogementResidencePrincipale extends StatelessWidget {
  const MonLogementResidencePrincipale({super.key});

  void _handleTypeDeLogement(
    final BuildContext context,
    final TypeDeLogement? value,
  ) {
    if (value == null) {
      return;
    }
    context.read<MonLogementBloc>().add(MonLogementTypeDeLogementChange(value));
  }

  @override
  Widget build(final BuildContext context) {
    final typeDeLogement = context.select<MonLogementBloc, TypeDeLogement?>(
      (final bloc) => bloc.state.typeDeLogement,
    );

    return MonLogementTitreEtContenu(
      titre: Localisation.votreResidencePrincipaleEst,
      contenu: DsfrRadioButtonSetHeadless(
        values: const {
          TypeDeLogement.appartement:
              DsfrRadioButtonItem(Localisation.unAppartement),
          TypeDeLogement.maison: DsfrRadioButtonItem(Localisation.uneMaison),
        },
        onCallback: (final value) => _handleTypeDeLogement(context, value),
        initialValue: typeDeLogement,
      ),
    );
  }
}
