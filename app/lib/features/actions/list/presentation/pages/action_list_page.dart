import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/list_item.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/actions/core/domain/action_status.dart';
import 'package:app/features/actions/detail/presentation/pages/action_detail_page.dart';
import 'package:app/features/actions/list/application/fetch_actions.dart';
import 'package:app/features/actions/list/presentation/bloc/action_list_bloc.dart';
import 'package:app/features/actions/list/presentation/bloc/action_list_event.dart';
import 'package:app/features/actions/list/presentation/bloc/action_list_state.dart';
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
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => ActionListBloc(FetchActions(context.read()))
          ..add(const ActionListFetch()),
        child: Builder(
          builder: (final context) => Scaffold(
            appBar: FnvAppBar(),
            body: ListView(
              padding:
                  const EdgeInsets.symmetric(vertical: paddingVerticalPage),
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: paddingVerticalPage),
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
                            ActionStatus.inProgress => '⏳ Défi en cours',
                            ActionStatus.refused => '👎 Pas envie',
                            ActionStatus.alreadyDone => '✅ Déjà fait',
                            ActionStatus.abandonned => '❌ Abandonné',
                            ActionStatus.done => '🏆 Défi réalisé',
                          };

                          return ListItem(
                            title: item.titre,
                            subTitle: subTitle,
                            onTap: () async {
                              final result =
                                  await GoRouter.of(context).pushNamed(
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
            ),
            backgroundColor: FnvColors.aidesFond,
          ),
        ),
      );
}
