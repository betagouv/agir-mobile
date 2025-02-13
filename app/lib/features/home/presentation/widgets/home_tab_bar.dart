import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class HomeTabBar extends TabBar {
  const HomeTabBar({super.key, required final TextScaler textScaler})
    : super(
        tabs: const [
          Tab(icon: Icon(DsfrIcons.buildingsHome4Line)),
          Tab(text: 'Me nourrir'),
          Tab(text: 'Me loger'),
          Tab(text: 'Me déplacer'),
          Tab(text: 'Consommer'),
        ],
        isScrollable: true,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        indicator: const UnderlineTabIndicator(borderSide: BorderSide(color: DsfrColors.blueFranceSun113, width: 3)),
        dividerHeight: 0,
        labelStyle: const DsfrTextStyle.bodyMd(),
        labelPadding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s1w),
        unselectedLabelStyle: const DsfrTextStyle.bodyMd(),
        tabAlignment: TabAlignment.start,
        textScaler: textScaler,
      );
}
