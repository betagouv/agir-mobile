import 'dart:io';

import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/features/upgrade/presentation/bloc/upgrade_bloc.dart';
import 'package:app/features/upgrade/presentation/bloc/upgrade_state.dart';
import 'package:app/features/upgrade/upgrade_l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpgradeWidget extends StatelessWidget {
  const UpgradeWidget({
    super.key,
    required this.navigatorKey,
    required this.child,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;

  @override
  Widget build(final context) => BlocListener<UpgradeBloc, UpgradeState>(
    listener: (final context, final state) async {
      if (state is! UpgradeRequired || navigatorKey.currentContext == null) {
        return;
      }

      await DsfrModal.showModal<void>(
        context: navigatorKey.currentContext!,
        builder: (final context) => const _UpgradeModal(),
        name: 'upgrade-modal',
        isDismissible: false,
      );
    },
    child: child,
  );
}

class _UpgradeModal extends StatelessWidget {
  const _UpgradeModal();

  @override
  Widget build(final context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Text(UpgradeL10n.title, style: DsfrTextStyle.headline4()),
      const SizedBox(height: DsfrSpacings.s2w),
      const Text(UpgradeL10n.content, style: DsfrTextStyle.bodyMd()),
      const SizedBox(height: DsfrSpacings.s4w),
      DsfrButton(
        label: UpgradeL10n.button,
        variant: DsfrButtonVariant.primary,
        size: DsfrButtonSize.lg,
        onPressed: () async {
          final url =
              Platform.isIOS
                  ? 'https://apps.apple.com/app/6504984321'
                  : 'https://play.google.com/store/apps/details?id=fr.gouv.agir';
          try {
            await FnvUrlLauncher.launch(url);
          } on PlatformException catch (_) {}
        },
      ),
    ],
  );
}
