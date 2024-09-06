import 'package:app/features/univers/domain/tuile_univers.dart';

abstract final class TuileUniversMapper {
  const TuileUniversMapper._();

  static TuileUnivers fromJson(final Map<String, dynamic> json) => TuileUnivers(
        type: json['type'] as String,
        titre: json['titre'] as String,
        imageUrl: json['image_url'] as String,
        estTerminee: json['is_done'] as bool,
      );
}
