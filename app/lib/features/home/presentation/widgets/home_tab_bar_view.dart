import 'package:app/features/home/presentation/widgets/home_content.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/presentation/pages/theme_page.dart';
import 'package:flutter/material.dart';

class HomeTabBarView extends StatelessWidget {
  const HomeTabBarView({super.key});

  @override
  Widget build(final BuildContext context) => const TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeContent(),
          ThemePage(themeType: ThemeType.alimentation),
          ThemePage(themeType: ThemeType.logement),
          ThemePage(themeType: ThemeType.transport),
          ThemePage(themeType: ThemeType.consommation),
        ],
      );
}
