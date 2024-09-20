import 'package:app/features/profil/informations/presentation/blocs/mes_informations_bloc.dart';
import 'package:app/features/profil/informations/presentation/blocs/mes_informations_event.dart';
import 'package:app/features/profil/informations/presentation/widgets/revenu_fiscal_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MesInformationsRevenuFiscal extends StatelessWidget {
  const MesInformationsRevenuFiscal({super.key});

  @override
  Widget build(final BuildContext context) {
    final revenuFiscal = context.select<MesInformationsBloc, int?>(
      (final bloc) => bloc.state.revenuFiscal,
    );

    return RevenuFiscalInput(
      initialValue: revenuFiscal,
      onChanged: (final value) {
        context
            .read<MesInformationsBloc>()
            .add(MesInformationsRevenuFiscalChange(value));
      },
    );
  }
}
