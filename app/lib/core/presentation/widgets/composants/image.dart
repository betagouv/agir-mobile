import 'package:app/core/infrastructure/svg.dart';
import 'package:flutter/material.dart';

class FnvImage extends StatelessWidget {
  const FnvImage.asset(
    final String assetName, {
    super.key,
    this.alignment = Alignment.center,
    this.width,
    this.height,
    this.semanticLabel,
    this.fit = BoxFit.contain,
  }) : _imageUrl = null,
       _assetName = assetName;

  const FnvImage.network(
    final String imageUrl, {
    super.key,
    this.alignment = Alignment.center,
    this.width,
    this.height,
    this.semanticLabel,
    this.fit = BoxFit.contain,
  }) : _assetName = null,
       _imageUrl = imageUrl;

  final String? _assetName;
  final String? _imageUrl;
  final Alignment alignment;
  final double? width;
  final double? height;
  final String? semanticLabel;
  final BoxFit fit;

  @override
  Widget build(final context) =>
      _imageUrl == null
          ? _assetName!.endsWith('.svg')
              ? FnvSvg.asset(
                _assetName,
                width: width,
                height: height,
                fit: fit,
                alignment: alignment,
                semanticsLabel: semanticLabel,
              )
              : Image.asset(
                _assetName,
                semanticLabel: semanticLabel,
                width: width,
                height: height,
                fit: fit,
                alignment: alignment,
              )
          : _imageUrl.endsWith('.svg')
          ? FnvSvg.network(
            _imageUrl,
            width: width,
            height: height,
            fit: fit,
            alignment: alignment,
            semanticsLabel: semanticLabel,
          )
          : Image.network(
            _imageUrl,
            loadingBuilder:
                (final context, final child, final loadingProgress) =>
                    loadingProgress == null
                        ? child
                        : SizedBox(width: width, height: height),
            semanticLabel: semanticLabel,
            width: width,
            height: height,
            fit: fit,
            alignment: alignment,
          );
}
