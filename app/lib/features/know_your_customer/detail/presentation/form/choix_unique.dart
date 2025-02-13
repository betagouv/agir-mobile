import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/mieux_vous_connaitre_edit_bloc.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/mieux_vous_connaitre_edit_event.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoixUnique extends StatelessWidget {
  const ChoixUnique({super.key, required this.question});

  final QuestionSingleChoice question;

  @override
  Widget build(final context) => DsfrRadioButtonSetHeadless(
    values: Map.fromEntries(
      question.responses.map(
        (final r) => MapEntry(r.label, DsfrRadioButtonItem(r.label)),
      ),
    ),
    onCallback: (final value) {
      if (value == null) {
        return;
      }
      context.read<MieuxVousConnaitreEditBloc>().add(
        MieuxVousConnaitreEditChoixUniqueChangee(value),
      );
    },
    initialValue:
        question.responses.where((final r) => r.isSelected).firstOrNull?.label,
    mode: DsfrRadioButtonSetMode.column,
  );
}
