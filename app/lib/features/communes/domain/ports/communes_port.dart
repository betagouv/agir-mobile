abstract interface class CommunesPort {
  Future<List<String>> recupererLesCommunes(final String codePostal);
}
