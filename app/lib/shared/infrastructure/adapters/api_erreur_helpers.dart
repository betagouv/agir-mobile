import 'dart:convert';

import 'package:app/shared/domain/entities/api_erreur.dart';
import 'package:app/shared/infrastructure/adapters/api_erreur_mapper.dart';
import 'package:fpdart/fpdart.dart';

Left<ApiErreur, Unit> handleError(
  final String errorMessage, {
  required final String defaultMessage,
}) {
  if (errorMessage.isEmpty) {
    return Left(ApiErreur(defaultMessage));
  }

  final json = jsonDecode(errorMessage) as Map<String, dynamic>;
  final message = ApiErreurMapper.fromJson(json);

  return Left(message);
}
