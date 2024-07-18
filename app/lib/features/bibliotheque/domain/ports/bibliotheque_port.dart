import 'package:app/features/bibliotheque/domain/bibliotheque.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BibliothequePort {
  Future<Either<Exception, Bibliotheque>> recuperer({
    final List<String>? thematiques,
    final String? titre,
    final bool? estFavoris,
  });
}
