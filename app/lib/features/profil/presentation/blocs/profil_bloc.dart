import 'dart:async';

import 'package:app/features/profil/domain/ports/profil_port.dart';
import 'package:app/features/profil/presentation/blocs/profil_event.dart';
import 'package:app/features/profil/presentation/blocs/profil_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilBloc extends Bloc<ProfilEvent, ProfilState> {
  ProfilBloc({required final ProfilPort profilRepository})
      : _profilRepository = profilRepository,
        super(const ProfilInitial()) {
    on<ProfilRecuperationDemandee>(_onRecuperationDemandee);
  }

  Future<void> _onRecuperationDemandee(
    final ProfilRecuperationDemandee event,
    final Emitter<ProfilState> emit,
  ) async {
    await _profilRepository.recupereProfil();
  }

  final ProfilPort _profilRepository;
}
