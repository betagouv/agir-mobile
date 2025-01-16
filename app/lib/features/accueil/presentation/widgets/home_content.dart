import 'package:app/features/accueil/presentation/widgets/home_content_layout.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_bloc.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_event.dart';
import 'package:app/features/notifications/infrastructure/notification_repository.dart';
import 'package:app/features/notifications/infrastructure/notification_service.dart';
import 'package:app/features/questions/first_name/presentation/pages/first_name_page.dart';
import 'package:app/features/utilisateur/presentation/bloc/utilisateur_bloc.dart';
import 'package:app/features/utilisateur/presentation/bloc/utilisateur_event.dart';
import 'package:app/features/utilisateur/presentation/bloc/utilisateur_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    context
        .read<UtilisateurBloc>()
        .add(const UtilisateurRecuperationDemandee());
    context
        .read<EnvironmentalPerformanceBloc>()
        .add(const EnvironmentalPerformanceStarted());
  }

  Future<void> _handleUserState(
    final BuildContext context,
    final UtilisateurState state,
  ) async {
    final estIntegrationTerminee = state.utilisateur.estIntegrationTerminee;
    if (estIntegrationTerminee == null) {
      return;
    }

    if (!estIntegrationTerminee) {
      await GoRouter.of(context).pushReplacementNamed(FirstNamePage.name);

      return;
    }

    await _handleNotifications(context);
  }

  Future<void> _handleNotifications(final BuildContext context) async {
    final notificationService = context.read<NotificationService>();
    final authorizationStatus = await notificationService.requestPermission();
    if (authorizationStatus == AuthorizationStatus.authorized &&
        context.mounted) {
      await context.read<NotificationRepository>().saveToken();
    }
  }

  @override
  Widget build(final BuildContext context) =>
      BlocListener<UtilisateurBloc, UtilisateurState>(
        listener: _handleUserState,
        listenWhen: (final previous, final current) =>
            previous.utilisateur.estIntegrationTerminee !=
            current.utilisateur.estIntegrationTerminee,
        child: const HomeContentLayout(),
      );
}
