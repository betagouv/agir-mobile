import 'dart:async';

import 'package:app/features/profil/domain/ports/profil_port.dart';
import 'package:app/features/profil/informations/presentation/blocs/mes_informations_event.dart';
import 'package:app/features/profil/informations/presentation/blocs/mes_informations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MesInformationsBloc
    extends Bloc<MesInformationsEvent, MesInformationsState> {
  MesInformationsBloc({required final ProfilPort profilPort})
      : _profilPort = profilPort,
        super(const MesInformationsState.empty()) {
    on<MesInformationsRecuperationDemandee>(_onRecuperationDemandee);
    on<MesInformationsPrenomChange>(_onPrenomChange);
    on<MesInformationsNomChange>(_onNomChange);
    on<MesInformationsEmailChange>(_onEmailChange);
    on<MesInformationsNombreDePartsFiscalesChange>(
      _onNombreDePartsFiscalesChange,
    );
    on<MesInformationsRevenuFiscalChange>(_onRevenuFiscalChange);
    on<MesInformationsMiseAJourDemandee>(_onMiseAJourDemandee);
  }

  final ProfilPort _profilPort;

  Future<void> _onRecuperationDemandee(
    final MesInformationsRecuperationDemandee event,
    final Emitter<MesInformationsState> emit,
  ) async {
    emit(state.copyWith(statut: MesInformationsStatut.chargement));
    final profil = await _profilPort.recupererProfil();
    emit(
      MesInformationsState(
        prenom: profil.prenom,
        nom: profil.nom,
        email: profil.email,
        nombreDePartsFiscales: profil.nombreDePartsFiscales,
        revenuFiscal: profil.revenuFiscal,
        statut: MesInformationsStatut.succes,
      ),
    );
  }

  void _onPrenomChange(
    final MesInformationsPrenomChange event,
    final Emitter<MesInformationsState> emit,
  ) =>
      emit(state.copyWith(prenom: event.valeur));

  void _onNomChange(
    final MesInformationsNomChange event,
    final Emitter<MesInformationsState> emit,
  ) =>
      emit(state.copyWith(nom: event.valeur));

  void _onEmailChange(
    final MesInformationsEmailChange event,
    final Emitter<MesInformationsState> emit,
  ) =>
      emit(state.copyWith(email: event.valeur));

  void _onNombreDePartsFiscalesChange(
    final MesInformationsNombreDePartsFiscalesChange event,
    final Emitter<MesInformationsState> emit,
  ) =>
      emit(state.copyWith(nombreDePartsFiscales: event.valeur));

  void _onRevenuFiscalChange(
    final MesInformationsRevenuFiscalChange event,
    final Emitter<MesInformationsState> emit,
  ) =>
      emit(state.copyWith(revenuFiscal: event.valeur));

  Future<void> _onMiseAJourDemandee(
    final MesInformationsMiseAJourDemandee event,
    final Emitter<MesInformationsState> emit,
  ) async {
    await _profilPort.mettreAJour(
      prenom: state.prenom,
      nom: state.nom,
      email: state.email,
      nombreDePartsFiscales: state.nombreDePartsFiscales,
      revenuFiscal: state.revenuFiscal,
    );
  }
}
