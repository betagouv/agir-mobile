// ignore_for_file: avoid-collection-mutating-methods

import 'dart:async';
import 'dart:io';

import 'package:app/core/authentication/domain/authentication_service.dart';
import 'package:app/core/authentication/domain/authentication_status.dart';
import 'package:dio/dio.dart';

class DioHttpClient {
  DioHttpClient({required final Dio dio, required final AuthenticationService authenticationService}) : _dio = dio {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (final options, final handler) async {
          await authenticationService.checkAuthenticationStatus();
          try {
            final token = authenticationService.token;
            options.headers[HttpHeaders.authorizationHeader] = 'Bearer ${token.value}';
          } on Exception catch (_) {}
          final status = authenticationService.status;
          if (status is Authenticated) {
            final updatedUri = options.uri.toString().replaceFirst('%7BuserId%7D', status.userId.value);
            options.path = updatedUri;
          }
          handler.next(options);
        },
        onResponse: (final response, final handler) async {
          if (response.statusCode == HttpStatus.unauthorized) {
            await authenticationService.logout();
          }
          handler.next(response);
        },
      ),
    );
  }

  final Dio _dio;

  String get baseUrl => _dio.options.baseUrl;

  void add(final Interceptor interceptor) => _dio.interceptors.add(interceptor);

  Future<Response<dynamic>> get(final String path) async => _dio.get(path);
  Future<Response<dynamic>> patch(final String path, {final Object? data}) async => _dio.patch(path, data: data);
  Future<Response<dynamic>> post(final String path, {final Object? data}) async => _dio.post(path, data: data);
  Future<Response<dynamic>> put(final String path, {final Object? data}) async => _dio.put(path, data: data);
  Future<Response<dynamic>> delete(final String path, {final Object? data}) => _dio.delete(path, data: data);
}
