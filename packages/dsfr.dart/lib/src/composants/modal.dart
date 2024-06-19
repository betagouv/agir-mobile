import 'package:dsfr/src/composants/buttons/button.dart';
import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/icons.g.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrModal extends StatelessWidget {
  const DsfrModal({super.key, required this.child});

  static Future<T?> showModal<T>({
    required final BuildContext context,
    required final WidgetBuilder builder,
  }) =>
      showModalBottomSheet<T>(
        context: context,
        builder: (final context) => DsfrModal(child: builder(context)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: const RoundedRectangleBorder(),
        barrierColor: DsfrColors.grey50.withOpacity(0.64),
        isScrollControlled: true,
      );

  final Widget child;

  @override
  Widget build(final BuildContext context) => ColoredBox(
        color: DsfrColors.grey1000,
        child: Padding(
          padding: const EdgeInsets.all(DsfrSpacings.s2w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: DsfrButton(
                  label: 'Fermer',
                  icon: DsfrIcons.systemCloseLine,
                  iconLocation: DsfrButtonIconLocation.right,
                  variant: DsfrButtonVariant.tertiaryWithouBorder,
                  size: DsfrButtonSize.sm,
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(height: DsfrSpacings.s1w),
              child,
            ],
          ),
        ),
      );
}
