import 'package:flutter/widgets.dart';

double adjustTextSize(final BuildContext context, final double fontSize) {
  final scale = MediaQuery.textScalerOf(context).scale(fontSize);

  return scale > fontSize ? scale : fontSize;
}
