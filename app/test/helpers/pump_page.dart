import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:nested/nested.dart';

import '../old/device_info.dart';

Future<void> pumpPage({
  required final WidgetTester tester,
  required final List<RepositoryProvider<Object>> repositoryProviders,
  final List<SingleChildWidget> blocProviders = const [],
  required final Widget page,
  final List<String>? routes,
}) async {
  DeviceInfo.setup(tester);
  Widget widget = MaterialApp.router(
    routerConfig: GoRouter(
      routes: [
        GoRoute(path: '/', builder: (final context, final state) => page),
        ...?routes?.map(
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
  );
  if (blocProviders.isNotEmpty) {
    widget = MultiBlocProvider(providers: blocProviders, child: widget);
  }
  await tester.pumpWidget(
    MultiRepositoryProvider(providers: repositoryProviders, child: widget),
  );
}
