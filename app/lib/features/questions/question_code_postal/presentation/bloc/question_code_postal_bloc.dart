import 'package:app/features/communes/infrastructure/communes_repository.dart';
import 'package:app/features/profil/core/infrastructure/profil_repository.dart';
import 'package:app/features/questions/question_code_postal/presentation/bloc/question_code_postal_event.dart';
import 'package:app/features/questions/question_code_postal/presentation/bloc/question_code_postal_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class QuestionCodePostalBloc extends Bloc<QuestionCodePostalEvent, QuestionCodePostalState> {
  QuestionCodePostalBloc({required final ProfilRepository profilRepository, required final CommunesRepository communesRepository})
    : super(const QuestionCodePostalState(prenom: '', codePostal: '', communes: [], commune: '', aEteChange: false)) {
    on<QuestionCodePostalPrenomDemande>((final event, final emit) async {
      final result = await profilRepository.recupererProfil();
      if (result.isRight()) {
        final profil = result.getRight().getOrElse(() => throw Exception());
        emit(state.copyWith(prenom: profil.prenom));
      }
    });
    on<QuestionCodePostalAChange>((final event, final emit) async {
      final result =
          (event.valeur.length == 5
              ? await communesRepository.recupererLesCommunes(event.valeur)
              : Either<Exception, List<String>>.right(<String>[]));
      if (result.isRight()) {
        final communes = result.getRight().getOrElse(() => throw Exception());
        emit(state.copyWith(codePostal: event.valeur, communes: communes, commune: communes.length == 1 ? communes.first : ''));
      }
    });
    on<QuestionCommuneAChange>((final event, final emit) => emit(state.copyWith(commune: event.valeur)));
    on<QuestionCodePostalMiseAJourDemandee>((final event, final emit) async {
      await profilRepository.mettreAJourCodePostalEtCommune(codePostal: state.codePostal, commune: state.commune);

      emit(state.copyWith(aEteChange: true));
    });
  }
}
