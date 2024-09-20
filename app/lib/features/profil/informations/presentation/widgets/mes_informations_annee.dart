import 'package:app/features/profil/informations/presentation/blocs/mes_informations_bloc.dart';
import 'package:app/features/profil/informations/presentation/blocs/mes_informations_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MesInformationsAnnee extends StatelessWidget {
  const MesInformationsAnnee({super.key});

  @override
  Widget build(final BuildContext context) {
    final anneeDeNaissance = context.select<MesInformationsBloc, int?>(
      (final bloc) => bloc.state.anneeDeNaissance,
    );

    return DsfrInput(
      label: Localisation.anneeDeNaissance,
      hint: Localisation.facultatif,
      onChanged: (final value) {
        final parsedValue = int.tryParse(value);
        if (parsedValue == null) {
          return;
        }
        context
            .read<MesInformationsBloc>()
            .add(MesInformationsAnneeChange(parsedValue));
      },
      initialValue: anneeDeNaissance?.toString(),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
      ],
      textInputAction: TextInputAction.next,
    );
  }
}
