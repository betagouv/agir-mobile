import 'package:app/core/helpers/text_scaler.dart';
import 'package:app/features/profil/logement/presentation/bloc/mon_logement_bloc.dart';
import 'package:app/features/profil/logement/presentation/bloc/mon_logement_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonLogementNombreAdultes extends StatelessWidget {
  const MonLogementNombreAdultes({super.key});

  void _handleNombreAdultes(final BuildContext context, final String value) {
    final nombreAdultes = int.tryParse(value);
    if (nombreAdultes == null) {
      return;
    }
    context
        .read<MonLogementBloc>()
        .add(MonLogementNombreAdultesChange(nombreAdultes));
  }

  @override
  Widget build(final BuildContext context) {
    const adultes = Localisation.adultes;
    final nombreAdultes = context
        .select<MonLogementBloc, int>((final bloc) => bloc.state.nombreAdultes);

    return Row(
      children: [
        SizedBox(
          width: adjustTextSize(context, 97),
          child: DsfrInputHeadless(
            initialValue: nombreAdultes.toString(),
            onChanged: (final value) => _handleNombreAdultes(context, value),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            key: const ValueKey(adultes),
          ),
        ),
        const SizedBox(width: DsfrSpacings.s1v),
        const Expanded(child: Text(adultes, style: DsfrTextStyle.bodySm())),
      ],
    );
  }
}
