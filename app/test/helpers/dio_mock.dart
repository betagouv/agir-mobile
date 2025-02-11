// ignore_for_file: prefer-overriding-parent-equality

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {
  DioMock() {
    when(() => interceptors).thenReturn(Interceptors());
  }

  @override
  final options = BaseOptions(baseUrl: 'https://api.example.com');

  void getM<T>(final String path, {final int statusCode = HttpStatus.ok, required final T responseData}) {
    when(() => get<dynamic>(path)).thenAnswer(
      (final answer) async => Response(data: responseData, requestOptions: RequestOptions(path: path), statusCode: statusCode),
    );
  }

  void postM(final String path, {final int statusCode = HttpStatus.ok, final dynamic requestData, final dynamic responseData}) {
    when(() => post<dynamic>(path, data: requestData ?? any(named: 'data'))).thenAnswer(
      (final answer) async => Response(data: responseData, requestOptions: RequestOptions(path: path), statusCode: statusCode),
    );
  }

  void patchM(final String path, {final int statusCode = HttpStatus.ok, final dynamic requestData, final dynamic responseData}) {
    when(() => patch<dynamic>(path, data: requestData ?? any(named: 'data'))).thenAnswer(
      (final _) async => Response(data: responseData, requestOptions: RequestOptions(path: path), statusCode: statusCode),
    );
  }

  void putM(final String path, {final int statusCode = HttpStatus.ok, final dynamic requestData}) {
    when(
      () => put<dynamic>(path, data: requestData ?? any(named: 'data')),
    ).thenAnswer((final _) async => Response(requestOptions: RequestOptions(path: path), statusCode: statusCode));
  }

  void deleteM(final String path, {final int statusCode = HttpStatus.ok, final dynamic requestData}) {
    when(
      () => delete<dynamic>(path, data: requestData ?? any(named: 'data')),
    ).thenAnswer((final _) async => Response(requestOptions: RequestOptions(path: path), statusCode: statusCode));
  }
}
