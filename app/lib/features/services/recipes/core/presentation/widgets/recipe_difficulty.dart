import 'package:dsfr/dsfr.dart';
import 'package:flutter/widgets.dart';

class RecipeDifficulty extends StatelessWidget {
  const RecipeDifficulty({super.key, required this.value});

  final String value;

  @override
  Widget build(final BuildContext context) => DsfrTag.sm(
    label: TextSpan(text: value),
    backgroundColor: const Color(0xffEAEAEA),
    foregroundColor: const Color(0xff3F3F3F),
    textStyle: const DsfrTextStyle.bodyXsMedium(),
  );
}
