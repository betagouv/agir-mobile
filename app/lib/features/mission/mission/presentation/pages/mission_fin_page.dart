import 'package:app/core/assets/svgs.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/mission/mission/presentation/bloc/mission_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class MissionFinPage extends StatelessWidget {
  const MissionFinPage({super.key, required this.step});

  final MissionStepFin step;

  @override
  Widget build(final context) => Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            AssetsSvgs.fireworks,
            alignment: Alignment.topCenter,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: paddingVerticalPage),
            child: Column(
              children: [
                const SizedBox(height: DsfrSpacings.s6w),
                SvgPicture.asset(AssetsSvgs.flags),
                const SizedBox(height: DsfrSpacings.s1w),
                const Text(
                  Localisation.bravo,
                  style: DsfrTextStyle.headline2(),
                ),
                Text(
                  Localisation.vousAvezTermineLaMission(step.title),
                  style: const DsfrTextStyle.bodyXl(
                    color: DsfrColors.blueFranceSun113,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: DsfrSpacings.s2w),
                Center(
                  child: FittedBox(
                    child: DsfrButton(
                      label: Localisation.retour,
                      variant: DsfrButtonVariant.primary,
                      size: DsfrButtonSize.lg,
                      onPressed: () => GoRouter.of(context).pop(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
