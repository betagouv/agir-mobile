abstract final class Endpoints {
  Endpoints._();

  static const actions = '/utilisateurs/{userId}/defis_v2';
  static const assistances = '/utilisateurs/{userId}/aides_v2';
  static const bibliotheque = '/utilisateurs/{userId}/bibliotheque';
  static const communes = '/communes';
  static const events = '/utilisateurs/{userId}/events';
  static const gamification = '/utilisateurs/{userId}/gamification';
  static const logement = '/utilisateurs/{userId}/logement';
  static const login = '/utilisateurs/login_v2';
  static const loginCode = '/utilisateurs/login_v2_code';
  static const missionsRecommandees = '/utilisateurs/{userId}/tuiles_missions';
  static const modifierMotDePasse = '/utilisateurs/modifier_mot_de_passe';
  static const oubliMotDePasse = '/utilisateurs/oubli_mot_de_passe';
  static const profile = '/utilisateurs/{userId}/profile';
  static const questionsKyc = '/utilisateurs/{userId}/questionsKYC_v2';
  static const renvoyerCode = '/utilisateurs/renvoyer_code';
  static const simulerAideVelo = '/utilisateurs/{userId}/simulerAideVelo';
  static const utilisateur = '/utilisateurs/{userId}';
  static const validerCode = '/utilisateurs/valider';
  static String action(final String defiId) =>
      '/utilisateurs/{userId}/defis/$defiId';
  static String article(final String contentId) =>
      '/utilisateurs/{userId}/bibliotheque/articles/$contentId';
  static String mission(final String codeMission) =>
      '/utilisateurs/{userId}/missions/$codeMission';
  static String missionTerminer(final String codeMission) =>
      '/utilisateurs/{userId}/missions/$codeMission/terminer';
  static String recommandationsParThematique(final String thematique) =>
      '/utilisateurs/{userId}/thematiques/$thematique/recommandations';
  static String missionsRecommandeesParThematique(
    final String codeThematique,
  ) =>
      '/utilisateurs/{userId}/thematiques/$codeThematique/tuiles_missions';
  static String questionKyc(final String questionId) =>
      '/utilisateurs/{userId}/questionsKYC_v2/$questionId';
  static String questions(final String enchainementId) =>
      '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/$enchainementId';
  static String servicesParThematique(final String codeThematique) =>
      '/utilisateurs/{userId}/thematiques/$codeThematique/recherche_services';
}
