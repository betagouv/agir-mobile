import 'package:app/core/presentation/widgets/composants/list_item.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/actions/core/domain/action_status.dart';
import 'package:app/features/actions/detail/presentation/pages/action_detail_page.dart';
import 'package:app/features/actions/list/application/fetch_actions.dart';
import 'package:app/features/actions/list/presentation/bloc/action_list_bloc.dart';
import 'package:app/features/actions/list/presentation/bloc/action_list_event.dart';
import 'package:app/features/actions/list/presentation/bloc/action_list_state.dart';
import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ActionListPage extends StatelessWidget {
  const ActionListPage({super.key});

  static const name = 'action-list';
  static const path = 'action';

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const ActionListPage(),
      );

  @override
  Widget build(final context) => BlocProvider(
        create: (final context) => ActionListBloc(FetchActions(context.read()))
          ..add(const ActionListFetch()),
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
          BlocBuilder<ActionListBloc, ActionListState>(
            builder: (final context, final state) => switch (state) {
              ActionListInitial() => const SizedBox.shrink(),
              ActionListLoading() =>
                const Center(child: CircularProgressIndicator()),
              ActionListSuccess() => ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (final context, final index) {
                    final item = state.actions[index];
                    final subTitle = switch (item.status) {
                      ActionStatus.toDo => '📝 À faire',
                      ActionStatus.inProgress => '⏳ Action en cours',
                      ActionStatus.refused => '👎 Pas envie',
                      ActionStatus.alreadyDone => '✅ Déjà fait',
                      ActionStatus.abandonned => '❌ Abandonnée',
                      ActionStatus.done => '🏆 Action réalisée',
                    };

                    return ListItem(
                      title: item.titre,
                      subTitle: subTitle,
                      onTap: () async {
                        final result = await GoRouter.of(context).pushNamed(
                          ActionDetailPage.name,
                          pathParameters: {'id': item.id.value},
                        );

                        if (result != true || !context.mounted) {
                          return;
                        }

                        context
                            .read<ActionListBloc>()
                            .add(const ActionListFetch());
                      },
                    );
                  },
                  separatorBuilder: (final context, final index) =>
                      const DsfrDivider(color: Color(0xFFEAEBF6)),
                  itemCount: state.actions.length,
                ),
              ActionListFailure() => const Text('Oups'),
            },
          ),
        ],
      );
}
