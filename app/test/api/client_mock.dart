// ignore_for_file: discarded_futures

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'custom_response.dart';
import 'request_fake.dart';
import 'request_mathcher.dart';

class ClientMock extends Mock implements http.Client {
  void postSuccess({
    required final Map<String, dynamic> bodyFields,
    required final CustomResponse response,
  }) {
    registerFallbackValue(RequestFake());
    when(
      () => send(any(that: RequestMathcher('/utilisateurs/login', bodyFields))),
    ).thenAnswer((final _) async => response);
  }
}
