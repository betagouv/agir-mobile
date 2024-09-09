// ignore_for_file: avoid-cubits

import 'package:app/features/accueil/presentation/cubit/home_disclaimer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDisclaimerCubit extends Cubit<HomeDisclaimerState> {
  HomeDisclaimerCubit() : super(const HomeDisclaimerVisible());

  void closeDisclaimer() {
    emit(const HomeDisclaimerNotVisible());
  }
}
