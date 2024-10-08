import 'package:app/core/presentation/widgets/composants/failure_widget.dart';
import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/bloc/mieux_vous_connaitre_edit_bloc.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/bloc/mieux_vous_connaitre_edit_event.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/bloc/mieux_vous_connaitre_edit_state.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/form/choix_multiple.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/form/choix_unique.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/form/libre.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/form/mieux_vous_connaitre_controller.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/form/mosaic.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef OnSavedCallback = void Function();

class MieuxVousConnaitreForm extends StatelessWidget {
  const MieuxVousConnaitreForm({
    super.key,
    required this.id,
    required this.controller,
    this.onSaved,
  });

  final String id;
  final MieuxVousConnaitreController controller;
  final OnSavedCallback? onSaved;

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => MieuxVousConnaitreEditBloc(
          mieuxVousConnaitrePort: context.read(),
        )..add(MieuxVousConnaitreEditRecuperationDemandee(id)),
        child: _Content(controller: controller, onSaved: onSaved),
      );
}

class _Content extends StatelessWidget {
  const _Content({required this.controller, required this.onSaved});

  final MieuxVousConnaitreController controller;
  final OnSavedCallback? onSaved;

  @override
  Widget build(final BuildContext context) =>
      BlocListener<MieuxVousConnaitreEditBloc, MieuxVousConnaitreEditState>(
        listener: (final context, final state) {
          final aState = state;
          if (aState is MieuxVousConnaitreEditMisAJour) {
            onSaved?.call();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(Localisation.miseAJourEffectuee)),
            );
          }
        },
        child: BlocBuilder<MieuxVousConnaitreEditBloc,
            MieuxVousConnaitreEditState>(
          builder: (final context, final state) => switch (state) {
            MieuxVousConnaitreEditInitial() ||
            MieuxVousConnaitreEditMisAJour() =>
              const SizedBox(),
            MieuxVousConnaitreEditLoaded() =>
              _LoadedContent(controller: controller, state: state),
            MieuxVousConnaitreEditError() => FnvFailureWidget(
                onPressed: () => context.read<MieuxVousConnaitreEditBloc>().add(
                      MieuxVousConnaitreEditRecuperationDemandee(state.id),
                    ),
              ),
          },
        ),
      );
}

class _LoadedContent extends StatelessWidget {
  const _LoadedContent({required this.controller, required this.state});

  final MieuxVousConnaitreEditLoaded state;
  final MieuxVousConnaitreController controller;
  @override
  Widget build(final BuildContext context) {
    final question = state.question;
    void listener() => context.read<MieuxVousConnaitreEditBloc>().add(
          MieuxVousConnaitreEditMisAJourDemandee(question.id.value),
        );
    controller
      ..removeListener(listener)
      ..addListener(listener);

    return switch (question) {
      ChoixMultipleQuestion() => _ChoixMultipleContent(question: question),
      ChoixUniqueQuestion() => _ChoixUniqueContent(question: question),
      LibreQuestion() => _LibreContent(question: question),
      MosaicQuestion() => _MosaicContent(question: question),
    };
  }
}

class _ChoixMultipleContent extends StatelessWidget {
  const _ChoixMultipleContent({required this.question});

  final ChoixMultipleQuestion question;

  @override
  Widget build(final BuildContext context) => Column(
        children: [
          FnvTitle(
            title: question.text.value,
            subtitle: Localisation.plusieursReponsesPossibles,
          ),
          ChoixMultiple(question: question),
        ],
      );
}

class _ChoixUniqueContent extends StatelessWidget {
  const _ChoixUniqueContent({required this.question});

  final ChoixUniqueQuestion question;

  @override
  Widget build(final BuildContext context) => Column(
        children: [
          FnvTitle(title: question.text.value),
          ChoixUnique(question: question),
        ],
      );
}

class _LibreContent extends StatelessWidget {
  const _LibreContent({required this.question});

  final LibreQuestion question;

  @override
  Widget build(final BuildContext context) => Column(
        children: [
          FnvTitle(title: question.text.value),
          Libre(question: question),
        ],
      );
}

class _MosaicContent extends StatelessWidget {
  const _MosaicContent({required this.question});

  final MosaicQuestion question;

  @override
  Widget build(final BuildContext context) => Column(
        children: [
          FnvTitle(
            title: question.text.value,
            subtitle: Localisation.plusieursReponsesPossibles,
          ),
          Mosaic(question: question),
        ],
      );
}
