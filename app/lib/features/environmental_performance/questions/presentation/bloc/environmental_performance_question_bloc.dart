import 'package:app/features/environmental_performance/questions/infrastructure/environment_performance_question_repository.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_event.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnvironmentalPerformanceQuestionBloc
    extends
        Bloc<
          EnvironmentalPerformanceQuestionEvent,
          EnvironmentalPerformanceQuestionState
        > {
  EnvironmentalPerformanceQuestionBloc({
    required final EnvironmentalPerformanceQuestionRepository repository,
  }) : super(const EnvironmentalPerformanceQuestionInitial()) {
    on<EnvironmentalPerformanceQuestionIdListGiven>((final event, final emit) {
      emit(const EnvironmentalPerformanceQuestionInitial());
      emit(
        EnvironmentalPerformanceQuestionLoadSuccess(
          questionIdList: event.questionIdList,
        ),
      );
    });
    on<EnvironmentalPerformanceQuestionIdListRequested>((
      final event,
      final emit,
    ) async {
      emit(const EnvironmentalPerformanceQuestionInitial());
      final result = await repository.fetchBilanByCategory(event.categoryId);

      return result.fold(
        (final l) => emit(
          EnvironmentalPerformanceQuestionLoadFailure(message: l.toString()),
        ),
        (final r) => emit(
          EnvironmentalPerformanceQuestionLoadSuccess(
            questionIdList: r.map((final e) => e.id).toList(),
          ),
        ),
      );
    });
  }
}
