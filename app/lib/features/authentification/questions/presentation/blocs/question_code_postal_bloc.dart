import 'dart:async';

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
  })  : _profilPort = profilPort,
        _communesPort = communesPort,
        super(
          const QuestionCodePostalState(
            prenom: '',
            codePostal: '',
            communes: [],
            commune: '',
            aEteChange: false,
          ),
        ) {
    on<QuestionCodePostalPrenomDemande>(_onPrenomDemande);
    on<QuestionCodePostalAChange>(_onAChange);
    on<QuestionCommuneAChange>(_onCommuneAChange);
    on<QuestionCodePostalMiseAJourDemandee>(_onMiseAJourDemandee);
  }

  final ProfilPort _profilPort;
  final CommunesPort _communesPort;

  Future<void> _onPrenomDemande(
    final QuestionCodePostalPrenomDemande event,
    final Emitter<QuestionCodePostalState> emit,
  ) async {
    final result = await _profilPort.recupererProfil();
    if (result.isRight()) {
      final profil = result.getRight().getOrElse(() => throw Exception());
      emit(state.copyWith(prenom: profil.prenom));
    }
  }

  Future<void> _onAChange(
    final QuestionCodePostalAChange event,
    final Emitter<QuestionCodePostalState> emit,
  ) async {
    final result = (event.valeur.length == 5
        ? await _communesPort.recupererLesCommunes(event.valeur)
        : Either<Exception, List<String>>.right(<String>[]));
    if (result.isRight()) {
      final communes = result.getRight().getOrElse(() => throw Exception());
      emit(
        state.copyWith(
          codePostal: event.valeur,
          communes: communes,
          commune: communes.length == 1 ? communes.firstOrNull : null,
        ),
      );
    }
  }

  void _onCommuneAChange(
    final QuestionCommuneAChange event,
    final Emitter<QuestionCodePostalState> emit,
  ) {
    emit(state.copyWith(commune: event.valeur));
  }

  Future<void> _onMiseAJourDemandee(
    final QuestionCodePostalMiseAJourDemandee event,
    final Emitter<QuestionCodePostalState> emit,
  ) async {
    await _profilPort.mettreAJourCodePostalEtCommune(
      codePostal: state.codePostal,
      commune: state.commune,
    );

    emit(state.copyWith(aEteChange: true));
  }
}
