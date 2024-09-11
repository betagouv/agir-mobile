final class ApiErreur implements Exception {
  const ApiErreur(this.message);

  final String message;
}
