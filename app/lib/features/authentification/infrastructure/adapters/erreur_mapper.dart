import 'package:app/features/authentification/domain/entities/authentification_erreur.dart';

abstract final class AuthentificationErreurMapper {
  const AuthentificationErreurMapper._();

  static AuthentificationErreur fromJson(final Map<String, dynamic> json) =>
      AuthentificationErreur(json['message'] as String);
}
