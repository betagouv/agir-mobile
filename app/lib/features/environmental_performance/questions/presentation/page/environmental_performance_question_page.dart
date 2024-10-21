import 'package:app/core/extensions/go_router.dart';
import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_bloc.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_state.dart';
import 'package:app/features/environmental_performance/questions/presentation/widgets/question_progress_bar.dart';
import 'package:app/features/environmental_performance/summary/presentation/page/environmental_performance_summary_page.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/form/mieux_vous_connaitre_controller.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/form/mieux_vous_connaitre_form.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EnvironmentalPerformanceQuestionPage extends StatelessWidget {
  const EnvironmentalPerformanceQuestionPage({
    super.key,
    required this.number,
  });

  static const name = 'bilan-question';
  static const path = '$name/:number';

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) =>
            EnvironmentalPerformanceQuestionPage(
          number: int.parse(state.pathParameters['number'] ?? '1'),
        ),
      );

  final int number;

  @override
  Widget build(final BuildContext context) => _View(number: number);
}

class _View extends StatefulWidget {
  const _View({required this.number});

  final int number;

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  final _mieuxVousConnaitreController = MieuxVousConnaitreController();

  @override
  void dispose() {
    _mieuxVousConnaitreController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: const FnvAppBar(),
        body: BlocBuilder<EnvironmentalPerformanceQuestionBloc,
            EnvironmentalPerformanceQuestionState>(
          builder: (final context, final state) => switch (state) {
            EnvironmentalPerformanceQuestionInitial() =>
              const SizedBox.shrink(),
            EnvironmentalPerformanceQuestionLoadSuccess() =>
              _LoadSuccess(state: state, number: widget.number),
            EnvironmentalPerformanceQuestionLoadFailure() =>
              const Text('Erreur'),
          },
        ),
        backgroundColor: FnvColors.aidesFond,
      );
}

class _LoadSuccess extends StatefulWidget {
  const _LoadSuccess({required this.state, required this.number});

  final EnvironmentalPerformanceQuestionLoadSuccess state;
  final int number;

  @override
  State<_LoadSuccess> createState() => _LoadSuccessState();
}

class _LoadSuccessState extends State<_LoadSuccess> {
  final _mieuxVousConnaitreController = MieuxVousConnaitreController();

  @override
  void dispose() {
    _mieuxVousConnaitreController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Column(
        children: [
          QuestionsProgressBar(
            current: widget.number,
            total: widget.state.questionIdList.length,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(paddingVerticalPage),
              children: [
                MieuxVousConnaitreForm(
                  id: widget.state.questionIdList[widget.number - 1].value,
                  controller: _mieuxVousConnaitreController,
                  onSaved: () async {
                    if (widget.number == widget.state.questionIdList.length) {
                      GoRouter.of(context).popUntilNamed(
                        EnvironmentalPerformanceSummaryPage.name,
                        result: true,
                      );

                      return;
                    }
                    await GoRouter.of(context).pushNamed(
                      EnvironmentalPerformanceQuestionPage.name,
                      pathParameters: {'number': '${widget.number + 1}'},
                    );
                  },
                ),
                const SizedBox(height: DsfrSpacings.s3w),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    child: DsfrButton(
                      label: Localisation.continuer,
                      variant: DsfrButtonVariant.primary,
                      size: DsfrButtonSize.lg,
                      onPressed: _mieuxVousConnaitreController.save,
                    ),
                  ),
                ),
                const SafeArea(child: SizedBox.shrink()),
              ],
            ),
          ),
        ],
      );
}
