import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/accueil/presentation/widgets/home_disclaimer.dart';
import 'package:app/features/actions/home/presentation/widgets/actions_section.dart';
import 'package:app/features/assistances/core/presentation/widgets/assitances_section.dart';
import 'package:app/features/environmental_performance/home/presentation/widgets/environmental_performance_section.dart';
import 'package:app/features/mission/home/presentation/widgets/mission_section.dart';
import 'package:app/features/survey/survey_section.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class HomeContentLayout extends StatelessWidget {
  const HomeContentLayout({super.key});

  @override
  Widget build(final BuildContext context) {
    const spacing = SizedBox(height: DsfrSpacings.s4w);

    return ListView(
      padding: EdgeInsets.zero,
      children: const [
        HomeDisclaimer(),
        SizedBox(height: paddingVerticalPage),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
          child: EnvironmentalPerformanceSection(),
        ),
        spacing,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
          child: MissionSection(),
        ),
        spacing,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
          child: AssitancesSection(),
        ),
        spacing,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
          child: ActionsSection(),
        ),
        spacing,
        SurveySection(),
      ],
    );
  }
}
