import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/element/blocs/mieux_vous_connaitre_edit_bloc.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/element/blocs/mieux_vous_connaitre_edit_event.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/element/blocs/mieux_vous_connaitre_edit_state.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/element/widgets/checkbox_set.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/liste/blocs/mieux_vous_connaitre_bloc.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/liste/blocs/mieux_vous_connaitre_event.dart';
import 'package:app/features/profil/presentation/widgets/profil_title.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/app_bar.dart';
import 'package:app/shared/widgets/composants/bottom_bar.dart';
import 'package:app/shared/widgets/fondamentaux/colors.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MieuxVousConnaitreEditView extends StatelessWidget {
  const MieuxVousConnaitreEditView({super.key});

  void _handleMiseAJour(
    final BuildContext context,
    final MieuxVousConnaitreEditState state,
  ) {
    context.read<MieuxVousConnaitreBloc>().add(
          const MieuxVousConnaitreRecuperationDemandee(),
        );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(Localisation.miseAJourEffectuee)),
    );
    GoRouter.of(context).pop();
  }

  @override
  Widget build(final BuildContext context) =>
      BlocListener<MieuxVousConnaitreEditBloc, MieuxVousConnaitreEditState>(
        listener: _handleMiseAJour,
        listenWhen: (final previous, final current) =>
            previous.estMiseAJour != current.estMiseAJour &&
            current.estMiseAJour,
        child: const _Content(),
      );
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(final BuildContext context) {
    final question = context.select<MieuxVousConnaitreEditBloc, Question>(
      (final bloc) => bloc.state.question,
    );

    return Scaffold(
      appBar: const FnvAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(DsfrSpacings.s2w),
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
          const Text(
            Localisation.maReponse,
            style: DsfrTextStyle.headline4(),
          ),
          const SizedBox(height: DsfrSpacings.s3w),
          switch (question.type) {
            ReponseType.choixUnique => _ChoixUnique(question: question),
            ReponseType.choixMultiple => _ChoixMultiple(question: question),
            ReponseType.libre => _Libre(question: question),
          },
        ],
      ),
      bottomNavigationBar: FnvBottomBar(
        child: DsfrButton(
          label: Localisation.mettreAJour,
          icon: DsfrIcons.deviceSave3Fill,
          variant: DsfrButtonVariant.primary,
          size: DsfrButtonSize.lg,
          onPressed: () => context
              .read<MieuxVousConnaitreEditBloc>()
              .add(MieuxVousConnaitreEditMisAJourDemandee(question.id)),
        ),
      ),
      backgroundColor: FnvColors.aidesFond,
    );
  }
}

class _ChoixUnique extends StatelessWidget {
  const _ChoixUnique({required this.question});

  final Question question;

  @override
  Widget build(final BuildContext context) => DsfrRadioButtonSetHeadless(
        values: Map.fromEntries(
          question.reponsesPossibles.map(
            (final reponse) => MapEntry(reponse, DsfrRadioButtonItem(reponse)),
          ),
        ),
        onCallback: (final value) => context
            .read<MieuxVousConnaitreEditBloc>()
            .add(MieuxVousConnaitreEditReponsesChangee([value ?? ''])),
        initialValue: question.reponses.firstOrNull,
        mode: DsfrRadioButtonSetMode.column,
      );
}

class _ChoixMultiple extends StatelessWidget {
  const _ChoixMultiple({required this.question});

  final Question question;

  @override
  Widget build(final BuildContext context) => FnvCheckboxSet(
        options: question.reponsesPossibles,
        selectedOptions: question.reponses,
        onChanged: (final value) => context
            .read<MieuxVousConnaitreEditBloc>()
            .add(MieuxVousConnaitreEditReponsesChangee(value)),
      );
}

class _Libre extends StatelessWidget {
  const _Libre({required this.question});

  final Question question;

  @override
  Widget build(final BuildContext context) {
    final controller =
        TextEditingController(text: question.reponses.firstOrNull);

    return DsfrInputHeadless(
      controller: controller,
      onChanged: (final value) =>
          context.read<MieuxVousConnaitreEditBloc>().add(
                MieuxVousConnaitreEditReponsesChangee([value]),
              ),
      maxLines: 4,
      minLines: 3,
      inputConstraints: null,
      key: const ValueKey(Localisation.maReponse),
    );
  }
}
