import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/bottom_bar.dart';
import 'package:app/core/presentation/widgets/composants/html_widget.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/challenges/core/domain/challenge_id.dart';
import 'package:app/features/challenges/detail/presentation/bloc/challenge_detail_bloc.dart';
import 'package:app/features/challenges/detail/presentation/bloc/challenge_detail_event.dart';
import 'package:app/features/challenges/detail/presentation/bloc/challenge_detail_state.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:app/features/theme/presentation/widgets/theme_type_tag.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChallengeDetailPage extends StatelessWidget {
  const ChallengeDetailPage({super.key, required this.id});

  static const name = 'defi-detail';
  static const path = 'defi/:id';

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => ChallengeDetailPage(
          id: ChallengeId(state.pathParameters['id']!),
        ),
      );

  final ChallengeId id;

  @override
  Widget build(final context) => BlocProvider(
        create: (final context) => ChallengeDetailBloc(
          repository: context.read(),
        )..add(ChallengeDetailLoadRequested(id)),
        child: const _View(),
      );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final context) =>
      BlocListener<ChallengeDetailBloc, ChallengeDetailState>(
        listener: (final context, final state) {
          switch (state) {
            case ChallengeDetailUpdateSuccess():
              context.pop(true);
            case ChallengeDetailUpdateIgnored():
              context.pop(false);
            default:
              break;
          }
        },
        child: FnvScaffold(
          appBar: FnvAppBar(),
          body: const _Body(),
          bottomNavigationBar: const _BottomBar(),
        ),
      );
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(final context) =>
      BlocBuilder<ChallengeDetailBloc, ChallengeDetailState>(
        builder: (final context, final state) => switch (state) {
          ChallengeDetailInitial() ||
          ChallengeDetailUpdateSuccess() ||
          ChallengeDetailUpdateIgnored() =>
            const SizedBox(),
          ChallengeDetailLoadInProgress() => const Center(
              child: CircularProgressIndicator(),
            ),
          ChallengeDetailLoadSuccess() => _SuccessContent(state: state),
          ChallengeDetailLoadFailure() => const Text('Oups'),
        },
      );
}

class _SuccessContent extends StatelessWidget {
  const _SuccessContent({required this.state});

  final ChallengeDetailLoadSuccess state;

  @override
  Widget build(final context) => ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: ThemeTypeTag(themeType: state.challenge.themeType),
          ),
          const SizedBox(height: DsfrSpacings.s1w),
          FnvTitle(title: state.challenge.title),
          const SizedBox(height: DsfrSpacings.s3w),
          DsfrRadioButtonSetHeadless(
            values: {
              true: DsfrRadioButtonItem(state.acceptanceText),
              false: DsfrRadioButtonItem(state.refusalText),
            },
            onCallback: (final value) {
              if (value == null) {
                return;
              }
              context
                  .read<ChallengeDetailBloc>()
                  .add(ChallengeDetailResponseSubmitted(value));
            },
            initialValue: state.isAccepted,
          ),
          if (state.isAccepted ?? true) ...[
            const SizedBox(height: DsfrSpacings.s4w),
            const Text(
              Localisation.bonnesAstucesPourRealiserCetteAction,
              style: DsfrTextStyle.headline4(),
            ),
            const SizedBox(height: DsfrSpacings.s1w),
            FnvHtmlWidget(state.challenge.tips),
            const SizedBox(height: DsfrSpacings.s4w),
            const Text(
              Localisation.pourquoiCetteAction,
              style: DsfrTextStyle.headline4(),
            ),
            const SizedBox(height: DsfrSpacings.s1w),
            FnvHtmlWidget(state.challenge.why),
          ] else ...[
            const SizedBox(height: DsfrSpacings.s2w),
            const Text(
              Localisation.cetteActionNeVousConvientPas,
              style: DsfrTextStyle.headline3(),
            ),
            const SizedBox(height: DsfrSpacings.s2w),
            DsfrInput(
              label: Localisation.cetteActionNeVousConvientPasDetails,
              initialValue: state.challenge.reason,
              onChanged: (final value) => context
                  .read<ChallengeDetailBloc>()
                  .add(ChallengeDetailReasonChanged(value)),
            ),
          ],
        ],
      );
}

class _BottomBar extends StatelessWidget {
  const _BottomBar();

  @override
  Widget build(final context) => FnvBottomBar(
        child: DsfrButton(
          label: Localisation.valider,
          variant: DsfrButtonVariant.primary,
          size: DsfrButtonSize.lg,
          onPressed: () {
            context
                .read<ChallengeDetailBloc>()
                .add(const ChallengeDetailValidatePressed());
          },
        ),
      );
}
