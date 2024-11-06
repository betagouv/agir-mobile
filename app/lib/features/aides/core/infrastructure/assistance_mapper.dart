import 'package:app/features/aides/core/domain/aide.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';

abstract final class AssistanceMapper {
  const AssistanceMapper._();

  static Assistance fromJson(final Map<String, dynamic> json) => Assistance(
        titre: json['titre'] as String,
        themeType: _mapThemeType(
          (json['thematiques'] as List<dynamic>).cast<String>().firstOrNull ??
              '',
        ),
        contenu: json['contenu'] as String,
        montantMax: (json['montant_max'] as num?)?.toInt(),
        urlSimulateur: json['url_simulateur'] as String?,
      );

  static ThemeType _mapThemeType(final String? type) => switch (type) {
        'alimentation' => ThemeType.alimentation,
        'transport' => ThemeType.transport,
        'consommation' => ThemeType.consommation,
        'logement' => ThemeType.logement,
        _ => ThemeType.decouverte,
      };
}
