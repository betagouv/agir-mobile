import 'package:app/features/challenges/core/domain/challenge_id.dart';
import 'package:app/features/challenges/core/domain/challenge_status.dart';
import 'package:app/features/challenges/detail/domain/challenge.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';

abstract final class ChallengeMapper {
  const ChallengeMapper._();

  static Challenge fromJson(final Map<String, dynamic> json) => Challenge(
        id: ChallengeId(json['id'] as String),
        themeType: _mapThemeType(json['thematique'] as String),
        title: json['titre'] as String,
        status: _challengeStatusfromJson(json['status'] as String),
        reason: json['motif'] as String?,
        tips: json['astuces'] as String,
        why: json['pourquoi'] as String,
      );

  static ChallengeStatus _challengeStatusfromJson(final String json) =>
      switch (json) {
        'todo' => ChallengeStatus.toDo,
        'en_cours' => ChallengeStatus.inProgress,
        'pas_envie' => ChallengeStatus.refused,
        'deja_fait' => ChallengeStatus.alreadyDone,
        'abondon' => ChallengeStatus.abandonned,
        'fait' => ChallengeStatus.done,
        // ignore: no-equal-switch-expression-cases
        _ => ChallengeStatus.toDo,
      };

  static ThemeType _mapThemeType(final String? type) => switch (type) {
        'alimentation' => ThemeType.alimentation,
        'transport' => ThemeType.transport,
        'consommation' => ThemeType.consommation,
        'logement' => ThemeType.logement,
        _ => ThemeType.decouverte,
      };
}
