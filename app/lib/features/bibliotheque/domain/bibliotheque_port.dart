import 'package:app/features/bibliotheque/domain/bibliotheque.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BibliothequePort {
  Future<Either<Exception, Bibliotheque>> recuperer({
    required final List<String>? thematiques,
    required final String? titre,
    required final bool? isFavorite,
  });
}
