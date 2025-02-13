import 'dart:async';

import 'package:app/features/communes/infrastructure/communes_repository.dart';
import 'package:app/features/profil/core/infrastructure/profil_repository.dart';
import 'package:app/features/simulateur_velo/domain/velo_pour_simulateur.dart';
import 'package:app/features/simulateur_velo/infrastructure/aide_velo_repository.dart';
import 'package:app/features/simulateur_velo/presentation/bloc/aide_velo_event.dart';
import 'package:app/features/simulateur_velo/presentation/bloc/aide_velo_state.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class AideVeloBloc extends Bloc<AideVeloEvent, AideVeloState> {
  AideVeloBloc({
    required final ProfilRepository profilRepository,
    required final CommunesRepository communesRepository,
    required final AideVeloRepository aideVeloRepository,
  }) : _profilRepository = profilRepository,
       _communesRepository = communesRepository,
       _aideVeloRepository = aideVeloRepository,
       super(const AideVeloState.empty()) {
    on<AideVeloInformationsDemandee>(_onInformationsDemandee);
    on<AideVeloModificationDemandee>(_onModificationDemandee);
    on<AideVeloPrixChange>(_onPrixChange);
    on<AideVeloEtatChange>(_onEtatChange);
    on<AideVeloCodePostalChange>(_onCodePostalChange);
    on<AideVeloCommuneChange>(_onCommuneChange);
    on<AideVeloNombreDePartsFiscalesChange>(_onNombreDePartsFiscalesChange);
    on<AideVeloRevenuFiscalChange>(_onRevenuFiscalChange);
    on<AideVeloEstimationDemandee>(_onEstimationDemandee);
  }

  final CommunesRepository _communesRepository;
  final ProfilRepository _profilRepository;
  final AideVeloRepository _aideVeloRepository;

  Future<void> _onInformationsDemandee(final AideVeloInformationsDemandee event, final Emitter<AideVeloState> emit) async {
    final result = await _profilRepository.recupererProfil();
    if (result.isRight()) {
      final informations = result.getRight().getOrElse(() => throw Exception());
      emit(
        AideVeloState(
          prix: 1000,
          etatVelo: VeloEtat.neuf,
          codePostal: informations.codePostal ?? '',
          communes: const [],
          commune: informations.commune ?? '',
          nombreDePartsFiscales: informations.nombreDePartsFiscales,
          revenuFiscal: informations.revenuFiscal,
          aidesDisponibles: const [],
          veutModifierLesInformations: informations.revenuFiscal == null,
          aideVeloStatut: AideVeloStatut.initial,
        ),
      );
    }
  }

  Future<void> _onModificationDemandee(final AideVeloModificationDemandee event, final Emitter<AideVeloState> emit) async {
    final result =
        state.codePostal.length == 5
            ? await _communesRepository.recupererLesCommunes(state.codePostal)
            : Either<Exception, List<String>>.right(<String>[]);

    if (result.isRight()) {
      final communes = result.getRight().getOrElse(() => throw Exception());
      emit(state.copyWith(veutModifierLesInformations: true, communes: communes));
    }
  }

  void _onPrixChange(final AideVeloPrixChange event, final Emitter<AideVeloState> emit) {
    emit(state.copyWith(prix: event.valeur));
  }

  void _onEtatChange(final AideVeloEtatChange event, final Emitter<AideVeloState> emit) {
    emit(state.copyWith(etatVelo: event.valeur));
  }

  Future<void> _onCodePostalChange(final AideVeloCodePostalChange event, final Emitter<AideVeloState> emit) async {
    final result =
        event.valeur.length == 5
            ? await _communesRepository.recupererLesCommunes(event.valeur)
            : Either<Exception, List<String>>.right(<String>[]);
    if (result.isRight()) {
      final communes = result.getRight().getOrElse(() => throw Exception());
      emit(state.copyWith(codePostal: event.valeur, communes: communes, commune: communes.length == 1 ? communes.first : ''));
    }
  }

  void _onCommuneChange(final AideVeloCommuneChange event, final Emitter<AideVeloState> emit) {
    emit(state.copyWith(commune: event.valeur));
  }

  void _onNombreDePartsFiscalesChange(final AideVeloNombreDePartsFiscalesChange event, final Emitter<AideVeloState> emit) {
    emit(state.copyWith(nombreDePartsFiscales: event.valeur));
  }

  void _onRevenuFiscalChange(final AideVeloRevenuFiscalChange event, final Emitter<AideVeloState> emit) {
    emit(state.copyWith(revenuFiscal: event.valeur));
  }

  Future<void> _onEstimationDemandee(final AideVeloEstimationDemandee event, final Emitter<AideVeloState> emit) async {
    if (!state.estValide) {
      return;
    }
    emit(state.copyWith(aideVeloStatut: AideVeloStatut.chargement));
    final result = await _aideVeloRepository.simuler(
      prix: state.prix,
      etatVelo: state.etatVelo,
      codePostal: state.codePostal,
      commune: state.commune,
      nombreDePartsFiscales: state.nombreDePartsFiscales,
      revenuFiscal: state.revenuFiscal!,
    );
    result.fold(
      (final l) => emit(state.copyWith(aideVeloStatut: AideVeloStatut.erreur)),
      (final r) => emit(
        state.copyWith(
          aidesDisponibles:
              {
                'Acheter un vélo mécanique': r.mecaniqueSimple,
                '⚡Acheter un vélo électrique': r.electrique,
                'Acheter un vélo cargo': r.cargo,
                '⚡Acheter un vélo cargo électrique': r.cargoElectrique,
                'Acheter un vélo pliant': r.pliant,
                '⚡Acheter un vélo pliant électrique': r.pliantElectrique,
                '⚡️Transformer un vélo classique en électrique': r.motorisation,
                '🦽Acheter un vélo adapté': r.adapte,
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
      ),
    );
  }
}
