import 'package:app/core/presentation/widgets/composants/mot_de_passe/mot_de_passe.dart';
import 'package:app/features/profil/changer_mot_de_passe/presentation/bloc/changer_mot_de_passe_bloc.dart';
import 'package:app/features/profil/changer_mot_de_passe/presentation/bloc/changer_mot_de_passe_event.dart';
import 'package:app/features/profil/changer_mot_de_passe/presentation/bloc/changer_mot_de_passe_state.dart';
import 'package:app/features/profil/profil/presentation/widgets/profil_titre_partie.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangerMotDePasse extends StatelessWidget {
  const ChangerMotDePasse({super.key});

  @override
  Widget build(final context) => BlocProvider(
        create: (final context) =>
            ChangerMotDePasseBloc(profilPort: context.read()),
        child: const _ChangerMotDePasse(),
      );
}

class _ChangerMotDePasse extends StatelessWidget {
  const _ChangerMotDePasse();

  void _handleMotPasseEstChange(final BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(Localisation.changerVotreMotDePasseConfirmation),
      ),
    );
    GoRouter.of(context).pop();
  }

  @override
  Widget build(final context) =>
      BlocListener<ChangerMotDePasseBloc, ChangerMotDePasseState>(
        listener: (final context, final state) =>
            _handleMotPasseEstChange(context),
        listenWhen: (final previous, final current) =>
            previous.motPasseEstChange != current.motPasseEstChange &&
            current.motPasseEstChange,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfilTitrePartie(titre: Localisation.changerMonMotDePasse),
            SizedBox(height: DsfrSpacings.s2w),
            _MotDePasse(),
            SizedBox(height: DsfrSpacings.s3w),
            _ChangerMotDePasseButton(),
          ],
        ),
      );
}

class _MotDePasse extends StatelessWidget {
  const _MotDePasse();

  @override
  Widget build(final context) => FnvMotDePasse(
        onChanged: (final value) => context
            .read<ChangerMotDePasseBloc>()
            .add(ChangerMotDePasseAChange(value)),
      );
}

class _ChangerMotDePasseButton extends StatelessWidget {
  const _ChangerMotDePasseButton();

  @override
  Widget build(final context) => DsfrButton(
        label: Localisation.changerMonMotDePasse,
        variant: DsfrButtonVariant.primary,
        size: DsfrButtonSize.lg,
        onPressed: context.select<ChangerMotDePasseBloc, bool>(
          (final bloc) => bloc.state.estValide,
        )
            ? () => context
                .read<ChangerMotDePasseBloc>()
                .add(const ChangerMotDePasseChangementDemande())
            : null,
      );
}
