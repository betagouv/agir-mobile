import 'package:app/core/helpers/number_format.dart';
import 'package:app/features/profil/informations/presentation/bloc/mes_informations_bloc.dart';
import 'package:app/features/profil/informations/presentation/bloc/mes_informations_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MesInformationsNombreDePartsFiscales extends StatelessWidget {
  const MesInformationsNombreDePartsFiscales({super.key});

  void _handleNombreDePartsFiscales(
    final BuildContext context,
    final String value,
  ) {
    final parse = double.tryParse(value.replaceFirst(',', '.'));
    if (parse == null) {
      context
          .read<MesInformationsBloc>()
          .add(const MesInformationsNombreDePartsFiscalesChange(0));

      return;
    }
    context
        .read<MesInformationsBloc>()
        .add(MesInformationsNombreDePartsFiscalesChange(parse));
  }

  @override
  Widget build(final context) {
    final nombreDePartsFiscales = context.select<MesInformationsBloc, double>(
      (final bloc) => bloc.state.nombreDePartsFiscales,
    );

    return DsfrInput(
      label: Localisation.nombreDePartsFiscales,
      hint: Localisation.nombreDePartsFiscalesDescription,
      initialValue: FnvNumberFormat.formatNumber(nombreDePartsFiscales),
      onChanged: (final value) => _handleNombreDePartsFiscales(context, value),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.next,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9,.]')),
      ],
    );
  }
}
