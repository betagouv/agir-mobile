import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/failure_widget.dart';
import 'package:app/core/presentation/widgets/composants/list_item.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/detail/presentation/pages/mieux_vous_connaitre_edit_page.dart';
import 'package:app/features/know_your_customer/list/presentation/bloc/know_your_customers_bloc.dart';
import 'package:app/features/know_your_customer/list/presentation/bloc/know_your_customers_event.dart';
import 'package:app/features/know_your_customer/list/presentation/bloc/know_your_customers_state.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

class KnowYourCustomersPage extends StatelessWidget {
  const KnowYourCustomersPage({super.key});

  static const name = 'know_your_customers';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const KnowYourCustomersPage(),
      );

  @override
  Widget build(final context) => BlocProvider(
        create: (final context) =>
            KnowYourCustomersBloc(repository: context.read())
              ..add(const KnowYourCustomersStarted()),
        child: Builder(
          builder: (final context) => FnvScaffold(
            appBar: FnvAppBar(),
            body: ListView(
              padding:
                  const EdgeInsets.symmetric(vertical: paddingVerticalPage),
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: paddingVerticalPage),
                  child: FnvTitle(title: Localisation.mieuxVousConnaitre),
                ),
                const SizedBox(height: DsfrSpacings.s3w),
                BlocBuilder<KnowYourCustomersBloc, KnowYourCustomersState>(
                  builder: (final context, final state) => switch (state) {
                    KnowYourCustomersInitial() => const SizedBox.shrink(),
                    KnowYourCustomersLoading() =>
                      const Center(child: CircularProgressIndicator()),
                    KnowYourCustomersSuccess() => _Success(state),
                    KnowYourCustomersFailure() => FnvFailureWidget(
                        onPressed: () =>
                            context.read<KnowYourCustomersBloc>().add(
                                  const KnowYourCustomersStarted(),
                                ),
                      ),
                  },
                ),
              ],
            ),
          ),
        ),
      );
}

class _Success extends StatelessWidget {
  const _Success(this.state);

  final KnowYourCustomersSuccess state;

  @override
  Widget build(final context) {
    final questions = state.questionsFiltered;
    final themeSelected = state.themeSelected;
    const padding = EdgeInsets.symmetric(horizontal: paddingVerticalPage);

    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        const Padding(
          padding: padding,
          child: Text(
            Localisation.lesCategories,
            style: DsfrTextStyle.headline4(),
          ),
        ),
        const SizedBox(height: DsfrSpacings.s2w),
        Padding(
          padding: padding,
          child: Wrap(
            spacing: DsfrSpacings.s1w,
            runSpacing: DsfrSpacings.s1w,
            children: [null, ...ThemeType.values]
                .map(
                  (final e) => _Tag(
                    thematique: e,
                    isSelected: themeSelected.fold(
                      () => e == null,
                      (final s) => s == e,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: DsfrSpacings.s2w),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (final context, final index) => _Item(questions[index]),
          separatorBuilder: (final context, final index) => const DsfrDivider(),
          itemCount: questions.length,
        ),
        const SafeArea(child: SizedBox.shrink()),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.thematique, required this.isSelected});

  final ThemeType? thematique;
  final bool isSelected;

  @override
  Widget build(final context) {
    const blue = DsfrColors.blueFranceSun113;

    const borderRadius = BorderRadius.all(Radius.circular(DsfrSpacings.s4w));

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.read<KnowYourCustomersBloc>().add(
              KnowYourCustomersThemePressed(
                thematique == null ? const None() : Some(thematique!),
              ),
            ),
        borderRadius: borderRadius,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isSelected ? blue : null,
            border: const Border.fromBorderSide(BorderSide(color: blue)),
            borderRadius: borderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Text(
              thematique?.displayName ?? Localisation.tout,
              style: DsfrTextStyle.bodySmMedium(
                color: isSelected ? Colors.white : blue,
              ),
              semanticsLabel: thematique?.displayNameWithoutEmoji,
            ),
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(this.question);

  final Question question;

  @override
  Widget build(final context) => ListItem(
        title: question.label,
        subTitle: question.responsesDisplay(),
        onTap: () async {
          final result = await GoRouter.of(context).pushNamed<bool>(
            MieuxVousConnaitreEditPage.name,
            pathParameters: {'id': question.id.value},
          );

          if (result != true || !context.mounted) {
            return;
          }

          context
              .read<KnowYourCustomersBloc>()
              .add(const KnowYourCustomersRefreshNeed());
        },
      );
}
