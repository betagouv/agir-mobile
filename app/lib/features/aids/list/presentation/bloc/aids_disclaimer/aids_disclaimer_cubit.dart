// ignore_for_file: avoid-cubits

import 'package:app/features/aids/list/presentation/bloc/aids_disclaimer/aids_disclaimer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AidsDisclaimerCubit extends Cubit<AidsDisclaimerState> {
  AidsDisclaimerCubit() : super(const AidsDisclaimerVisible());

  void closeDisclaimer() {
    emit(const AidsDisclaimerNotVisible());
  }
}
