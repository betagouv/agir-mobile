abstract interface class CommunesRepository {
  Future<List<String>> recupererLesCommunes(final String codePostal);
}
