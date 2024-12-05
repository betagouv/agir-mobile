import 'package:app/core/assets/svgs.dart';
import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/core/presentation/widgets/composants/badge.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/mission/mission/presentation/pages/mission_page.dart';
import 'package:app/features/recommandations/presentation/widgets/mes_recommandations.dart';
import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:app/features/theme/core/domain/service_item.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:app/features/theme/presentation/bloc/theme_event.dart';
import 'package:app/features/theme/presentation/widgets/theme_card.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

final themeRouteObserver = RouteObserver<ModalRoute<dynamic>>();

class ThemePage extends StatelessWidget {
  const ThemePage({super.key, required this.type});

  final String type;

  @override
  Widget build(final context) => BlocProvider(
        create: (final context) => ThemeBloc(themePort: context.read()),
        child: _Page(type),
      );
}

class _Page extends StatefulWidget {
  const _Page(this.type);

  final String type;

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> with RouteAware {
  void _handleMission() {
    if (mounted) {
      context.read<ThemeBloc>().add(UniversRecuperationDemandee(widget.type));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeRouteObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() => _handleMission();

  @override
  void didPush() => _handleMission();

  @override
  void dispose() {
    themeRouteObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(final context) => const _View();
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final context) => ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: const [
          _ImageEtTitre(),
          SizedBox(height: DsfrSpacings.s5w),
          _Missions(),
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
  Widget build(final context) {
    final themeType = context
        .select<ThemeBloc, ThemeType>((final bloc) => bloc.state.themeType);

    return Column(
      children: [
        ClipOval(
          child: SizedBox.square(
            dimension: 80,
            child: SvgPicture.asset(
              switch (themeType) {
                ThemeType.alimentation => AssetsSvgs.alimentation,
                ThemeType.transport => AssetsSvgs.transport,
                ThemeType.logement => AssetsSvgs.logement,
                ThemeType.consommation => AssetsSvgs.consommation,
                ThemeType.decouverte => throw UnimplementedError(),
              },
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              placeholderBuilder: (final context) =>
                  const SizedBox.square(dimension: 80),
            ),
          ),
        ),
        const SizedBox(height: DsfrSpacings.s1w),
        Text(
          themeType.displayNameWithoutEmoji,
          style: const DsfrTextStyle.headline2(),
        ),
      ],
    );
  }
}

class _Missions extends StatelessWidget {
  const _Missions();

  @override
  Widget build(final context) {
    final thematiques = context.select<ThemeBloc, List<MissionListe>>(
      (final bloc) => bloc.state.missions,
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: IntrinsicHeight(
        child: Row(
          children: thematiques
              .map((final e) => _Mission(mission: e))
              .separator(const SizedBox(width: DsfrSpacings.s2w))
              .toList(),
        ),
      ),
    );
  }
}

class _Mission extends StatelessWidget {
  const _Mission({required this.mission});

  final MissionListe mission;

  @override
  Widget build(final context) {
    const width = 160.0;
    const color = DsfrColors.blueFranceSun113;
    const success = DsfrColors.success425;
    final progression = mission.progression / mission.progressionCible;

    return ThemeCard(
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
        pathParameters: {
          'mission': mission.code,
          'thematique': mission.themeType.name,
        },
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
              child: FnvImage.network(
                mission.imageUrl,
                width: width,
                height: 130,
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
            Text(mission.titre, style: const DsfrTextStyle.bodyLg()),
          ],
        ),
      ),
    );
  }
}

class _Services extends StatelessWidget {
  const _Services();

  @override
  Widget build(final context) {
    final services = context.select<ThemeBloc, List<ServiceItem>>(
      (final bloc) => bloc.state.services,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Localisation.mesServices,
          style: DsfrTextStyle.headline4(),
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
  Widget build(final context) {
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
          onTap: () async => FnvUrlLauncher.launch(service.externalUrl),
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
  Widget build(final context) {
    final type = context.select<ThemeBloc, ThemeType>(
      (final bloc) => bloc.state.themeType,
    );

    return MesRecommandations(theme: type);
  }
}
