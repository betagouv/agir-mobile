import 'package:app/features/home/presentation/widgets/home_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const name = 'home';
  static const path = '/';

  static GoRoute route({required final List<RouteBase> routes}) => GoRoute(
    path: path,
    name: name,
    builder: (final context, final state) => const HomePage(),
    routes: routes,
  );

  @override
  Widget build(final BuildContext context) => const HomeTabController();
}
