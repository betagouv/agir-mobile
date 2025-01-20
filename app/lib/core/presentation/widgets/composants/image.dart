import 'package:app/core/infrastructure/svg.dart';
import 'package:flutter/material.dart';

class FnvImage extends StatelessWidget {
  const FnvImage.asset(
    this.assetName, {
    super.key,
    this.alignment = Alignment.center,
    this.width,
    this.height,
    this.semanticLabel,
    this.fit = BoxFit.contain,
  }) : imageUrl = null;

  const FnvImage.network(
    this.imageUrl, {
    super.key,
    this.alignment = Alignment.center,
    this.width,
    this.height,
    this.semanticLabel,
    this.fit = BoxFit.contain,
  }) : assetName = null;

  final String? assetName;
  final String? imageUrl;
  final Alignment alignment;
  final double? width;
  final double? height;
  final String? semanticLabel;
  final BoxFit fit;

  int? _cacheSize(final BuildContext context, {final double? value}) =>
      value == null
          ? null
          : (MediaQuery.devicePixelRatioOf(context) * value).round();

  @override
  Widget build(final context) => imageUrl == null
      ? assetName!.endsWith('.svg')
          ? FnvSvg.asset(
              assetName!,
              width: width,
              height: height,
              fit: fit,
              alignment: alignment,
              semanticsLabel: semanticLabel,
            )
          : Image.asset(
              assetName!,
              semanticLabel: semanticLabel,
              width: width,
              height: height,
              fit: fit,
              alignment: alignment,
              cacheWidth: _cacheSize(context, value: width),
              cacheHeight: _cacheSize(context, value: height),
            )
      : imageUrl!.endsWith('.svg')
          ? FnvSvg.network(
              imageUrl!,
              width: width,
              height: height,
              fit: fit,
              alignment: alignment,
              semanticsLabel: semanticLabel,
            )
          : Image.network(
              imageUrl!,
              loadingBuilder: (
                final context,
                final child,
                final loadingProgress,
              ) =>
                  loadingProgress == null
                      ? child
                      : SizedBox(width: width, height: height),
              semanticLabel: semanticLabel,
              width: width,
              height: height,
              fit: fit,
              alignment: alignment,
              cacheWidth: _cacheSize(context, value: width),
              cacheHeight: _cacheSize(context, value: height),
            );
}
