import 'package:app/core/presentation/widgets/composants/failure_widget.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/mieux_vous_connaitre_edit_bloc.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/mieux_vous_connaitre_edit_event.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/mieux_vous_connaitre_edit_state.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/choix_multiple.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/choix_unique.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/entier.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/libre.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/mieux_vous_connaitre_controller.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/mosaic.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
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
  Widget build(final context) => BlocProvider(
    create:
        (final context) => MieuxVousConnaitreEditBloc(
          mieuxVousConnaitreRepository: context.read(),
        )..add(MieuxVousConnaitreEditRecuperationDemandee(id)),
    lazy: false,
    child: _Content(controller: controller, onSaved: onSaved),
  );
}

class _Content extends StatelessWidget {
  const _Content({required this.controller, required this.onSaved});

  final MieuxVousConnaitreController controller;
  final OnSavedCallback? onSaved;

  @override
  Widget build(
    final context,
  ) => BlocListener<MieuxVousConnaitreEditBloc, MieuxVousConnaitreEditState>(
    listener: (final context, final state) {
      final aState = state;
      if (aState is MieuxVousConnaitreEditLoaded && aState.updated) {
        onSaved?.call();
      }
    },
    child: BlocBuilder<MieuxVousConnaitreEditBloc, MieuxVousConnaitreEditState>(
      builder:
          (final context, final state) => switch (state) {
            MieuxVousConnaitreEditInitial() => const SizedBox.shrink(),
            MieuxVousConnaitreEditLoaded() => _LoadedContent(
              controller: controller,
              state: state,
            ),
            MieuxVousConnaitreEditError() => FnvFailureWidget(
              onPressed:
                  () => context.read<MieuxVousConnaitreEditBloc>().add(
                    MieuxVousConnaitreEditRecuperationDemandee(state.id),
                  ),
            ),
          },
      buildWhen:
          (final oldState, final newState) =>
              (oldState is! MieuxVousConnaitreEditLoaded ||
                  newState is! MieuxVousConnaitreEditLoaded) ||
              oldState.question != newState.question,
    ),
  );
}

class _LoadedContent extends StatefulWidget {
  const _LoadedContent({required this.controller, required this.state});

  final MieuxVousConnaitreEditLoaded state;
  final MieuxVousConnaitreController controller;

  @override
  State<_LoadedContent> createState() => _LoadedContentState();
}

class _LoadedContentState extends State<_LoadedContent> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_listener);
  }

  void _listener() => context.read<MieuxVousConnaitreEditBloc>().add(
    MieuxVousConnaitreEditMisAJourDemandee(widget.state.question.id.value),
  );

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(final context) {
    final question = widget.state.question;

    return switch (question) {
      QuestionSingleChoice() => _ChoixUniqueContent(question: question),
      QuestionMultipleChoice() => _ChoixMultipleContent(question: question),
      QuestionInteger() => _EntierContent(question: question),
      QuestionOpen() => _LibreContent(question: question),
      QuestionMosaicBoolean() => _MosaicContent(question: question),
    };
  }
}

class _ChoixMultipleContent extends StatelessWidget {
  const _ChoixMultipleContent({required this.question});

  final QuestionMultipleChoice question;

  @override
  Widget build(final context) => Column(
    spacing: DsfrSpacings.s3w,
    children: [
      FnvTitle(
        title: question.label,
        subtitle: Localisation.plusieursReponsesPossibles,
      ),
      ChoixMultiple(question: question),
    ],
  );
}

class _ChoixUniqueContent extends StatelessWidget {
  const _ChoixUniqueContent({required this.question});

  final QuestionSingleChoice question;

  @override
  Widget build(final context) => Column(
    spacing: DsfrSpacings.s3w,
    children: [
      FnvTitle(title: question.label),
      ChoixUnique(question: question),
    ],
  );
}

class _LibreContent extends StatelessWidget {
  const _LibreContent({required this.question});

  final QuestionOpen question;

  @override
  Widget build(final context) => Column(
    spacing: DsfrSpacings.s3w,
    children: [FnvTitle(title: question.label), Libre(question: question)],
  );
}

class _EntierContent extends StatelessWidget {
  const _EntierContent({required this.question});

  final QuestionInteger question;

  @override
  Widget build(final context) => Column(
    spacing: DsfrSpacings.s3w,
    children: [FnvTitle(title: question.label), Entier(question: question)],
  );
}

class _MosaicContent extends StatelessWidget {
  const _MosaicContent({required this.question});

  final QuestionMosaicBoolean question;

  @override
  Widget build(final context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s3w,
    children: [
      FnvTitle(
        title: question.label,
        subtitle: Localisation.plusieursReponsesPossibles,
      ),
      Mosaic(question: question),
    ],
  );
}
