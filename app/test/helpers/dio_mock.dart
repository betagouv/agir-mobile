import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {
  DioMock() {
    when(() => interceptors).thenReturn(Interceptors());
  }

  void patchM(
    final String path, {
    final dynamic requestData,
    final int statusCode = 200,
  }) {
    // ignore: discarded_futures
    when(() => patch<void>(path, data: requestData ?? any(named: 'data')))
        .thenAnswer(
      (final _) async => Response(
        requestOptions: RequestOptions(),
        statusCode: statusCode,
      ),
    );
  }

  void postM<T>(
    final String path, {
    final dynamic requestData,
    required final T responseData,
    final int statusCode = 200,
  }) {
    final requestOptions = RequestOptions(path: path);
    if (responseData is List) {
      when(
        // ignore: discarded_futures
        () => post<List<dynamic>>(
          path,
          data: requestData ?? any(named: 'data'),
        ),
      ).thenAnswer(
        (final answer) async => Response(
          data: responseData,
          requestOptions: requestOptions,
          statusCode: statusCode,
        ),
      );
    } else {
      // ignore: discarded_futures
      when(() => post<dynamic>(path, data: requestData ?? any(named: 'data')))
          .thenAnswer(
        (final answer) async => Response(
          data: responseData,
          requestOptions: requestOptions,
          statusCode: statusCode,
        ),
      );
    }
  }

  void getM<T>(
    final String path, {
    required final T responseData,
    final int statusCode = 200,
  }) {
    final requestOptions = RequestOptions(path: path);
    if (responseData is List) {
      // ignore: discarded_futures
      when(() => get<List<dynamic>>(path)).thenAnswer(
        (final answer) async => Response(
          data: responseData,
          requestOptions: requestOptions,
          statusCode: statusCode,
        ),
      );
    } else {
      // ignore: discarded_futures
      when(() => get<dynamic>(path)).thenAnswer(
        (final answer) async => Response(
          data: responseData,
          requestOptions: requestOptions,
          statusCode: statusCode,
        ),
      );
    }
  }
}
