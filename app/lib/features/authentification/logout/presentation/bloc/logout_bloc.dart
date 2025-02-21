import 'package:app/core/notifications/infrastructure/notification_repository.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_repository.dart';
import 'package:app/features/authentification/logout/presentation/bloc/logout_event.dart';
import 'package:app/features/authentification/logout/presentation/bloc/logout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc({
    required final NotificationRepository notificationRepository,
    required final AuthentificationRepository authentificationRepository,
  }) : super(const LogoutInitial()) {
    on<LogoutRequested>((final event, final emit) async {
      emit(const LogoutLoadInProgress());
      await notificationRepository.deleteNotificationToken();
      await authentificationRepository.deconnexionDemandee();
      emit(const LogoutLoadSuccess());
    });
  }
}
