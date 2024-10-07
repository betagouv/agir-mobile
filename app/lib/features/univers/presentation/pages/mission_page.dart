// ignore_for_file: avoid-unnecessary-type-assertions

import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/core/presentation/widgets/fondamentaux/vertical_dotted_line.dart';
import 'package:app/features/articles/presentation/pages/article_page.dart';
import 'package:app/features/quiz/presentation/pages/quiz_page.dart';
import 'package:app/features/univers/core/domain/mission.dart';
import 'package:app/features/univers/presentation/bloc/mission_bloc.dart';
import 'package:app/features/univers/presentation/bloc/mission_event.dart';
import 'package:app/features/univers/presentation/bloc/mission_state.dart';
import 'package:app/features/univers/presentation/pages/mission_kyc_page.dart';
import 'package:app/features/univers/presentation/widgets/defi_widget.dart';
import 'package:app/features/univers/presentation/widgets/objectif_card.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final missionRouteObserver = RouteObserver<ModalRoute<dynamic>>();

class MissionPage extends StatelessWidget {
  const MissionPage({super.key, required this.id});

  static const name = 'mission';
  static const path = '$name/:id';

  final String id;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) =>
            MissionPage(id: state.pathParameters['id']!),
      );

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => MissionBloc(
          universPort: context.read(),
          gamificationPort: context.read(),
          missionId: id,
        ),
        child: const _Page(),
      );
}

class _Page extends StatefulWidget {
  const _Page();

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> with RouteAware {
  void _handleMission() {
    context.read<MissionBloc>().add(const MissionRecuperationDemandee());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    missionRouteObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() => _handleMission();

  @override
  void didPush() => _handleMission();

  @override
  void dispose() {
    missionRouteObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) =>
      BlocListener<MissionBloc, MissionState>(
        listener: (final context, final state) => GoRouter.of(context).pop(),
        listenWhen: (final previous, final current) =>
            previous != current &&
            current is MissionSucces &&
            current.estTerminee,
        child: Scaffold(
          appBar: const FnvAppBar(),
          body: BlocBuilder<MissionBloc, MissionState>(
            builder: (final context, final state) => switch (state) {
              MissionInitial() => const SizedBox(),
              MissionChargement() =>
                const Center(child: CircularProgressIndicator()),
              MissionSucces() => _Success(state.mission),
              MissionErreur() => const Center(child: Text('Erreur')),
            },
          ),
          backgroundColor: FnvColors.aidesFond,
        ),
      );
}

class _Success extends StatelessWidget {
  const _Success(this.mission);

  final Mission mission;

  @override
  Widget build(final BuildContext context) => ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: [
          _ImageEtTitre(mission),
          const SizedBox(height: DsfrSpacings.s4w),
          Stack(
            children: [
              const Positioned.fill(left: 16, child: VerticalDottedLine()),
              _Contenu(mission),
            ],
          ),
          const SafeArea(child: SizedBox()),
        ],
      );
}

class _ImageEtTitre extends StatelessWidget {
  const _ImageEtTitre(this.mission);

  final Mission mission;

  @override
  Widget build(final BuildContext context) {
    const size = 63.0;

    return Row(
      children: [
        ClipOval(
          child: Image.network(
            mission.imageUrl,
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: DsfrSpacings.s1w),
        Expanded(
          child: Text(
            mission.titre,
            style: const DsfrTextStyle(fontSize: 24),
          ),
        ),
      ],
    );
  }
}

class _Contenu extends StatelessWidget {
  const _Contenu(this.mission);

  final Mission mission;

  @override
  Widget build(final BuildContext context) => ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          if (mission.kycListe.isNotEmpty) ...[
            const _SousTitre(titre: Localisation.partieUne),
            const SizedBox(height: DsfrSpacings.s1w),
            ObjectifCard(
              id: mission.kycListe.first.id,
              leading: AssetsImages.chat,
              title: Localisation.quelquesQuestionPourMieuxVousConnaitre,
              points: mission.kycListe
                  .map((final e) => e.points)
                  .fold(0, (final a, final b) => a + b),
              estFait: mission.kycListe.first.estFait,
              estVerrouille: false,
              aEteReleve: mission.kycListe.first.aEteRecolte,
              onTap: () async => GoRouter.of(context).pushNamed(
                MissionKycPage.name,
                extra: mission.kycListe
                    .map((final e) => e.contentId.value)
                    .toList(),
              ),
            ),
            const SizedBox(height: DsfrSpacings.s7w),
          ],
          const _SousTitre(titre: Localisation.partieDeux),
          const SizedBox(height: DsfrSpacings.s1w),
          ...mission.quizListe
              .map(
                (final o) => ObjectifCard(
                  id: o.id,
                  leading: AssetsImages.newspaper,
                  title: o.titre,
                  points: o.points,
                  estFait: o.estFait,
                  estVerrouille: o.estVerrouille,
                  aEteReleve: o.aEteRecolte,
                  onTap: o.estFait
                      ? null
                      : () async => GoRouter.of(context).pushNamed(
                            QuizPage.name,
                            pathParameters: {'id': o.contentId.value},
                          ),
                ),
              )
              .separator(const SizedBox(height: DsfrSpacings.s2w)),
          const SizedBox(height: DsfrSpacings.s2w),
          ...mission.articles
              .map(
                (final o) => ObjectifCard(
                  id: o.id,
                  leading: AssetsImages.newspaper,
                  title: o.titre,
                  points: o.points,
                  estFait: o.estFait,
                  estVerrouille: o.estVerrouille,
                  aEteReleve: o.aEteRecolte,
                  onTap: () async => GoRouter.of(context).pushNamed(
                    ArticlePage.name,
                    pathParameters: {'id': o.contentId.value},
                  ),
                ),
              )
              .separator(const SizedBox(height: DsfrSpacings.s2w)),
          const SizedBox(height: DsfrSpacings.s7w),
          const _SousTitre(titre: Localisation.partieTrois),
          const SizedBox(height: DsfrSpacings.s1w),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: IntrinsicHeight(
              child: Row(
                children: mission.defis
                    .map(
                      (final o) => SizedBox(
                        width: 258,
                        child: DefiWidget(defi: o),
                      ),
                    )
                    .separator(const SizedBox(width: DsfrSpacings.s3w))
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: DsfrSpacings.s7w),
          const _SousTitre(titre: Localisation.partieQuatre),
          const SizedBox(height: DsfrSpacings.s1w),
          FnvCard(
            child: Padding(
              padding: const EdgeInsets.all(DsfrSpacings.s2w),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(DsfrSpacings.s1w),
                        ),
                        child: Image.network(
                          mission.imageUrl,
                          width: 120,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: DsfrSpacings.s2w),
                      Expanded(
                        child: Text(
                          mission.titre,
                          style: const DsfrTextStyle.headline4(),
                        ),
                      ),
                    ],
                  ),
                  if (mission.peutEtreTermine && !mission.estTermine) ...[
                    const SizedBox(height: DsfrSpacings.s1w),
                    DsfrButton(
                      label: Localisation.termineLaMission,
                      variant: DsfrButtonVariant.tertiary,
                      size: DsfrButtonSize.sm,
                      onPressed: () => context
                          .read<MissionBloc>()
                          .add(const MissionTerminerDemande()),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      );
}

class _SousTitre extends StatelessWidget {
  const _SousTitre({required this.titre});

  final String titre;

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: DsfrSpacings.s4w),
        child: Text(
          titre,
          style: const DsfrTextStyle.bodyXs(color: DsfrColors.blueFranceSun113),
        ),
      );
}
