import 'dart:async';

import 'package:app/features/aides/simulateur_velo/domain/ports/aide_velo_port.dart';
import 'package:app/features/aides/simulateur_velo/presentation/blocs/aide_velo_event.dart';
import 'package:app/features/aides/simulateur_velo/presentation/blocs/aide_velo_state.dart';
import 'package:app/features/communes/domain/ports/communes_port.dart';
import 'package:app/features/profil/domain/ports/profil_port.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AideVeloBloc extends Bloc<AideVeloEvent, AideVeloState> {
  AideVeloBloc({
    required final ProfilPort profilPort,
    required final CommunesPort communesPort,
    required final AideVeloPort aideVeloPort,
  })  : _profilPort = profilPort,
        _communesPort = communesPort,
        _aideVeloPort = aideVeloPort,
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

  final CommunesPort _communesPort;
  final ProfilPort _profilPort;
  final AideVeloPort _aideVeloPort;

  Future<void> _onInformationsDemandee(
    final AideVeloInformationsDemandee event,
    final Emitter<AideVeloState> emit,
  ) async {
    final informations = await _profilPort.recupererProfil();
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
        aideVeloStatut: AideVeloStatut.initial,
      ),
    );
  }

  Future<void> _onModificationDemandee(
    final AideVeloModificationDemandee event,
    final Emitter<AideVeloState> emit,
  ) async {
    final communes = await _communesPort.recupererLesCommunes(state.codePostal);
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
    final communes = await _communesPort.recupererLesCommunes(event.valeur);
    emit(
      state.copyWith(
        codePostal: event.valeur,
        communes: communes,
        ville: '',
      ),
    );
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
    emit(state.copyWith(aideVeloStatut: AideVeloStatut.chargement));
    final aidesDisponibles = await _aideVeloPort.simuler(
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
        aideVeloStatut: AideVeloStatut.succes,
      ),
    );
  }
}
