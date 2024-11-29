import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/progress_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/accueil/presentation/pages/home_page.dart';
import 'package:app/features/mission/actions/presentation/pages/mission_actions_page.dart';
import 'package:app/features/mission/mission/domain/mission_article.dart';
import 'package:app/features/mission/mission/domain/mission_code.dart';
import 'package:app/features/mission/mission/domain/mission_kyc.dart';
import 'package:app/features/mission/mission/domain/mission_quiz.dart';
import 'package:app/features/mission/mission/presentation/bloc/mission_bloc.dart';
import 'package:app/features/mission/mission/presentation/bloc/mission_event.dart';
import 'package:app/features/mission/mission/presentation/bloc/mission_state.dart';
import 'package:app/features/mission/mission/presentation/pages/mission_article_page.dart';
import 'package:app/features/mission/mission/presentation/pages/mission_fin_page.dart';
import 'package:app/features/mission/mission/presentation/pages/mission_introduction_page.dart';
import 'package:app/features/mission/mission/presentation/pages/mission_kyc_page.dart';
import 'package:app/features/mission/mission/presentation/pages/mission_quiz_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MissionPage extends StatelessWidget {
  const MissionPage({super.key, required this.code});

  static const name = 'mission';
  static const path = 'thematique/:thematique/mission/:mission';

  final MissionCode code;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => MissionPage(
          code: MissionCode(state.pathParameters['mission']!),
        ),
      );

  @override
  Widget build(final context) => BlocProvider(
        create: (final context) =>
            MissionBloc(missionRepository: context.read())
              ..add(MissionLoadRequested(code)),
        child: FnvScaffold(
          appBar: FnvAppBar(leading: const _BackButton()),
          body: const _View(),
        ),
      );
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(final context) => IconButton(
        iconSize: 24,
        padding: const EdgeInsets.all(DsfrSpacings.s1w),
        onPressed: () {
          final bloc = context.read<MissionBloc>();
          final state = bloc.state;
          if (state is MissionSuccess && state.index > 0) {
            bloc.add(const MissionPreviousRequested());
          } else {
            final goRouter = GoRouter.of(context);
            if (goRouter.canPop()) {
              goRouter.pop();
            } else {
              goRouter.goNamed(HomePage.name);
            }
          }
        },
        style: const ButtonStyle(
          shape: WidgetStatePropertyAll(roundedRectangleBorder),
        ),
        icon: const Icon(
          DsfrIcons.systemArrowLeftLine,
          color: DsfrColors.blueFranceSun113,
          semanticLabel: Localisation.retour,
        ),
      );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final context) => BlocBuilder<MissionBloc, MissionState>(
        builder: (final context, final state) => switch (state) {
          MissionInitial() || MissionFailure() => const SizedBox(),
          MissionLoading() => const Center(child: CircularProgressIndicator()),
          MissionSuccess() => _Success(state),
        },
      );
}

class _Success extends StatefulWidget {
  const _Success(this.state);

  final MissionSuccess state;

  @override
  State<_Success> createState() => _SuccessState();
}

class _SuccessState extends State<_Success> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.state.index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(final context) => BlocListener<MissionBloc, MissionState>(
        listener: (final context, final state) async {
          if (state is MissionSuccess &&
              state.index != _pageController.page?.round()) {
            await _pageController.animateToPage(
              state.index,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
            );
          }
        },
        child: Column(
          children: [
            FnvProgressBar(
              current: widget.state.index + 1,
              total: widget.state.steps.length,
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                pageSnapping: false,
                itemBuilder: (final context, final index) =>
                    index == widget.state.index
                        ? switch (widget.state.steps[index]) {
                            final MissionStepIntroduction s =>
                              MissionIntroductionPage(step: s),
                            final MissionStepObjectif s => switch (s.objectif) {
                                final MissionKyc a => MissionKycPage(value: a),
                                final MissionArticle a =>
                                  MissionArticlePage(value: a),
                                final MissionQuiz a =>
                                  MissionQuizPage(value: a),
                                _ => throw UnimplementedError(),
                              },
                            MissionStepActions _ =>
                              MissionActionsPage(code: widget.state.code),
                            final MissionStepFin s => MissionFinPage(step: s),
                          }
                        : const SizedBox(),
                itemCount: widget.state.steps.length,
              ),
            ),
          ],
        ),
      );
}
