class MissingEnvironmentKeyException implements Exception {
  const MissingEnvironmentKeyException(this.message);

  final String message;

  @override
  String toString() =>
      'MissingEnvironmentKeyException: The environment key "$message" is missing.';
}
