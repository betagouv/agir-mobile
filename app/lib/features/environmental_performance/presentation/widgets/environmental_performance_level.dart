import 'package:app/features/environmental_performance/environmental_performance_l10n.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class EnvironmentalPerformanceLevel extends Equatable {
  const EnvironmentalPerformanceLevel._({
    required this.label,
    required this.backgroundColor,
    required this.labelColor,
  });

  const EnvironmentalPerformanceLevel.low()
      : this._(
          label: EnvironmentalPerformanceLocalisation.faible,
          backgroundColor: const Color(0xFFF1FFE3),
          labelColor: const Color(0xFF105A06),
        );

  const EnvironmentalPerformanceLevel.medium()
      : this._(
          label: EnvironmentalPerformanceLocalisation.moyen,
          backgroundColor: const Color(0xFFFFFAE3),
          labelColor: const Color(0xFF784000),
        );

  const EnvironmentalPerformanceLevel.strong()
      : this._(
          label: EnvironmentalPerformanceLocalisation.fort,
          backgroundColor: const Color(0xFFFFF3E3),
          labelColor: const Color(0xFF950704),
        );

  const EnvironmentalPerformanceLevel.veryStrong()
      : this._(
          label: EnvironmentalPerformanceLocalisation.tresFort,
          backgroundColor: const Color(0xFFFFE3E3),
          labelColor: const Color(0xFF910501),
        );

  factory EnvironmentalPerformanceLevel.fromProgress(final double progress) {
    switch (progress) {
      case <= 0.23:
        return const EnvironmentalPerformanceLevel.low();
      case <= 0.47:
        return const EnvironmentalPerformanceLevel.medium();
      case <= 0.77:
        return const EnvironmentalPerformanceLevel.strong();
      default:
        return const EnvironmentalPerformanceLevel.veryStrong();
    }
  }

  final String label;
  final Color backgroundColor;
  final Color labelColor;

  @override
  List<Object> get props => [label, backgroundColor, labelColor];
}
