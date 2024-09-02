import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/element/blocs/mieux_vous_connaitre_edit_bloc.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/element/blocs/mieux_vous_connaitre_edit_event.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/element/blocs/mieux_vous_connaitre_edit_state.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/element/widgets/form/choix_multiple.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/element/widgets/form/choix_unique.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/element/widgets/form/libre.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/element/widgets/form/mieux_vous_connaitre_controller.dart';
import 'package:app/features/profil/presentation/widgets/profil_title.dart';
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
  Widget build(final BuildContext context) {
    final question = context.select<MieuxVousConnaitreEditBloc, Question>(
      (final bloc) => bloc.state.question,
    );
    controller.addListener(
      () => context.read<MieuxVousConnaitreEditBloc>().add(
            MieuxVousConnaitreEditMisAJourDemandee(question.id),
          ),
    );

    return BlocListener<MieuxVousConnaitreEditBloc,
        MieuxVousConnaitreEditState>(
      listener: (final context, final state) {
        onSaved?.call();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(Localisation.miseAJourEffectuee)),
        );
      },
      listenWhen: (final previous, final current) =>
          previous.estMiseAJour != current.estMiseAJour && current.estMiseAJour,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            switch (question.thematique) {
              Thematique.alimentation =>
                '🥦 ${Localisation.lesCategoriesAlimentation}',
              Thematique.transport =>
                '🚗 ${Localisation.lesCategoriesTransport}',
              Thematique.logement => '🏡 ${Localisation.lesCategoriesLogement}',
              Thematique.consommation =>
                '🛒 ${Localisation.lesCategoriesConsommation}',
              Thematique.climat => '🌍 ${Localisation.lesCategoriesClimat}',
              Thematique.dechet => '🗑️ ${Localisation.lesCategoriesDechet}',
              Thematique.loisir => '⚽ ${Localisation.lesCategoriesLoisir}',
            },
            style: const DsfrTextStyle.bodySm(),
          ),
          const SizedBox(height: DsfrSpacings.s1w),
          ProfilTitle(title: question.question),
          const Text(Localisation.maReponse, style: DsfrTextStyle.headline4()),
          const SizedBox(height: DsfrSpacings.s3w),
          switch (question.type) {
            ReponseType.choixUnique => ChoixUnique(question: question),
            ReponseType.choixMultiple => ChoixMultiple(question: question),
            ReponseType.libre => Libre(question: question),
          },
        ],
      ),
    );
  }
}
