import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/home/presentation/widgets/title_section.dart';
import 'package:app/features/mission/home/presentation/bloc/mission_home_bloc.dart';
import 'package:app/features/mission/home/presentation/bloc/mission_home_event.dart';
import 'package:app/features/mission/home/presentation/bloc/mission_home_state.dart';
import 'package:app/features/mission/mission/presentation/pages/mission_page.dart';
import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:app/features/theme/presentation/widgets/theme_type_tag.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MissionSection extends StatelessWidget {
  const MissionSection({super.key});

  @override
  Widget build(final context) {
    context.read<MissionHomeBloc>().add(const MissionHomeFetch());

    return BlocBuilder<MissionHomeBloc, MissionHomeState>(
      builder:
          (final context, final state) => switch (state) {
            MissionHomeInitial() => const SizedBox.shrink(),
            MissionHomeLoadSuccess() => _Section(state),
          },
    );
  }
}

class _Section extends StatelessWidget {
  const _Section(this.data);

  final MissionHomeLoadSuccess data;

  @override
  Widget build(final context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s2w,
    children: [
      const TitleSection(title: Localisation.missionTitle, subTitle: Localisation.missionSubTitle),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.none,
        child: IntrinsicHeight(child: Row(spacing: DsfrSpacings.s2w, children: data.missions.map(_Mission.new).toList())),
      ),
    ],
  );
}

class _Mission extends StatefulWidget {
  const _Mission(this.mission);

  final MissionListe mission;

  @override
  State<_Mission> createState() => _MissionState();
}

class _MissionState extends State<_Mission> with MaterialStateMixin<_Mission> {
  @override
  Widget build(final context) {
    const width = 150.0;
    const color = DsfrColors.blueFranceSun113;
    const success = DsfrColors.success425;
    final missionProgression = widget.mission.progression;
    final missionProgressionCible = widget.mission.progressionCible;
    final progression = missionProgression / missionProgressionCible;

    const borderRadius = BorderRadius.all(Radius.circular(DsfrSpacings.s1w));

    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: DsfrFocusWidget(
        isFocused: isFocused,
        borderRadius: borderRadius,
        child: DecoratedBox(
          decoration: const ShapeDecoration(
            color: Colors.white,
            shadows: recommandationOmbre,
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
          ),
          child: Material(
            color: FnvColors.transparent,
            child: InkWell(
              onTap: () async {
                await GoRouter.of(context).pushNamed(
                  MissionPage.name,
                  pathParameters: {'mission': widget.mission.code, 'thematique': widget.mission.themeType.routeCode},
                );
                if (context.mounted) {
                  context.read<MissionHomeBloc>().add(const MissionHomeFetch());
                }
              },
              onHighlightChanged: updateMaterialState(WidgetState.pressed),
              onHover: updateMaterialState(WidgetState.hovered),
              focusColor: FnvColors.transparent,
              borderRadius: borderRadius,
              onFocusChange: updateMaterialState(WidgetState.focused),
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
                        borderRadius: const BorderRadius.all(Radius.circular(DsfrSpacings.s1w)),
                        child: FnvImage.network(widget.mission.imageUrl, width: width, height: 124, fit: BoxFit.cover),
                      ),
                      const SizedBox(height: DsfrSpacings.s2w),
                      ThemeTypeTag(themeType: widget.mission.themeType),
                      const SizedBox(height: DsfrSpacings.s1v),
                      Expanded(child: Text(widget.mission.titre, style: const DsfrTextStyle.bodyLg())),
                      const SizedBox(height: DsfrSpacings.s1w),
                      LinearProgressIndicator(
                        value: progression,
                        backgroundColor: const Color(0xFFDDDDFF),
                        color: progression == 1 ? success : color,
                        minHeight: 7,
                        semanticsLabel: '$missionProgression/$missionProgressionCible terminée',
                        borderRadius: const BorderRadius.all(Radius.circular(DsfrSpacings.s1v)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
