import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/mission/challenges/presentation/bloc/mission_challenges_bloc.dart';
import 'package:app/features/mission/challenges/presentation/bloc/mission_challenges_event.dart';
import 'package:app/features/mission/challenges/presentation/bloc/mission_challenges_state.dart';
import 'package:app/features/mission/mission/domain/mission_code.dart';
import 'package:app/features/mission/mission/presentation/bloc/mission_bloc.dart';
import 'package:app/features/mission/mission/presentation/bloc/mission_event.dart';
import 'package:app/features/mission/mission/presentation/widgets/challenge_widget.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MissionChallengesPage extends StatelessWidget {
  const MissionChallengesPage({super.key, required this.code});

  final MissionCode code;

  @override
  Widget build(final context) => BlocProvider(
        create: (final context) =>
            MissionChallengesBloc(repository: context.read())
              ..add(MissionChallengesRefreshRequested(code)),
        child: _View(code: code),
      );
}

class _View extends StatelessWidget {
  const _View({required this.code});

  final MissionCode code;

  @override
  Widget build(final context) =>
      BlocBuilder<MissionChallengesBloc, MissionChallengesState>(
        builder: (final context, final state) => ListView(
          padding: const EdgeInsets.all(paddingVerticalPage),
          children: [
            MarkdownBody(
              data: Localisation.missionActionsTitle,
              styleSheet: MarkdownStyleSheet(
                p: const DsfrTextStyle.headline2(),
                strong: const DsfrTextStyle.headline2(
                  color: DsfrColors.blueFranceSun113,
                ),
              ),
            ),
            const SizedBox(height: DsfrSpacings.s1w),
            MarkdownBody(
              data: Localisation.missionActionsSubTitle,
              styleSheet: MarkdownStyleSheet(p: const DsfrTextStyle.bodyMd()),
            ),
            const SizedBox(height: DsfrSpacings.s3w),
            ...state.challenges.values
                .map(
                  (final e) => ChallengeWidget(
                    challenge: e,
                    onChanged: () {
                      context.read<MissionChallengesBloc>().add(
                            MissionChallengesRefreshRequested(code),
                          );
                    },
                  ),
                )
                .separator(const SizedBox(height: DsfrSpacings.s2w)),
            const SizedBox(height: DsfrSpacings.s3w),
            SafeArea(
              child: Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  child: DsfrButton(
                    label: Localisation.continuer,
                    variant: DsfrButtonVariant.primary,
                    size: DsfrButtonSize.lg,
                    onPressed: state.challenges.canBeCompleted
                        ? () => context
                            .read<MissionBloc>()
                            .add(const MissionCompleteRequested())
                        : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
