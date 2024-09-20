import 'package:app/features/recommandations/presentation/widgets/mes_recommandations.dart';
import 'package:app/features/univers/domain/mission_liste.dart';
import 'package:app/features/univers/domain/tuile_univers.dart';
import 'package:app/features/univers/domain/value_objects/service_item.dart';
import 'package:app/features/univers/presentation/blocs/univers_bloc.dart';
import 'package:app/features/univers/presentation/blocs/univers_event.dart';
import 'package:app/features/univers/presentation/pages/mission_page.dart';
import 'package:app/features/univers/presentation/widgets/univers_card.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/app_bar.dart';
import 'package:app/shared/widgets/composants/badge.dart';
import 'package:app/shared/widgets/fondamentaux/colors.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

final universRouteObserver = RouteObserver<ModalRoute<dynamic>>();

class UniversPage extends StatelessWidget {
  const UniversPage({super.key, required this.univers});

  static const name = 'univers';
  static const path = name;

  final TuileUnivers univers;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) =>
            UniversPage(univers: state.extra! as TuileUnivers),
      );

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => UniversBloc(
          univers: univers,
          universPort: context.read(),
        ),
        child: _Page(univers),
      );
}

class _Page extends StatefulWidget {
  const _Page(this.univers);

  final TuileUnivers univers;

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> with RouteAware {
  void _handleMission() {
    context
        .read<UniversBloc>()
        .add(UniversRecuperationDemandee(widget.univers.type));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    universRouteObserver.subscribe(this, ModalRoute.of(context)!);
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
  Widget build(final BuildContext context) => const Scaffold(
        appBar: FnvAppBar(),
        body: _View(),
        backgroundColor: FnvColors.aidesFond,
      );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: const [
          _ImageEtTitre(),
          SizedBox(height: DsfrSpacings.s5w),
          _Thematiques(),
          SizedBox(height: DsfrSpacings.s5w),
          _Services(),
          SizedBox(height: DsfrSpacings.s5w),
          _Recommandations(),
        ],
      );
}

class _ImageEtTitre extends StatelessWidget {
  const _ImageEtTitre();

  @override
  Widget build(final BuildContext context) {
    final univers = context
        .select<UniversBloc, TuileUnivers>((final bloc) => bloc.state.univers);

    const size = 80.0;

    return Column(
      children: [
        ClipOval(
          child: Image.network(
            univers.imageUrl,
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: DsfrSpacings.s1w),
        Text(univers.titre, style: const DsfrTextStyle.headline2()),
      ],
    );
  }
}

class _Thematiques extends StatelessWidget {
  const _Thematiques();

  @override
  Widget build(final BuildContext context) {
    final thematiques = context.select<UniversBloc, List<MissionListe>>(
      (final bloc) => bloc.state.thematiques,
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: IntrinsicHeight(
        child: Row(
          children: thematiques
              .map((final e) => _Thematique(mission: e))
              .separator(const SizedBox(width: DsfrSpacings.s2w))
              .toList(),
        ),
      ),
    );
  }
}

class _Thematique extends StatelessWidget {
  const _Thematique({required this.mission});

  final MissionListe mission;

  @override
  Widget build(final BuildContext context) {
    const width = 160.0;
    const color = DsfrColors.blueFranceSun113;
    const success = DsfrColors.success425;
    final progression = mission.progression / mission.progressionCible;

    return UniversCard(
      badge: mission.estNouvelle
          ? const FnvBadge(
              label: Localisation.nouveau,
              backgroundColor: DsfrColors.info425,
            )
          : progression == 1
              ? const FnvBadge(
                  label: Localisation.termine,
                  backgroundColor: success,
                )
              : null,
      onTap: () async => GoRouter.of(context).pushNamed(
        MissionPage.name,
        pathParameters: {'id': mission.id},
      ),
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(DsfrSpacings.s1v),
              ),
              child: Image.network(
                mission.imageUrl,
                width: width,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: DsfrSpacings.s3v),
            LinearProgressIndicator(
              value: progression,
              backgroundColor: const Color(0xFFDDDDFF),
              color: progression == 1 ? success : color,
              minHeight: 7,
              semanticsLabel:
                  '${mission.progression}/${mission.progressionCible} terminée',
              borderRadius: const BorderRadius.all(
                Radius.circular(DsfrSpacings.s1v),
              ),
            ),
            const SizedBox(height: DsfrSpacings.s1w),
            if (mission.niveau != null) ...[
              Text(
                Localisation.niveau(mission.niveau!),
                style: const DsfrTextStyle.bodyXs(color: color),
              ),
              const SizedBox(height: DsfrSpacings.s1v),
            ],
            Text(
              mission.titre,
              style: const DsfrTextStyle.bodyLg(lineHeight: 22),
            ),
          ],
        ),
      ),
    );
  }
}

class _Services extends StatelessWidget {
  const _Services();

  @override
  Widget build(final BuildContext context) {
    final services = context.select<UniversBloc, List<ServiceItem>>(
      (final bloc) => bloc.state.services,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Localisation.mesServices,
          style: DsfrTextStyle.headline5(),
        ),
        const SizedBox(height: DsfrSpacings.s2w),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: IntrinsicHeight(
            child: Row(
              children: services
                  .map(_Service.new)
                  .separator(const SizedBox(width: DsfrSpacings.s2w))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _Service extends StatelessWidget {
  const _Service(this.service);

  final ServiceItem service;

  @override
  Widget build(final BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(DsfrSpacings.s1w));

    return DecoratedBox(
      decoration: const ShapeDecoration(
        color: Color(0xFFEEF2FF),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFFB1B1FF)),
          borderRadius: borderRadius,
        ),
      ),
      child: Material(
        color: FnvColors.transparent,
        child: InkWell(
          onTap: () async => launchUrlString(service.externalUrl),
          borderRadius: borderRadius,
          child: SizedBox(
            width: 156,
            child: Padding(
              padding: const EdgeInsets.all(DsfrSpacings.s1w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.titre,
                    style: const DsfrTextStyle.bodyMdMedium(
                      color: DsfrColors.blueFranceSun113,
                    ),
                  ),
                  const SizedBox(height: DsfrSpacings.s1w),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          service.sousTitre,
                          style: const DsfrTextStyle.bodySmMedium(
                            color: DsfrColors.blueFranceSun113,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(
                        DsfrIcons.systemExternalLinkLine,
                        size: 20,
                        color: DsfrColors.blueFranceSun113,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Recommandations extends StatelessWidget {
  const _Recommandations();

  @override
  Widget build(final BuildContext context) {
    final univers = context
        .select<UniversBloc, TuileUnivers>((final bloc) => bloc.state.univers);

    return MesRecommandations(thematique: univers.type);
  }
}
