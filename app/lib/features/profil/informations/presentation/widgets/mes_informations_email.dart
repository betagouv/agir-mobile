import 'package:app/features/profil/informations/presentation/blocs/mes_informations_bloc.dart';
import 'package:app/features/profil/informations/presentation/blocs/mes_informations_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MesInformationsEmail extends StatelessWidget {
  const MesInformationsEmail({super.key});

  @override
  Widget build(final BuildContext context) {
    final email = context
        .select<MesInformationsBloc, String>((final bloc) => bloc.state.email);

    return DsfrInput(
      label: Localisation.adresseCourrierElectronique,
      hint: Localisation.adresseCourrierElectroniqueDescription,
      onChanged: (final value) => context
          .read<MesInformationsBloc>()
          .add(MesInformationsEmailChange(value)),
      initialValue: email,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
    );
  }
}
