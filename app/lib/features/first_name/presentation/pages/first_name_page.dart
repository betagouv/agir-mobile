import 'package:app/features/authentification/questions/presentation/pages/question_code_postal_page.dart';
import 'package:app/features/first_name/application/use_cases/add_first_name.dart';
import 'package:app/features/first_name/domain/value_objects/first_name.dart';
import 'package:app/features/first_name/presentation/bloc/first_name_bloc.dart';
import 'package:app/features/first_name/presentation/bloc/first_name_event.dart';
import 'package:app/features/first_name/presentation/bloc/first_name_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/assets/images.dart';
import 'package:app/shared/widgets/composants/alert.dart';
import 'package:app/shared/widgets/composants/bottom_bar.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
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

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const FirstNamePage(),
      );

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => FirstNameBloc(AddFirstName(context.read())),
        child: Builder(
          builder: (final context) =>
              BlocListener<FirstNameBloc, FirstNameState>(
            listener: (final context, final state) async {
              if (state is FirstNameSuccess) {
                await GoRouter.of(context)
                    .pushNamed(QuestionCodePostalPage.name);
              }
            },
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                iconTheme:
                    const IconThemeData(color: DsfrColors.blueFranceSun113),
              ),
              body: ListView(
                padding: const EdgeInsets.all(paddingVerticalPage),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      AssetsImages.illustration1,
                      width: 208,
                      height: 141,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: DsfrSpacings.s3w),
                  MarkdownBody(
                    data: Localisation.questionCourantSurMax(1, 3),
                    styleSheet: MarkdownStyleSheet(
                      p: const DsfrTextStyle.bodyMd(
                        color: DsfrColors.blueFranceSun113,
                      ),
                    ),
                  ),
                  const SizedBox(height: DsfrSpacings.s2w),
                  const Text(
                    Localisation.bienvenueSurAgir,
                    style: DsfrTextStyle.headline2(),
                  ),
                  const SizedBox(height: DsfrSpacings.s2w),
                  const Text(
                    Localisation.bienvenueSurAgirDetails,
                    style: DsfrTextStyle.bodyLg(lineHeight: 28),
                  ),
                  const SizedBox(height: DsfrSpacings.s3w),
                  DsfrInput(
                    label: Localisation.votrePrenom,
                    onChanged: (final value) {
                      context.read<FirstNameBloc>().add(
                            FirstNameChanged(FirstName.create(value)),
                          );
                    },
                    keyboardType: TextInputType.name,
                  ),
                  BlocSelector<FirstNameBloc, FirstNameState, Option<String>>(
                    selector: (final state) => switch (state) {
                      FirstNameFailure() => Some(state.errorMessage),
                      _ => const None(),
                    },
                    builder: (final context, final state) => state.match(
                      () => const SizedBox.shrink(),
                      (final t) => Column(
                        children: [
                          const SizedBox(height: DsfrSpacings.s2w),
                          FnvAlert.error(label: t),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar:
                  BlocSelector<FirstNameBloc, FirstNameState, bool>(
                selector: (final state) => switch (state) {
                  FirstNameEntered() => state.firstName.value.isNotEmpty,
                  _ => false,
                },
                builder: (final context, final state) => FnvBottomBar(
                  child: DsfrButton(
                    label: Localisation.continuer,
                    variant: DsfrButtonVariant.primary,
                    size: DsfrButtonSize.lg,
                    onPressed: state
                        ? () => context.read<FirstNameBloc>().add(
                              const FirstNameUpdatePressed(),
                            )
                        : null,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}