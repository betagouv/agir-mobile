import 'package:app/features/profil/informations/presentation/blocs/mes_informations_bloc.dart';
import 'package:app/features/profil/informations/presentation/blocs/mes_informations_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MesInformationsRevenuFiscal extends StatelessWidget {
  const MesInformationsRevenuFiscal({super.key});

  void _handleRevenuFiscal(final BuildContext context, final int? value) {
    if (value == null) {
      return;
    }
    context
        .read<MesInformationsBloc>()
        .add(MesInformationsRevenuFiscalChange(value));
  }

  @override
  Widget build(final BuildContext context) {
    final revenuFiscal = context.select<MesInformationsBloc, int?>(
      (final bloc) => bloc.state.revenuFiscal,
    );

    return DsfrRadioButtonSet(
      title: Localisation.revenuFiscal,
      values: const {
        0: Localisation.tranche0,
        16000: Localisation.tranche1,
        35000: Localisation.tranche2,
      },
      onCallback: (final value) => _handleRevenuFiscal(context, value),
      initialValue: revenuFiscal,
    );
  }
}
