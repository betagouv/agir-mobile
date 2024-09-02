import 'package:app/features/mieux_vous_connaitre/presentation/element/widgets/form/mieux_vous_connaitre_controller.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/element/widgets/form/mieux_vous_connaitre_form.dart';
import 'package:app/features/univers/presentation/pages/mission_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/extensions/go_router.dart';
import 'package:app/shared/widgets/composants/app_bar.dart';
import 'package:app/shared/widgets/composants/bottom_bar.dart';
import 'package:app/shared/widgets/fondamentaux/colors.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MissionKycPage extends StatelessWidget {
  const MissionKycPage({super.key, required this.ids});

  static const name = 'mission-kyc';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) {
          final extra = state.extra;

          if (extra is List<String>) {
            return MissionKycPage(ids: extra);
          }
          throw Exception('ids is required');
        },
      );

  final List<String> ids;

  @override
  Widget build(final BuildContext context) {
    final mieuxVousConnaitreController = MieuxVousConnaitreController();

    return Scaffold(
      appBar: const FnvAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        child: MieuxVousConnaitreForm(
          id: ids.first,
          controller: mieuxVousConnaitreController,
          onSaved: () async {
            final newIds = List<String>.of(ids)..removeAt(0);
            if (newIds.isNotEmpty) {
              await GoRouter.of(context)
                  .pushNamed(MissionKycPage.name, extra: newIds);
            } else {
              GoRouter.of(context).popUntilNamed(MissionPage.name);
            }
          },
        ),
      ),
      bottomNavigationBar: FnvBottomBar(
        child: DsfrButton(
          label: Localisation.continuer,
          variant: DsfrButtonVariant.primary,
          size: DsfrButtonSize.lg,
          onPressed: mieuxVousConnaitreController.save,
        ),
      ),
      backgroundColor: FnvColors.aidesFond,
    );
  }
}
