abstract final class Endpoints {
  Endpoints._();

  static const actions = '/actions';
  static String action({required final String type, required final String code}) => '/utilisateurs/{userId}/actions/$type/$code';
  static const aids = '/utilisateurs/{userId}/aides_v2';
  static String article(final String contentId) => '/utilisateurs/{userId}/bibliotheque/articles/$contentId';
  static const bibliotheque = '/utilisateurs/{userId}/bibliotheque';
  static const bilan = '/utilisateurs/{userId}/bilans/last_v3';
  static const challenges = '/utilisateurs/{userId}/defis_v2';
  static String challenge(final String defiId) => '/utilisateurs/{userId}/defis/$defiId';
  static const creationCompte = '/utilisateurs_v2';
  static const events = '/utilisateurs/{userId}/events';
  static const franceConnectStep2 = '/login_france_connect_step_2';
  static const gamification = '/utilisateurs/{userId}/gamification';
  static const logement = '/utilisateurs/{userId}/logement';
  static const login = '/utilisateurs/login_v2';
  static const loginCode = '/utilisateurs/login_v2_code';
  static const logout = '/utilisateurs/{userId}/logout';
  static const missionsRecommandees = '/utilisateurs/{userId}/tuiles_missions';
  static String missionsRecommandeesParThematique(final String codeThematique) =>
      '/utilisateurs/{userId}/thematiques/$codeThematique/tuiles_missions';
  static String mission(final String codeMission) => '/utilisateurs/{userId}/missions/$codeMission';
  static String missionTerminer(final String codeMission) => '/utilisateurs/{userId}/missions/$codeMission/terminer';
  static const modifierMotDePasse = '/utilisateurs/modifier_mot_de_passe';
  static const notificationToken = '/utilisateurs/{userId}/mobile_token';
  static const oubliMotDePasse = '/utilisateurs/oubli_mot_de_passe';
  static const profile = '/utilisateurs/{userId}/profile';
  static const questionsKyc = '/utilisateurs/{userId}/questionsKYC_v2';
  static String quiz(final String contentId) => '/utilisateurs/{userId}/bibliotheque/quizz/$contentId';
  static const renvoyerCode = '/utilisateurs/renvoyer_code';
  static const simulerAideVelo = '/utilisateurs/{userId}/simulerAideVelo';
  static const utilisateur = '/utilisateurs/{userId}';
  static const validerCode = '/utilisateurs/valider';
  static const seasonalFruitsAndVegetablesCategories = '/utilisateurs/{userId}/recherche_services/fruits_legumes/categories';
  static const seasonalFruitsAndVegetablesSearch = '/utilisateurs/{userId}/recherche_services/fruits_legumes/search2';
  static const lvaoSearch = '/utilisateurs/{userId}/recherche_services/longue_vie_objets/search2';
  static const recipesCategories = '/utilisateurs/{userId}/recherche_services/recettes/categories';
  static const recipesSearch = '/utilisateurs/{userId}/recherche_services/recettes/search2';

  static String communes(final String codePostal) => '/communes?code_postal=$codePostal';
  static String recommandationsParThematique(final String thematique) =>
      '/utilisateurs/{userId}/thematiques/$thematique/recommandations';
  static String questionKyc(final String questionId) => '/utilisateurs/{userId}/questionsKYC_v2/$questionId';
  static String questions(final String enchainementId) => '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/$enchainementId';
  static String servicesParThematique(final String codeThematique) =>
      '/utilisateurs/{userId}/thematiques/$codeThematique/recherche_services';
  static String recipe(final String recipeId) => '/utilisateurs/{userId}/recherche_services/recettes/last_results/$recipeId';
}
