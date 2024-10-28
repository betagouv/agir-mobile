import 'package:app/features/upgrade/presentation/bloc/upgrade_event.dart';
import 'package:app/features/upgrade/presentation/bloc/upgrade_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpgradeBloc extends Bloc<UpgradeEvent, UpgradeState> {
  UpgradeBloc() : super(const UpgradeInitial()) {
    on<UpgradeRequested>((final event, final emit) {
      emit(const UpgradeRequired());
    });
  }
}
