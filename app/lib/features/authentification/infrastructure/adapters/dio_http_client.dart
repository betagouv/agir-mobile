// ignore_for_file: avoid-collection-mutating-methods

import 'package:app/features/authentification/infrastructure/adapters/authentification_token_storage.dart';
import 'package:dio/dio.dart';

abstract class HttpClient {
  Future<Response<T>> patch<T>(final String path, {final Object? data});

  Future<Response<T>> post<T>(final String path, {final Object? data});

  Future<Response<T>> get<T>(final String path);
}

class DioHttpClient implements HttpClient {
  DioHttpClient({
    required final Dio dio,
    required final AuthentificationTokenStorage authentificationTokenStorage,
  })  : _dio = dio,
        _authentificationTokenStorage = authentificationTokenStorage {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (final options, final handler) async {
          final token = await _authentificationTokenStorage.recupererToken;
          if (token == null) return;
          options.headers['Authorization'] = 'Bearer $token';
          handler.next(options);
        },
      ),
    );
  }

  final Dio _dio;
  final AuthentificationTokenStorage _authentificationTokenStorage;

  Future<String?> get recupererUtilisateurId async =>
      _authentificationTokenStorage.recupererUtilisateurId;

  @override
  Future<Response<T>> get<T>(final String path) => _dio.get(path);

  @override
  Future<Response<T>> patch<T>(final String path, {final Object? data}) =>
      _dio.patch(path, data: data);

  @override
  Future<Response<T>> post<T>(final String path, {final Object? data}) =>
      _dio.post(path, data: data);
}
