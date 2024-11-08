import 'package:app/core/error/domain/api_erreur.dart';
import 'package:app/features/assistances/core/domain/aide.dart';
import 'package:app/features/assistances/list/infrastructure/assistances_repository.dart';
import 'package:app/features/assistances/list/presentation/bloc/assistance_list/assistance_list_event.dart';
import 'package:app/features/assistances/list/presentation/bloc/assistance_list/assistance_list_state.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssistanceListBloc
    extends Bloc<AssistanceListEvent, AssistanceListState> {
  AssistanceListBloc({
    required final AssistancesRepository assistancesRepository,
  }) : super(const AssistanceListInitial()) {
    on<AssistanceListFetch>((final event, final emit) async {
      emit(const AssistanceListLoadInProgress());
      final result = await assistancesRepository.fetch();
      result.fold(
        (final l) {
          emit(
            AssistanceListLoadFailure(
              l is ApiErreur ? l.message : l.toString(),
            ),
          );
        },
        (final r) {
          final assistanceListModel = _groupAssistancesByTheme(r);

          emit(
            AssistanceListLoadSuccess(
              isCovered: r.isCovered,
              themes: assistanceListModel,
              themeSelected: null,
            ),
          );
        },
      );
    });
    on<AssistanceListThemeSelected>((final event, final emit) async {
      final aState = state;
      if (aState is AssistanceListLoadSuccess) {
        emit(
          AssistanceListLoadSuccess(
            isCovered: aState.isCovered,
            themes: aState.themes,
            themeSelected: event.value,
          ),
        );
      }
    });
  }

  Map<ThemeType, List<Assistance>> _groupAssistancesByTheme(
    final AssistanceList r,
  ) =>
      Map.fromEntries(
        ThemeType.values
            .map((final themeType) {
              final assistances =
                  r.assistances.where((final a) => a.themeType == themeType);

              return assistances.isNotEmpty
                  ? MapEntry(themeType, assistances.toList())
                  : null;
            })
            .where((final entry) => entry != null)
            .cast<MapEntry<ThemeType, List<Assistance>>>(),
      );
}
