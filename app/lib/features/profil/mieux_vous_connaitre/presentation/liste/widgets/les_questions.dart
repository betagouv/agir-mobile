import 'package:app/features/profil/mieux_vous_connaitre/presentation/element/pages/mieux_vous_connaitre_edit_page.dart';
import 'package:app/features/profil/mieux_vous_connaitre/presentation/liste/blocs/mieux_vous_connaitre_bloc.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LesQuestions extends StatelessWidget {
  const LesQuestions({super.key});

  @override
  Widget build(final BuildContext context) {
    final questions =
        context.watch<MieuxVousConnaitreBloc>().state.questionsParCategorie;
    const dsfrDivider = DsfrDivider(color: Color(0xFFEAEBF6));

    return Column(
      children: [
        dsfrDivider,
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (final context, final index) {
            final question = questions[index];

            return GestureDetector(
              onTap: () async => GoRouter.of(context)
                  .pushNamed(MieuxVousConnaitreEditPage.name, extra: question),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(DsfrSpacings.s2w),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            question.question,
                            style: const DsfrTextStyle.headline6(),
                          ),
                          Text(
                            question.reponses.join(' - '),
                            style: const DsfrTextStyle.bodyXs(
                              color: Color(0xFF7E7E7E),
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: DsfrSpacings.s1v),
                    const Icon(DsfrIcons.systemArrowRightSLine),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (final context, final index) => dsfrDivider,
          itemCount: questions.length,
        ),
        dsfrDivider,
      ],
    );
  }
}
