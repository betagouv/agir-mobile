abstract final class Endpoints {
  Endpoints._();

  /// https://agir-back-dev.osc-fr1.scalingo.io/api#/Defis/DefisController_getAllUserDefi_2
  static const actions = '/utilisateurs/{userId}/defis_v2';

  /// https://agir-back-dev.osc-fr1.scalingo.io/api#/Defis/DefisController_getById
  static String action(final String defiId) =>
      '/utilisateurs/{userId}/defis/$defiId';
}
