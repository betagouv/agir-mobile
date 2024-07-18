// ignore_for_file: no-equal-switch-expression-cases

import 'package:app/features/bibliotheque/domain/bibliotheque.dart';
import 'package:app/features/recommandations/infrastructure/adapters/recommandation_mapper.dart';

abstract final class BibliothequeMapper {
  const BibliothequeMapper._();

  static Bibliotheque fromJson(final Map<String, dynamic> json) => Bibliotheque(
        contenus: (json['contenu'] as List<dynamic>)
            .map(
              (final e) =>
                  RecommandationMapper.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
        filtres: (json['filtres'] as List<dynamic>)
            .map(
              (final e) =>
                  BibliothequeFiltreMapper.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );
}

abstract final class BibliothequeFiltreMapper {
  const BibliothequeFiltreMapper._();

  static BibliothequeFiltre fromJson(final Map<String, dynamic> json) =>
      BibliothequeFiltre(
        code: json['code'] as String,
        titre: json['label'] as String,
        choisi: json['selected'] as bool,
      );
}
