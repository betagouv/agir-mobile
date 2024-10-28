import 'package:app/features/theme/core/domain/theme_tile.dart';

abstract final class TuileUniversMapper {
  const TuileUniversMapper._();

  static ThemeTile fromJson(final Map<String, dynamic> json) => ThemeTile(
        type: json['type'] as String,
        title: json['titre'] as String,
        imageUrl: json['image_url'] as String,
      );
}
