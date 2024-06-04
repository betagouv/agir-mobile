import 'dart:async';

import 'package:app/src/fonctionnalites/profil/bloc/profil_event.dart';
import 'package:app/src/fonctionnalites/profil/bloc/profil_state.dart';
import 'package:app/src/fonctionnalites/profil/domain/ports/profil_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilBloc extends Bloc<ProfilEvent, ProfilState> {
  ProfilBloc({required final ProfilRepository profilRepository})
      : _profilRepository = profilRepository,
        super(const ProfilInitial()) {
    on<ProfilRecuperationDemandee>(_onRecuperationDemandee);
  }

  FutureOr<void> _onRecuperationDemandee(
    final ProfilRecuperationDemandee event,
    final Emitter<ProfilState> emit,
  ) {}

  final ProfilRepository _profilRepository;
}
