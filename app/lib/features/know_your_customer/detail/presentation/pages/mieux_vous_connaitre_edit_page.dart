import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/bottom_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/mieux_vous_connaitre_controller.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/mieux_vous_connaitre_form.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MieuxVousConnaitreEditPage extends StatelessWidget {
  const MieuxVousConnaitreEditPage({super.key, required this.id});

  static const name = 'mieux-vous-connaitre-edit';
  static const path = '$name/:id';

  static GoRoute get route => GoRoute(
    path: path,
    name: name,
    builder: (final context, final state) => MieuxVousConnaitreEditPage(id: state.pathParameters['id']!),
  );

  final String id;

  @override
  Widget build(final context) => _View(id: id);
}

class _View extends StatefulWidget {
  const _View({required this.id});

  final String id;

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  final _mieuxVousConnaitreController = MieuxVousConnaitreController();

  @override
  void dispose() {
    _mieuxVousConnaitreController.dispose();
    super.dispose();
  }

  @override
  Widget build(final context) => FnvScaffold(
    appBar: FnvAppBar(),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(paddingVerticalPage),
      child: MieuxVousConnaitreForm(
        id: widget.id,
        controller: _mieuxVousConnaitreController,
        onSaved: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text(Localisation.miseAJourEffectuee)));
          GoRouter.of(context).pop<bool>(true);
        },
      ),
    ),
    bottomNavigationBar: FnvBottomBar(
      child: DsfrButton(
        label: Localisation.mettreAJour,
        icon: DsfrIcons.deviceSave3Fill,
        variant: DsfrButtonVariant.primary,
        size: DsfrButtonSize.lg,
        onPressed: _mieuxVousConnaitreController.save,
      ),
    ),
  );
}
