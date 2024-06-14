abstract final class Localisation {
  static const commencer = 'Commencer';
  static const preOnboardingTitre =
      'Ensemble,\naméliorons\nnos habitudes\nau jour le jour';
  static const preOnboarding1 =
      'L’accompagnement personnalisé qui vous offre des solutions réalisables, **pour vous**';
  static const preOnboarding2 =
      'Rejoignez plus de **160 000** utilisateurs engagés';
  static const preOnboarding3 =
      'Faites des **économies** en instaurant des habitudes durables';
  static const preOnboardingFinTitre =
      'Faites un premier pas en estimant rapidement les principaux impacts de vos usages';
  static const preOnboardingFinSousTitre =
      'Les questions suivantes nous aideront à calculer une approximation de votre empreinte carbone et vous proposer des conseils personnalisés';
  static const suivant = 'Suivant';
  static const jaiDejaUnCompte = "J'ai déjà un compte";
  static const seConnecter = 'Se connecter';
  static const adresseElectronique = 'Adresse électronique';
  static const motDePasse = 'Mot de passe';
  static const bonjour = 'Bonjour,\n';
  static String prenomExclamation(final String value) => '$value !';
  static const menuAccueil = 'Accueil';
  static const menuAides = 'Aides';
  static const accueilMesAides = 'Mes aides';
  static const accueilMesAidesLien = 'Voir toutes les aides';
  static const vosAidesTitre = 'Vos aides disponibles';
  static const vosAidesSousTitre =
      'Accédez à toutes les aides publiques locales ou nationales pour la transition écologique en fonction de votre situation.';
  static const jusqua = "Jusqu'à ";
  static const fermer = 'Fermer';
  static const retour = 'Retour';
  static const menu = 'Menu';
  static const simulateur = 'Simulateur';
  static const accederAuSimulateur = 'Accéder au simulateur';
  static const simulerMonAide = 'Simuler mon aide';
  static const acheterUnVelo = 'Acheter un vélo';
  static const prixDuVelo = 'Prix du vélo';
  static const prixDuVeloObligatoire = 'Le prix du vélo ne peux pas être vide';
  static const prixDuVeloExplications =
      'À titre indicatif, voici quelques prix moyens';
  static String veloLabel(final String text) => '$text : ';
  static const elementsNecessaireAuCalcul = 'Éléments nécessaires au calcul';
  static const donneesUtiliseesPart1 = 'Données utilisées : code postal ';
  static String donneesUtiliseesCodePostalEtVille({
    required final String codePostal,
    required final String ville,
  }) =>
      '($codePostal - $ville)';
  static const donneesUtiliseesPart2 = ', revenu fiscal de référence ';
  static String donneesUtiliseesRevenuFiscal(final String value) =>
      '(${value.toLowerCase()})';
  static const donneesUtiliseesPart3 = ', nombre de parts ';
  static String donneesUtiliseesNombreDeParts(final double value) => '($value)';
  static const point = '.';
  static const modifier = 'Modifier';
  static const aideVeloAvertissement =
      'Veuillez compléter ces informations afin de débuter l’estimation';
  static const codePostal = 'Code postal';
  static const ville = 'Ville';
  static const revenuQuestion = 'Quelle est votre tranche de revenus ?';
  static const nombreDePartsFiscales =
      'Nombre de parts fiscales de votre foyer';
  static const nombreDePartsFiscalesDescription =
      '(Pré-calculé à partir des membres de votre foyer)';
  static const revenuFiscal = 'Revenu fiscal de référence de votre foyer';
  static const tranche0 = 'Moins de 16 000 €';
  static const tranche1 = 'De 16 000 € à 35 000 €';
  static const tranche2 = 'Plus de 35 000 €';
  static const ouTrouverCesInformations = 'Où trouver ces informations ?';
  static const ouTrouverCesInformationsReponse = '''
Le **revenu fiscal de référence** et votre **nombre de parts** se trouvent sur la 1ère page de votre dernier avis d’impôt.

**Nombre de part**

Si vous ne disposez pas de votre dernier avis d’impôt, renseignez 1 part pour chaque adulte de votre foyer fiscal, puis 0,5 part par enfant jusqu’à 2 enfants, puis 1 part par enfant à partir du 3ème enfant.

Si vous ne disposez pas de votre dernier avis d’impôt, renseignez la somme des revenus de toutes les personnes avec lequelles vous partagez vos déclarations d’impôts (pour toute l’année) pour vous faire une première idée.''';
  static const pourquoiCesQuestions = 'Pourquoi ces questions ?';
  static const pourquoiCesQuestionsReponse =
      'Votre **revenu fiscal de référence** et le **nombre de parts** permettent d’afficher les aides en fonction de vos ressources.';
  static const estimerMesAides = 'Estimer mes aides';
  static const vosAidesDisponibles = 'Vos aides disponibles';
  static const revenirAuSimulateur = 'Revenir au simulateur';
  static const aucuneAideDisponible = 'Aucune aide\ndisponible';
  static const voirLesDemarches = 'Voir les démarches';
  static const propulsePar = 'Propulsé par ';
  static String euro(final int value) => '$value €';
  static const monProfil = 'Mon profil';
  static const identitePersonnelle = 'Identité personnelle';
}
