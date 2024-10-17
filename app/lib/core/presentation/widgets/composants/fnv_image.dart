import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FnvImage extends StatelessWidget {
  const FnvImage.network(
    this.imageUrl, {
    super.key,
    this.width,
    this.height,
    this.semanticLabel,
    this.fit,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final String? semanticLabel;
  final BoxFit? fit;

  int? _cacheSize(final BuildContext context, {final double? value}) =>
      value == null
          ? null
          : (MediaQuery.devicePixelRatioOf(context) * value).round();

  @override
  Widget build(final BuildContext context) => imageUrl.endsWith('.svg')
      ? SizedBox(
          width: width,
          height: height,
          child: SvgPicture.network(
            imageUrl,
            width: width,
            height: height,
            fit: fit ?? BoxFit.cover,
            placeholderBuilder: (final context) =>
                SizedBox(width: width, height: height),
            semanticsLabel: semanticLabel,
          ),
        )
      : Image.network(
          imageUrl,
          loadingBuilder: (final context, final child, final loadingProgress) =>
              loadingProgress == null
                  ? child
                  : SizedBox(width: width, height: height),
          semanticLabel: semanticLabel,
          width: width,
          height: height,
          fit: fit,
          cacheWidth: _cacheSize(context, value: width),
          cacheHeight: _cacheSize(context, value: height),
        );
}
