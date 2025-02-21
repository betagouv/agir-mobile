import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  const DividerWithText({super.key});

  @override
  Widget build(final context) {
    final divider = Expanded(child: Container(color: const Color(0xffDFD9D9), height: 1));

    return Row(
      children: [
        divider,
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Text('Ou', style: TextStyle(color: DsfrColors.grey50)),
        ),
        divider,
      ],
    );
  }
}
