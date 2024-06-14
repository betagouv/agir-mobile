import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  static const name = 'profil';
  static const path = '/$name';

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const ProfilPage(),
      );

  @override
  Widget build(final BuildContext context) => const RootPage(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: DsfrSpacings.s3w),
            child: Text(Localisation.identitePersonnelle),
          ),
        ),
      );
}
