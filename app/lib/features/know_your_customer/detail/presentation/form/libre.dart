import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/mieux_vous_connaitre_edit_bloc.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/mieux_vous_connaitre_edit_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Libre extends StatelessWidget {
  const Libre({super.key, required this.question});

  final QuestionOpen question;

  @override
  Widget build(final context) {
    final controller = TextEditingController(text: question.response.value);

    return DsfrInputHeadless(
      key: const ValueKey(Localisation.maReponse),
      controller: controller,
      onChanged: (final value) =>
          context.read<MieuxVousConnaitreEditBloc>().add(
                MieuxVousConnaitreEditLibreChangee(value),
              ),
      maxLines: 4,
      minLines: 3,
      inputConstraints: null,
    );
  }
}
