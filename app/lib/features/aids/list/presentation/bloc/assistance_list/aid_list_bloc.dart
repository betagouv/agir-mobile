import 'package:app/core/error/domain/api_erreur.dart';
import 'package:app/features/aids/core/domain/aid.dart';
import 'package:app/features/aids/core/domain/aid_list.dart';
import 'package:app/features/aids/list/infrastructure/aids_repository.dart';
import 'package:app/features/aids/list/presentation/bloc/assistance_list/aid_list_event.dart';
import 'package:app/features/aids/list/presentation/bloc/assistance_list/aid_list_state.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AidListBloc extends Bloc<AidListEvent, AidListState> {
  AidListBloc({required final AidsRepository aidsRepository})
    : super(const AidListInitial()) {
    on<AidListFetch>((final event, final emit) async {
      emit(const AidListLoadInProgress());
      final result = await aidsRepository.fetch();
      result.fold(
        (final l) {
          emit(AidListLoadFailure(l is ApiErreur ? l.message : l.toString()));
        },
        (final r) {
          final assistanceListModel = _groupAssistancesByTheme(r);
          emit(
            AidListLoadSuccess(
              isCovered: r.isCovered,
              themes: assistanceListModel,
              themeSelected: null,
            ),
          );
        },
      );
    });
    on<AidListThemeSelected>((final event, final emit) async {
      final aState = state;
      if (aState is AidListLoadSuccess) {
        emit(
          AidListLoadSuccess(
            isCovered: aState.isCovered,
            themes: aState.themes,
            themeSelected: event.value,
          ),
        );
      }
    });
  }

  Map<ThemeType, List<Aid>> _groupAssistancesByTheme(final AidList r) =>
      Map.fromEntries(
        ThemeType.values
            .map((final themeType) {
              final assistances = r.aids.where(
                (final a) => a.themeType == themeType,
              );

              return assistances.isNotEmpty
                  ? MapEntry(themeType, assistances.toList())
                  : null;
            })
            .where((final entry) => entry != null)
            .cast<MapEntry<ThemeType, List<Aid>>>(),
      );
}
