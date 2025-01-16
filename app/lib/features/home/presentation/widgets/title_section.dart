import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({super.key, required this.title, required this.subTitle});

  final String title;
  final String subTitle;

  @override
  Widget build(final context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarkdownBody(
            data: title,
            styleSheet: MarkdownStyleSheet(
              p: const DsfrTextStyle.headline4(),
              strong: const DsfrTextStyle.headline4(
                color: DsfrColors.blueFranceSun113,
              ),
            ),
          ),
          const SizedBox(height: DsfrSpacings.s1v5),
          MarkdownBody(
            data: subTitle,
            styleSheet: MarkdownStyleSheet(p: const DsfrTextStyle.bodyMd()),
          ),
        ],
      );
}
