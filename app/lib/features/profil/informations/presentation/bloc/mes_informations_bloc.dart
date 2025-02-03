import 'package:app/features/profil/core/infrastructure/profil_repository.dart';
import 'package:app/features/profil/informations/presentation/bloc/mes_informations_event.dart';
import 'package:app/features/profil/informations/presentation/bloc/mes_informations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class MesInformationsBloc
    extends Bloc<MesInformationsEvent, MesInformationsState> {
  MesInformationsBloc({required final ProfilRepository profilRepository})
      : super(const MesInformationsState.empty()) {
    on<MesInformationsRecuperationDemandee>((final event, final emit) async {
      emit(state.copyWith(statut: MesInformationsStatut.chargement));
      final result = await profilRepository.recupererProfil();
      if (result.isRight()) {
        final profil = result.getRight().getOrElse(() => throw Exception());
        emit(
          MesInformationsState(
            email: profil.email,
            prenom: profil.prenom,
            nom: profil.nom,
            anneeDeNaissance: profil.anneeDeNaissance,
            nombreDePartsFiscales: profil.nombreDePartsFiscales,
            revenuFiscal: profil.revenuFiscal,
            statut: MesInformationsStatut.succes,
          ),
        );
      }
    });
    on<MesInformationsPrenomChange>(
      (final event, final emit) => emit(state.copyWith(prenom: event.valeur)),
    );
    on<MesInformationsNomChange>(
      (final event, final emit) => emit(state.copyWith(nom: event.valeur)),
    );
    on<MesInformationsAnneeChange>(
      (final event, final emit) =>
          emit(state.copyWith(anneeDeNaissance: event.valeur)),
    );
    on<MesInformationsNombreDePartsFiscalesChange>(
      (final event, final emit) =>
          emit(state.copyWith(nombreDePartsFiscales: event.valeur)),
    );
    on<MesInformationsRevenuFiscalChange>(
      (final event, final emit) =>
          emit(state.copyWith(revenuFiscal: event.valeur)),
    );
    on<MesInformationsMiseAJourDemandee>(
      (final event, final emit) async => profilRepository.mettreAJour(
        prenom: state.prenom,
        nom: state.nom,
        anneeDeNaissance: state.anneeDeNaissance,
        nombreDePartsFiscales: state.nombreDePartsFiscales,
        revenuFiscal: state.revenuFiscal,
      ),
    );
  }
}
