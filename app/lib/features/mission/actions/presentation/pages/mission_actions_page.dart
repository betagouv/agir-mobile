import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/mission/actions/presentation/bloc/mission_actions_bloc.dart';
import 'package:app/features/mission/actions/presentation/bloc/mission_actions_event.dart';
import 'package:app/features/mission/actions/presentation/bloc/mission_actions_state.dart';
import 'package:app/features/mission/mission/domain/mission_code.dart';
import 'package:app/features/mission/mission/presentation/bloc/mission_bloc.dart';
import 'package:app/features/mission/mission/presentation/bloc/mission_event.dart';
import 'package:app/features/mission/mission/presentation/widgets/action_widget.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MissionActionsPage extends StatelessWidget {
  const MissionActionsPage({super.key, required this.code});

  final MissionCode code;

  @override
  Widget build(final context) => BlocProvider(
        create: (final context) =>
            MissionActionsBloc(missionActionsRepository: context.read())
              ..add(MissionActionRefreshRequested(code)),
        child: _View(code: code),
      );
}

class _View extends StatelessWidget {
  const _View({required this.code});

  final MissionCode code;

  @override
  Widget build(final context) =>
      BlocBuilder<MissionActionsBloc, MissionActionsState>(
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
            ...state.actions.values
                .map(
                  (final e) => ActionWidget(
                    action: e,
                    onChanged: () {
                      context.read<MissionActionsBloc>().add(
                            MissionActionRefreshRequested(code),
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
                    onPressed: state.actions.canBeCompleted
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
