import 'package:app/features/profil/presentation/widgets/profil_title.dart';
import 'package:app/features/univers/domain/value_objects/defi_id.dart';
import 'package:app/features/univers/presentation/blocs/defi_bloc.dart';
import 'package:app/features/univers/presentation/blocs/defi_event.dart';
import 'package:app/features/univers/presentation/blocs/defi_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/widgets/composants/app_bar.dart';
import 'package:app/shared/widgets/composants/bottom_bar.dart';
import 'package:app/shared/widgets/composants/html_widget.dart';
import 'package:app/shared/widgets/fondamentaux/colors.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DefiPage extends StatelessWidget {
  const DefiPage({super.key, required this.id});

  static const name = 'defi';
  static const path = '$name/:id';

  final String id;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) =>
            DefiPage(id: state.pathParameters['id']!),
      );

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => DefiBloc(universPort: context.read())
          ..add(DefiRecuperationDemande(DefiId(id))),
        child: const Scaffold(
          appBar: FnvAppBar(),
          body: _View(),
          bottomNavigationBar: FnvBottomBar(child: _Boutons()),
          backgroundColor: FnvColors.aidesFond,
        ),
      );
}

class _Boutons extends StatelessWidget {
  const _Boutons();

  @override
  Widget build(final BuildContext context) => BlocListener<DefiBloc, DefiState>(
        listener: (final context, final state) {
          GoRouter.of(context).pop();
        },
        listenWhen: (final previous, final current) =>
            current is DefiSucces && current.estMiseAJour,
        child: DsfrButton(
          label: Localisation.valider,
          variant: DsfrButtonVariant.primary,
          size: DsfrButtonSize.lg,
          onPressed: () {
            context.read<DefiBloc>().add(const DefiValidationDemande());
          },
        ),
      );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => BlocBuilder<DefiBloc, DefiState>(
        builder: (final context, final state) => switch (state) {
          DefiInitial() => const SizedBox.shrink(),
          DefiChargement() => const Center(child: CircularProgressIndicator()),
          DefiSucces() => _Succes(state: state),
          DefiError() => const Center(child: Text('Erreur')),
        },
      );
}

class _Succes extends StatelessWidget {
  const _Succes({required this.state});

  final DefiSucces state;

  @override
  Widget build(final BuildContext context) {
    final defi = state.defi;

    return ListView(
      padding: const EdgeInsets.all(paddingVerticalPage),
      children: [
        Text(defi.thematique, style: const DsfrTextStyle.bodySm()),
        const SizedBox(height: DsfrSpacings.s1w),
        ProfilTitle(title: defi.titre),
        if (defi.status == 'en_cours')
          DsfrRadioButtonSetHeadless(
            values: const {
              true: DsfrRadioButtonItem('Défi réalisé'),
              false: DsfrRadioButtonItem('Finalement, pas pour moi'),
            },
            onCallback: (final value) {
              if (value != null) {
                context.read<DefiBloc>().add(
                      value
                          ? const DefiRealiseDemande()
                          : const DefiAbandonDemande(),
                    );
              }
            },
          )
        else
          DsfrRadioButtonSetHeadless(
            values: const {
              true: DsfrRadioButtonItem(Localisation.jeReleveLeDefi),
              false: DsfrRadioButtonItem(Localisation.pasPourMoi),
            },
            onCallback: (final value) {
              if (value != null) {
                context.read<DefiBloc>().add(
                      value
                          ? const DefiReleveDemande()
                          : const DefiNeRelevePasDemande(),
                    );
              }
            },
          ),
        _TextField(state),
        const SizedBox(height: DsfrSpacings.s2w),
        FnvHtmlWidget(defi.astuces),
        const SizedBox(height: DsfrSpacings.s4w),
        const Text(
          Localisation.pourquoiCeDefi,
          style: DsfrTextStyle.headline4(),
        ),
        const SizedBox(height: DsfrSpacings.s1w),
        FnvHtmlWidget(defi.pourquoi),
      ],
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField(this.state);

  final DefiSucces state;

  @override
  Widget build(final BuildContext context) => state.veutRelever.fold(
        SizedBox.new,
        (final value) => value
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: DsfrSpacings.s2w),
                  const Text(
                    Localisation.cetteActionNeVousConvientPas,
                    style: DsfrTextStyle.headline3(),
                  ),
                  const SizedBox(height: DsfrSpacings.s2w),
                  DsfrInput(
                    label: Localisation.cetteActionNeVousConvientPasDetails,
                    onChanged: (final value) {
                      context
                          .read<DefiBloc>()
                          .add(DefiNeRelevePasMotifChange(value));
                    },
                  ),
                ],
              ),
      );
}
