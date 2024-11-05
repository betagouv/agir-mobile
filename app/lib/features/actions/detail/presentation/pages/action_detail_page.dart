import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/bottom_bar.dart';
import 'package:app/core/presentation/widgets/composants/html_widget.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/actions/core/domain/action_id.dart';
import 'package:app/features/actions/detail/presentation/bloc/action_detail_bloc.dart';
import 'package:app/features/actions/detail/presentation/bloc/action_detail_event.dart';
import 'package:app/features/actions/detail/presentation/bloc/action_detail_state.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ActionDetailPage extends StatelessWidget {
  const ActionDetailPage({super.key, required this.actionId});

  static const name = 'action-detail';
  static const path = 'action/:id';

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => ActionDetailPage(
          actionId: ActionId(state.pathParameters['id']!),
        ),
      );

  final ActionId actionId;

  @override
  Widget build(final context) => BlocProvider(
        create: (final context) => ActionDetailBloc(
          repository: context.read(),
        )..add(ActionDetailLoadRequested(actionId)),
        child: const _View(),
      );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final context) =>
      BlocListener<ActionDetailBloc, ActionDetailState>(
        listener: (final context, final state) {
          switch (state) {
            case ActionDetailUpdateSuccess():
              context.pop(true);
            case ActionDetailUpdateIgnored():
              context.pop(false);
            default:
              break;
          }
        },
        child: Scaffold(
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
      BlocBuilder<ActionDetailBloc, ActionDetailState>(
        builder: (final context, final state) => switch (state) {
          ActionDetailInitial() ||
          ActionDetailUpdateSuccess() ||
          ActionDetailUpdateIgnored() =>
            const SizedBox(),
          ActionDetailLoadInProgress() => const Center(
              child: CircularProgressIndicator(),
            ),
          ActionDetailLoadSuccess() => _SuccessContent(state: state),
          ActionDetailLoadFailure() => const Text('Oups'),
        },
      );
}

class _SuccessContent extends StatelessWidget {
  const _SuccessContent({required this.state});

  final ActionDetailLoadSuccess state;

  @override
  Widget build(final context) => ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: [
          Text(state.action.theme, style: const DsfrTextStyle.bodySm()),
          const SizedBox(height: DsfrSpacings.s1w),
          FnvTitle(title: state.action.title),
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
                  .read<ActionDetailBloc>()
                  .add(ActionDetailResponseSubmitted(value));
            },
            initialValue: state.isAccepted,
          ),
          if (state.isAccepted ?? true) ...[
            const SizedBox(height: DsfrSpacings.s4w),
            const Text(
              Localisation.bonnesAstucesPourRealiserCeDefi,
              style: DsfrTextStyle.headline4(),
            ),
            const SizedBox(height: DsfrSpacings.s1w),
            FnvHtmlWidget(state.action.tips),
            const SizedBox(height: DsfrSpacings.s4w),
            const Text(
              Localisation.pourquoiCeDefi,
              style: DsfrTextStyle.headline4(),
            ),
            const SizedBox(height: DsfrSpacings.s1w),
            FnvHtmlWidget(state.action.why),
          ] else ...[
            const SizedBox(height: DsfrSpacings.s2w),
            const Text(
              Localisation.cetteActionNeVousConvientPas,
              style: DsfrTextStyle.headline3(),
            ),
            const SizedBox(height: DsfrSpacings.s2w),
            DsfrInput(
              label: Localisation.cetteActionNeVousConvientPasDetails,
              initialValue: state.action.reason,
              onChanged: (final value) => context
                  .read<ActionDetailBloc>()
                  .add(ActionDetailReasonChanged(value)),
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
                .read<ActionDetailBloc>()
                .add(const ActionDetailValidatePressed());
          },
        ),
      );
}
