import 'package:app/features/profil/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/profil/mieux_vous_connaitre/presentation/blocs/mieux_vous_connaitre_bloc.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LesQuestions extends StatelessWidget {
  const LesQuestions({super.key});

  @override
  Widget build(final BuildContext context) {
    final questions = context.select<MieuxVousConnaitreBloc, List<Question>>(
      (final value) => value.state.questionsParCategorie,
    );
    const dsfrDivider = DsfrDivider(color: Color(0xFFEAEBF6));

    return Column(
      children: [
        dsfrDivider,
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (final context, final index) {
            final question = questions[index];

            return Padding(
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
                          question.reponse.join(' - '),
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
