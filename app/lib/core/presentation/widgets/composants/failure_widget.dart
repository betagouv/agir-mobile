import 'package:app/core/assets/svgs.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FnvFailureWidget extends StatelessWidget {
  const FnvFailureWidget({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(final BuildContext context) => ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: paddingVerticalPage),
        children: [
          const Text(
            Localisation.erreurInattendue,
            style: DsfrTextStyle.headline3(),
          ),
          SvgPicture.asset(AssetsSvgs.errorIllustration),
          const Text(
            Localisation.erreurInattendueContent,
            style: DsfrTextStyle.bodyXl(),
          ),
          const SizedBox(height: DsfrSpacings.s4w),
          DsfrButton(
            label: Localisation.rafraichir,
            variant: DsfrButtonVariant.secondary,
            size: DsfrButtonSize.lg,
            onPressed: onPressed,
          ),
        ],
      );
}