import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/element/blocs/mieux_vous_connaitre_edit_bloc.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/element/blocs/mieux_vous_connaitre_edit_event.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoixUnique extends StatelessWidget {
  const ChoixUnique({super.key, required this.question});

  final Question question;

  @override
  Widget build(final BuildContext context) => DsfrRadioButtonSetHeadless(
        values: Map.fromEntries(
          question.reponsesPossibles.map(
            (final reponse) => MapEntry(reponse, DsfrRadioButtonItem(reponse)),
          ),
        ),
        onCallback: (final value) => context
            .read<MieuxVousConnaitreEditBloc>()
            .add(MieuxVousConnaitreEditReponsesChangee([value ?? ''])),
        initialValue: question.reponses.firstOrNull,
        mode: DsfrRadioButtonSetMode.column,
      );
}
