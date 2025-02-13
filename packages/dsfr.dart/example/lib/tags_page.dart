import 'package:dsfr/dsfr.dart';
import 'package:dsfr_example/page_item.dart';
import 'package:flutter/material.dart';

class TagsPage extends StatelessWidget {
  const TagsPage({super.key});

  static final model = PageItem(title: 'Tags', pageBuilder: (final context) => const TagsPage());

  @override
  Widget build(final context) => const SingleChildScrollView(
    padding: EdgeInsets.all(DsfrSpacings.s2w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s1w,
      children: [
        DsfrTag.sm(
          label: TextSpan(text: 'Label tag'),
          backgroundColor: DsfrColors.blueFrance925,
          foregroundColor: DsfrColors.blueFranceSun113,
        ),
        DsfrTag.sm(
          label: TextSpan(text: 'Label tag'),
          backgroundColor: DsfrColors.blueFrance925,
          foregroundColor: DsfrColors.blueFranceSun113,
          icon: DsfrIcons.financeMoneyEuroCircleLine,
        ),
      ],
    ),
  );
}
