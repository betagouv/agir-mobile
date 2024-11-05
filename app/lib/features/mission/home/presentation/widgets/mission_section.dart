import 'package:app/core/presentation/widgets/composants/fnv_image.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/accueil/presentation/widgets/title_section.dart';
import 'package:app/features/mission/home/presentation/bloc/mission_home_bloc.dart';
import 'package:app/features/mission/home/presentation/bloc/mission_home_event.dart';
import 'package:app/features/mission/home/presentation/bloc/mission_home_state.dart';
import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:app/features/theme/presentation/pages/mission_page.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MissionSection extends StatelessWidget {
  const MissionSection({super.key});

  @override
  Widget build(final context) {
    context.read<MissionHomeBloc>().add(const MissionHomeFetch());

    return Builder(
      builder: (final context) =>
          BlocBuilder<MissionHomeBloc, MissionHomeState>(
        builder: (final context, final state) => switch (state) {
          MissionHomeInitial() => const SizedBox.shrink(),
          MissionHomeLoadSuccess() => _Section(state),
        },
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section(this.data);

  final MissionHomeLoadSuccess data;

  @override
  Widget build(final context) => Column(
        children: [
          const TitleSection(
            title: TextSpan(
              children: [
                TextSpan(text: 'Recommandés'),
                TextSpan(text: ' '),
                TextSpan(
                  text: 'pour vous',
                  style: DsfrTextStyle.headline5(
                    color: DsfrColors.blueFranceSun113,
                  ),
                ),
              ],
            ),
            subTitle:
                'Des solutions **adaptées à votre situation** et les clés pour comprendre',
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            clipBehavior: Clip.none,
            child: IntrinsicHeight(
              child: Row(
                children: data.missions
                    .map(_Mission.new)
                    .separator(const SizedBox(width: DsfrSpacings.s2w))
                    .toList(),
              ),
            ),
          ),
        ],
      );
}

class _Mission extends StatelessWidget {
  const _Mission(this.mission);

  final MissionListe mission;

  @override
  Widget build(final context) {
    const width = 150.0;
    const color = DsfrColors.blueFranceSun113;
    const success = DsfrColors.success425;
    final progression = mission.progression / mission.progressionCible;

    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: GestureDetector(
        onTap: () async => GoRouter.of(context).pushNamed(
          MissionPage.name,
          pathParameters: {'id': mission.id},
        ),
        child: DecoratedBox(
          decoration: const ShapeDecoration(
            color: Colors.white,
            shadows: recommandationOmbre,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1w)),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: DsfrSpacings.s1w,
              top: DsfrSpacings.s1w,
              right: DsfrSpacings.s1w,
              bottom: DsfrSpacings.s3v,
            ),
            child: SizedBox(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(DsfrSpacings.s1w),
                    ),
                    child: FnvImage.network(
                      mission.imageUrl,
                      width: width,
                      height: 124,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: DsfrSpacings.s2w),
                  DsfrTag.sm(
                    label: TextSpan(text: mission.themeType.displayName),
                    backgroundColor: mission.themeType.backgroundColor,
                    foregroundColor: mission.themeType.foregroundColor,
                  ),
                  const SizedBox(height: DsfrSpacings.s1v),
                  Expanded(
                    child: Text(
                      mission.titre,
                      style: const DsfrTextStyle.bodyLg(),
                    ),
                  ),
                  const SizedBox(height: DsfrSpacings.s1w),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
