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
  }) async =>
      Right(bibliotheque);
}
