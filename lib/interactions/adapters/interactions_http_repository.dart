import 'dart:convert';
import 'package:agir/interactions/ports/interactions_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../fetchInteractions_usecase.dart';

class InteractionApiModel {
  final String id;
  final String contentId;
  final String type;
  final String titre;
  final String soustitre;
  final String categorie;
  final List<String> tags;
  final String duree;
  final String imageUrl;
  final String? url;
  final int seen;
  final DateTime? seenAt;
  final bool clicked;
  final DateTime? clickedAt;
  final bool done;
  final DateTime? doneAt;
  final bool succeeded;
  final DateTime? succeededAt;
  final bool locked;
  final int difficulty;
  final int points;
  final int recoScore;
  final String? scheduledReset;
  final String? dayPeriod;
  final String? pinnedAtPosition;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String utilisateurId;

  InteractionApiModel({
    required this.id,
    required this.contentId,
    required this.type,
    required this.titre,
    required this.soustitre,
    required this.categorie,
    required this.tags,
    required this.duree,
    required this.imageUrl,
    required this.url,
    required this.seen,
    required this.seenAt,
    required this.clicked,
    required this.clickedAt,
    required this.done,
    required this.doneAt,
    required this.succeeded,
    required this.succeededAt,
    required this.locked,
    required this.difficulty,
    required this.points,
    required this.recoScore,
    required this.scheduledReset,
    required this.dayPeriod,
    required this.pinnedAtPosition,
    required this.createdAt,
    required this.updatedAt,
    required this.utilisateurId,
  });

  factory InteractionApiModel.fromJson(Map<String, dynamic> json) {
    return InteractionApiModel(
      id: json['id'],
      contentId: json['content_id'] ?? "",
      type: json['type'],
      titre: json['titre'],
      soustitre: json['soustitre'],
      categorie: json['categorie'],
      tags: List<String>.from(json['tags']),
      duree: json['duree'],
      imageUrl: json['image_url'],
      url: json['url'],
      seen: json['seen'],
      seenAt: json['seen_at'] != null ? DateTime.parse(json['seen_at']) : null,
      clicked: json['clicked'],
      clickedAt: json['clicked_at'] != null
          ? DateTime.parse(json['clicked_at'])
          : null,
      done: json['done'],
      doneAt: json['done_at'] != null ? DateTime.parse(json['done_at']) : null,
      succeeded: json['succeeded'],
      succeededAt: json['succeeded_at'] != null
          ? DateTime.parse(json['succeeded_at'])
          : null,
      locked: json['locked'],
      difficulty: json['difficulty'],
      points: json['points'],
      recoScore: json['reco_score'],
      scheduledReset: json['scheduled_reset'],
      dayPeriod: json['day_period'],
      pinnedAtPosition: json['pinned_at_position'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      utilisateurId: json['utilisateurId'],
    );
  }
}

class InteractionsHttpRepository implements InteractionsRepository {
  @override
  Future<List<Interaction>> getInteractions(String userId) async {
    var httpResponse = await http.get(Uri.parse(
        '${dotenv.get('API_BASE_URL')}/utilisateurs/$userId/interactions'));
    List<dynamic> jsonList = jsonDecode(httpResponse.body);
    List<InteractionApiModel> interactionsApiModel =
        jsonList.map((json) => InteractionApiModel.fromJson(json)).toList();
    return interactionsApiModel.map((apiModel) {
      return Interaction(
        id: apiModel.id,
        type: parseInteractionType(apiModel.type),
        titre: apiModel.titre,
        sousTitre: apiModel.soustitre,
        categorie: parseInteractionCategorie(apiModel.categorie),
        nombreDePointsAGagner: apiModel.points.toString(),
        miseEnAvant: apiModel.recoScore.toString(),
        illustrationURL: apiModel.imageUrl,
        url: apiModel.url,
        aEteFaite: apiModel.done,
        idDuContenu: apiModel.contentId,
        duree: apiModel.duree,
        estBloquee: apiModel.locked,
      );
    }).toList();
  }

  InteractionType parseInteractionType(String type) {
    switch (type) {
      case "quizz":
        return InteractionType.QUIZ;
      case "article":
        return InteractionType.ARTICLE;
      case "KYC":
        return InteractionType.KYC;
      case "suivi_du_jour":
        return InteractionType.SUIVIDUJOUR;
      default:
        throw ArgumentError("Invalid InteractionType: $type");
    }
  }

  InteractionCategorie parseInteractionCategorie(String categorie) {
    switch (categorie) {
      case "Energie":
        return InteractionCategorie.ENERGIE;
      case "Consommation":
        return InteractionCategorie.CONSOMMATION;
      case "Alimentation":
        return InteractionCategorie.ALIMENTATION;
      case "Global":
        return InteractionCategorie.GLOBAL;
      case "Transports":
        return InteractionCategorie.TRANSPORTS;
      default:
        throw ArgumentError("Invalid InteractionCategorie: $categorie");
    }
  }
}
