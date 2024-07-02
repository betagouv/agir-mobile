import 'package:app/features/profil/changer_mot_de_passe/presentation/blocs/changer_mot_de_passe_bloc.dart';
import 'package:app/features/profil/changer_mot_de_passe/presentation/blocs/changer_mot_de_passe_event.dart';
import 'package:app/features/profil/changer_mot_de_passe/presentation/blocs/changer_mot_de_passe_state.dart';
import 'package:app/features/profil/presentation/widgets/profil_titre_partie.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangerMotDePasse extends StatelessWidget {
  const ChangerMotDePasse({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) =>
            ChangerMotDePasseBloc(profilPort: context.read()),
        child: const _ChangerMotDePasse(),
      );
}

class _ChangerMotDePasse extends StatelessWidget {
  const _ChangerMotDePasse();

  void _handleMotPasseEstChange(
    final ChangerMotDePasseState state,
    final BuildContext context,
  ) {
    if (!state.motPasseEstChange) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(Localisation.changerVotreMotDePasseConfirmation),
      ),
    );
    GoRouter.of(context).pop();
  }

  @override
  Widget build(final BuildContext context) =>
      BlocListener<ChangerMotDePasseBloc, ChangerMotDePasseState>(
        listener: (final context, final state) =>
            _handleMotPasseEstChange(state, context),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfilTitrePartie(titre: Localisation.changerVotreMotDePasse),
            SizedBox(height: DsfrSpacings.s2w),
            _MotDePasse(),
            SizedBox(height: DsfrSpacings.s3w),
            _ChangerMotDePasseButton(),
          ],
        ),
      );
}

class _ChangerMotDePasseButton extends StatelessWidget {
  const _ChangerMotDePasseButton();

  @override
  Widget build(final BuildContext context) => DsfrButton(
        label: Localisation.changerVotreMotDePasse,
        variant: DsfrButtonVariant.primary,
        size: DsfrButtonSize.lg,
        onTap: context.select<ChangerMotDePasseBloc, bool>(
          (final bloc) => bloc.state.estValide,
        )
            ? () => context
                .read<ChangerMotDePasseBloc>()
                .add(const ChangerMotDePasseChangementDemande())
            : null,
      );
}

class _MotDePasse extends StatelessWidget {
  const _MotDePasse();

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DsfrInput(
            label: Localisation.motDePasse,
            onChanged: (final value) => context
                .read<ChangerMotDePasseBloc>()
                .add(ChangerMotDePasseAChange(value)),
            isPasswordMode: true,
            keyboardType: TextInputType.visiblePassword,
          ),
          const Text(
            Localisation.votreMotDePasseDoitContenir,
            style: DsfrTextStyle.bodyXs(color: DsfrColors.grey425),
          ),
          const _DouzeCarateresMinimum(),
          const _AuMoinsUnMajusculeEtUneMinuscule(),
          const _UnCaractereSpecialMinimum(),
          const _UnChiffreMinimum(),
        ],
      );
}

class _DouzeCarateresMinimum extends StatelessWidget {
  const _DouzeCarateresMinimum();

  @override
  Widget build(final BuildContext context) => _DoitContenir(
        valid: context.select<ChangerMotDePasseBloc, bool>(
          (final bloc) => bloc.state.douzeCaracteresMinimum,
        ),
        text: Localisation.motDePasse12CaractresMinimum,
      );
}

class _AuMoinsUnMajusculeEtUneMinuscule extends StatelessWidget {
  const _AuMoinsUnMajusculeEtUneMinuscule();

  @override
  Widget build(final BuildContext context) => _DoitContenir(
        valid: context.select<ChangerMotDePasseBloc, bool>(
          (final bloc) => bloc.state.auMoinsUneMajusculeEtUneMinuscule,
        ),
        text: Localisation.motDePasse1MajusculeEt1Minuscule,
      );
}

class _UnCaractereSpecialMinimum extends StatelessWidget {
  const _UnCaractereSpecialMinimum();

  @override
  Widget build(final BuildContext context) => _DoitContenir(
        valid: context.select<ChangerMotDePasseBloc, bool>(
          (final bloc) => bloc.state.unCaractereSpecialMinimum,
        ),
        text: Localisation.motDePasse1CaractreSpecialMinimum,
      );
}

class _UnChiffreMinimum extends StatelessWidget {
  const _UnChiffreMinimum();

  @override
  Widget build(final BuildContext context) => _DoitContenir(
        valid: context.select<ChangerMotDePasseBloc, bool>(
          (final bloc) => bloc.state.unChiffreMinimum,
        ),
        text: Localisation.motDePasse1ChiffreMinimum,
      );
}

class _DoitContenir extends StatelessWidget {
  const _DoitContenir({required this.valid, required this.text});

  final bool valid;
  final String text;

  @override
  Widget build(final BuildContext context) => DsfrFormMessage(
        type: valid ? DsfrFormMessageType.valid : DsfrFormMessageType.info,
        text: text,
      );
}
