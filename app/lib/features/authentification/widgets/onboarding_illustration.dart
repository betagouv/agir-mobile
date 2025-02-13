import 'package:app/core/infrastructure/svg.dart';
import 'package:flutter/material.dart';

class OnboardingIllustration extends StatelessWidget {
  const OnboardingIllustration({super.key, required this.assetName});

  final String assetName;

  @override
  Widget build(final context) => SizedBox.square(dimension: 165, child: FnvSvg.asset(assetName));
}
