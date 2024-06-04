import 'dart:convert';
import 'dart:io';

import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/api_url.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_token_storage.dart';
import 'package:http/http.dart' as http;

class AuthentificationApiClient extends http.BaseClient {
  AuthentificationApiClient({
    required this.apiUrl,
    required final AuthentificationTokenStorage authentificationTokenStorage,
    final http.Client? inner,
  })  : _inner = inner ?? http.Client(),
        _authentificationTokenStorage = authentificationTokenStorage;

  final http.Client _inner;
  final ApiUrl apiUrl;
  final AuthentificationTokenStorage _authentificationTokenStorage;

  Future<void> sauvegarderTokenEtUtilisateurId(
    final String token,
    final String utilisateurId,
  ) async =>
      _authentificationTokenStorage.sauvegarderTokenEtUtilisateurId(
        token,
        utilisateurId,
      );

  Future<void> supprimerTokenEtUtilisateurId() async =>
      _authentificationTokenStorage.supprimerTokenEtUtilisateurId();

  Future<String?> recupererUtilisateurId() async =>
      _authentificationTokenStorage.recupererUtilisateurId();

  @override
  Future<http.Response> get(
    final Uri url, {
    final Map<String, String>? headers,
  }) =>
      super.get(
        _uriParse(url),
        headers: headers,
      );

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

  Uri _uriParse(final Uri url) => Uri.parse(
        '${apiUrl.valeur.scheme}://${apiUrl.valeur.host}${apiUrl.valeur.path}${url.path}${url.hasQuery ? '?${url.query}' : ''}',
      );

  @override
  Future<http.StreamedResponse> send(final http.BaseRequest request) async {
    final token = await _authentificationTokenStorage.recupererToken();
    if (token != null) {
      request.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }
    request.headers[HttpHeaders.contentTypeHeader] =
        'application/json; charset=UTF-8';
    return _inner.send(request);
  }

  @override
  void close() {
    _inner.close();
  }
}
