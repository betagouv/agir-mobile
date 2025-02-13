import 'package:app/features/profil/informations/presentation/bloc/mes_informations_bloc.dart';
import 'package:app/features/profil/informations/presentation/bloc/mes_informations_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MesInformationsAnnee extends StatelessWidget {
  const MesInformationsAnnee({super.key});

  @override
  Widget build(final context) {
    final anneeDeNaissance = context.select<MesInformationsBloc, int?>((final bloc) => bloc.state.anneeDeNaissance);

    return DsfrInput(
      label: Localisation.anneeDeNaissance,
      hintText: Localisation.facultatif,
      initialValue: anneeDeNaissance?.toString(),
      onChanged: (final value) {
        final parsedValue = int.tryParse(value);
        if (parsedValue == null) {
          return;
        }
        context.read<MesInformationsBloc>().add(MesInformationsAnneeChange(parsedValue));
      },
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
    );
  }
}
