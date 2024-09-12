import 'package:app/features/profil/logement/presentation/blocs/mon_logement_bloc.dart';
import 'package:app/features/profil/logement/presentation/blocs/mon_logement_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/helpers/text_scaler.dart';
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

    const enfants = Localisation.enfants;

    return Row(
      children: [
        SizedBox(
          width: adjustTextSize(context, 97),
          child: DsfrInputHeadless(
            initialValue: nombreEnfants.toString(),
            onChanged: (final value) => _handleNombreEnfants(context, value),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            key: const ValueKey(enfants),
          ),
        ),
        const SizedBox(width: DsfrSpacings.s1v),
        const Expanded(child: Text(enfants, style: DsfrTextStyle.bodySm())),
      ],
    );
  }
}
