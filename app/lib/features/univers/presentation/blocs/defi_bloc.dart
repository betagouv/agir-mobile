import 'package:app/features/univers/domain/ports/univers_port.dart';
import 'package:app/features/univers/presentation/blocs/defi_event.dart';
import 'package:app/features/univers/presentation/blocs/defi_state.dart';
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
            veutRelever: none(),
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
            veutRelever: const Some(true),
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
            veutRelever: const Some(false),
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
          veutRelever: succes.veutRelever,
          motif: succes.motif,
          estMiseAJour: false,
        ),
      );
    });
    on<DefiValidationDemande>((final event, final emit) async {
      if (state is! DefiSucces) {
        return;
      }
      final succes = state as DefiSucces;
      await succes.veutRelever.fold(() => null, (final veutRelever) async {
        if (veutRelever) {
          await universPort.accepterDefi(defiId: succes.defi.id);
        } else {
          await universPort.refuserDefi(
            defiId: succes.defi.id,
            motif: succes.motif,
          );
        }
        emit(
          DefiSucces(
            defi: succes.defi,
            veutRelever: succes.veutRelever,
            motif: succes.motif,
            estMiseAJour: true,
          ),
        );
      });
    });
  }
}
