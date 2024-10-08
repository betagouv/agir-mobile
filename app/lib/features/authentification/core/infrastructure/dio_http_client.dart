// ignore_for_file: avoid-collection-mutating-methods, prefer-early-return

import 'dart:async';
import 'dart:io';

import 'package:app/features/authentication/domain/authentication_service.dart';
import 'package:app/features/authentication/domain/authentication_status.dart';
import 'package:dio/dio.dart';

class DioHttpClient {
  DioHttpClient({
    required final Dio dio,
    required final AuthenticationService authentificationService,
  })  : _dio = dio,
        _authentificationService = authentificationService {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (final options, final handler) async {
          await _authentificationService.checkAuthenticationStatus();
          final token = await _authentificationService.token;
          options.headers[HttpHeaders.authorizationHeader] =
              'Bearer ${token.value}';
          final status = _authentificationService.status;
          if (status is Authenticated) {
            final updatedUri = options.uri
                .toString()
                .replaceFirst('%7BuserId%7D', status.userId.value);
            options.path = updatedUri;
          }
          handler.next(options);
        },
        onResponse: (final response, final handler) async {
          if (response.statusCode == HttpStatus.unauthorized) {
            await _authentificationService.logout();
          }
          handler.next(response);
        },
      ),
    );
  }

  final Dio _dio;
  final AuthenticationService _authentificationService;

  Future<Response<dynamic>> get(final String path) async => _dio.get(path);
  Future<Response<dynamic>> patch(
    final String path, {
    final Object? data,
  }) async =>
      _dio.patch(path, data: data);
  Future<Response<dynamic>> post(
    final String path, {
    final Object? data,
  }) async =>
      _dio.post(path, data: data);
  Future<Response<dynamic>> put(
    final String path, {
    final Object? data,
  }) async =>
      _dio.put(path, data: data);
}
