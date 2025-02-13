import 'package:go_router/go_router.dart';

extension GoRouterExt on GoRouter {
  void popUntilNamed<T>(final String name, {final T? result}) {
    final currentConfiguration = routerDelegate.currentConfiguration;
    final routeStacks = List.of(currentConfiguration.routes);

    for (var i = routeStacks.length - 1; i >= 0; i--) {
      final route = routeStacks.elementAtOrNull(i);
      if (route is GoRoute) {
        if (route.name == name) {
          break;
        }

        if (i != 0 && routeStacks.elementAtOrNull(i - 1) is ShellRoute) {
          final last =
              currentConfiguration.matches.isNotEmpty
                  ? currentConfiguration.matches.lastOrNull
                  : null;
          if (last != null) {
            restore(currentConfiguration.remove(last));
          }
        } else {
          pop(result);
        }
      }
    }
  }

  void popUntilNumber<T>(final int number, {final T? result}) {
    final currentConfiguration = routerDelegate.currentConfiguration;
    final routeStacks = List.of(currentConfiguration.routes);
    for (var i = routeStacks.length - 1; i >= 0; i--) {
      final route = routeStacks.elementAtOrNull(i);
      if (route is GoRoute) {
        if (routeStacks.length - i == number) {
          break;
        }

        if (i != 0 && routeStacks.elementAtOrNull(i - 1) is ShellRoute) {
          final last =
              currentConfiguration.matches.isNotEmpty
                  ? currentConfiguration.matches.lastOrNull
                  : null;
          if (last != null) {
            restore(currentConfiguration.remove(last));
          }
        } else {
          pop(result);
        }
      }
    }
  }
}
