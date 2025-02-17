import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/aids/core/domain/aid.dart';
import 'package:app/features/aids/core/presentation/widgets/partner_widget.dart';
import 'package:app/features/aids/core/presentation/widgets/simulator_tag.dart';
import 'package:app/features/aids/item/presentation/bloc/aid_bloc.dart';
import 'package:app/features/aids/item/presentation/bloc/aid_event.dart';
import 'package:app/features/aids/item/presentation/pages/aid_page.dart';
import 'package:app/features/aids/list/presentation/bloc/aids_disclaimer/aids_disclaimer_cubit.dart';
import 'package:app/features/aids/list/presentation/bloc/aids_disclaimer/aids_disclaimer_state.dart';
import 'package:app/features/aids/list/presentation/bloc/assistance_list/aid_list_bloc.dart';
import 'package:app/features/aids/list/presentation/bloc/assistance_list/aid_list_event.dart';
import 'package:app/features/aids/list/presentation/bloc/assistance_list/aid_list_state.dart';
import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

class AidsPage extends StatelessWidget {
  const AidsPage({super.key});

  static const name = 'aides';
  static const path = name;

  static GoRoute get route => GoRoute(path: path, name: name, builder: (final context, final state) => const AidsPage());

  @override
  Widget build(final context) => BlocProvider(
    create: (final context) => AidListBloc(aidsRepository: context.read())..add(const AidListFetch()),
    child: const RootPage(body: _View()),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final context) => BlocBuilder<AidListBloc, AidListState>(
    builder:
        (final context, final state) => switch (state) {
          AidListInitial() || AidListLoadInProgress() || AidListLoadFailure() => const SizedBox(),
          AidListLoadSuccess() => _Success(state: state),
        },
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.state});

  final AidListLoadSuccess state;

  @override
  Widget build(final context) => ListView(
    children: [
      if (!state.isCovered)
        BlocBuilder<AidsDisclaimerCubit, AidsDisclaimerState>(
          builder:
              (final context, final state) => switch (state) {
                AidsDisclaimerVisible() => DsfrNotice(
                  titre: Localisation.leServiveNeCouvrePasEncoreVotreVille,
                  description: Localisation.leServiveNeCouvrePasEncoreVotreVilleDescription,
                  onClose: () => context.read<AidsDisclaimerCubit>().closeDisclaimer(),
                ),
                AidsDisclaimerNotVisible() => const SizedBox(),
              },
        ),
      SafeArea(child: _List(state: state)),
    ],
  );
}

class _List extends StatelessWidget {
  const _List({required this.state});

  final AidListLoadSuccess state;

  @override
  Widget build(final context) => Padding(
    padding: const EdgeInsets.all(paddingVerticalPage),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MarkdownBody(
          data: Localisation.aidListTitle,
          styleSheet: MarkdownStyleSheet(
            p: const DsfrTextStyle.headline2(),
            strong: const DsfrTextStyle.headline2(color: DsfrColors.blueFranceSun113),
          ),
        ),
        const SizedBox(height: DsfrSpacings.s3w),
        Wrap(
          spacing: DsfrSpacings.s1w,
          runSpacing: DsfrSpacings.s1w,
          children: [
            _Tag(label: Localisation.tout, value: null, groupValue: state.themeSelected),
            ...ThemeType.values
                .where(state.themes.containsKey)
                .map((final e) => _Tag(label: e.displayNameWithoutEmoji, value: e, groupValue: state.themeSelected)),
          ],
        ),
        const SizedBox(height: DsfrSpacings.s4w),
        _Elements(themes: state.currentTheme),
      ],
    ),
  );
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, required this.value, required this.groupValue});

  final String label;
  final ThemeType? value;
  final ThemeType? groupValue;

  @override
  Widget build(final context) {
    const selectedColor = DsfrColors.blueFranceSun113;
    final isSelected = value == groupValue;

    return Material(
      color: FnvColors.transparent,
      child: InkWell(
        onTap: () {
          context.read<AidListBloc>().add(AidListThemeSelected(value));
        },
        borderRadius: const BorderRadius.all(Radius.circular(DsfrSpacings.s4w)),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isSelected ? selectedColor : null,
            border: const Border.fromBorderSide(BorderSide(color: selectedColor)),
            borderRadius: const BorderRadius.all(Radius.circular(DsfrSpacings.s4w)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Text(label, style: DsfrTextStyle.bodySmMedium(color: isSelected ? Colors.white : selectedColor)),
          ),
        ),
      ),
    );
  }
}

class _Elements extends StatelessWidget {
  const _Elements({required this.themes});

  final Map<ThemeType, List<Aid>> themes;

  @override
  Widget build(final context) {
    final entries = themes.entries;
    if (entries.length == 1) {
      final a = entries.first;

      return _ThemeSection(themeType: a.key, assistances: a.value);
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (final context, final index) {
        final a = entries.elementAt(index);

        return _ThemeSection(themeType: a.key, assistances: a.value);
      },
      separatorBuilder: (final context, final index) => const SizedBox(height: DsfrSpacings.s3w),
      itemCount: entries.length,
    );
  }
}

class _ThemeSection extends StatelessWidget {
  const _ThemeSection({required this.themeType, required this.assistances});

  final ThemeType themeType;
  final List<Aid> assistances;

  @override
  Widget build(final context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s2w,
    children: [
      Text(themeType.displayName, style: const DsfrTextStyle.headline4(), semanticsLabel: themeType.displayNameWithoutEmoji),
      ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (final context, final index) => _AssitanceCard(assistance: assistances[index]),
        separatorBuilder: (final context, final index) => const SizedBox(height: DsfrSpacings.s1w),
        itemCount: assistances.length,
      ),
    ],
  );
}

class _AssitanceCard extends StatelessWidget {
  const _AssitanceCard({required this.assistance});

  final Aid assistance;

  @override
  Widget build(final context) => FnvCard(
    onTap: () async {
      context.read<AidBloc>().add(AidSelected(assistance));
      context.read<Tracker>().trackClick('Aides', assistance.title);
      await GoRouter.of(context).pushNamed(AidPage.name);
    },
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(DsfrSpacings.s2w),
          child: Row(
            spacing: DsfrSpacings.s2w,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (assistance.aUnSimulateur) ...[const SimulatorTag(), const SizedBox(width: DsfrSpacings.s1w)],
                    Text(assistance.title, style: const DsfrTextStyle.bodyMd()),
                    if (assistance.amountMax != null) ...[
                      const SizedBox(height: DsfrSpacings.s1w),
                      _AmountMax(value: assistance.amountMax!),
                    ],
                  ],
                ),
              ),
              const Icon(DsfrIcons.systemArrowRightSLine, color: DsfrColors.blueFranceSun113),
            ],
          ),
        ),
        if (assistance.partner != null) Ink(color: const Color(0xffeef2ff), child: PartnerWidget(partner: assistance.partner!)),
      ],
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
          child: Icon(DsfrIcons.financeMoneyEuroCircleLine, color: DsfrColors.blueFranceSun113),
        ),
        const WidgetSpan(child: SizedBox(width: DsfrSpacings.s1w)),
        const TextSpan(text: Localisation.jusqua),
        TextSpan(text: Localisation.euro(value), style: const DsfrTextStyle.bodySmBold()),
      ],
    ),
    style: const DsfrTextStyle.bodySm(),
  );
}
