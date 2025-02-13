// ignore_for_file: avoid-cubits

import 'package:app/core/presentation/widgets/composants/mot_de_passe/cubit/mot_de_passe_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MotDePasseCubit extends Cubit<MotDePasseState> {
  MotDePasseCubit() : super(const MotDePasseState(valeur: ''));

  void changerMotDePasseAChange(final String value) => emit(MotDePasseState(valeur: value));
}
