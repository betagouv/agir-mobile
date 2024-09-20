import 'package:app/features/profil/informations/presentation/blocs/mes_informations_bloc.dart';
import 'package:app/features/profil/informations/presentation/blocs/mes_informations_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MesInformationsPrenom extends StatelessWidget {
  const MesInformationsPrenom({super.key});

  @override
  Widget build(final BuildContext context) {
    final prenom = context.select<MesInformationsBloc, String?>(
      (final bloc) => bloc.state.prenom,
    );

    return DsfrInput(
      label: Localisation.prenom,
      hint: Localisation.obligatoire,
      onChanged: (final value) => context
          .read<MesInformationsBloc>()
          .add(MesInformationsPrenomChange(value)),
      initialValue: prenom,
      textInputAction: TextInputAction.next,
    );
  }
}
