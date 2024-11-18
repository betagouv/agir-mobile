// ignore_for_file: prefer-single-widget-per-file

import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class FnvTitle extends StatelessWidget {
  const FnvTitle({required this.title, this.subtitle, super.key});

  final String title;
  final String? subtitle;

  @override
  Widget build(final context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarkdownBody(
            data: title,
            styleSheet: MarkdownStyleSheet(
              p: const DsfrTextStyle.headline2(),
              strong: const DsfrTextStyle.headline2(
                color: DsfrColors.blueFranceSun113,
              ),
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: DsfrSpacings.s1v5),
            Text(subtitle!, style: const DsfrTextStyle.bodyMd()),
          ],
          const SizedBox(height: DsfrSpacings.s2w),
          const DsfrDivider(
            width: DsfrSpacings.s4w,
            height: DsfrSpacings.s0v5,
            color: DsfrColors.blueFranceSun113,
            alignment: Alignment.centerLeft,
          ),
        ],
      );
}
