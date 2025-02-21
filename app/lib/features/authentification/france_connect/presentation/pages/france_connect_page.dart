import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/features/authentification/france_connect/domain/open_id.dart';
import 'package:app/features/authentification/france_connect/presentation/bloc/france_connect_bloc.dart';
import 'package:app/features/authentification/france_connect/presentation/bloc/france_connect_event.dart';
import 'package:app/features/authentification/france_connect/presentation/bloc/france_connect_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FranceConnectPage extends StatelessWidget {
  const FranceConnectPage({super.key, required this.openId});

  static const path = '/fc-login-callback';

  final OpenId openId;

  static GoRoute get route => GoRoute(
    path: path,
    builder: (final context, final state) {
      final queryParameters = state.uri.queryParameters;

      return FranceConnectPage(openId: OpenId(code: queryParameters['code']!, state: queryParameters['state']!));
    },
  );

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => FranceConnectBloc(repository: context.read())..add(FranceConnectCallbackReceived(openId)),
    child: const _Body(),
  );
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(final BuildContext context) => FnvScaffold(
    body: BlocBuilder<FranceConnectBloc, FranceConnectState>(
      builder:
          (final context, final state) => switch (state) {
            FranceConnectInitial() || FranceConnectLoadInProgress() => const Center(child: CircularProgressIndicator()),
            FranceConnectLoadFailure() => const Center(child: Text('Erreur lors de la connexion')),
            FranceConnectLoadSuccess() => const Center(child: Text('Connexion réussie')),
          },
    ),
  );
}
