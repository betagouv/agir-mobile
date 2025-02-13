import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/action/presentation/pages/action_page.dart';
import 'package:app/features/actions/domain/action_summary.dart';
import 'package:app/features/actions/presentation/bloc/actions_bloc.dart';
import 'package:app/features/actions/presentation/bloc/actions_event.dart';
import 'package:app/features/actions/presentation/bloc/actions_state.dart';
import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

class ActionsPage extends StatelessWidget {
  const ActionsPage({super.key});

  static const name = 'actions';
  static const path = name;

  static GoRoute get route => GoRoute(
    path: path,
    name: name,
    builder: (final context, final state) => const ActionsPage(),
  );

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create:
        (final context) =>
            ActionsBloc(repository: context.read())
              ..add(const ActionsLoadRequested()),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => RootPage(
    body: ListView(
      padding: const EdgeInsets.all(paddingVerticalPage),
      children: [
        MarkdownBody(
          data: Localisation.toutesLesActions,
          styleSheet: MarkdownStyleSheet(p: const DsfrTextStyle(fontSize: 24)),
        ),
        const SizedBox(height: 16),
        BlocBuilder<ActionsBloc, ActionsState>(
          builder:
              (final context, final state) => switch (state) {
                ActionsInitial() || ActionsLoadInProgress() => const Center(
                  child: CircularProgressIndicator(),
                ),
                ActionsLoadSuccess() => _Success(state: state),
                ActionsLoadFailure() => const Center(
                  child: Text('Erreur lors du chargement des actions'),
                ),
              },
        ),
      ],
    ),
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.state});

  final ActionsLoadSuccess state;

  @override
  Widget build(final BuildContext context) {
    final actions = state.actions;

    return GridView.builder(
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder:
          (final context, final index) => _Element(action: actions[index]),
      itemCount: actions.length,
    );
  }
}

class _Element extends StatelessWidget {
  const _Element({required this.action});

  final ActionSummary action;

  @override
  Widget build(final BuildContext context) => FnvCard(
    onTap: () async {
      await GoRouter.of(context).pushNamed(
        ActionPage.name,
        pathParameters: ActionPage.pathParameters(
          title: action.title,
          id: action.id,
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(DsfrSpacings.s2w),
      child: Column(
        children: [
          MarkdownBody(
            data: action.title,
            styleSheet: MarkdownStyleSheet(p: const DsfrTextStyle.bodyMd()),
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          _Information(
            icon: DsfrIcons.userTeamLine,
            value: action.numberOfActionsCompleted,
            suffix: Localisation.action,
          ),
          _Information(
            icon: DsfrIcons.financeMoneyEuroCircleLine,
            value: action.numberOfAidsAvailable,
            suffix: Localisation.aide,
          ),
        ],
      ),
    ),
  );
}

class _Information extends StatelessWidget {
  const _Information({
    required this.icon,
    required this.value,
    required this.suffix,
  });

  final IconData icon;
  final int value;
  final String suffix;

  @override
  Widget build(final BuildContext context) =>
      value == 0
          ? const SizedBox()
          : ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 24),
            child: Row(
              children: [
                ExcludeSemantics(
                  child: Icon(
                    icon,
                    size: 18,
                    color: DsfrColors.blueFranceSun113,
                  ),
                ),
                const SizedBox(width: 8),
                MarkdownBody(
                  data: '**$value** $suffix${value > 1 ? 's' : ''}',
                  styleSheet: MarkdownStyleSheet(
                    p: const DsfrTextStyle.bodySmMedium(
                      color: Color(0xff5d5d5d),
                    ),
                  ),
                ),
              ],
            ),
          );
}
