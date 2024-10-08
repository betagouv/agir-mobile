import 'package:app/features/environmental_performance/summary/domain/environmental_performance_category.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_detail_item.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_detail_sub_item.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_empty.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_full.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_level.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_partial.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_summary.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_top_item.dart';
import 'package:app/features/environmental_performance/summary/domain/footprint.dart';

abstract final class EnvironmentalPerformanceSummaryMapperyMapper {
  const EnvironmentalPerformanceSummaryMapperyMapper._();

  static EnvironmentalPerformanceSummary fromJson(
    final Map<String, dynamic> json,
  ) {
    final partial = json['bilan_synthese'] as Map<String, dynamic>;
    final full = json['bilan_complet'] as Map<String, dynamic>;

    return EnvironmentalPerformanceSummary(
      empty: EnvironmentalPerformanceEmpty(questions: const []),
      partial: EnvironmentalPerformancePartial(
        performanceOnTransport:
            _mapLevelFromJson(partial['impact_transport'] as String?),
        performanceOnFood:
            _mapLevelFromJson(partial['impact_alimentation'] as String?),
        performanceOnHousing:
            _mapLevelFromJson(partial['impact_logement'] as String?),
        performanceOnConsumption: _mapLevelFromJson(
          partial['impact_consommation'] as String?,
        ),
        percentageCompletion:
            (partial['pourcentage_completion_totale'] as num).toInt(),
        categories: (partial['liens_bilans_univers'] as List<dynamic>)
            .map((final e) => e as Map<String, dynamic>)
            .map(_categoryFromJson)
            .toList(),
      ),
      full: EnvironmentalPerformanceFull(
        footprintInKgOfCO2ePerYear:
            Footprint((full['impact_kg_annee'] as num).toDouble()),
        top: (full['top_3'] as List<dynamic>)
            .map((final e) => e as Map<String, dynamic>)
            .map(topItemFromJson)
            .toList(),
        detail: (full['impact_univers'] as List<dynamic>)
            .map((final e) => e as Map<String, dynamic>)
            .map(_detailItemFromJson)
            .toList(),
      ),
    );
  }

  static EnvironmentalPerformanceLevel? _mapLevelFromJson(final String? type) =>
      switch (type) {
        null => null,
        'faible' => EnvironmentalPerformanceLevel.low,
        'moyen' => EnvironmentalPerformanceLevel.medium,
        'fort' => EnvironmentalPerformanceLevel.high,
        'tres_fort' => EnvironmentalPerformanceLevel.veryHigh,
        _ => throw UnimplementedError('Niveau non implémenté'),
      };

  static EnvironmentalPerformanceTopItem topItemFromJson(
    final Map<String, dynamic> json,
  ) =>
      EnvironmentalPerformanceTopItem(
        emoji: json['emoji'] as String,
        label: json['label'] as String,
        percentage: (json['pourcentage'] as num?)?.toInt(),
      );

  static EnvironmentalPerformanceDetailItem _detailItemFromJson(
    final Map<String, dynamic> json,
  ) =>
      EnvironmentalPerformanceDetailItem(
        emoji: json['emoji'] as String,
        label: json['univers_label'] as String,
        footprintInKgOfCO2ePerYear:
            Footprint((json['impact_kg_annee'] as num).toDouble()),
        subItems: (json['details'] as List<dynamic>)
            .map((final e) => e as Map<String, dynamic>)
            .map(_detailSubItemFromJson)
            .toList(),
      );

  static EnvironmentalPerformanceDetailSubItem _detailSubItemFromJson(
    final Map<String, dynamic> json,
  ) =>
      EnvironmentalPerformanceDetailSubItem(
        emoji: json['emoji'] as String,
        label: json['label'] as String,
        footprintInKgOfCO2ePerYear:
            Footprint((json['impact_kg_annee'] as num).toDouble()),
        percentage: (json['pourcentage_categorie'] as num?)?.toInt(),
      );

  static EnvironmentalPerformanceCategory _categoryFromJson(
    final Map<String, dynamic> json,
  ) =>
      EnvironmentalPerformanceCategory(
        id: json['id_enchainement_kyc'] as String,
        imageUrl: json['image_url'] as String,
        percentageCompletion: (json['pourcentage_progression'] as num).toInt(),
        label: json['univers_label'] as String,
        totalNumberQuestions: (json['nombre_total_question'] as num).toInt(),
      );
}
