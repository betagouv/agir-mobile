import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/mieux_vous_connaitre_edit_bloc.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/mieux_vous_connaitre_edit_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// NOTE: Seems to have equivalent implementation in the DSFR input used for the RFR.
class Decimal extends StatelessWidget {
  const Decimal({super.key, required this.question});

  final QuestionDecimal question;

  @override
  Widget build(final context) {
    final controller = TextEditingController(text: question.response.value);

    return DsfrInputHeadless(
      key: const ValueKey(Localisation.maReponse),
      controller: controller,
      onChanged: (final value) {
        if (double.tryParse(value) == null) {
          return;
        }
        context.read<MieuxVousConnaitreEditBloc>().add(MieuxVousConnaitreEditEntierChangee(value));
      },
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9,.]'))],
    );
  }
}
