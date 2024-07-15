import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/app_bar.dart';
import 'package:app/shared/widgets/composants/bottom_bar.dart';
import 'package:app/shared/widgets/composants/html_widget.dart';
import 'package:app/shared/widgets/fondamentaux/colors.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuizExplicationPage extends StatelessWidget {
  const QuizExplicationPage({required this.explication, super.key});

  static const name = 'quiz-explication';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => QuizExplicationPage(
          explication: state.extra! as String,
        ),
      );

  final String explication;

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: const FnvAppBar(),
        body: ListView(
          padding: const EdgeInsets.all(DsfrSpacings.s3w),
          children: [
            const Text(Localisation.pourquoi, style: DsfrTextStyle.headline2()),
            const SizedBox(height: DsfrSpacings.s2w),
            FnvHtmlWidget(explication),
          ],
        ),
        bottomNavigationBar: FnvBottomBar(
          child: DsfrButton(
            label: Localisation.revenirAccueil,
            variant: DsfrButtonVariant.primary,
            size: DsfrButtonSize.lg,
            onPressed: () => GoRouter.of(context).pop(),
          ),
        ),
        backgroundColor: FnvColors.aidesFond,
      );
}
