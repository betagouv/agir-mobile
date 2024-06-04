import 'package:app/src/fonctionnalites/communes/domain/ports/communes_repository.dart';

class CommunesRepositoryMock implements CommunesRepository {
  const CommunesRepositoryMock(this.communes);

  final List<String> communes;

  @override
  Future<List<String>> recupererLesCommunes(final String codePostal) async =>
      communes;
}
