import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({super.key, required this.title, required this.subTitle});

  final TextSpan title;
  final String subTitle;

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(title, style: const DsfrTextStyle.headline5()),
          const SizedBox(height: DsfrSpacings.s1v5),
          MarkdownBody(
            data: subTitle,
            styleSheet: MarkdownStyleSheet(p: const DsfrTextStyle.bodyMd()),
          ),
        ],
      );
}
