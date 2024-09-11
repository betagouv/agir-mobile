import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../old/device_info.dart';

Future<void> pumpPage({
  required final WidgetTester tester,
  required final List<RepositoryProvider<Object>> providers,
  required final Widget page,
  required final List<String> routes,
}) async {
  DeviceInfo.setup(tester);
  await tester.pumpWidget(
    MultiRepositoryProvider(
      providers: providers,
      child: MaterialApp.router(
        routerConfig: GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (final context, final state) => page,
            ),
            ...routes.map(
              (final route) => GoRoute(
                path: '/$route',
                name: route,
                builder: (final context, final state) => Text(route),
              ),
            ),
          ],
        ),
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      ),
    ),
  );
}
