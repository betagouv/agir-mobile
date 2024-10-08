import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/environmental_performance/environmental_performance_l10n.dart';
import 'package:app/features/environmental_performance/presentation/widgets/environnemental_performance_card.dart';
import 'package:app/features/environmental_performance/presentation/widgets/environnemental_performance_tonnes_card.dart';
import 'package:app/features/environmental_performance/presentation/widgets/estimaded_timed_widget.dart';
import 'package:app/features/environmental_performance/presentation/widgets/partner_card.dart';
import 'package:app/features/environmental_performance/presentation/widgets/question_section.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EnvironmentalPerformancePage extends StatelessWidget {
  const EnvironmentalPerformancePage({super.key});

  static const name = 'bilan';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) =>
            const EnvironmentalPerformancePage(),
      );

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: const FnvAppBar(),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s3w),
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
              child: _BodyEarly(),
            ),
            SizedBox(height: DsfrSpacings.s3w),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
              child: _BodyInProgress(),
            ),
            SizedBox(height: DsfrSpacings.s3w),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
              child: _BodyDone(),
            ),
            SizedBox(height: DsfrSpacings.s3w),
            QuestionSection(),
            SizedBox(height: DsfrSpacings.s3w),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
              child: PartnerCard(),
            ),
          ],
        ),
        backgroundColor: FnvColors.accueilFond,
      );
}

class _BodyEarly extends StatelessWidget {
  const _BodyEarly();

  @override
  Widget build(final BuildContext context) => ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          const FnvTitle(
            title:
                '${EnvironmentalPerformanceLocalisation.estimezVotre} ${EnvironmentalPerformanceLocalisation.bilanEnvironnemental}',
          ),
          const EstimadedTimedWidget(),
          const SizedBox(height: DsfrSpacings.s3v),
          const Text(
            EnvironmentalPerformanceLocalisation
                .commencerMonMiniBilanDescription,
            style: DsfrTextStyle.bodyLg(),
          ),
          const SizedBox(height: DsfrSpacings.s3v),
          Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              child: DsfrButton(
                label:
                    EnvironmentalPerformanceLocalisation.commencerMonMiniBilan,
                variant: DsfrButtonVariant.primary,
                size: DsfrButtonSize.lg,
                onPressed: () {},
              ),
            ),
          ),
        ],
      );
}

class _BodyInProgress extends StatelessWidget {
  const _BodyInProgress();

  @override
  Widget build(final BuildContext context) => ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: const [
          FnvTitle(
            title:
                '${EnvironmentalPerformanceLocalisation.estimezVotre} ${EnvironmentalPerformanceLocalisation.bilanEnvironnemental}',
          ),
          Text(
            EnvironmentalPerformanceLocalisation.votrePremiereEstimation,
            style: DsfrTextStyle.headline4(),
          ),
          SizedBox(height: DsfrSpacings.s3v),
          EnvironnementalPerformanceCard(),
          SizedBox(height: DsfrSpacings.s3v),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: EnvironmentalPerformanceLocalisation.etincelles,
                  style: DsfrTextStyle.headline4(),
                ),
                TextSpan(
                  text:
                      ' ${EnvironmentalPerformanceLocalisation.estimationCompleteA} ',
                  style: DsfrTextStyle.bodyMd(),
                ),
                TextSpan(
                  text: '30%',
                  style: DsfrTextStyle.bodyMd(
                    color: DsfrColors.blueFranceSun113,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

class _BodyDone extends StatelessWidget {
  const _BodyDone();

  @override
  Widget build(final BuildContext context) => ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: const [
          FnvTitle(
            title:
                'Votre ${EnvironmentalPerformanceLocalisation.bilanEnvironnemental}',
          ),
          EnvironnementalPerformanceTonnesCard(),
        ],
      );
}
