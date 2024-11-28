import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/accueil/presentation/widgets/title_section.dart';
import 'package:app/features/actions/detail/presentation/pages/action_detail_page.dart';
import 'package:app/features/actions/home/presentation/bloc/home_actions_bloc.dart';
import 'package:app/features/actions/home/presentation/bloc/home_actions_event.dart';
import 'package:app/features/actions/home/presentation/bloc/home_actions_state.dart';
import 'package:app/features/actions/list/domain/action_item.dart';
import 'package:app/features/actions/list/presentation/pages/action_list_page.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/presentation/widgets/theme_type_tag.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ActionsSection extends StatelessWidget {
  const ActionsSection({super.key, this.themeType});

  final ThemeType? themeType;

  @override
  Widget build(final BuildContext context) {
    context.read<HomeActionsBloc>().add(HomeActionsLoadRequested(themeType));

    return BlocBuilder<HomeActionsBloc, HomeActionsState>(
      builder: (final context, final state) => switch (state) {
        HomeActionsInitial() => const SizedBox.shrink(),
        HomeActionsLoadSuccess() => _Section(state),
      },
    );
  }
}

class _Section extends StatelessWidget {
  const _Section(this.state);

  final HomeActionsLoadSuccess state;

  @override
  Widget build(final context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleSection(
            title: Localisation.homeActionsTitle,
            subTitle: Localisation.homeActionsSubTitle,
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          _Actions(actions: state.actions),
          const SizedBox(height: DsfrSpacings.s2w),
          Align(
            alignment: Alignment.centerLeft,
            child: DsfrLink.md(
              label: Localisation.homeActionsLink,
              onTap: () async =>
                  GoRouter.of(context).pushNamed(ActionListPage.name),
            ),
          ),
        ],
      );
}

class _Actions extends StatelessWidget {
  const _Actions({required this.actions});

  final List<ActionItem> actions;

  @override
  Widget build(final BuildContext context) => actions.isEmpty
      ? const Text(
          Localisation.homeActionsListEmpty,
          style: DsfrTextStyle.bodySm(),
        )
      : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          clipBehavior: Clip.none,
          child: IntrinsicHeight(
            child: Row(
              children: actions
                  .map(_Action.new)
                  .separator(const SizedBox(width: DsfrSpacings.s2w))
                  .toList(),
            ),
          ),
        );
}

class _Action extends StatelessWidget {
  const _Action(this.item);

  final ActionItem item;

  @override
  Widget build(final context) {
    const width = 250.0;

    return GestureDetector(
      onTap: () async {
        final result = await GoRouter.of(context).pushNamed(
          ActionDetailPage.name,
          pathParameters: {'id': item.id.value},
        );

        if (result != true || !context.mounted) {}
        // if (context.mounted) {
        //   context.read<MissionHomeBloc>().add(const MissionHomeFetch());
        // }
      },
      child: DecoratedBox(
        decoration: const ShapeDecoration(
          color: Colors.white,
          shadows: recommandationOmbre,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1w)),
          ),
        ),
        child: SizedBox(
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(DsfrSpacings.s2w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ThemeTypeTag(themeType: item.themeType),
                const SizedBox(height: DsfrSpacings.s1w),
                Expanded(
                  child: Text(item.titre, style: const DsfrTextStyle.bodyLg()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
