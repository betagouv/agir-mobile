import 'package:app/shared/domain/entities/api_erreur.dart';

abstract final class ApiErreurMapper {
  const ApiErreurMapper._();

  static ApiErreur fromJson(final Map<String, dynamic> json) =>
      ApiErreur(json['message'] as String);
}
