import 'package:app/features/environmental_performance/summary/application/fetch_environmental_performance.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_event.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnvironmentalPerformanceBloc extends Bloc<EnvironmentalPerformanceEvent, EnvironmentalPerformanceState> {
  EnvironmentalPerformanceBloc({required final FetchEnvironmentalPerformance useCase})
    : super(const EnvironmentalPerformanceInitial()) {
    on<EnvironmentalPerformanceStarted>((final event, final emit) async {
      emit(const EnvironmentalPerformanceLoading());
      final result = await useCase();
      result.fold(
        (final l) => emit(EnvironmentalPerformanceFailure(errorMessage: l.toString())),
        (final r) => emit(EnvironmentalPerformanceSuccess(data: r)),
      );
    });
  }
}
