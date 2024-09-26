import 'dart:async';
import 'dart:io';

import 'package:app/features/actions/list/domain/action_item.dart';
import 'package:app/features/actions/list/domain/actions_port.dart';
import 'package:app/features/actions/list/infrastructure/action_item_mapper.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:fpdart/fpdart.dart';

class ActionsAdapter implements ActionsPort {
  const ActionsAdapter({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  @override
  Future<Either<Exception, List<ActionItem>>> fetchActions() async {
    final response = await _client.get<List<dynamic>>(
      '/utilisateurs/{userId}/defis',
    );

    if (response.statusCode != HttpStatus.ok) {
      return Left(Exception('Erreur lors de la récupération des actions'));
    }

    final json = response.data!;

    return Right(
      json
          .map(
            (final e) => ActionItemMapper.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
