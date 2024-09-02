import 'package:app/features/univers/domain/aggregates/mission.dart';
import 'package:app/features/univers/domain/entities/mission_article.dart';
import 'package:app/features/univers/domain/entities/mission_defi.dart';
import 'package:app/features/univers/domain/entities/mission_kyc.dart';
import 'package:app/features/univers/domain/entities/mission_quiz.dart';
import 'package:app/features/univers/domain/value_objects/content_id.dart';

abstract final class MissionMapper {
  const MissionMapper._();

  static Mission fromJson(final Map<String, dynamic> json) {
    final kycListe = <MissionKyc>[];
    final quizListe = <MissionQuiz>[];
    final articles = <MissionArticle>[];
    final defis = <MissionDefi>[];

    final objectifsList = json['objectifs'] as List<dynamic>;
    for (final item in objectifsList) {
      final o = item as Map<String, dynamic>;
      final type = o['type'] as String;
      switch (type) {
        case 'kyc':
          kycListe.add(_fromJsonMissionKyc(o));

        case 'quizz':
          quizListe.add(_fromJsonMissionQuiz(o));

        case 'article':
          articles.add(_fromJsonMissionArticle(o));

        case 'defi':
          defis.add(_fromJsonMissionDefi(o));
      }
    }

    return Mission(
      titre: json['titre'] as String,
      imageUrl: json['image_url'] as String,
      kycListe: kycListe,
      quizListe: quizListe,
      articles: articles,
      defis: defis,
      peutEtreTermine: json['terminable'] as bool,
      estTermine: json['done_at'] != null,
    );
  }

  static MissionKyc _fromJsonMissionKyc(final Map<String, dynamic> json) =>
      MissionKyc(
        id: ObjectifId(json['id'] as String),
        titre: json['titre'] as String,
        contentId: ContentId(json['content_id'] as String),
        estFait: json['done'] as bool,
        estVerrouille: json['is_locked'] as bool,
        points: json['points'] as int,
        aEteRecolte: json['sont_points_en_poche'] as bool,
      );

  static MissionQuiz _fromJsonMissionQuiz(final Map<String, dynamic> json) =>
      MissionQuiz(
        id: ObjectifId(json['id'] as String),
        titre: json['titre'] as String,
        contentId: ContentId(json['content_id'] as String),
        estFait: json['done'] as bool,
        estVerrouille: json['is_locked'] as bool,
        points: json['points'] as int,
        aEteRecolte: json['sont_points_en_poche'] as bool,
      );

  static MissionArticle _fromJsonMissionArticle(
    final Map<String, dynamic> json,
  ) =>
      MissionArticle(
        id: ObjectifId(json['id'] as String),
        titre: json['titre'] as String,
        contentId: ContentId(json['content_id'] as String),
        estFait: json['done'] as bool,
        estVerrouille: json['is_locked'] as bool,
        points: json['points'] as int,
        aEteRecolte: json['sont_points_en_poche'] as bool,
      );

  static MissionDefi _fromJsonMissionDefi(final Map<String, dynamic> json) =>
      MissionDefi(
        id: ObjectifId(json['id'] as String),
        titre: json['titre'] as String,
        contentId: ContentId(json['content_id'] as String),
        estFait: json['done'] as bool,
        estVerrouille: json['is_locked'] as bool,
        points: json['points'] as int,
        aEteRecolte: json['sont_points_en_poche'] as bool,
      );
}
