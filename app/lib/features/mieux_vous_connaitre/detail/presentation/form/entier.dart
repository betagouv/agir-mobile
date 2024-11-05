import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/bloc/mieux_vous_connaitre_edit_bloc.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/bloc/mieux_vous_connaitre_edit_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Entier extends StatelessWidget {
  const Entier({super.key, required this.question});

  final EntierQuestion question;

  @override
  Widget build(final context) {
    final controller =
        TextEditingController(text: question.responses.value.firstOrNull);

    return DsfrInputHeadless(
      key: const ValueKey(Localisation.maReponse),
      controller: controller,
      onChanged: (final value) {
        if (int.tryParse(value) == null) {
          return;
        }
        context.read<MieuxVousConnaitreEditBloc>().add(
              MieuxVousConnaitreEditEntierChangee(value),
            );
      },
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}
