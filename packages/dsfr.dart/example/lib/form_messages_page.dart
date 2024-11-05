// ignore_for_file: avoid-collection-mutating-methods

import 'package:dsfr/dsfr.dart';
import 'package:dsfr_example/page_item.dart';
import 'package:flutter/material.dart';

class FormMessagesPage extends StatelessWidget {
  const FormMessagesPage({super.key});

  static final model = PageItem(
    title: 'Message de formulaire',
    pageBuilder: (final context) => const FormMessagesPage(),
  );

  @override
  Widget build(final context) => ListView(
        children: const [
          DsfrFormMessage(
            type: DsfrFormMessageType.error,
            text: "Texte d'erreur obligatoire",
          ),
          DsfrFormMessage(
            type: DsfrFormMessageType.valid,
            text: 'Texte de validation optionnel',
          ),
          DsfrFormMessage(
            type: DsfrFormMessageType.warning,
            text: "Texte d'avertissement",
          ),
          DsfrFormMessage(
            type: DsfrFormMessageType.info,
            text: "Texte d'information",
          ),
        ],
      );
}
