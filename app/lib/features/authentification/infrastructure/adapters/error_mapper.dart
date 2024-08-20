import 'package:app/features/authentification/domain/entities/adapter_erreur.dart';

abstract final class AdapterErreurMapper {
  const AdapterErreurMapper._();

  static AdapterErreur fromJson(final Map<String, dynamic> json) =>
      AdapterErreur(json['message'] as String);
}
