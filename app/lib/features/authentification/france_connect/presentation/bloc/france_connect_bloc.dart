import 'package:app/features/authentification/core/infrastructure/authentification_repository.dart';
import 'package:app/features/authentification/france_connect/presentation/bloc/france_connect_event.dart';
import 'package:app/features/authentification/france_connect/presentation/bloc/france_connect_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FranceConnectBloc extends Bloc<FranceConnectEvent, FranceConnectState> {
  FranceConnectBloc({required final AuthentificationRepository repository}) : super(const FranceConnectInitial()) {
    on<FranceConnectCallbackReceived>((final event, final emit) async {
      emit(const FranceConnectLoadInProgress());
      final result = await repository.franceConnectStep2(openId: event.value);
      result.fold(
        (final failure) => emit(const FranceConnectLoadFailure()),
        (final user) => emit(const FranceConnectLoadSuccess()),
      );
    });
  }
}
