import 'package:dsfr/src/composants/buttons/button.dart';
import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/icons.g.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrModal extends StatelessWidget {
  const DsfrModal({
    super.key,
    required this.isDismissible,
    required this.child,
  });

  static Future<T?> showModal<T>({
    required final BuildContext context,
    required final WidgetBuilder builder,
    required final String name,
    final bool isDismissible = true,
  }) async => showModalBottomSheet<T>(
    context: context,
    builder:
        (final context) =>
            DsfrModal(isDismissible: isDismissible, child: builder(context)),
    backgroundColor: Colors.transparent,
    elevation: 0,
    shape: const RoundedRectangleBorder(),
    barrierColor: DsfrColors.grey50.withAlpha(163),
    isScrollControlled: true,
    isDismissible: isDismissible,
    routeSettings: RouteSettings(name: name),
  );

  final Widget child;
  final bool isDismissible;

  @override
  Widget build(final context) => ColoredBox(
    color: DsfrColors.grey1000,
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(DsfrSpacings.s2w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isDismissible) ...[
              Row(
                children: [
                  const Spacer(),
                  DsfrButton(
                    label: 'Fermer',
                    icon: DsfrIcons.systemCloseLine,
                    iconLocation: DsfrButtonIconLocation.right,
                    variant: DsfrButtonVariant.tertiaryWithouBorder,
                    size: DsfrButtonSize.sm,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: DsfrSpacings.s1w),
            ],
            child,
          ],
        ),
      ),
    ),
  );
}
