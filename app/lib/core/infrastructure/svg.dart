import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jovial_svg/jovial_svg.dart';

class FnvSvg extends StatelessWidget {
  FnvSvg.asset(
    final String assetName, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.semanticsLabel,
  }) : source = ScalableImageSource.fromSvg(rootBundle, assetName);

  FnvSvg.network(
    final String url, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.semanticsLabel,
  }) : source = ScalableImageSource.fromSvgHttpUrl(Uri.parse(url));

  final ScalableImageSource source;
  final BoxFit fit;
  final Alignment alignment;
  final double? width;
  final double? height;
  final String? semanticsLabel;

  @override
  Widget build(final BuildContext context) => SizedBox(
    width: width,
    height: height,
    child: Semantics(
      label: semanticsLabel,
      child: ScalableImageWidget.fromSISource(
        si: source,
        fit: fit,
        alignment: alignment,
        onLoading: (final context) => SizedBox(width: width, height: height),
      ),
    ),
  );
}
