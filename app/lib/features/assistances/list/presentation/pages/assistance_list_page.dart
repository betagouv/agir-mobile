import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/assistances/core/domain/aide.dart';
import 'package:app/features/assistances/core/presentation/widgets/tag_simulateur.dart';
import 'package:app/features/assistances/item/presentation/bloc/aide_bloc.dart';
import 'package:app/features/assistances/item/presentation/bloc/aide_event.dart';
import 'package:app/features/assistances/item/presentation/pages/assistance_detail_page.dart';
import 'package:app/features/assistances/list/presentation/bloc/aides_disclaimer/aides_disclaimer_cubit.dart';
import 'package:app/features/assistances/list/presentation/bloc/aides_disclaimer/aides_disclaimer_state.dart';
import 'package:app/features/assistances/list/presentation/bloc/assistance_list/assistance_list_bloc.dart';
import 'package:app/features/assistances/list/presentation/bloc/assistance_list/assistance_list_event.dart';
import 'package:app/features/assistances/list/presentation/bloc/assistance_list/assistance_list_state.dart';
import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

class AssistanceListPage extends StatelessWidget {
  const AssistanceListPage({super.key});

  static const name = 'aides';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const AssistanceListPage(),
      );

  @override
  Widget build(final context) => RootPage(
        body: BlocProvider(
          create: (final context) =>
              AssistanceListBloc(assistancesRepository: context.read())
                ..add(const AssistanceListFetch()),
          child: const _View(),
        ),
      );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final context) =>
      BlocBuilder<AssistanceListBloc, AssistanceListState>(
        builder: (final context, final state) => switch (state) {
          AssistanceListInitial() ||
          AssistanceListLoadInProgress() ||
          AssistanceListLoadFailure() =>
            const SizedBox(),
          AssistanceListLoadSuccess() => _Success(state: state),
        },
      );
}

class _Success extends StatelessWidget {
  const _Success({required this.state});

  final AssistanceListLoadSuccess state;

  @override
  Widget build(final context) => ListView(
        children: [
          if (!state.isCovered)
            BlocBuilder<AidesDisclaimerCubit, AidesDisclaimerState>(
              builder: (final context, final state) => switch (state) {
                AidesDisclaimerVisible() => DsfrNotice(
                    titre: Localisation.leServiveNeCouvrePasEncoreVotreVille,
                    description: Localisation
                        .leServiveNeCouvrePasEncoreVotreVilleDescription,
                    onClose: () =>
                        context.read<AidesDisclaimerCubit>().closeDisclaimer(),
                  ),
                AidesDisclaimerNotVisible() => const SizedBox(),
              },
            ),
          SafeArea(child: _List(state: state)),
        ],
      );
}

class _List extends StatelessWidget {
  const _List({required this.state});

  final AssistanceListLoadSuccess state;

  @override
  Widget build(final context) => ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: [
          MarkdownBody(
            data: Localisation.assistanceListTitle,
            styleSheet: MarkdownStyleSheet(
              p: const DsfrTextStyle.headline2(),
              strong: const DsfrTextStyle.headline2(
                color: DsfrColors.blueFranceSun113,
              ),
            ),
          ),
          const SizedBox(height: DsfrSpacings.s3w),
          Wrap(
            spacing: DsfrSpacings.s1w,
            runSpacing: DsfrSpacings.s1w,
            children: [
              _Tag(
                label: Localisation.tout,
                value: null,
                groupValue: state.themeSelected,
              ),
              ...ThemeType.values.where(state.themes.containsKey).map(
                    (final e) => _Tag(
                      label: e.displayNameWithoutEmoji,
                      value: e,
                      groupValue: state.themeSelected,
                    ),
                  ),
            ],
          ),
          const SizedBox(height: DsfrSpacings.s4w),
          _Elements(themes: state.currentTheme),
        ],
      );
}

class _Tag extends StatelessWidget {
  const _Tag({
    required this.label,
    required this.value,
    required this.groupValue,
  });

  final String label;
  final ThemeType? value;
  final ThemeType? groupValue;

  @override
  Widget build(final context) {
    const selectedColor = DsfrColors.blueFranceSun113;
    final isSelected = value == groupValue;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context
              .read<AssistanceListBloc>()
              .add(AssistanceListThemeSelected(value));
        },
        borderRadius: const BorderRadius.all(Radius.circular(DsfrSpacings.s4w)),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isSelected ? selectedColor : null,
            border:
                const Border.fromBorderSide(BorderSide(color: selectedColor)),
            borderRadius:
                const BorderRadius.all(Radius.circular(DsfrSpacings.s4w)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Text(
              label,
              style: DsfrTextStyle.bodySmMedium(
                color: isSelected ? Colors.white : selectedColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Elements extends StatelessWidget {
  const _Elements({required this.themes});

  final Map<ThemeType, List<Assistance>> themes;

  @override
  Widget build(final context) {
    final entries = themes.entries;
    if (entries.length == 1) {
      final a = entries.first;

      return _ThemeSection(
        themeType: a.key,
        assistances: a.value,
        scrollDirection: Axis.vertical,
      );
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (final context, final index) {
        final a = entries.elementAt(index);

        return _ThemeSection(
          themeType: a.key,
          assistances: a.value,
          scrollDirection: Axis.vertical,
        );
      },
      separatorBuilder: (final context, final index) =>
          const SizedBox(height: DsfrSpacings.s3w),
      itemCount: entries.length,
    );
  }
}

class _ThemeSection extends StatelessWidget {
  const _ThemeSection({
    required this.themeType,
    required this.assistances,
    this.scrollDirection = Axis.horizontal,
  });

  final ThemeType themeType;
  final List<Assistance> assistances;
  final Axis scrollDirection;

  @override
  Widget build(final context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            themeType.displayName,
            style: const DsfrTextStyle.headline4(),
            semanticsLabel: themeType.displayNameWithoutEmoji,
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          if (scrollDirection == Axis.horizontal) ...[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              clipBehavior: Clip.none,
              child: IntrinsicHeight(
                child: Row(
                  children: assistances
                      .map(
                        (final e) => SizedBox(
                          width: 220,
                          child: _AssitanceCard(
                            assistance: e,
                            scrollDirection: scrollDirection,
                          ),
                        ),
                      )
                      .separator(const SizedBox(width: DsfrSpacings.s2w))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: DsfrSpacings.s2w),
            DsfrLink.md(
              label: 'Voir les 9 aides',
              onTap: () {
                context
                    .read<AssistanceListBloc>()
                    .add(AssistanceListThemeSelected(themeType));
              },
            ),
          ],
          if (scrollDirection == Axis.vertical)
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (final context, final index) => _AssitanceCard(
                assistance: assistances[index],
                scrollDirection: scrollDirection,
              ),
              separatorBuilder: (final context, final index) =>
                  const SizedBox(height: DsfrSpacings.s1w),
              itemCount: assistances.length,
            ),
        ],
      );
}

class _AssitanceCard extends StatelessWidget {
  const _AssitanceCard({
    required this.assistance,
    required this.scrollDirection,
  });

  final Assistance assistance;
  final Axis scrollDirection;

  @override
  Widget build(final context) => FnvCard(
        onTap: () async {
          context.read<AideBloc>().add(AideSelectionnee(assistance));
          context.read<Tracker>().trackClick('Aides', assistance.titre);
          await GoRouter.of(context).pushNamed(AssistanceDetailPage.name);
        },
        child: Padding(
          padding: const EdgeInsets.all(DsfrSpacings.s2w),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (assistance.aUnSimulateur) ...[
                      const TagSimulateur(),
                      const SizedBox(width: DsfrSpacings.s1w),
                    ],
                    Text(assistance.titre, style: const DsfrTextStyle.bodyMd()),
                    if (assistance.montantMax != null) ...[
                      const SizedBox(height: DsfrSpacings.s1w),
                      _AmountMax(value: assistance.montantMax!),
                    ],
                  ],
                ),
              ),
              if (scrollDirection == Axis.vertical) ...[
                const SizedBox(width: DsfrSpacings.s2w),
                const Icon(
                  DsfrIcons.systemArrowRightSLine,
                  color: DsfrColors.blueFranceSun113,
                ),
              ],
            ],
          ),
        ),
      );
}

class _AmountMax extends StatelessWidget {
  const _AmountMax({required this.value});

  final int value;

  @override
  Widget build(final context) => Text.rich(
        TextSpan(
          children: [
            const WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Icon(
                DsfrIcons.financeMoneyEuroCircleLine,
                color: DsfrColors.blueFranceSun113,
              ),
            ),
            const WidgetSpan(child: SizedBox(width: DsfrSpacings.s1w)),
            const TextSpan(text: Localisation.jusqua),
            TextSpan(
              text: Localisation.euro(value),
              style: const DsfrTextStyle.bodySmBold(),
            ),
          ],
        ),
        style: const DsfrTextStyle.bodySm(),
      );
}
