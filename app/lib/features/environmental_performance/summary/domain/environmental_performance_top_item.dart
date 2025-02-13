import 'package:equatable/equatable.dart';

class EnvironmentalPerformanceTopItem extends Equatable {
  const EnvironmentalPerformanceTopItem({required this.emoji, required this.label, this.percentage});

  final String emoji;
  final String label;
  final int? percentage;

  @override
  List<Object?> get props => [emoji, label, percentage];
}
