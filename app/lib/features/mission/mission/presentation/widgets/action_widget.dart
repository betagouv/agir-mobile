import 'package:app/core/presentation/widgets/composants/badge.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/features/actions/detail/presentation/pages/action_detail_page.dart';
import 'package:app/features/mission/actions/domain/mission_action.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActionWidget extends StatelessWidget {
  const ActionWidget({
    super.key,
    required this.action,
    required this.onChanged,
  });

  final MissionAction action;
  final VoidCallback onChanged;

  @override
  Widget build(final context) {
    Future<void> onPressed() async {
      final result = await GoRouter.of(context).pushNamed<bool>(
        ActionDetailPage.name,
        pathParameters: {'id': action.contentId.value},
      );

      if (result ?? false) {
        onChanged();
      }
    }

    switch (action.status) {
      case MissionActionStatus.toDo:
      case MissionActionStatus.refused:
        return Stack(
          alignment: Alignment.topLeft,
          children: [
            _ActionCard(
              title: action.title,
              button: DsfrButton(
                label: Localisation.allerALAction,
                variant: DsfrButtonVariant.primary,
                size: DsfrButtonSize.lg,
                onPressed: onPressed,
              ),
              borderColor: action.isRecommended ? DsfrColors.info425 : null,
            ),
            if (action.isRecommended)
              const _Badge(
                label: Localisation.recommande,
                backgroundColor: DsfrColors.info425,
              ),
          ],
        );
      case MissionActionStatus.inProgress:
        const color = Color(0xFFDCEF64);

        return Stack(
          alignment: Alignment.topLeft,
          children: [
            _ActionCard(
              title: action.title,
              button: DsfrButton(
                label: Localisation.reprendreLaction,
                variant: DsfrButtonVariant.secondary,
                size: DsfrButtonSize.lg,
                onPressed: onPressed,
              ),
              borderColor: color,
            ),
            const _Badge(
              label: Localisation.enCours,
              backgroundColor: color,
              foregroundColor: DsfrColors.grey50,
            ),
          ],
        );
      case MissionActionStatus.abandonned:
      case MissionActionStatus.alreadyDone:
      case MissionActionStatus.done:
        const success425 = DsfrColors.success425;

        return Stack(
          alignment: Alignment.topLeft,
          children: [
            _ActionCard(title: action.title, borderColor: success425),
            const _Badge(
              label: Localisation.termine2,
              backgroundColor: success425,
            ),
          ],
        );
    }
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.label,
    required this.backgroundColor,
    this.foregroundColor = Colors.white,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(final context) => Padding(
        padding: const EdgeInsets.only(left: DsfrSpacings.s3v),
        child: FnvBadge(
          label: label,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
        ),
      );
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.title, this.button, this.borderColor});

  final String title;
  final Widget? button;
  final Color? borderColor;

  @override
  Widget build(final context) => Padding(
        padding: const EdgeInsets.only(top: 14),
        child: FnvCard(
          borderColor: borderColor,
          child: Padding(
            padding: const EdgeInsets.all(DsfrSpacings.s2w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(title, style: const DsfrTextStyle.bodyLg()),
                if (button != null) ...[
                  const SizedBox(height: DsfrSpacings.s2w),
                  button!,
                ],
              ],
            ),
          ),
        ),
      );
}
