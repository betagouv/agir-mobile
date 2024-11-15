import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingIllustration extends StatelessWidget {
  const OnboardingIllustration({super.key, required this.assetName});

  final String assetName;

  @override
  Widget build(final context) => SizedBox.square(
        dimension: 165,
        child: SvgPicture.asset(assetName),
      );
}
