import 'dart:async';

import 'package:app/src/fonctionnalites/aides/bloc/aide_velo/aide_velo_event.dart';
import 'package:app/src/fonctionnalites/aides/bloc/aide_velo/aide_velo_state.dart';
import 'package:app/src/fonctionnalites/aides/domain/ports/aide_velo_repository.dart';
import 'package:app/src/fonctionnalites/communes/domain/ports/communes_repository.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AideVeloBloc extends Bloc<AideVeloEvent, AideVeloState> {
  AideVeloBloc({
    required final CommunesRepository communesRepository,
    required final AideVeloRepository aideVeloRepository,
  })  : _communesRepository = communesRepository,
        _aideVeloRepository = aideVeloRepository,
        super(const AideVeloState.empty()) {
    on<AideVeloPrixChange>(_onPrixChange);
    on<AideVeloCodePostalChange>(_onCodePostalChange);
    on<AideVeloVilleChange>(_onVilleChange);
    on<AideVeloNombreDePartsFiscalesChange>(_onNombreDePartsFiscalesChange);
    on<AideVeloRevenuFiscalChange>(_onRevenuFiscalChange);
    on<AideVeloEstimationDemandee>(_onEstimationDemandee);
  }

  final CommunesRepository _communesRepository;
  final AideVeloRepository _aideVeloRepository;

  void _onPrixChange(
    final AideVeloPrixChange event,
    final Emitter<AideVeloState> emit,
  ) {
    emit(state.copyWith(prix: event.valeur));
  }

  Future<void> _onCodePostalChange(
    final AideVeloCodePostalChange event,
    final Emitter<AideVeloState> emit,
  ) async {
    final communes =
        await _communesRepository.recupererLesCommunes(event.valeur);
    emit(state.copyWith(codePostal: event.valeur, communes: communes));
  }

  void _onVilleChange(
    final AideVeloVilleChange event,
    final Emitter<AideVeloState> emit,
  ) {
    emit(state.copyWith(ville: event.valeur));
  }

  void _onNombreDePartsFiscalesChange(
    final AideVeloNombreDePartsFiscalesChange event,
    final Emitter<AideVeloState> emit,
  ) {
    emit(state.copyWith(nombreDePartsFiscales: event.valeur));
  }

  void _onRevenuFiscalChange(
    final AideVeloRevenuFiscalChange event,
    final Emitter<AideVeloState> emit,
  ) {
    emit(state.copyWith(revenuFiscal: event.valeur));
  }

  Future<void> _onEstimationDemandee(
    final AideVeloEstimationDemandee event,
    final Emitter<AideVeloState> emit,
  ) async {
    final aidesDisponibles = await _aideVeloRepository.simuler(
      prix: state.prix,
      codePostal: state.codePostal,
      ville: state.ville,
      nombreDePartsFiscales: state.nombreDePartsFiscales,
      revenuFiscal: state.revenuFiscal,
    );
    final viewModels = [
      AideDisponiblesViewModel(
        titre: 'Acheter un vélo mécanique',
        montantTotal: aidesDisponibles.mecaniqueSimple
            .map((final e) => e.montant)
            .maxOrNull,
        aides: aidesDisponibles.mecaniqueSimple,
      ),
      AideDisponiblesViewModel(
        titre: '⚡Acheter un vélo électrique',
        montantTotal:
            aidesDisponibles.electrique.map((final e) => e.montant).maxOrNull,
        aides: aidesDisponibles.electrique,
      ),
      AideDisponiblesViewModel(
        titre: 'Acheter un vélo cargo',
        montantTotal:
            aidesDisponibles.cargo.map((final e) => e.montant).maxOrNull,
        aides: aidesDisponibles.cargo,
      ),
      AideDisponiblesViewModel(
        titre: '⚡Acheter un vélo cargo électrique',
        montantTotal: aidesDisponibles.cargoElectrique
            .map((final e) => e.montant)
            .maxOrNull,
        aides: aidesDisponibles.cargoElectrique,
      ),
      AideDisponiblesViewModel(
        titre: 'Acheter un vélo pliant',
        montantTotal:
            aidesDisponibles.pliant.map((final e) => e.montant).maxOrNull,
        aides: aidesDisponibles.pliant,
      ),
      AideDisponiblesViewModel(
        titre: '⚡️ Transformer un vélo classique en électrique',
        montantTotal:
            aidesDisponibles.motorisation.map((final e) => e.montant).maxOrNull,
        aides: aidesDisponibles.motorisation,
      ),
    ];
    emit(state.copyWith(aidesDisponibles: viewModels));
  }
}
