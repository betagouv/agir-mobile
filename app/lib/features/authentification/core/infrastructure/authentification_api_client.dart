// ignore_for_file: avoid-collection-mutating-methods

import 'dart:convert';
import 'dart:io';

import 'package:app/features/authentication/domain/authentication_service.dart';
import 'package:app/features/authentication/domain/authentication_status.dart';
import 'package:app/features/authentification/core/infrastructure/api_url.dart';
import 'package:http/http.dart' as http;

class AuthentificationApiClient extends http.BaseClient {
  AuthentificationApiClient({
    required this.apiUrl,
    required final AuthenticationService authenticationService,
    final http.Client? inner,
  })  : _inner = inner ?? http.Client(),
        _authenticationService = authenticationService;

  final ApiUrl apiUrl;
  final http.Client _inner;
  final AuthenticationService _authenticationService;

  String? get recupererUtilisateurId => switch (_authenticationService.status) {
        Authenticated(:final userId) => userId.value,
        _ => null,
      };

  @override
  Future<http.Response> get(
    final Uri url, {
    final Map<String, String>? headers,
  }) =>
      super.get(_uriParse(url), headers: headers);

  @override
  Future<http.Response> patch(
    final Uri url, {
    final Map<String, String>? headers,
    final Object? body,
    final Encoding? encoding,
  }) =>
      super.patch(
        _uriParse(url),
        headers: headers,
        body: body,
        encoding: encoding,
      );

  @override
  Future<http.Response> post(
    final Uri url, {
    final Map<String, String>? headers,
    final Object? body,
    final Encoding? encoding,
  }) =>
      super.post(
        _uriParse(url),
        headers: headers,
        body: body,
        encoding: encoding,
      );

  @override
  Future<http.Response> delete(
    final Uri url, {
    final Map<String, String>? headers,
    final Object? body,
    final Encoding? encoding,
  }) =>
      super.delete(
        _uriParse(url),
        headers: headers,
        body: body,
        encoding: encoding,
      );

  @override
  Future<http.Response> put(
    final Uri url, {
    final Map<String, String>? headers,
    final Object? body,
    final Encoding? encoding,
  }) =>
      super.put(
        _uriParse(url),
        headers: headers,
        body: body,
        encoding: encoding,
      );

  Uri _uriParse(final Uri url) => Uri(
        scheme: apiUrl.valeur.scheme,
        host: apiUrl.valeur.host,
        path: apiUrl.valeur.path + url.path,
        query: url.hasQuery ? url.query : null,
      );

  @override
  Future<http.StreamedResponse> send(final http.BaseRequest request) async {
    try {
      final token = await _authenticationService.token;
      request.headers[HttpHeaders.authorizationHeader] =
          'Bearer ${token.value}';
    } on Exception catch (_) {}

    request.headers[HttpHeaders.contentTypeHeader] =
        'application/json; charset=UTF-8';

    return _inner.send(request);
  }

  @override
  Future<void> close() async {
    await _authenticationService.dispose();
    _inner.close();
  }
}
