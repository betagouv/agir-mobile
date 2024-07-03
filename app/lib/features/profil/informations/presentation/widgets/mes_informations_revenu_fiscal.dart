import 'package:app/features/profil/informations/presentation/blocs/mes_informations_bloc.dart';
import 'package:app/features/profil/informations/presentation/blocs/mes_informations_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MesInformationsRevenuFiscal extends StatelessWidget {
  const MesInformationsRevenuFiscal({super.key});

  void _handleRevenuFiscal(final BuildContext context, final String value) {
    final parse = int.tryParse(value);
    if (parse == null) {
      return;
    }
    context
        .read<MesInformationsBloc>()
        .add(MesInformationsRevenuFiscalChange(parse));
  }

  @override
  Widget build(final BuildContext context) {
    final revenuFiscal = context.select<MesInformationsBloc, int?>(
      (final bloc) => bloc.state.revenuFiscal,
    );

    return DsfrInput(
      label: Localisation.revenuFiscal,
      onChanged: (final value) => _handleRevenuFiscal(context, value),
      suffixText: '€',
      initialValue: revenuFiscal?.toString(),
      textAlign: TextAlign.end,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}
