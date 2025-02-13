import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/svg.dart';
import 'package:app/core/presentation/widgets/composants/badge.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/challenges/section/presentation/widgets/challenges_section.dart';
import 'package:app/features/mission/mission/presentation/pages/mission_page.dart';
import 'package:app/features/recommandations/presentation/widgets/mes_recommandations.dart';
import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:app/features/theme/core/domain/service_item.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:app/features/theme/presentation/bloc/theme_event.dart';
import 'package:app/features/theme/presentation/widgets/service_card.dart';
import 'package:app/features/theme/presentation/widgets/theme_card.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final themeRouteObserver = RouteObserver<ModalRoute<dynamic>>();

class ThemePage extends StatelessWidget {
  const ThemePage({super.key, required this.themeType});

  final ThemeType themeType;

  @override
  Widget build(final context) =>
      BlocProvider(create: (final context) => ThemeBloc(themeRepository: context.read()), child: _Page(themeType));
}

class _Page extends StatefulWidget {
  const _Page(this.themeType);

  final ThemeType themeType;

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> with RouteAware {
  void _handleMission() {
    if (mounted) {
      context.read<ThemeBloc>().add(ThemeRecuperationDemandee(widget.themeType));
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
  Widget build(final context) => _View(widget.themeType);
}

class _View extends StatelessWidget {
  const _View(this.themeType);

  final ThemeType themeType;

  @override
  Widget build(final context) => ListView(
    padding: const EdgeInsets.all(paddingVerticalPage),
    children: [
      const _ImageEtTitre(),
      const SizedBox(height: DsfrSpacings.s5w),
      const _Missions(),
      const SizedBox(height: DsfrSpacings.s5w),
      ChallengesSection(themeType: themeType),
      const SizedBox(height: DsfrSpacings.s5w),
      const _Services(),
      const SizedBox(height: DsfrSpacings.s5w),
      const SafeArea(child: _Recommandations()),
    ],
  );
}

class _ImageEtTitre extends StatelessWidget {
  const _ImageEtTitre();

  @override
  Widget build(final context) {
    final themeType = context.select<ThemeBloc, ThemeType>((final bloc) => bloc.state.themeType);

    return Column(
      spacing: DsfrSpacings.s1w,
      children: [
        ClipOval(
          child: SizedBox.square(
            dimension: 80,
            child: FnvSvg.asset(
              switch (themeType) {
                ThemeType.alimentation => AssetImages.alimentation,
                ThemeType.transport => AssetImages.transport,
                ThemeType.logement => AssetImages.logement,
                ThemeType.consommation => AssetImages.consommation,
                ThemeType.decouverte => throw UnimplementedError(),
              },
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(themeType.displayNameWithoutEmoji, style: const DsfrTextStyle.headline2()),
      ],
    );
  }
}

class _Missions extends StatelessWidget {
  const _Missions();

  @override
  Widget build(final context) {
    final thematiques = context.select<ThemeBloc, List<MissionListe>>((final bloc) => bloc.state.missions);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: IntrinsicHeight(
        child: Row(spacing: DsfrSpacings.s2w, children: thematiques.map((final e) => _Mission(mission: e)).toList()),
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
      badge:
          mission.estNouvelle
              ? const FnvBadge(label: Localisation.nouveau, backgroundColor: DsfrColors.info425)
              : progression == 1
              ? const FnvBadge(label: Localisation.termine, backgroundColor: success)
              : null,
      onTap:
          () async => GoRouter.of(
            context,
          ).pushNamed(MissionPage.name, pathParameters: {'mission': mission.code, 'thematique': mission.themeType.routeCode}),
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(DsfrSpacings.s1v)),
              child: FnvImage.network(mission.imageUrl, width: width, height: 130, fit: BoxFit.cover),
            ),
            const SizedBox(height: DsfrSpacings.s3v),
            LinearProgressIndicator(
              value: progression,
              backgroundColor: const Color(0xFFDDDDFF),
              color: progression == 1 ? success : color,
              minHeight: 7,
              semanticsLabel: '${mission.progression}/${mission.progressionCible} terminée',
              borderRadius: const BorderRadius.all(Radius.circular(DsfrSpacings.s1v)),
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
    final services = context.select<ThemeBloc, List<ServiceItem>>((final bloc) => bloc.state.services);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s2w,
      children: [
        const Text(Localisation.mesServices, style: DsfrTextStyle.headline4()),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: IntrinsicHeight(
            child: Row(spacing: DsfrSpacings.s2w, children: services.map((final e) => ServiceCard(service: e)).toList()),
          ),
        ),
      ],
    );
  }
}

class _Recommandations extends StatelessWidget {
  const _Recommandations();

  @override
  Widget build(final context) {
    final type = context.select<ThemeBloc, ThemeType>((final bloc) => bloc.state.themeType);

    return MesRecommandations(theme: type);
  }
}
