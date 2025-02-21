import 'package:app/features/authentification/logout/presentation/bloc/logout_bloc.dart';
import 'package:app/features/authentification/logout/presentation/bloc/logout_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => LogoutBloc(notificationRepository: context.read(), authentificationRepository: context.read()),
    child: const _Part(),
  );
}

class _Part extends StatelessWidget {
  const _Part();

  @override
  Widget build(final context) => Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
      child: DsfrLink.md(
        label: Localisation.seDeconnecter,
        onTap: () {
          context.read<LogoutBloc>().add(const LogoutRequested());
        },
      ),
    ),
  );
}
