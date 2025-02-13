import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/features/aids/core/domain/aid.dart';
import 'package:app/features/aids/core/presentation/widgets/simulator_tag.dart';
import 'package:app/features/aids/item/presentation/bloc/aid_bloc.dart';
import 'package:app/features/aids/item/presentation/bloc/aid_event.dart';
import 'package:app/features/aids/item/presentation/pages/aid_page.dart';
import 'package:app/features/theme/presentation/widgets/theme_type_tag.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AidCard extends StatelessWidget {
  const AidCard({super.key, required this.aid});

  final Aid aid;

  @override
  Widget build(final context) => FnvCard(
    onTap: () async {
      context.read<AidBloc>().add(AidSelected(aid));
      context.read<Tracker>().trackClick('Aides', aid.title);
      await GoRouter.of(context).pushNamed(AidPage.name);
    },
    child: Padding(
      padding: const EdgeInsets.all(DsfrSpacings.s2w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: DsfrSpacings.s1v,
              children: [
                Text(aid.title, style: const DsfrTextStyle.bodyMdMedium()),
                ThemeTypeTag(themeType: aid.themeType),
              ],
            ),
          ),
          if (aid.aUnSimulateur) ...[
            const SizedBox(width: DsfrSpacings.s1v),
            const SimulatorTag(),
          ],
          const SizedBox(width: DsfrSpacings.s1v),
          const Icon(DsfrIcons.systemArrowRightSLine),
        ],
      ),
    ),
  );
}
