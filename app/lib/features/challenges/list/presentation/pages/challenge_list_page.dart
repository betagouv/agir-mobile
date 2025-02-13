import 'package:app/core/presentation/widgets/composants/list_item.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/challenges/core/domain/challenge_status.dart';
import 'package:app/features/challenges/detail/presentation/pages/challenge_detail_page.dart';
import 'package:app/features/challenges/list/application/fetch_challenges.dart';
import 'package:app/features/challenges/list/presentation/bloc/challenge_list_bloc.dart';
import 'package:app/features/challenges/list/presentation/bloc/challenge_list_event.dart';
import 'package:app/features/challenges/list/presentation/bloc/challenge_list_state.dart';
import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChallengeListPage extends StatelessWidget {
  const ChallengeListPage({super.key});

  static const name = 'action-list';
  static const path = 'mes-actions';

  static GoRoute get route => GoRoute(path: path, name: name, builder: (final context, final state) => const ChallengeListPage());

  @override
  Widget build(final context) => BlocProvider(
    create: (final context) => ChallengeListBloc(FetchChallenges(context.read()))..add(const ChallengeListFetch()),
    child: const RootPage(body: _View()),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final context) => ListView(
    padding: const EdgeInsets.symmetric(vertical: paddingVerticalPage),
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
        child: FnvTitle(title: Localisation.mesActions),
      ),
      const SizedBox(height: DsfrSpacings.s3w),
      BlocBuilder<ChallengeListBloc, ChallengeListState>(
        builder:
            (final context, final state) => switch (state) {
              ChallengeListInitial() => const SizedBox.shrink(),
              ChallengeListLoading() => const Center(child: CircularProgressIndicator()),
              ChallengeListSuccess() => ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (final context, final index) {
                  final item = state.challenges[index];
                  final subTitle = switch (item.status) {
                    ChallengeStatus.toDo => '📝 À faire',
                    ChallengeStatus.inProgress => '⏳ Action en cours',
                    ChallengeStatus.refused => '👎 Pas envie',
                    ChallengeStatus.alreadyDone => '✅ Déjà fait',
                    ChallengeStatus.abandonned => '❌ Abandonnée',
                    ChallengeStatus.done => '🏆 Action réalisée',
                  };

                  return ListItem(
                    title: item.titre,
                    subTitle: subTitle,
                    onTap: () async {
                      final result = await GoRouter.of(
                        context,
                      ).pushNamed(ChallengeDetailPage.name, pathParameters: {'id': item.id.value});

                      if (result != true || !context.mounted) {
                        return;
                      }

                      context.read<ChallengeListBloc>().add(const ChallengeListFetch());
                    },
                  );
                },
                separatorBuilder: (final context, final index) => const DsfrDivider(color: Color(0xFFEAEBF6)),
                itemCount: state.challenges.length,
              ),
              ChallengeListFailure() => const Text('Oups'),
            },
      ),
    ],
  );
}
