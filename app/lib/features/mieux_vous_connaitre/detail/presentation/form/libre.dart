import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/bloc/mieux_vous_connaitre_edit_bloc.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/bloc/mieux_vous_connaitre_edit_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Libre extends StatelessWidget {
  const Libre({super.key, required this.question});

  final Question question;

  @override
  Widget build(final BuildContext context) {
    final controller =
        TextEditingController(text: question.reponses.firstOrNull);

    return DsfrInputHeadless(
      key: const ValueKey(Localisation.maReponse),
      controller: controller,
      onChanged: (final value) =>
          context.read<MieuxVousConnaitreEditBloc>().add(
                MieuxVousConnaitreEditReponsesChangee([value]),
              ),
      maxLines: 4,
      minLines: 3,
      inputConstraints: null,
    );
  }
}
