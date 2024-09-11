// ignore_for_file: avoid-unnecessary-type-assertions

import 'package:app/features/articles/presentation/pages/article_page.dart';
import 'package:app/features/quiz/presentation/pages/quiz_page.dart';
import 'package:app/features/univers/domain/aggregates/mission.dart';
import 'package:app/features/univers/domain/value_objects/content_id.dart';
import 'package:app/features/univers/presentation/blocs/mission_bloc.dart';
import 'package:app/features/univers/presentation/blocs/mission_event.dart';
import 'package:app/features/univers/presentation/blocs/mission_state.dart';
import 'package:app/features/univers/presentation/pages/defi_page.dart';
import 'package:app/features/univers/presentation/pages/mission_kyc_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/assets/images.dart';
import 'package:app/shared/widgets/composants/app_bar.dart';
import 'package:app/shared/widgets/composants/card.dart';
import 'package:app/shared/widgets/fondamentaux/colors.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
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
        child: const Scaffold(
          appBar: FnvAppBar(),
          body: _View(),
          backgroundColor: FnvColors.aidesFond,
        ),
      );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<MissionBloc, MissionState>(
        builder: (final context, final state) => switch (state) {
          MissionInitial() => const SizedBox(),
          MissionChargement() =>
            const Center(child: CircularProgressIndicator()),
          MissionSucces() => _Succes(state.mission),
          MissionErreur() => const Center(child: Text('Erreur')),
        },
      );
}

class _Succes extends StatelessWidget {
  const _Succes(this.mission);

  final Mission mission;

  @override
  Widget build(final BuildContext context) => ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: [
          _ImageEtTitre(mission),
          const SizedBox(height: DsfrSpacings.s4w),
          Stack(
            children: [
              const Positioned.fill(left: 16, child: _VerticalDottedLine()),
              _Contenu(mission),
            ],
          ),
          const SafeArea(child: SizedBox()),
        ],
      );
}

class _VerticalDottedLine extends StatelessWidget {
  const _VerticalDottedLine();

  @override
  Widget build(final BuildContext context) => const CustomPaint(
        painter: _DottedLinePainter(),
      );
}

class _DottedLinePainter extends CustomPainter {
  const _DottedLinePainter();

  @override
  void paint(final Canvas canvas, final Size size) {
    final paint = Paint()
      ..color = const Color(0xFFBABABA)
      ..strokeWidth = 2;

    const dashHeight = 4;
    const dashSpace = 4;
    var startY = 0.0;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(final CustomPainter oldDelegate) => false;
}

class _Contenu extends StatelessWidget {
  const _Contenu(this.mission);

  final Mission mission;

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (mission.kycListe.isNotEmpty) ...[
            const _SousTitre(titre: Localisation.partieUne),
            const SizedBox(height: DsfrSpacings.s1w),
            _ObjectifRaw(
              leading: AssetsImages.chat,
              title: Localisation.quelquesQuestionPourMieuxVousConnaitre,
              points: mission.kycListe
                  .map((final e) => e.points)
                  .fold(0, (final a, final b) => a + b),
              estFait: mission.kycListe.first.estFait,
              estVerrouille: false,
              id: mission.kycListe.first.id,
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
                (final o) => _ObjectifRaw(
                  leading: AssetsImages.newspaper,
                  title: o.titre,
                  points: o.points,
                  estFait: o.estFait,
                  estVerrouille: o.estVerrouille,
                  id: o.id,
                  aEteReleve: o.aEteRecolte,
                  onTap: () async => GoRouter.of(context).pushNamed(
                    QuizPage.name,
                    pathParameters: {'id': o.contentId.value},
                  ),
                ),
              )
              .separator(const SizedBox(height: DsfrSpacings.s2w)),
          const SizedBox(height: DsfrSpacings.s2w),
          ...mission.articles
              .map(
                (final o) => _ObjectifRaw(
                  leading: AssetsImages.newspaper,
                  title: o.titre,
                  points: o.points,
                  estFait: o.estFait,
                  estVerrouille: o.estVerrouille,
                  id: o.id,
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
          ...mission.defis
              .map(
                (final o) => _ObjectifRaw(
                  leading: AssetsImages.target,
                  title: o.titre,
                  points: o.points,
                  estFait: o.estFait,
                  estVerrouille: o.estVerrouille,
                  id: o.id,
                  aEteReleve: o.aEteRecolte,
                  onTap: o.estFait
                      ? null
                      : () async => GoRouter.of(context).pushNamed(
                            DefiPage.name,
                            pathParameters: {'id': o.contentId.value},
                          ),
                ),
              )
              .separator(const SizedBox(height: DsfrSpacings.s2w)),
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
            style: const DsfrTextStyle(fontSize: 24, lineHeight: 28),
          ),
        ),
      ],
    );
  }
}

class _ObjectifRaw extends StatelessWidget {
  const _ObjectifRaw({
    required this.leading,
    required this.title,
    required this.points,
    required this.estFait,
    required this.estVerrouille,
    required this.id,
    required this.aEteReleve,
    required this.onTap,
  });

  final String leading;
  final String title;
  final int points;
  final bool estFait;
  final bool estVerrouille;
  final ObjectifId id;
  final bool aEteReleve;
  final GestureTapCallback? onTap;

  @override
  Widget build(final BuildContext context) {
    const success425 = DsfrColors.success425;

    return FnvCard(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: DsfrSpacings.s2w,
          horizontal: DsfrSpacings.s3v,
        ),
        child: Row(
          children: [
            if (estFait)
              const Icon(
                DsfrIcons.systemCheckboxCircleLine,
                color: success425,
              )
            else
              Image.asset(leading, width: 18, height: 18),
            const SizedBox(width: DsfrSpacings.s1w),
            Expanded(
              child: Text(
                estVerrouille ? Localisation.aDecouvrir : title,
                style: const DsfrTextStyle.bodySm(),
              ),
            ),
            const SizedBox(width: DsfrSpacings.s1v),
            if (estFait)
              DsfrRawButton(
                variant: DsfrButtonVariant.tertiary,
                size: DsfrButtonSize.sm,
                onTap: aEteReleve
                    ? null
                    : () => context
                        .read<MissionBloc>()
                        .add(MissionGagnerPointsDemande(id)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$points'),
                    const SizedBox(width: DsfrSpacings.s1v),
                    const Icon(
                      DsfrIcons.othersLeafFill,
                      size: DsfrSpacings.s2w,
                      color: Color(0xFF3CD277),
                    ),
                  ],
                ),
              ),
            const SizedBox(width: DsfrSpacings.s1v),
            if (estVerrouille)
              const Icon(DsfrIcons.systemLockLine)
            else if (!estFait)
              const Icon(
                DsfrIcons.systemArrowRightLine,
                color: DsfrColors.blueFranceSun113,
              ),
          ],
        ),
      ),
    );
  }
}
