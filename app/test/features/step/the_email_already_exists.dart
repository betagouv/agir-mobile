import 'dart:io';

import 'package:app/core/infrastructure/endpoints.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';

/// Usage: the email already exists
Future<void> theEmailAlreadyExists(final WidgetTester tester) async {
  FeatureContext.instance.dioMock.postM(
    Endpoints.creationCompte,
    statusCode: HttpStatus.badRequest,
    responseData: {
      'statusCode': HttpStatus.badRequest,
      'code': '022',
      'message': 'Adresse électronique joe@doe.fr déjà existante',
    },
  );
}
