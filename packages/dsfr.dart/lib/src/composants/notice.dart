import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/icons.g.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrNotice extends StatelessWidget {
  const DsfrNotice({
    super.key,
    required this.titre,
    required this.description,
    required this.onClose,
  });

  final String titre;
  final String description;
  final VoidCallback? onClose;

  @override
  Widget build(final BuildContext context) {
    const color = DsfrColors.info425;
    const textStyle = DsfrTextStyle(fontSize: 14, color: color);

    return ColoredBox(
      color: DsfrColors.info950,
      child: Padding(
        padding: const EdgeInsets.only(
          left: DsfrSpacings.s2w,
          top: DsfrSpacings.s3v,
          right: DsfrSpacings.s2w,
          bottom: DsfrSpacings.s2w,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: DsfrSpacings.s1w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(DsfrIcons.systemFrInfoFill, color: color),
                        const SizedBox(width: DsfrSpacings.s1w),
                        Expanded(
                          child: Text(
                            titre,
                            style:
                                textStyle.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Text(description, style: textStyle),
                  ],
                ),
              ),
            ),
            const SizedBox(width: DsfrSpacings.s1w),
            IconButton(
              iconSize: DsfrSpacings.s2w,
              onPressed: onClose,
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              icon: const Icon(
                DsfrIcons.systemCloseLine,
                color: color,
                semanticLabel: 'Masquer le message',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
