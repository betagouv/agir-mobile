import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class FnvAlertInfo extends StatelessWidget {
  const FnvAlertInfo({super.key, required this.label, this.content});

  final String label;
  final Widget? content;

  @override
  Widget build(final context) {
    Widget child = Row(
      children: [
        const Icon(
          DsfrIcons.systemQuestionLine,
          color: DsfrColors.blueFranceSun113,
        ),
        const SizedBox(width: DsfrSpacings.s1w),
        Expanded(
          child: MarkdownBody(
            data: label,
            styleSheet: MarkdownStyleSheet(
              p: const DsfrTextStyle(fontSize: 15),
            ),
          ),
        ),
      ],
    );
    if (content != null) {
      child = Column(children: [child, content!]);
    }

    return DecoratedBox(
      decoration: const ShapeDecoration(
        color: DsfrColors.info950,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: DsfrColors.blueFranceMain525),
          borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1w)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(DsfrSpacings.s2w),
        child: child,
      ),
    );
  }
}
