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
    on<AideVeloInformationsDemandee>(_onInformationsDemandee);
    on<AideVeloModificationDemandee>(_onModificationDemandee);
    on<AideVeloPrixChange>(_onPrixChange);
    on<AideVeloCodePostalChange>(_onCodePostalChange);
    on<AideVeloVilleChange>(_onVilleChange);
    on<AideVeloNombreDePartsFiscalesChange>(_onNombreDePartsFiscalesChange);
    on<AideVeloRevenuFiscalChange>(_onRevenuFiscalChange);
    on<AideVeloEstimationDemandee>(_onEstimationDemandee);
  }

  final CommunesRepository _communesRepository;
  final AideVeloRepository _aideVeloRepository;

  Future<void> _onInformationsDemandee(
    final AideVeloInformationsDemandee event,
    final Emitter<AideVeloState> emit,
  ) async {
    final informations = await _aideVeloRepository.recupererProfil();
    emit(
      AideVeloState(
        prix: 1000,
        codePostal: informations.codePostal,
        communes: const [],
        ville: informations.ville,
        nombreDePartsFiscales: informations.nombreDePartsFiscales,
        revenuFiscal: informations.revenuFiscal,
        aidesDisponibles: const [],
        veutModifierLesInformations: false,
      ),
    );
  }

  Future<void> _onModificationDemandee(
    final AideVeloModificationDemandee event,
    final Emitter<AideVeloState> emit,
  ) async {
    final communes =
        await _communesRepository.recupererLesCommunes(state.codePostal);
    emit(state.copyWith(veutModifierLesInformations: true, communes: communes));
  }

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
    if (!state.estValide) {
      return;
    }
    final aidesDisponibles = await _aideVeloRepository.simuler(
      prix: state.prix,
      codePostal: state.codePostal,
      ville: state.ville,
      nombreDePartsFiscales: state.nombreDePartsFiscales,
      revenuFiscal: state.revenuFiscal!,
    );
    emit(
      state.copyWith(
        aidesDisponibles: {
          'Acheter un vélo cargo': aidesDisponibles.cargo,
          'Acheter un vélo mécanique': aidesDisponibles.mecaniqueSimple,
          '⚡Acheter un vélo cargo électrique': aidesDisponibles.cargoElectrique,
          '⚡Acheter un vélo électrique': aidesDisponibles.electrique,
          '⚡️ Transformer un vélo classique en électrique':
              aidesDisponibles.motorisation,
        }.entries.map((final e) {
          final value = e.value;

          return AideDisponiblesViewModel(
            titre: e.key,
            montantTotal: value.map((final e) => e.montant).maxOrNull,
            aides: value,
          );
        }).toList(),
      ),
    );
  }
}
