import 'package:app/features/authentification/questions/presentation/blocs/question_prenom_event.dart';
import 'package:app/features/authentification/questions/presentation/blocs/question_prenom_state.dart';
import 'package:app/features/profil/domain/ports/profil_port.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionPrenomBloc
    extends Bloc<QuestionPrenomEvent, QuestionPrenomState> {
  QuestionPrenomBloc({required final ProfilPort profilPort})
      : super(const QuestionPrenomState(prenom: '', aEteChange: false)) {
    on<QuestionPrenomAChange>(
      (final event, final emit) => emit(state.copyWith(prenom: event.valeur)),
    );
    on<QuestionPrenomMiseAJourDemandee>((final event, final emit) async {
      await profilPort.mettreAJourPrenom(state.prenom);

      emit(state.copyWith(aEteChange: true));
    });
  }
}
