import 'package:app/features/authentification/saisie_code/presentation/blocs/saisie_code_bloc.dart';
import 'package:app/features/authentification/saisie_code/presentation/blocs/saisie_code_event.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaisieCodeInput extends StatelessWidget {
  const SaisieCodeInput({super.key});

  void _handleCode(final BuildContext context, final String value) {
    if (value.length == 6) {
      context.read<SaisieCodeBloc>().add(SaisieCodeCodeSaisie(value));
    }
  }

  @override
  Widget build(final BuildContext context) => DsfrInputHeadless(
        onChanged: (final value) => _handleCode(context, value),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputStyle: const DsfrTextStyle.displayXs(),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(6),
        ],
        key: const Key('saisie_code_key'),
      );
}
