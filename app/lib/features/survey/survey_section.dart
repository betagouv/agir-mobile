import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/survey/survey_l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class SurveySection extends StatelessWidget {
  const SurveySection({super.key});

  @override
  Widget build(final context) => ColoredBox(
    color: DsfrColors.blueFrance113,
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(paddingVerticalPage),
        child: Column(
          children: [
            const Text(
              SurveySectionL10n.title,
              style: DsfrTextStyle.bodyLgBold(color: Colors.white),
            ),
            const SizedBox(height: paddingVerticalPage),
            DsfrButton(
              label: SurveySectionL10n.button,
              icon: DsfrIcons.documentSurveyLine,
              variant: DsfrButtonVariant.secondary,
              foregroundColor: Colors.white,
              size: DsfrButtonSize.lg,
              onPressed:
                  () async => FnvUrlLauncher.launch(SurveySectionL10n.link),
            ),
          ],
        ),
      ),
    ),
  );
}
