import 'package:app/features/aides/domain/entities/aide.dart';
import 'package:app/features/aides/presentation/blocs/aide/aide_bloc.dart';
import 'package:app/features/aides/presentation/blocs/aide/aide_event.dart';
import 'package:app/features/aides/presentation/pages/aide_page.dart';
import 'package:app/features/aides/presentation/widgets/tag_simulateur.dart';
import 'package:app/shared/widgets/fondamentaux/colors.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/shared/widgets/fondamentaux/shadows.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CarteAide extends StatelessWidget {
  const CarteAide({required this.aide, super.key});

  final Aide aide;

  Future<void> _handleTap(final BuildContext context) async {
    context.read<AideBloc>().add(AideSelectionnee(aide));
    await GoRouter.of(context).pushNamed(AidePage.name);
  }

  @override
  Widget build(final BuildContext context) => DecoratedBox(
        decoration: const ShapeDecoration(
          color: FnvColors.carteFond,
          shadows: carteOmbre,
          shape: roundedRectangleBorder,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async => _handleTap(context),
            borderRadius:
                roundedRectangleBorder.borderRadius.resolve(TextDirection.ltr),
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
        ),
      );
}
