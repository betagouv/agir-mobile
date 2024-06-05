import 'dart:ui';

import 'package:dsfr/dsfr.dart';

abstract final class FnvTextStyles {
  const FnvTextStyles._();

  static const appBarTitleStyle = DsfrFonts.bodyMd;

  static const prixExplicationsStyle =
      DsfrTextStyle(fontSize: 14, fontWeight: FontWeight.bold);
}
