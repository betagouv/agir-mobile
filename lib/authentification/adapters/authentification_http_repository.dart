import 'dart:convert';
import 'package:agir/authentification/ports/authentification_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../authenticateUser_usecase.dart';

class Badge {
  final String id;
  final String type;
  final String titre;
  final String utilisateurId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Badge({
    required this.id,
    required this.type,
    required this.titre,
    required this.utilisateurId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Badge.fromJson(Map<String, dynamic> json) {
    return Badge(
      id: json['id'],
      type: json['type'],
      titre: json['titre'],
      utilisateurId: json['utilisateurId'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class UtilisateurApiModel {
  final String id;
  final String name;
  final int points;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Badge> badges;

  UtilisateurApiModel({
    required this.id,
    required this.name,
    required this.points,
    required this.createdAt,
    required this.updatedAt,
    required this.badges,
  });

  factory UtilisateurApiModel.fromJson(Map<String, dynamic> json) {
    var badgeList = json['badges'] as List;
    List<Badge> badges = badgeList.map((badgeJson) => Badge.fromJson(badgeJson)).toList();

    return UtilisateurApiModel(
      id: json['id'],
      name: json['name'],
      points: json['points'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      badges: badges,
    );
  }
}

class AuthentificationHttpRepository implements AuthentificationRepository {
  @override
  Future<Utilisateur> doAuthentification(String userName) async {
    var httpResponse = await http.get(Uri.parse(
        '${dotenv.get('API_BASE_URL')}/utilisateurs?name=$userName'));
    List<dynamic> jsonList = jsonDecode(httpResponse.body);
    List<UtilisateurApiModel> utilisateurs = jsonList.map((json) => UtilisateurApiModel.fromJson(json)).toList();
    final utilisateur = utilisateurs[0];
    return Utilisateur(utilisateur.name, utilisateur.id);
  }
}

