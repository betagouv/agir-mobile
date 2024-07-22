// ignore_for_file: no-equal-switch-expression-cases

import 'package:app/features/univers/domain/tuile_univers.dart';

abstract final class TuileUniversMapper {
  const TuileUniversMapper._();

  static TuileUnivers fromJson(final Map<String, dynamic> json) => TuileUnivers(
        titre: json['titre'] as String,
        imageUrl: json['image_url'] as String,
        estVerrouille: json['is_locked'] as bool,
        estTerminee: json['is_done'] as bool,
      );
}
