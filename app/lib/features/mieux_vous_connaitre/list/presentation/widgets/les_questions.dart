import 'package:app/core/presentation/widgets/composants/list_item.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/pages/mieux_vous_connaitre_edit_page.dart';
import 'package:app/features/mieux_vous_connaitre/list/presentation/bloc/mieux_vous_connaitre_bloc.dart';
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
          padding: EdgeInsets.zero,
          itemBuilder: (final context, final index) {
            final item = questions[index];

            return ListItem(
              title: item.question,
              subTitle: item.reponses.join(' - '),
              onTap: () async => GoRouter.of(context).pushNamed(
                MieuxVousConnaitreEditPage.name,
                pathParameters: {'id': item.id},
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
