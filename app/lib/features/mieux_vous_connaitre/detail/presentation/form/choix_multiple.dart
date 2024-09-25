import 'package:app/core/presentation/widgets/composants/checkbox_set.dart';
import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/bloc/mieux_vous_connaitre_edit_bloc.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/bloc/mieux_vous_connaitre_edit_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoixMultiple extends StatelessWidget {
  const ChoixMultiple({super.key, required this.question});

  final Question question;

  @override
  Widget build(final BuildContext context) => FnvCheckboxSet(
        options: question.reponsesPossibles,
        selectedOptions: question.reponses,
        onChanged: (final value) => context
            .read<MieuxVousConnaitreEditBloc>()
            .add(MieuxVousConnaitreEditReponsesChangee(value)),
      );
}
