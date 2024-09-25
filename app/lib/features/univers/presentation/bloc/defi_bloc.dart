import 'package:app/features/univers/core/domain/mission_defi.dart';
import 'package:app/features/univers/core/domain/univers_port.dart';
import 'package:app/features/univers/presentation/bloc/defi_event.dart';
import 'package:app/features/univers/presentation/bloc/defi_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class DefiBloc extends Bloc<DefiEvent, DefiState> {
  DefiBloc({required final UniversPort universPort})
      : super(const DefiInitial()) {
    on<DefiRecuperationDemande>((final event, final emit) async {
      emit(const DefiChargement());
      final result = await universPort.recupererDefi(defiId: event.defiId);
      result.fold(
        (final exception) => emit(const DefiError()),
        (final defi) => emit(
          DefiSucces(
            defi: defi,
            status: none(),
            motif: null,
            estMiseAJour: false,
          ),
        ),
      );
    });
    on<DefiReleveDemande>((final event, final emit) async {
      if (state is DefiSucces) {
        emit(
          DefiSucces(
            defi: (state as DefiSucces).defi,
            status: some(MissionDefiStatus.inProgress),
            motif: null,
            estMiseAJour: false,
          ),
        );
      }
    });
    on<DefiNeRelevePasDemande>((final event, final emit) async {
      if (state is DefiSucces) {
        emit(
          DefiSucces(
            defi: (state as DefiSucces).defi,
            status: some(MissionDefiStatus.refused),
            motif: null,
            estMiseAJour: false,
          ),
        );
      }
    });
    on<DefiNeRelevePasMotifChange>((final event, final emit) async {
      if (state is! DefiSucces) {
        return;
      }
      final succes = state as DefiSucces;
      emit(
        DefiSucces(
          defi: succes.defi,
          status: succes.status,
          motif: succes.motif,
          estMiseAJour: false,
        ),
      );
    });
    on<DefiRealiseDemande>((final event, final emit) async {
      if (state is DefiSucces) {
        emit(
          DefiSucces(
            defi: (state as DefiSucces).defi,
            status: some(MissionDefiStatus.done),
            motif: null,
            estMiseAJour: false,
          ),
        );
      }
    });
    on<DefiAbandonDemande>((final event, final emit) async {
      if (state is DefiSucces) {
        emit(
          DefiSucces(
            defi: (state as DefiSucces).defi,
            status: some(MissionDefiStatus.abandonned),
            motif: null,
            estMiseAJour: false,
          ),
        );
      }
    });
    on<DefiValidationDemande>((final event, final emit) async {
      if (state is! DefiSucces) {
        return;
      }
      final succes = state as DefiSucces;
      await succes.status.fold(() => null, (final status) async {
        switch (status) {
          case MissionDefiStatus.inProgress:
            await universPort.accepterDefi(defiId: succes.defi.id);

          case MissionDefiStatus.refused:
            await universPort.refuserDefi(
              defiId: succes.defi.id,
              motif: succes.motif,
            );

          case MissionDefiStatus.abandonned:
            await universPort.abondonnerDefi(
              defiId: succes.defi.id,
              motif: succes.motif,
            );

          case MissionDefiStatus.done:
            await universPort.realiserDefi(succes.defi.id);

          case MissionDefiStatus.toDo:
          case MissionDefiStatus.alreadyDone:
            break;
        }

        emit(
          DefiSucces(
            defi: succes.defi,
            status: succes.status,
            motif: succes.motif,
            estMiseAJour: true,
          ),
        );
      });
    });
  }
}
