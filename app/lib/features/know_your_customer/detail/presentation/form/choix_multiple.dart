import 'package:app/core/presentation/widgets/composants/checkbox_set.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/mieux_vous_connaitre_edit_bloc.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/mieux_vous_connaitre_edit_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoixMultiple extends StatelessWidget {
  const ChoixMultiple({super.key, required this.question});

  final QuestionMultipleChoice question;

  @override
  Widget build(final context) => FnvCheckboxSet(
        options: question.responses.map((final e) => e.label).toList(),
        selectedOptions: question.responses
            .where((final e) => e.isSelected)
            .map((final e) => e.label)
            .toList(),
        onChanged: (final value) => context
            .read<MieuxVousConnaitreEditBloc>()
            .add(MieuxVousConnaitreEditChoixMultipleChangee(value)),
      );
}
