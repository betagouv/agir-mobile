import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/challenges/detail/presentation/pages/challenge_detail_page.dart';
import 'package:app/features/challenges/list/domain/challenge_item.dart';
import 'package:app/features/challenges/list/presentation/pages/challenge_list_page.dart';
import 'package:app/features/challenges/section/presentation/bloc/challenges_bloc.dart';
import 'package:app/features/challenges/section/presentation/bloc/challenges_event.dart';
import 'package:app/features/challenges/section/presentation/bloc/challenges_state.dart';
import 'package:app/features/home/presentation/widgets/title_section.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/presentation/widgets/theme_type_tag.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChallengesSection extends StatelessWidget {
  const ChallengesSection({super.key, this.themeType});

  final ThemeType? themeType;

  @override
  Widget build(final BuildContext context) {
    context.read<ChallengesBloc>().add(ChallengesLoadRequested(themeType));

    return BlocBuilder<ChallengesBloc, ChallengesState>(
      builder:
          (final context, final state) => switch (state) {
            ChallengesInitial() => const SizedBox.shrink(),
            ChallengesLoadSuccess() => _Section(state),
          },
    );
  }
}

class _Section extends StatelessWidget {
  const _Section(this.state);

  final ChallengesLoadSuccess state;

  @override
  Widget build(final context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const TitleSection(
        title: Localisation.actionsSectionTitle,
        subTitle: Localisation.actionsSectionSubTitle,
      ),
      const SizedBox(height: DsfrSpacings.s2w),
      _Challenges(value: state.challenges),
      const SizedBox(height: DsfrSpacings.s2w),
      Align(
        alignment: Alignment.centerLeft,
        child: DsfrLink.md(
          label: Localisation.homeActionsLink,
          onTap:
              () async =>
                  GoRouter.of(context).pushNamed(ChallengeListPage.name),
        ),
      ),
    ],
  );
}

class _Challenges extends StatelessWidget {
  const _Challenges({required this.value});

  final List<ChallengeItem> value;

  @override
  Widget build(final BuildContext context) =>
      value.isEmpty
          ? const Text(
            Localisation.actionsSectionListEmpty,
            style: DsfrTextStyle.bodySm(),
          )
          : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            clipBehavior: Clip.none,
            child: IntrinsicHeight(
              child: Row(
                children:
                    value
                        .map(_Challenge.new)
                        .separator(const SizedBox(width: DsfrSpacings.s2w))
                        .toList(),
              ),
            ),
          );
}

class _Challenge extends StatefulWidget {
  const _Challenge(this.item);

  final ChallengeItem item;

  @override
  State<_Challenge> createState() => _ChallengeState();
}

class _ChallengeState extends State<_Challenge>
    with MaterialStateMixin<_Challenge> {
  @override
  Widget build(final context) {
    const width = 250.0;
    const borderRadius = BorderRadius.all(Radius.circular(DsfrSpacings.s1w));

    return DsfrFocusWidget(
      isFocused: isFocused,
      borderRadius: borderRadius,
      child: DecoratedBox(
        decoration: const ShapeDecoration(
          color: Colors.white,
          shadows: recommandationOmbre,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: Material(
          color: FnvColors.transparent,
          child: InkWell(
            onTap: () async {
              final result = await GoRouter.of(context).pushNamed(
                ChallengeDetailPage.name,
                pathParameters: {'id': widget.item.id.value},
              );

              if (result != true || !context.mounted) {}
              if (context.mounted) {
                context.read<ChallengesBloc>().add(
                  const ChallengesRefreshRequested(),
                );
              }
            },
            onHighlightChanged: updateMaterialState(WidgetState.pressed),
            onHover: updateMaterialState(WidgetState.hovered),
            focusColor: FnvColors.transparent,
            borderRadius: borderRadius,
            onFocusChange: updateMaterialState(WidgetState.focused),
            child: SizedBox(
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(DsfrSpacings.s2w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ThemeTypeTag(themeType: widget.item.themeType),
                    const SizedBox(height: DsfrSpacings.s1w),
                    Expanded(
                      child: Text(
                        widget.item.titre,
                        style: const DsfrTextStyle.bodyLg(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
