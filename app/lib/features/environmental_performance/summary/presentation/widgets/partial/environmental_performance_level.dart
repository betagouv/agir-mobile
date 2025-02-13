import 'package:app/features/environmental_performance/summary/domain/environmental_performance_level.dart';
import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class EnvironmentalPerformanceLevelRepresentation extends Equatable {
  const EnvironmentalPerformanceLevelRepresentation._({
    required this.label,
    required this.backgroundColor,
    required this.labelColor,
  });

  const EnvironmentalPerformanceLevelRepresentation.low()
    : this._(
        label: EnvironmentalPerformanceSummaryL10n.faible,
        backgroundColor: const Color(0xFFF1FFE3),
        labelColor: const Color(0xFF105A06),
      );

  const EnvironmentalPerformanceLevelRepresentation.medium()
    : this._(
        label: EnvironmentalPerformanceSummaryL10n.moyen,
        backgroundColor: const Color(0xFFFFFAE3),
        labelColor: const Color(0xFF784000),
      );

  const EnvironmentalPerformanceLevelRepresentation.high()
    : this._(
        label: EnvironmentalPerformanceSummaryL10n.fort,
        backgroundColor: const Color(0xFFFFF3E3),
        labelColor: const Color(0xFF950704),
      );

  const EnvironmentalPerformanceLevelRepresentation.veryHigh()
    : this._(
        label: EnvironmentalPerformanceSummaryL10n.tresFort,
        backgroundColor: const Color(0xFFFFE3E3),
        labelColor: const Color(0xFF910501),
      );

  factory EnvironmentalPerformanceLevelRepresentation.fromProgress(
    final EnvironmentalPerformanceLevel level,
  ) => switch (level) {
    EnvironmentalPerformanceLevel.low =>
      const EnvironmentalPerformanceLevelRepresentation.low(),
    EnvironmentalPerformanceLevel.medium =>
      const EnvironmentalPerformanceLevelRepresentation.medium(),
    EnvironmentalPerformanceLevel.high =>
      const EnvironmentalPerformanceLevelRepresentation.high(),
    EnvironmentalPerformanceLevel.veryHigh =>
      const EnvironmentalPerformanceLevelRepresentation.veryHigh(),
  };

  final String label;
  final Color backgroundColor;
  final Color labelColor;

  @override
  List<Object> get props => [label, backgroundColor, labelColor];
}
