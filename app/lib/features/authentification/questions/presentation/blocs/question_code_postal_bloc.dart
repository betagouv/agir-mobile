import 'package:app/features/authentification/questions/presentation/blocs/question_code_postal_event.dart';
import 'package:app/features/authentification/questions/presentation/blocs/question_code_postal_state.dart';
import 'package:app/features/communes/domain/ports/communes_port.dart';
import 'package:app/features/profil/domain/ports/profil_port.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class QuestionCodePostalBloc
    extends Bloc<QuestionCodePostalEvent, QuestionCodePostalState> {
  QuestionCodePostalBloc({
    required final ProfilPort profilPort,
    required final CommunesPort communesPort,
  }) : super(
          const QuestionCodePostalState(
            prenom: '',
            codePostal: '',
            communes: [],
            commune: '',
            aEteChange: false,
          ),
        ) {
    on<QuestionCodePostalPrenomDemande>((final event, final emit) async {
      final result = await profilPort.recupererProfil();
      if (result.isRight()) {
        final profil = result.getRight().getOrElse(() => throw Exception());
        emit(state.copyWith(prenom: profil.prenom));
      }
    });
    on<QuestionCodePostalAChange>((final event, final emit) async {
      final result = (event.valeur.length == 5
          ? await communesPort.recupererLesCommunes(event.valeur)
          : Either<Exception, List<String>>.right(<String>[]));
      if (result.isRight()) {
        final communes = result.getRight().getOrElse(() => throw Exception());
        emit(
          state.copyWith(
            codePostal: event.valeur,
            communes: communes,
            commune: communes.length == 1 ? communes.first : '',
          ),
        );
      }
    });
    on<QuestionCommuneAChange>(
      (final event, final emit) => emit(state.copyWith(commune: event.valeur)),
    );
    on<QuestionCodePostalMiseAJourDemandee>((final event, final emit) async {
      await profilPort.mettreAJourCodePostalEtCommune(
        codePostal: state.codePostal,
        commune: state.commune,
      );

      emit(state.copyWith(aEteChange: true));
    });
  }
}
