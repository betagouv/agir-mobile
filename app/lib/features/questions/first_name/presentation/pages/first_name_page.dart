import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/alert.dart';
import 'package:app/core/presentation/widgets/composants/bottom_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/questions/core/presentation/widgets/onboarding_illustration.dart';
import 'package:app/features/questions/first_name/domain/first_name.dart';
import 'package:app/features/questions/first_name/presentation/bloc/first_name_bloc.dart';
import 'package:app/features/questions/first_name/presentation/bloc/first_name_event.dart';
import 'package:app/features/questions/first_name/presentation/bloc/first_name_state.dart';
import 'package:app/features/questions/question_code_postal/presentation/pages/question_code_postal_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

class FirstNamePage extends StatelessWidget {
  const FirstNamePage({super.key});

  static const name = 'question-prenom';
  static const path = name;

  static GoRoute get route => GoRoute(path: path, name: name, builder: (final context, final state) => const FirstNamePage());

  void _handleSubmitted(final BuildContext context) {
    context.read<FirstNameBloc>().add(const FirstNameSubmitted());
  }

  @override
  Widget build(final context) => BlocProvider(
    create: (final context) => FirstNameBloc(repository: context.read(), clock: context.read()),
    child: Builder(
      builder:
          (final context) => BlocListener<FirstNameBloc, FirstNameState>(
            listener: (final context, final state) async {
              if (state is FirstNameSuccess) {
                await GoRouter.of(context).pushNamed(QuestionCodePostalPage.name);
              }
            },
            child: FnvScaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: FnvColors.homeBackground,
                iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113),
              ),
              body: ListView(
                padding: const EdgeInsets.all(paddingVerticalPage),
                children: [
                  MarkdownBody(
                    data: Localisation.questionCourantSurMax(1, 3),
                    styleSheet: MarkdownStyleSheet(p: const DsfrTextStyle.bodyMd(color: DsfrColors.blueFranceSun113)),
                  ),
                  const SizedBox(height: DsfrSpacings.s3v),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: OnboardingIllustration(assetName: AssetImages.illustration1),
                  ),
                  const Text(Localisation.bienvenueSur, style: DsfrTextStyle.headline2()),
                  const SizedBox(height: DsfrSpacings.s2w),
                  const Text(Localisation.bienvenueSurDetails, style: DsfrTextStyle.bodyLg()),
                  const SizedBox(height: DsfrSpacings.s3w),
                  DsfrInput(
                    label: Localisation.monPrenom,
                    onChanged: (final value) {
                      context.read<FirstNameBloc>().add(FirstNameChanged(FirstName.create(value)));
                    },
                    onFieldSubmitted: (final value) {
                      _handleSubmitted(context);
                    },
                    autofocus: true,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.givenName],
                  ),
                  BlocSelector<FirstNameBloc, FirstNameState, Option<String>>(
                    selector:
                        (final state) => switch (state) {
                          FirstNameFailure() => Some(state.errorMessage),
                          _ => const None(),
                        },
                    builder:
                        (final context, final state) => state.fold(
                          () => const SizedBox.shrink(),
                          (final t) => Column(children: [const SizedBox(height: DsfrSpacings.s2w), FnvAlert.error(label: t)]),
                        ),
                  ),
                ],
              ),
              bottomNavigationBar: BlocSelector<FirstNameBloc, FirstNameState, bool>(
                selector:
                    (final state) => switch (state) {
                      FirstNameEntered() => state.firstName.value.isNotEmpty,
                      FirstNameSuccess() => true,
                      _ => false,
                    },
                builder:
                    (final context, final state) => FnvBottomBar(
                      child: DsfrButton(
                        label: Localisation.continuer,
                        variant: DsfrButtonVariant.primary,
                        size: DsfrButtonSize.lg,
                        onPressed: state ? () => _handleSubmitted(context) : null,
                      ),
                    ),
              ),
            ),
          ),
    ),
  );
}
