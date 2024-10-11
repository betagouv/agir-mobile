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
            semanticsLabel: semanticLabel,
          ),
        )
      : Image.network(
          imageUrl,
          semanticLabel: semanticLabel,
          width: width,
          height: height,
          fit: fit,
        );
}
