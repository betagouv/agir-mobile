import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/features/aides/core/domain/aide.dart';
import 'package:app/features/aides/core/presentation/widgets/tag_simulateur.dart';
import 'package:app/features/aides/item/presentation/bloc/aide_bloc.dart';
import 'package:app/features/aides/item/presentation/bloc/aide_event.dart';
import 'package:app/features/aides/item/presentation/pages/aide_page.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CarteAide extends StatelessWidget {
  const CarteAide({required this.aide, super.key});

  final Aide aide;

  Future<void> _handleTap(final BuildContext context) async {
    context.read<AideBloc>().add(AideSelectionnee(aide));
    context.read<Tracker>().trackClick('Aides', aide.titre);
    await GoRouter.of(context).pushNamed(AidePage.name);
  }

  @override
  Widget build(final BuildContext context) => FnvCard(
        onTap: () async => _handleTap(context),
        child: Padding(
          padding: const EdgeInsets.all(DsfrSpacings.s2w),
          child: Row(
            children: [
              Expanded(
                child:
                    Text(aide.titre, style: const DsfrTextStyle.bodyMdMedium()),
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
      );
}
