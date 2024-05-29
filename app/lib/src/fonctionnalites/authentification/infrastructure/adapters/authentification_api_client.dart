import 'dart:convert';
import 'dart:io';

import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/api_url.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_token_storage.dart';
import 'package:http/http.dart';

class AuthentificationApiClient extends BaseClient {
  AuthentificationApiClient({
    required this.apiUrl,
    required final AuthentificationTokenStorage authentificationTokenStorage,
    final Client? inner,
  })  : _inner = inner ?? Client(),
        _authentificationTokenStorage = authentificationTokenStorage;

  final Client _inner;
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
  Future<Response> get(
    final Uri url, {
    final Map<String, String>? headers,
  }) async =>
      super.get(
        _uriParse(url),
        headers: headers,
      );

  Uri _uriParse(final Uri url) => Uri.parse(
        '${apiUrl.valeur.scheme}://${apiUrl.valeur.host}${apiUrl.valeur.path}${url.path}',
      );

  @override
  Future<Response> post(
    final Uri url, {
    final Map<String, String>? headers,
    final Object? body,
    final Encoding? encoding,
  }) async =>
      super.post(
        _uriParse(url),
        headers: headers,
        body: body,
        encoding: encoding,
      );

  @override
  Future<StreamedResponse> send(final BaseRequest request) async {
    final token = await _authentificationTokenStorage.recupererToken();
    if (token != null) {
      request.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }
    return _inner.send(request);
  }
}
