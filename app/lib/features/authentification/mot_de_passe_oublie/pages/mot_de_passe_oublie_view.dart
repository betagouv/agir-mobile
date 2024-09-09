import 'package:app/features/authentification/mot_de_passe_oublie/blocs/mot_de_passe_oublie/mot_de_passe_oublie_bloc.dart';
import 'package:app/features/authentification/mot_de_passe_oublie/blocs/mot_de_passe_oublie/mot_de_passe_oublie_event.dart';
import 'package:app/features/authentification/mot_de_passe_oublie/pages/mot_de_passe_oublie_code_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MotDePasseOublieView extends StatelessWidget {
  const MotDePasseOublieView({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113),
        ),
        body: ListView(
          padding: const EdgeInsets.all(paddingVerticalPage),
          children: [
            const Text(
              Localisation.motDePasseOublieTitre,
              style: DsfrTextStyle.headline2(),
            ),
            const SizedBox(height: DsfrSpacings.s1w),
            const Text(
              Localisation.motDePasseOublieDetails,
              style: DsfrTextStyle.bodyLg(),
            ),
            const SizedBox(height: DsfrSpacings.s3w),
            DsfrInput(
              label: Localisation.adresseEmail,
              onChanged: (final value) =>
                  context.read<MotDePasseOublieBloc>().add(
                        MotDePasseOublieEmailChange(value),
                      ),
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: DsfrSpacings.s2w),
            const _Valider(),
          ],
        ),
      );
}

class _Valider extends StatelessWidget {
  const _Valider();

  @override
  Widget build(final BuildContext context) {
    final emailEstValide = context.select<MotDePasseOublieBloc, bool>(
      (final bloc) => bloc.state.emailEstValide,
    );

    return DsfrButton(
      label: Localisation.valider,
      variant: DsfrButtonVariant.primary,
      size: DsfrButtonSize.lg,
      onPressed: emailEstValide
          ? () async {
              final bloc = context.read<MotDePasseOublieBloc>()
                ..add(const MotDePasseOublieValider());
              await GoRouter.of(context).pushNamed(
                MotDePasseOublieCodePage.name,
                pathParameters: {'email': bloc.state.email},
              );
            }
          : null,
    );
  }
}