import 'package:app/features/univers/domain/value_objects/content_id.dart';
import 'package:app/features/univers/presentation/blocs/mission_bloc.dart';
import 'package:app/features/univers/presentation/blocs/mission_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/card.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ObjectifCard extends StatelessWidget {
  const ObjectifCard({
    super.key,
    required this.id,
    required this.leading,
    required this.title,
    required this.points,
    required this.estFait,
    required this.estVerrouille,
    required this.aEteReleve,
    required this.onTap,
  });

  final ObjectifId id;
  final String leading;
  final String title;
  final int points;
  final bool estFait;
  final bool estVerrouille;
  final bool aEteReleve;
  final GestureTapCallback? onTap;

  @override
  Widget build(final BuildContext context) => FnvCard(
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
                  color: DsfrColors.success425,
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
              const SizedBox(width: DsfrSpacings.s1w),
              _TrailingIcon(
                estVerrouille: estVerrouille,
                estFait: estFait,
                id: id,
                aEteReleve: aEteReleve,
                points: points,
              ),
            ],
          ),
        ),
      );
}

class _TrailingIcon extends StatelessWidget {
  const _TrailingIcon({
    required this.estVerrouille,
    required this.estFait,
    required this.id,
    required this.aEteReleve,
    required this.points,
  });

  final bool estVerrouille;
  final bool estFait;
  final ObjectifId id;
  final bool aEteReleve;
  final int points;

  @override
  Widget build(final BuildContext context) {
    if (estVerrouille) {
      return const Icon(DsfrIcons.systemLockLine);
    } else if (!estFait) {
      return const Icon(
        DsfrIcons.systemArrowRightLine,
        color: DsfrColors.blueFranceSun113,
      );
    }

    return _PointsButton(id: id, points: points, aEteReleve: aEteReleve);
  }
}

class _PointsButton extends StatelessWidget {
  const _PointsButton({
    required this.id,
    required this.points,
    required this.aEteReleve,
  });

  final ObjectifId id;
  final int points;
  final bool aEteReleve;

  @override
  Widget build(final BuildContext context) {
    final widget = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$points'),
        const SizedBox(width: DsfrSpacings.s1v),
        const Icon(DsfrIcons.othersLeafFill, size: DsfrSpacings.s2w),
      ],
    );

    return aEteReleve
        ? DefaultTextStyle(
            style: const TextStyle(color: DsfrColors.grey625),
            child: IconTheme(
              data: const IconThemeData(color: DsfrColors.grey625),
              child: widget,
            ),
          )
        : DsfrRawButton(
            variant: DsfrButtonVariant.tertiary,
            size: DsfrButtonSize.sm,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            onTap: () =>
                context.read<MissionBloc>().add(MissionGagnerPointsDemande(id)),
            child: IconTheme(
              data: const IconThemeData(color: Color(0xFF3CD277)),
              child: widget,
            ),
          );
  }
}
