import 'package:dsfr/dsfr.dart';
import 'package:dsfr_example/page_item.dart';
import 'package:flutter/material.dart';

class ButtonsPage extends StatelessWidget {
  const ButtonsPage({super.key});

  static final model = PageItem(
    title: 'Bouton',
    pageBuilder: (final context) => const ButtonsPage(),
  );

  void _handleTap() {}

  @override
  Widget build(final context) {
    const label = 'Bouton';
    const gap = SizedBox(height: DsfrSpacings.s2w);

    final children = <Widget>[];
    for (final variant in DsfrButtonVariant.values) {
      for (final size in DsfrButtonSize.values) {
        children
          ..add(Text('variant: ${variant.name}, size: ${size.name}'))
          ..add(DsfrButton(label: label, variant: variant, size: size))
          ..add(
            DsfrButton(
              label: label,
              variant: variant,
              size: size,
              onPressed: _handleTap,
            ),
          )
          ..add(
            DsfrButton(
              label: label,
              icon: DsfrIcons.buildingsAncientGateFill,
              variant: variant,
              size: size,
              onPressed: _handleTap,
            ),
          )
          ..add(
            DsfrButton(
              label: label,
              icon: DsfrIcons.buildingsAncientGateFill,
              iconLocation: DsfrButtonIconLocation.right,
              variant: variant,
              size: size,
              onPressed: _handleTap,
            ),
          );
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children.separator(gap).toList(),
      ),
    );
  }
}
