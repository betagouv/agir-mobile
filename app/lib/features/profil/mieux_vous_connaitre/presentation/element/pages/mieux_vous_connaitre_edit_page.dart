import 'package:app/features/profil/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/profil/mieux_vous_connaitre/presentation/element/blocs/mieux_vous_connaitre_edit_bloc.dart';
import 'package:app/features/profil/mieux_vous_connaitre/presentation/element/pages/mieux_vous_connaitre_edit_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MieuxVousConnaitreEditPage extends StatelessWidget {
  const MieuxVousConnaitreEditPage({required this.question, super.key});

  static const name = 'mieux-vous-connaitre-edit';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) =>
            MieuxVousConnaitreEditPage(question: state.extra! as Question),
      );

  final Question question;

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => MieuxVousConnaitreEditBloc(
          mieuxVousConnaitrePort: context.read(),
        ),
        child: MieuxVousConnaitreEditView(question: question),
      );
}
