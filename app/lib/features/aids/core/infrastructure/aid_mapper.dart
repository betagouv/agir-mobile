import 'package:app/features/aids/core/domain/aid.dart';
import 'package:app/features/articles/domain/partner.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';

abstract final class AidMapper {
  const AidMapper._();

  static Aid fromJson(final Map<String, dynamic> json) => Aid(
    themeType: _mapThemeType(
      (json['thematiques'] as List<dynamic>).cast<String>().firstOrNull ?? '',
    ),
    title: json['titre'] as String,
    content: json['contenu'] as String,
    amountMax: (json['montant_max'] as num?)?.toInt(),
    simulatorUrl: json['url_simulateur'] as String?,
    partner:
        json['partenaire_nom'] == null
            ? null
            : Partner(
              nom: json['partenaire_nom'] as String,
              url: json['partenaire_url'] as String?,
              logo: json['partenaire_logo_url'] as String? ?? '',
            ),
  );

  static ThemeType _mapThemeType(final String? type) => switch (type) {
    'alimentation' => ThemeType.alimentation,
    'transport' => ThemeType.transport,
    'consommation' => ThemeType.consommation,
    'logement' => ThemeType.logement,
    _ => ThemeType.decouverte,
  };
}
