// ignore_for_file: avoid-unnecessary-type-assertions

import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/badge.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/features/actions/detail/presentation/pages/action_detail_page.dart';
import 'package:app/features/theme/core/domain/content_id.dart';
import 'package:app/features/theme/core/domain/mission_defi.dart';
import 'package:app/features/theme/presentation/bloc/mission_bloc.dart';
import 'package:app/features/theme/presentation/bloc/mission_event.dart';
import 'package:app/features/theme/presentation/widgets/objectif_card.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DefiWidget extends StatelessWidget {
  const DefiWidget({super.key, required this.defi});

  final MissionDefi defi;

  @override
  Widget build(final context) {
    if (defi.estVerrouille) {
      return ObjectifCard(
        id: const ObjectifId(''),
        leading: AssetsImages.target,
        title: '',
        points: 0,
        estFait: defi.estFait,
        estVerrouille: defi.estVerrouille,
        aEteReleve: false,
        onTap: () {},
      );
    }

    Future<Object?> onPressed() async => GoRouter.of(context).pushNamed(
          ActionDetailPage.name,
          pathParameters: {'id': defi.contentId.value},
        );

    switch (defi.status) {
      case MissionDefiStatus.toDo:
      case MissionDefiStatus.refused:
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            _DefiCard(
              title: defi.titre,
              button: DsfrButton(
                label: Localisation.allerALAction,
                variant: DsfrButtonVariant.primary,
                size: DsfrButtonSize.lg,
                onPressed: onPressed,
              ),
              borderColor: defi.isRecommended ? DsfrColors.info425 : null,
            ),
            if (defi.isRecommended)
              const FnvBadge(
                label: Localisation.recommande,
                backgroundColor: DsfrColors.info425,
              ),
          ],
        );
      case MissionDefiStatus.inProgress:
        const color = Color(0xFFDCEF64);

        return Stack(
          alignment: Alignment.topCenter,
          children: [
            _DefiCard(
              title: defi.titre,
              button: DsfrButton(
                label: Localisation.reprendreLaction,
                variant: DsfrButtonVariant.secondary,
                size: DsfrButtonSize.lg,
                onPressed: onPressed,
              ),
              borderColor: color,
            ),
            const FnvBadge(
              label: Localisation.enCours,
              backgroundColor: color,
              foregroundColor: DsfrColors.grey50,
            ),
          ],
        );
      case MissionDefiStatus.abandonned:
      case MissionDefiStatus.alreadyDone:
      case MissionDefiStatus.done:
        const success425 = DsfrColors.success425;

        final isPointsCollected =
            defi.aEteRecolte || defi.status != MissionDefiStatus.done;

        return Stack(
          alignment: Alignment.topCenter,
          children: [
            _DefiCard(
              title: defi.titre,
              button: DsfrRawButton(
                variant: DsfrButtonVariant.secondary,
                size: DsfrButtonSize.lg,
                onTap: isPointsCollected
                    ? null
                    : () => context
                        .read<MissionBloc>()
                        .add(MissionGagnerPointsDemande(defi.id)),
                child: Text.rich(
                  TextSpan(
                    text: Localisation.recolterVosPoints(defi.points),
                    children: [
                      const WidgetSpan(
                        child: SizedBox(width: DsfrSpacings.s1v),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(
                          DsfrIcons.othersLeafFill,
                          color: isPointsCollected
                              ? DsfrColors.grey625
                              : const Color(0xFF3CD277),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              borderColor: success425,
            ),
            const FnvBadge(
              label: Localisation.termine2,
              backgroundColor: success425,
            ),
          ],
        );
    }
  }
}

class _DefiCard extends StatelessWidget {
  const _DefiCard({
    required this.title,
    required this.button,
    this.borderColor,
  });

  final String title;
  final Widget button;
  final Color? borderColor;

  @override
  Widget build(final context) => Padding(
        padding: const EdgeInsets.only(top: 14),
        child: FnvCard(
          borderColor: borderColor,
          child: Padding(
            padding: const EdgeInsets.all(DsfrSpacings.s3w),
            child: Column(
              children: [
                Expanded(
                  child: Text(title, style: const DsfrTextStyle.bodyLg()),
                ),
                const SizedBox(height: DsfrSpacings.s3w),
                button,
              ],
            ),
          ),
        ),
      );
}
