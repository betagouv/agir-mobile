import 'package:agir/src/router/app_router.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(final BuildContext context) => MaterialApp.router(
        routerConfig: goRouter(),
        theme: ThemeData(
          colorSchemeSeed: DsfrColors.blueFranceSun113,
          scaffoldBackgroundColor: Colors.white,
        ),
      );
}
