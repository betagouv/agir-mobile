import 'package:app/features/accueil/presentation/widgets/title_section.dart';
import 'package:app/features/assistances/core/presentation/bloc/aides_accueil_bloc.dart';
import 'package:app/features/assistances/core/presentation/bloc/aides_accueil_event.dart';
import 'package:app/features/assistances/core/presentation/bloc/aides_accueil_state.dart';
import 'package:app/features/assistances/core/presentation/widgets/assitance_card.dart';
import 'package:app/features/assistances/list/presentation/pages/assistance_list_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AssitancesSection extends StatelessWidget {
  const AssitancesSection({super.key});

  @override
  Widget build(final context) {
    final bloc = context.read<AidesAccueilBloc>()
      ..add(const AidesAccueilRecuperationDemandee());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleSection(
          title: Localisation.homeAssistanceTitle,
          subTitle: Localisation.homeAssistanceSubTitle,
        ),
        const SizedBox(height: DsfrSpacings.s2w),
        BlocBuilder<AidesAccueilBloc, AidesAccueilState>(
          builder: (final context, final state) {
            if (state.aides.isEmpty) {
              return const SizedBox();
            }
            final assistances = state.aides;

            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (final context, final index) {
                final aide = assistances[index];

                return AssitanceCard(assistance: aide);
              },
              separatorBuilder: (final context, final index) =>
                  const SizedBox(height: DsfrSpacings.s1w),
              itemCount: assistances.length,
            );
          },
          bloc: bloc,
        ),
        const SizedBox(height: DsfrSpacings.s2w),
        Align(
          alignment: Alignment.centerLeft,
          child: DsfrLink.md(
            label: Localisation.mesAidesLien,
            onTap: () async =>
                GoRouter.of(context).pushNamed(AssistanceListPage.name),
          ),
        ),
      ],
    );
  }
}
