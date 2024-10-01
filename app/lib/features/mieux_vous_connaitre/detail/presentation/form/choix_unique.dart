import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/bloc/mieux_vous_connaitre_edit_bloc.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/bloc/mieux_vous_connaitre_edit_event.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoixUnique extends StatelessWidget {
  const ChoixUnique({super.key, required this.question});

  final ChoixUniqueQuestion question;

  @override
  Widget build(final BuildContext context) => DsfrRadioButtonSetHeadless(
        values: Map.fromEntries(
          question.responsesPossibles.value.map(
            (final reponse) => MapEntry(reponse, DsfrRadioButtonItem(reponse)),
          ),
        ),
        onCallback: (final value) {
          if (value == null) {
            return;
          }
          context
              .read<MieuxVousConnaitreEditBloc>()
              .add(MieuxVousConnaitreEditChoixUniqueChangee(value));
        },
        initialValue: question.responses.value.firstOrNull,
        mode: DsfrRadioButtonSetMode.column,
      );
}
