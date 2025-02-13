import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/svg.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/features/home/presentation/pages/home_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FnvErrorRoutePage extends StatelessWidget {
  const FnvErrorRoutePage({super.key});

  @override
  Widget build(final context) => FnvScaffold(
    body: ListView(
      padding: MediaQuery.paddingOf(context).copyWith(left: DsfrSpacings.s2w, right: DsfrSpacings.s2w),
      children: [
        const Text(Localisation.erreurRoutePageTitre, style: DsfrTextStyle.headline3()),
        FnvSvg.asset(AssetImages.errorIllustration),
        const Text(Localisation.erreurRoutePageDescription, style: DsfrTextStyle.bodyXl()),
        const SizedBox(height: DsfrSpacings.s4w),
        DsfrButton(
          label: Localisation.erreurRoutePageAction,
          variant: DsfrButtonVariant.primary,
          size: DsfrButtonSize.lg,
          onPressed: () => context.go(HomePage.path),
        ),
      ],
    ),
  );
}
