// ignore_for_file: avoid-long-parameter-list

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:nested/nested.dart';

import '../old/mocks/device_info.dart';

Future<void> pumpPage({
  required final WidgetTester tester,
  required final List<RepositoryProvider<Object>> repositoryProviders,
  final List<SingleChildWidget> blocProviders = const [],
  final GoRouter? router,
  final GoRoute? page,
  final GoRoute? realRoutes,
  final Map<String, String>? routes,
}) async {
  DeviceInfo.setup(tester);
  Widget widget = MaterialApp.router(
    routerConfig: router ??
        GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (final context, final state) => const Text('pop'),
              routes: [
                page!,
                if (realRoutes != null) realRoutes,
                if (realRoutes == null)
                  ...?routes?.entries.map(
                    (final e) => GoRoute(
                      path: e.value,
                      name: e.key,
                      builder: (final context, final state) =>
                          Text('route: ${e.key}'),
                    ),
                  ),
              ],
            ),
          ],
          initialLocation: '/${page.path}',
        ),
    localizationsDelegates: const [
      GlobalCupertinoLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
  );

  if (blocProviders.isNotEmpty) {
    widget = MultiBlocProvider(providers: blocProviders, child: widget);
  }

  if (repositoryProviders.isNotEmpty) {
    widget =
        MultiRepositoryProvider(providers: repositoryProviders, child: widget);
  }

  await tester.pumpWidget(widget);
}
