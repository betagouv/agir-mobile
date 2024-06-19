import 'package:app/features/profil/informations/presentation/blocs/mes_informations_bloc.dart';
import 'package:app/features/profil/informations/presentation/blocs/mes_informations_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MesInformationsNom extends StatelessWidget {
  const MesInformationsNom({super.key});

  @override
  Widget build(final BuildContext context) {
    final nom = context
        .select<MesInformationsBloc, String>((final bloc) => bloc.state.nom);

    return DsfrInput(
      label: Localisation.nom,
      onChanged: (final value) => context
          .read<MesInformationsBloc>()
          .add(MesInformationsNomChange(value)),
      initialValue: nom,
    );
  }
}
