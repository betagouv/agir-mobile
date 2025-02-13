import 'dart:async';

import 'package:app/features/communes/infrastructure/communes_repository.dart';
import 'package:app/features/profil/core/infrastructure/profil_repository.dart';
import 'package:app/features/profil/logement/domain/logement.dart';
import 'package:app/features/profil/logement/presentation/bloc/mon_logement_event.dart';
import 'package:app/features/profil/logement/presentation/bloc/mon_logement_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class MonLogementBloc extends Bloc<MonLogementEvent, MonLogementState> {
  MonLogementBloc({
    required final ProfilRepository profilRepository,
    required final CommunesRepository communesRepository,
  }) : _profilRepository = profilRepository,
       _communesRepository = communesRepository,
       super(const MonLogementState.empty()) {
    on<MonLogementRecuperationDemandee>(_onRecuperationDemandee);
    on<MonLogementCodePostalChange>(_onCodePostalChange);
    on<MonLogementCommuneChange>(_onCommuneChange);
    on<MonLogementNombreAdultesChange>(_onNombreAdultesChange);
    on<MonLogementNombreEnfantsChange>(_onNombreEnfantsChange);
    on<MonLogementTypeDeLogementChange>(_onNombreTypeDeLogementChange);
    on<MonLogementEstProprietaireChange>(_onEstProprietaireChange);
    on<MonLogementSuperficieChange>(_onSuperficieChange);
    on<MonLogementPlusDe15AnsChange>(_onPlusDe15AnsChange);
    on<MonLogementDpeChange>(_onDpeChange);
    on<MonLogementMiseAJourDemandee>(_onMiseAJourDemandee);
  }

  final ProfilRepository _profilRepository;
  final CommunesRepository _communesRepository;

  Future<void> _onRecuperationDemandee(
    final MonLogementRecuperationDemandee event,
    final Emitter<MonLogementState> emit,
  ) async {
    emit(state.copyWith(statut: MonLogementStatut.chargement));
    final result = await _profilRepository.recupererLogement();
    if (result.isRight()) {
      final logement = result.getRight().getOrElse(() => throw Exception());
      final communes =
          logement.codePostal == null
              ? Either<Exception, List<String>>.right(<String>[])
              : await _communesRepository.recupererLesCommunes(
                logement.codePostal!,
              );

      emit(
        state.copyWith(
          codePostal: logement.codePostal,
          communes: communes.getRight().getOrElse(() => throw Exception()),
          commune: logement.commune,
          nombreAdultes: logement.nombreAdultes,
          nombreEnfants: logement.nombreEnfants,
          typeDeLogement: logement.typeDeLogement,
          estProprietaire: logement.estProprietaire,
          superficie: logement.superficie,
          plusDe15Ans: logement.plusDe15Ans,
          dpe: logement.dpe,
          statut: MonLogementStatut.succes,
        ),
      );
    }
  }

  Future<void> _onCodePostalChange(
    final MonLogementCodePostalChange event,
    final Emitter<MonLogementState> emit,
  ) async {
    final result =
        (event.valeur.length == 5
            ? await _communesRepository.recupererLesCommunes(event.valeur)
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
  }

  void _onCommuneChange(
    final MonLogementCommuneChange event,
    final Emitter<MonLogementState> emit,
  ) => emit(state.copyWith(commune: event.valeur));

  void _onNombreAdultesChange(
    final MonLogementNombreAdultesChange event,
    final Emitter<MonLogementState> emit,
  ) => emit(state.copyWith(nombreAdultes: event.valeur));

  void _onNombreEnfantsChange(
    final MonLogementNombreEnfantsChange event,
    final Emitter<MonLogementState> emit,
  ) => emit(state.copyWith(nombreEnfants: event.valeur));

  void _onNombreTypeDeLogementChange(
    final MonLogementTypeDeLogementChange event,
    final Emitter<MonLogementState> emit,
  ) => emit(state.copyWith(typeDeLogement: event.valeur));

  void _onEstProprietaireChange(
    final MonLogementEstProprietaireChange event,
    final Emitter<MonLogementState> emit,
  ) => emit(state.copyWith(estProprietaire: event.valeur));

  void _onSuperficieChange(
    final MonLogementSuperficieChange event,
    final Emitter<MonLogementState> emit,
  ) => emit(state.copyWith(superficie: event.valeur));

  void _onPlusDe15AnsChange(
    final MonLogementPlusDe15AnsChange event,
    final Emitter<MonLogementState> emit,
  ) {
    emit(state.copyWith(plusDe15Ans: event.valeur));
  }

  void _onDpeChange(
    final MonLogementDpeChange event,
    final Emitter<MonLogementState> emit,
  ) {
    emit(state.copyWith(dpe: event.valeur));
  }

  Future<void> _onMiseAJourDemandee(
    final MonLogementMiseAJourDemandee event,
    final Emitter<MonLogementState> emit,
  ) async {
    await _profilRepository.mettreAJourLogement(
      logement: Logement(
        codePostal: state.codePostal,
        commune: state.commune,
        nombreAdultes: state.nombreAdultes,
        nombreEnfants: state.nombreEnfants,
        typeDeLogement: state.typeDeLogement,
        estProprietaire: state.estProprietaire,
        superficie: state.superficie,
        plusDe15Ans: state.plusDe15Ans,
        dpe: state.dpe,
      ),
    );
  }
}
