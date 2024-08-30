import 'package:app/features/authentification/mot_de_passe_oublie/blocs/mot_de_passe_oublie_code/mot_de_passe_oublie_code_bloc.dart';
import 'package:app/features/authentification/mot_de_passe_oublie/blocs/mot_de_passe_oublie_code/mot_de_passe_oublie_code_event.dart';
import 'package:app/features/authentification/mot_de_passe_oublie/blocs/mot_de_passe_oublie_code/mot_de_passe_oublie_code_state.dart';
import 'package:app/features/authentification/presentation/pages/se_connecter_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/extensions/go_router.dart';
import 'package:app/shared/widgets/composants/alert.dart';
import 'package:app/shared/widgets/composants/code_input.dart';
import 'package:app/shared/widgets/composants/mot_de_passe/mot_de_passe.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

class MotDePasseOublieCodePage extends StatelessWidget {
  const MotDePasseOublieCodePage({super.key, required this.email});

  static const name = 'mot-de-passe-oublie-code';
  static const path = '$name/:email';

  final String email;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => MotDePasseOublieCodePage(
          email: state.pathParameters['email']!,
        ),
      );

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => MotDePasseOublieCodeBloc(
          authentificationPort: context.read(),
          email: email,
        ),
        child: _View(email: email),
      );
}

class _View extends StatelessWidget {
  const _View({required this.email});

  final String email;

  void _handleMotDePasseModifie(final BuildContext context) {
    GoRouter.of(context).popUntilNamed(SeConnecterPage.path);
    // while (GoRouter.of(context)
    //         .routerDelegate
    //         .currentConfiguration
    //         .last
    //         .route
    //         .name !=
    //     SeConnecterPage.name) {
    //   GoRouter.of(context).pop();
    // }
  }

  @override
  Widget build(final BuildContext context) =>
      BlocListener<MotDePasseOublieCodeBloc, MotDePasseOublieCodeState>(
        listener: (final context, final state) =>
            _handleMotDePasseModifie(context),
        listenWhen: (final previous, final current) =>
            previous.motDePasseModifie != current.motDePasseModifie &&
            current.motDePasseModifie,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113),
          ),
          body: ListView(
            padding: const EdgeInsets.all(paddingVerticalPage),
            children: [
              const Text(
                Localisation.motDePasseOublieTitre2,
                style: DsfrTextStyle.headline2(),
              ),
              const SizedBox(height: DsfrSpacings.s1w),
              Text(
                Localisation.entrezLeCodeRecuOublieMotDePasseParMailDetails(
                  email,
                ),
                style: const DsfrTextStyle.bodyLg(),
              ),
              const SizedBox(height: DsfrSpacings.s2w),
              const _Code(),
              const SizedBox(height: DsfrSpacings.s2w),
              const Align(
                alignment: Alignment.centerLeft,
                child: _ButtonRenvoyerCode(),
              ),
              const SizedBox(height: DsfrSpacings.s4w),
              const _MotDePasse(),
              const _MessageErreur(),
              const SizedBox(height: DsfrSpacings.s2w),
              DsfrButton(
                label: Localisation.valider,
                variant: DsfrButtonVariant.primary,
                size: DsfrButtonSize.lg,
                onPressed: () => context
                    .read<MotDePasseOublieCodeBloc>()
                    .add(const MotDePasseOublieCodeValidationDemande()),
              ),
            ],
          ),
        ),
      );
}

class _Code extends StatelessWidget {
  const _Code();

  void _handleCode(final BuildContext context, final String value) {
    if (value.length == 6) {
      context
          .read<MotDePasseOublieCodeBloc>()
          .add(MotDePasseOublieCodeCodeChange(value));
    }
  }

  @override
  Widget build(final BuildContext context) => FnvCodeInput(
        onChanged: (final value) => _handleCode(context, value),
      );
}

class _ButtonRenvoyerCode extends StatelessWidget {
  const _ButtonRenvoyerCode();

  void _handleRenvoyerCode(final BuildContext context) =>
      context.read<MotDePasseOublieCodeBloc>().add(
            const MotDePasseOublieCodeRenvoyerCodeDemande(),
          );

  @override
  Widget build(final BuildContext context) =>
      BlocListener<MotDePasseOublieCodeBloc, MotDePasseOublieCodeState>(
        listener: (final context, final state) =>
            ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(Localisation.emailDeConnexionRenvoye)),
        ),
        listenWhen: (final previous, final current) =>
            previous.renvoyerCodeDemande != current.renvoyerCodeDemande &&
            current.renvoyerCodeDemande,
        child: DsfrLink.md(
          label: Localisation.renvoyerCode,
          onPressed: () => _handleRenvoyerCode(context),
        ),
      );
}

class _MotDePasse extends StatelessWidget {
  const _MotDePasse();

  void _handleMotDePasse(final BuildContext context, final String value) {
    context
        .read<MotDePasseOublieCodeBloc>()
        .add(MotDePasseOublieCodeMotDePasseChange(value));
  }

  @override
  Widget build(final context) => FnvMotDePasse(
        onChanged: (final value) => _handleMotDePasse(context, value),
      );
}

class _MessageErreur extends StatelessWidget {
  const _MessageErreur();

  @override
  Widget build(final BuildContext context) => context
      .select<MotDePasseOublieCodeBloc, Option<String>>(
        (final bloc) => bloc.state.erreur,
      )
      .match(
        () => const SizedBox.shrink(),
        (final t) => Column(
          children: [
            const SizedBox(height: DsfrSpacings.s2w),
            FnvAlert.error(label: t),
          ],
        ),
      );
}
