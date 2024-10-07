import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FnvImage extends StatelessWidget {
  const FnvImage.network(
    this.imageUrl, {
    super.key,
    this.width,
    this.height,
    this.semanticLabel,
    this.colorBlendMode,
    this.fit,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final String? semanticLabel;
  final BlendMode? colorBlendMode;
  final BoxFit? fit;

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
            colorFilter: colorBlendMode == null
                ? null
                : ColorFilter.mode(Colors.black, colorBlendMode!),
            semanticsLabel: semanticLabel,
          ),
        )
      : Image.network(
          imageUrl,
          semanticLabel: semanticLabel,
          width: width,
          height: height,
          colorBlendMode: colorBlendMode,
          fit: fit,
        );
}
