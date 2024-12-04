import 'package:app/features/environmental_performance/summary/domain/environmental_performance_category.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_detail_item.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_level.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_top_item.dart';
import 'package:app/features/environmental_performance/summary/domain/footprint.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:equatable/equatable.dart';

sealed class EnvironmentalPerformanceData extends Equatable {
  const EnvironmentalPerformanceData();

  @override
  List<Object?> get props => [];
}

final class EnvironmentalPerformanceEmpty extends EnvironmentalPerformanceData {
  EnvironmentalPerformanceEmpty({required this.questions})
      : questionsNumber = questions.length,
        questionsNumberAnswered =
            questions.where((final question) => question.isAnswered).length;

  final List<Question> questions;
  final int questionsNumber;
  final int questionsNumberAnswered;
  double get percentageCompletion => questionsNumberAnswered / questionsNumber;

  @override
  List<Object> get props => [
        questions,
        questionsNumberAnswered,
        questionsNumber,
      ];
}

final class EnvironmentalPerformancePartial
    extends EnvironmentalPerformanceData {
  const EnvironmentalPerformancePartial({
    required this.performanceOnTransport,
    required this.performanceOnFood,
    required this.performanceOnHousing,
    required this.performanceOnConsumption,
    required this.percentageCompletion,
    required this.categories,
  });

  final EnvironmentalPerformanceLevel? performanceOnTransport;
  final EnvironmentalPerformanceLevel? performanceOnFood;
  final EnvironmentalPerformanceLevel? performanceOnHousing;
  final EnvironmentalPerformanceLevel? performanceOnConsumption;
  final int percentageCompletion;
  final List<EnvironmentalPerformanceCategory> categories;

  @override
  List<Object?> get props => [
        performanceOnTransport,
        performanceOnFood,
        performanceOnHousing,
        performanceOnConsumption,
        percentageCompletion,
        categories,
      ];
}

final class EnvironmentalPerformanceFull extends EnvironmentalPerformanceData {
  const EnvironmentalPerformanceFull({
    required this.footprintInKgOfCO2ePerYear,
    required this.top,
    required this.detail,
    required this.categories,
  });

  final Footprint footprintInKgOfCO2ePerYear;
  final List<EnvironmentalPerformanceTopItem> top;
  final List<EnvironmentalPerformanceDetailItem> detail;
  final List<EnvironmentalPerformanceCategory> categories;

  @override
  List<Object> get props =>
      [top, footprintInKgOfCO2ePerYear, detail, categories];
}
