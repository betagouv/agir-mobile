// ignore_for_file: avoid-cubits

import 'package:app/features/aides/presentation/blocs/aides_disclaimer/aides_disclaimer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AidesDisclaimerCubit extends Cubit<AidesDisclaimerState> {
  AidesDisclaimerCubit() : super(const AidesDisclaimerVisible());

  void closeDisclaimer() {
    emit(const AidesDisclaimerNotVisible());
  }
}
