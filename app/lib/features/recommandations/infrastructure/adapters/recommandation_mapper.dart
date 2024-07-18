// ignore_for_file: no-equal-switch-expression-cases

import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';

abstract final class RecommandationMapper {
  const RecommandationMapper._();

  static Recommandation fromJson(final Map<String, dynamic> json) =>
      Recommandation(
        id: json['content_id'] as String,
        type: _mapContentTypeFromJson(json['type'] as String),
        titre: json['titre'] as String,
        sousTitre: json['soustitre'] as String?,
        imageUrl: json['image_url'] as String,
        points: (json['points'] as num).toInt(),
        thematique:
            _mapThematiqueFromJson(json['thematique_principale'] as String),
        thematiqueLabel: json['thematique_principale_label'] as String,
      );

  static TypeDuContenu _mapContentTypeFromJson(final String? type) =>
      switch (type) {
        'article' => TypeDuContenu.article,
        'kyc' => TypeDuContenu.kyc,
        'quizz' => TypeDuContenu.quiz,
        _ => TypeDuContenu.article,
      };

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
