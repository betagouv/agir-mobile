import 'package:equatable/equatable.dart';

class EnvironmentalPerformanceCategory extends Equatable {
  const EnvironmentalPerformanceCategory({
    required this.id,
    required this.imageUrl,
    required this.percentageCompletion,
    required this.label,
    required this.totalNumberQuestions,
  });

  final String id;
  final String imageUrl;
  final int percentageCompletion;
  final String label;
  final int totalNumberQuestions;

  @override
  List<Object?> get props => [
    id,
    imageUrl,
    percentageCompletion,
    label,
    totalNumberQuestions,
  ];
}
