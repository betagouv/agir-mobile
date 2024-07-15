import 'package:app/features/mieux_vous_connaitre/presentation/element/blocs/mieux_vous_connaitre_edit_bloc.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/element/blocs/mieux_vous_connaitre_edit_event.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/element/pages/mieux_vous_connaitre_edit_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MieuxVousConnaitreEditPage extends StatelessWidget {
  const MieuxVousConnaitreEditPage({required this.id, super.key});

  static const name = 'mieux-vous-connaitre-edit';
  static const path = '$name/:id';

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) =>
            MieuxVousConnaitreEditPage(id: state.pathParameters['id']!),
      );

  final String id;

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => MieuxVousConnaitreEditBloc(
          mieuxVousConnaitrePort: context.read(),
        )..add(MieuxVousConnaitreEditRecuperationDemandee(id)),
        child: const MieuxVousConnaitreEditView(),
      );
}
