class UtilisateurIdNonTrouveException implements Exception {
  const UtilisateurIdNonTrouveException([
    this.message = 'ID utilisateur non trouvé',
  ]);

  final String message;
  @override
  String toString() => 'UtilisateurIdNonTrouveException: $message';
}
