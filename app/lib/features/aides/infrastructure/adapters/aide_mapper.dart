import 'package:app/features/aides/domain/entities/aide.dart';

abstract final class AideMapper {
  const AideMapper._();

  static Aide fromJson(final Map<String, dynamic> json) => Aide(
        titre: json['titre'] as String,
        thematique: (json['thematiques_label'] as List<dynamic>)
                .cast<String>()
                .firstOrNull ??
            '',
        contenu: json['contenu'] as String,
        montantMax: (json['montant_max'] as num?)?.toInt(),
        urlSimulateur: json['url_simulateur'] as String?,
      );
}
