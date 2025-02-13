import 'package:app/features/aids/core/presentation/bloc/aids_home_bloc.dart';
import 'package:app/features/aids/core/presentation/bloc/aids_home_event.dart';
import 'package:app/features/aids/core/presentation/bloc/aids_home_state.dart';
import 'package:app/features/aids/core/presentation/widgets/aid_card.dart';
import 'package:app/features/aids/list/presentation/pages/aids_page.dart';
import 'package:app/features/home/presentation/widgets/title_section.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AidsSection extends StatelessWidget {
  const AidsSection({super.key});

  @override
  Widget build(final context) {
    final bloc =
        context.read<AidsHomeBloc>()..add(const AidsHomeLoadRequested());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleSection(
          title: Localisation.homeAssistanceTitle,
          subTitle: Localisation.homeAssistanceSubTitle,
        ),
        const SizedBox(height: DsfrSpacings.s2w),
        BlocBuilder<AidsHomeBloc, AidsHomeState>(
          builder: (final context, final state) {
            if (state.aids.isEmpty) {
              return const SizedBox();
            }
            final aids = state.aids;

            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder:
                  (final context, final index) => AidCard(aid: aids[index]),
              separatorBuilder:
                  (final context, final index) =>
                      const SizedBox(height: DsfrSpacings.s1w),
              itemCount: aids.length,
            );
          },
          bloc: bloc,
        ),
        const SizedBox(height: DsfrSpacings.s2w),
        Align(
          alignment: Alignment.centerLeft,
          child: DsfrLink.md(
            label: Localisation.mesAidesLien,
            onTap: () async => GoRouter.of(context).pushNamed(AidsPage.name),
          ),
        ),
      ],
    );
  }
}
