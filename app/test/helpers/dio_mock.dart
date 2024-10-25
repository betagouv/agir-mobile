import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {
  DioMock() {
    when(() => interceptors).thenReturn(Interceptors());
  }

  void getM<T>(
    final String path, {
    required final T responseData,
    final int statusCode = 200,
  }) {
    when(() => get<dynamic>(path)).thenAnswer(
      (final answer) async => Response(
        data: responseData,
        requestOptions: RequestOptions(path: path),
        statusCode: statusCode,
      ),
    );
  }

  void postM(
    final String path, {
    final dynamic requestData,
    final dynamic responseData,
    final int statusCode = 200,
  }) {
    when(() => post<dynamic>(path, data: requestData ?? any(named: 'data')))
        .thenAnswer(
      (final answer) async => Response(
        data: responseData,
        requestOptions: RequestOptions(path: path),
        statusCode: statusCode,
      ),
    );
  }

  void patchM(
    final String path, {
    final dynamic requestData,
    final int statusCode = 200,
  }) {
    when(() => patch<dynamic>(path, data: requestData ?? any(named: 'data')))
        .thenAnswer(
      (final _) async => Response(
        requestOptions: RequestOptions(path: path),
        statusCode: statusCode,
      ),
    );
  }

  void putM(
    final String path, {
    final dynamic requestData,
    final int statusCode = 200,
  }) {
    when(() => put<dynamic>(path, data: requestData ?? any(named: 'data')))
        .thenAnswer(
      (final _) async => Response(
        requestOptions: RequestOptions(path: path),
        statusCode: statusCode,
      ),
    );
  }

  void deleteM(
    final String path, {
    final dynamic requestData,
    final int statusCode = 200,
  }) {
    when(() => delete<dynamic>(path, data: requestData ?? any(named: 'data')))
        .thenAnswer(
      (final _) async => Response(
        requestOptions: RequestOptions(path: path),
        statusCode: statusCode,
      ),
    );
  }
}
