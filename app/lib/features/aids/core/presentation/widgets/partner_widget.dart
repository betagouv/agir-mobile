import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/articles/domain/partner.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class PartnerWidget extends StatelessWidget {
  const PartnerWidget({super.key, required this.partner});

  final Partner partner;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.all(DsfrSpacings.s1w),
    child: Row(
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border.fromBorderSide(BorderSide(color: Color(0xffb1b1ff))),
            borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1v5)),
          ),
          child: FnvImage.network(partner.logo, width: 40, height: 40),
        ),
        const SizedBox(width: DsfrSpacings.s1w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                Localisation.proposePar,
                style: DsfrTextStyle.bodySmItalic(
                  color: DsfrColors.blueFranceSun113,
                ),
              ),
              Text(
                partner.nom,
                style: const DsfrTextStyle.bodyMd(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
