import 'package:app/features/profil/mon_logement/presentation/blocs/mon_logement_bloc.dart';
import 'package:app/features/profil/mon_logement/presentation/blocs/mon_logement_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonLogementNombreEnfants extends StatelessWidget {
  const MonLogementNombreEnfants({super.key});

  void _handleNombreEnfants(final BuildContext context, final String value) {
    final nombreEnfants = int.tryParse(value);
    if (nombreEnfants == null) {
      return;
    }
    context
        .read<MonLogementBloc>()
        .add(MonLogementNombreEnfantsChange(nombreEnfants));
  }

  @override
  Widget build(final BuildContext context) {
    final nombreEnfants = context
        .select<MonLogementBloc, int>((final bloc) => bloc.state.nombreEnfants);

    return DsfrInput(
      label: Localisation.enfants,
      onChanged: (final value) => _handleNombreEnfants(context, value),
      initialValue: nombreEnfants.toString(),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}
