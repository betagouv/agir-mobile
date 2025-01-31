import 'package:app/core/presentation/widgets/composants/alert.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/authentification/saisie_code/presentation/bloc/saisie_code_bloc.dart';
import 'package:app/features/authentification/saisie_code/presentation/bloc/saisie_code_event.dart';
import 'package:app/features/authentification/saisie_code/presentation/bloc/saisie_code_state.dart';
import 'package:app/features/authentification/saisie_code/presentation/widgets/saisie_code_input.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

class SaisieCodePage extends StatelessWidget {
  const SaisieCodePage({super.key, required this.email});

  static const name = 'validation-authentification';
  static const path = '$name/:email';

  final String email;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) =>
            SaisieCodePage(email: state.pathParameters['email']!),
      );

  @override
  Widget build(final context) => BlocProvider(
        create: (final context) => SaisieCodeBloc(
          authentificationRepository: context.read(),
          email: email,
        ),
        child: FnvScaffold(
          appBar: AppBar(
            backgroundColor: FnvColors.homeBackground,
            iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113),
          ),
          body: ListView(
            padding: const EdgeInsets.all(paddingVerticalPage),
            children: [
              const Text(
                Localisation.entrezLeCodeRecuParMail,
                style: DsfrTextStyle.headline2(),
              ),
              const SizedBox(height: DsfrSpacings.s1w),
              Text(
                Localisation.entrezLeCodeRecuParMailDetails(email),
                style: const DsfrTextStyle.bodyLg(),
              ),
              const SizedBox(height: DsfrSpacings.s3w),
              const SaisieCodeInput(),
              const _MessageErreur(),
              const SizedBox(height: DsfrSpacings.s3w),
              const Align(
                alignment: Alignment.centerLeft,
                child: _ButtonRenvoyerCode(),
              ),
            ],
          ),
        ),
      );
}

class _MessageErreur extends StatelessWidget {
  const _MessageErreur();

  @override
  Widget build(final context) => context
      .select<SaisieCodeBloc, Option<String>>(
        (final bloc) => bloc.state.erreur,
      )
      .fold(
        () => const SizedBox.shrink(),
        (final t) => Column(
          children: [
            const SizedBox(height: DsfrSpacings.s3w),
            FnvAlert.error(label: t),
          ],
        ),
      );
}

class _ButtonRenvoyerCode extends StatelessWidget {
  const _ButtonRenvoyerCode();

  @override
  Widget build(final context) => BlocListener<SaisieCodeBloc, SaisieCodeState>(
        listener: (final context, final state) =>
            ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(Localisation.emailDeConnexionRenvoye)),
        ),
        listenWhen: (final previous, final current) =>
            previous.renvoyerCodeDemande != current.renvoyerCodeDemande &&
            current.renvoyerCodeDemande,
        child: DsfrLink.md(
          label: Localisation.renvoyerEmailDeConnexion,
          onTap: () => context.read<SaisieCodeBloc>().add(
                const SaiseCodeRenvoyerCodeDemandee(),
              ),
        ),
      );
}
