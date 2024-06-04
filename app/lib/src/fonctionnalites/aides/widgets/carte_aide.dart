import 'package:app/src/design_system/fondamentaux/colors.dart';
import 'package:app/src/design_system/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/src/design_system/fondamentaux/shadows.dart';
import 'package:app/src/fonctionnalites/aides/bloc/aide/aide_bloc.dart';
import 'package:app/src/fonctionnalites/aides/bloc/aide/aide_event.dart';
import 'package:app/src/fonctionnalites/aides/domain/aide.dart';
import 'package:app/src/fonctionnalites/aides/widgets/tag_simulateur.dart';
import 'package:app/src/pages/aides/aide_page.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CarteAide extends StatelessWidget {
  const CarteAide({required this.aide, super.key});

  final Aide aide;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
        decoration: const ShapeDecoration(
          shape: roundedRectangleBorder,
          color: FnvColors.carteFond,
          shadows: carteOmbre,
        ),
        child: GestureDetector(
          onTap: () async {
            context.read<AideBloc>().add(AideSelectionnee(aide));
            await GoRouter.of(context).pushNamed(AidePage.name);
          },
          child: Padding(
            padding: const EdgeInsets.all(DsfrSpacings.s2w),
            child: Row(
              children: [
                Expanded(
                  child: Text(aide.titre, style: DsfrFonts.bodyMdMedium),
                ),
                if (aide.aUnSimulateur) ...[
                  const SizedBox(width: DsfrSpacings.s1v),
                  const TagSimulateur(),
                ],
                const SizedBox(width: DsfrSpacings.s1v),
                const Icon(DsfrIcons.systemArrowRightSLine),
              ],
            ),
          ),
        ),
      );
}
