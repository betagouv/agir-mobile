import 'dart:async';
import 'dart:io';

import 'package:app/features/aides/core/domain/aide.dart';
import 'package:app/features/aides/core/domain/aides_port.dart';
import 'package:app/features/aides/core/infrastructure/aide_mapper.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:fpdart/fpdart.dart';

class AidesApiAdapter implements AidesPort {
  const AidesApiAdapter({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  @override
  Future<Either<Exception, List<Aide>>> fetchAides() async {
    final response = await _client.get('/utilisateurs/{userId}/aides');

    if (response.statusCode != HttpStatus.ok) {
      return Left(Exception('Erreur lors de la récupération des aides'));
    }

    final json = response.data! as List<dynamic>;

    return Right(
      json
          .map((final e) => AideMapper.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
