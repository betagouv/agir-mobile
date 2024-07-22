// ignore_for_file: no-equal-switch-expression-cases

import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/univers/domain/tuile_univers.dart';

abstract final class TuileUniversMapper {
  const TuileUniversMapper._();

  static TuileUnivers fromJson(final Map<String, dynamic> json) => TuileUnivers(
        type: _mapThematiqueFromJson(json['type'] as String),
        titre: json['titre'] as String,
        imageUrl: json['image_url'] as String,
        estVerrouille: json['is_locked'] as bool,
        estTerminee: json['is_done'] as bool,
      );

  static Thematique _mapThematiqueFromJson(final String? type) =>
      switch (type) {
        'alimentation' => Thematique.alimentation,
        'transport' => Thematique.transport,
        'logement' => Thematique.logement,
        'consommation' => Thematique.consommation,
        'climat' => Thematique.climat,
        'dechet' => Thematique.dechet,
        'loisir' => Thematique.loisir,
        _ => Thematique.loisir,
      };
}
