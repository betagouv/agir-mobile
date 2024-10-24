import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingIllustration extends StatelessWidget {
  const OnboardingIllustration({required this.assetName, super.key});

  final String assetName;

  @override
  Widget build(final BuildContext context) => SizedBox.square(
        dimension: 165,
        child: SvgPicture.asset(assetName),
      );
}
