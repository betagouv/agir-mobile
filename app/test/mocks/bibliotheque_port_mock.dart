import 'dart:async';

import 'package:app/features/bibliotheque/domain/bibliotheque.dart';
import 'package:app/features/bibliotheque/domain/ports/bibliotheque_port.dart';
import 'package:fpdart/fpdart.dart';

class BibliothequePortMock implements BibliothequePort {
  BibliothequePortMock(this.bibliotheque);

  Bibliotheque bibliotheque;

  @override
  Future<Either<Exception, Bibliotheque>> recuperer({
    final List<String>? thematiques,
    final String? titre,
    final bool? estFavoris,
  }) async {
    if (titre == null && thematiques == null && estFavoris == null) {
      return Right(bibliotheque);
    }

    if (titre != null && titre != '') {
      final contenus = bibliotheque.contenus
          .where((final e) => e.titre.contains(titre))
          .toList();

      return Right(
        Bibliotheque(contenus: contenus, filtres: bibliotheque.filtres),
      );
    }

    if (thematiques != null && thematiques.isNotEmpty) {
      final contenus = bibliotheque.contenus
          .where((final e) => thematiques.contains(e.thematique.name))
          .toList();
      final filtres = bibliotheque.filtres
          .map(
            (final e) => thematiques.contains(e.code)
                ? e.copyWith(choisi: true)
                : e.copyWith(choisi: false),
          )
          .toList();

      return Right(Bibliotheque(contenus: contenus, filtres: filtres));
    }

    return Right(bibliotheque);
  }
}
