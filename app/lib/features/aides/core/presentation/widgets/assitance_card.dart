import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/features/aides/core/domain/aide.dart';
import 'package:app/features/aides/core/presentation/widgets/tag_simulateur.dart';
import 'package:app/features/aides/item/presentation/bloc/aide_bloc.dart';
import 'package:app/features/aides/item/presentation/bloc/aide_event.dart';
import 'package:app/features/aides/item/presentation/pages/assistance_detail_page.dart';
import 'package:app/features/theme/presentation/widgets/theme_type_tag.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AssitanceCard extends StatelessWidget {
  const AssitanceCard({required this.assistance, super.key});

  final Assistance assistance;

  @override
  Widget build(final context) => FnvCard(
        onTap: () async {
          context.read<AideBloc>().add(AideSelectionnee(assistance));
          context.read<Tracker>().trackClick('Aides', assistance.titre);
          await GoRouter.of(context).pushNamed(AssistanceDetailPage.name);
        },
        child: Padding(
          padding: const EdgeInsets.all(DsfrSpacings.s2w),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      assistance.titre,
                      style: const DsfrTextStyle.bodyMdMedium(),
                    ),
                    const SizedBox(height: DsfrSpacings.s1v),
                    ThemeTypeTag(themeType: assistance.themeType),
                  ],
                ),
              ),
              if (assistance.aUnSimulateur) ...[
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
