import 'package:app/features/accueil/presentation/widgets/home_app_bar_title.dart';
import 'package:app/features/accueil/presentation/widgets/home_tab_bar.dart';
import 'package:app/features/accueil/presentation/widgets/home_tab_bar_view.dart';
import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:flutter/material.dart';

class HomeTabController extends StatelessWidget {
  const HomeTabController({super.key});

  @override
  Widget build(final BuildContext context) => DefaultTabController(
        length: 5,
        child: RootPage(
          title: const HomeAppBarTitle(),
          appBarBottom: HomeTabBar(
            textScaler:
                MediaQuery.textScalerOf(context).clamp(maxScaleFactor: 2),
          ),
          body: const HomeTabBarView(),
        ),
      );
}
