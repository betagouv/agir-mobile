import 'package:app/core/presentation/widgets/composants/code_input.dart';
import 'package:app/features/authentification/saisie_code/presentation/bloc/saisie_code_bloc.dart';
import 'package:app/features/authentification/saisie_code/presentation/bloc/saisie_code_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaisieCodeInput extends StatelessWidget {
  const SaisieCodeInput({super.key});

  void _handleCode(final BuildContext context, final String value) {
    if (value.length == 6) {
      context.read<SaisieCodeBloc>().add(SaisieCodeCodeSaisie(value));
    }
  }

  @override
  Widget build(final context) => Semantics(
        textField: true,
        label: 'Code de vérification',
        child: ExcludeSemantics(
          child: FnvCodeInput(
            onChanged: (final value) => _handleCode(context, value),
          ),
        ),
      );
}
