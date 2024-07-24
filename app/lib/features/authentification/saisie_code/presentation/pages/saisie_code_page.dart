import 'package:app/features/authentification/saisie_code/presentation/blocs/saisie_code_bloc.dart';
import 'package:app/features/authentification/saisie_code/presentation/blocs/saisie_code_event.dart';
import 'package:app/features/authentification/saisie_code/presentation/blocs/saisie_code_state.dart';
import 'package:app/features/authentification/saisie_code/presentation/pages/saisie_code_input.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SaisieCodePage extends StatelessWidget {
  const SaisieCodePage({super.key, required this.email});

  static const name = 'saisie-code';
  static const path = '$name/:email';

  final String email;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) =>
            SaisieCodePage(email: state.pathParameters['email']!),
      );

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: DsfrSpacings.s2w,
              right: DsfrSpacings.s2w,
              bottom: DsfrSpacings.s2w,
            ),
            child: BlocProvider(
              create: (final context) => SaisieCodeBloc(
                authentificationPort: context.read(),
                email: email,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    Localisation.entrezLeCodeRecuParMail,
                    style: DsfrTextStyle.headline2(),
                  ),
                  const SizedBox(height: DsfrSpacings.s1w),
                  Text(
                    Localisation.entrezLeCodeRecuParMailDetails(email),
                    style: const DsfrTextStyle.bodyXl(),
                  ),
                  const SizedBox(height: DsfrSpacings.s3w),
                  const SaisieCodeInput(),
                  const SizedBox(height: DsfrSpacings.s3w),
                  const _ButtonRenvoyerCode(),
                ],
              ),
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
      );
}

class _ButtonRenvoyerCode extends StatelessWidget {
  const _ButtonRenvoyerCode();

  void _handleRenvoyerCode(final BuildContext context) =>
      context.read<SaisieCodeBloc>().add(
            const SaiseCodeRenvoyerCodeDemandee(),
          );

  void _handleCodeRenvoye(final BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(Localisation.emailDeConnexionRenvoye)),
    );
  }

  @override
  Widget build(final BuildContext context) =>
      BlocListener<SaisieCodeBloc, SaisieCodeState>(
        listener: (final context, final state) => _handleCodeRenvoye(context),
        listenWhen: (final previous, final current) =>
            previous.renvoyerCodeDemandee != current.renvoyerCodeDemandee &&
            current.renvoyerCodeDemandee,
        child: DsfrLink.md(
          label: Localisation.renvoyerEmailDeConnexion,
          onPressed: () => _handleRenvoyerCode(context),
        ),
      );
}
