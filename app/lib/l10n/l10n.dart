abstract final class Localisation {
  const Localisation._();

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
  static const votreMotDePasseDoitContenir =
      'Votre mot de passe doit contenir :';
  static const motDePasse12CaractresMinimum = '12 caractères minimum';
  static const motDePasse1MajusculeEt1Minuscule =
      'Au moins 1 majuscule et 1 minuscule';
  static const motDePasse1CaractreSpecialMinimum =
      '1 caractère spécial minimum';
  static const motDePasse1ChiffreMinimum = '1 chiffre minimum';
  static const bonjour = 'Bonjour,\n';
  static String prenomExclamation(final String value) => '$value !';
  static const menuAccueil = 'Accueil';
  static const menuAides = 'Aides';
  static const accueilMesAides = 'Mes aides';
  static const accueilMesAidesLien = 'Voir toutes les aides';
  static const accueilRecommandationsTitre = 'Recommandé, pour vous';
  static const accueilRecommandationsSousTitre =
      'Une sélection d’articles et de services, pour vous, selon vos préférences !';
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
  static String donneesUtiliseesCodePostalEtCommune({
    required final String codePostal,
    required final String commune,
  }) =>
      '($codePostal - $commune)';
  static const donneesUtiliseesPart2 = ', revenu fiscal de référence ';
  static String donneesUtiliseesRevenuFiscal(final int? value) =>
      '(${value == null ? '' : euro(value)})';
  static const donneesUtiliseesPart3 = ', nombre de parts ';
  static String donneesUtiliseesNombreDeParts(final double value) => '($value)';
  static const point = '.';
  static const modifier = 'Modifier';
  static const aideVeloAvertissement =
      'Veuillez compléter ces informations afin de débuter l’estimation';
  static const codePostal = 'Code postal';
  static const commune = 'Commune';
  static const revenuQuestion = 'Quelle est votre tranche de revenus ?';
  static const nombreDePartsFiscales =
      'Nombre de parts fiscales de votre foyer';
  static const nombreDePartsFiscalesDescription =
      '(Pré-calculé à partir des membres de votre foyer)';
  static const revenuFiscal = 'Revenu fiscal de référence de votre foyer';
  static const ouTrouverCesInformations = 'Où trouver ces informations ?';
  static const ouTrouverCesInformationsReponse = '''
Le **revenu fiscal de référence** et votre **nombre de parts** se trouvent sur la 1ère page de votre dernier avis d’impôt.

**Nombre de part**

Si vous ne disposez pas de votre dernier avis d’impôt, renseignez 1 part pour chaque adulte de votre foyer fiscal, puis 0,5 part par enfant jusqu’à 2 enfants, puis 1 part par enfant à partir du 3ème enfant.

Si vous ne disposez pas de votre dernier avis d’impôt, renseignez la somme des revenus de toutes les personnes avec lequelles vous partagez vos déclarations d’impôts (pour toute l’année) pour vous faire une première idée.''';
  static const pourquoi = 'Pourquoi ?';
  static const pourquoiCesQuestions = 'Pourquoi ces questions ?';
  static const pourquoiCesQuestionsReponse =
      'Votre **revenu fiscal de référence** et le **nombre de parts** permettent d’afficher les aides en fonction de vos ressources.';
  static const estimerMesAides = 'Estimer mes aides';
  static const vosAidesDisponibles = 'Vos aides disponibles';
  static const revenirAuSimulateur = 'Revenir au simulateur';
  static const revenirAccueil = "Revenir à l'accueil";
  static const aucuneAideDisponible = 'Aucune aide\ndisponible';
  static const voirLesDemarches = 'Voir les démarches';
  static const propulsePar = 'Propulsé par ';
  static String euro(final int value) => '$value €';
  static const seDeconnecter = 'Se déconnecter';
  static const votreProfil = 'Votre profil';
  static const vosInformations = 'Vos informations';
  static const mieuxVousConnaitre = 'Mieux vous connaître';
  static const votreIdentite = 'Votre identité';
  static const prenom = 'Prénom';
  static const nom = 'Nom';
  static const adresseCourrierElectronique = 'Adresse courrier électronique';
  static const adresseCourrierElectroniqueDescription =
      'Format attendu : nom@domaine.fr';
  static const donneesPersonnelles = 'Données personnelles';
  static const mettreAJour = 'Mettre à jour';
  static const mettreAJourVosInformations = 'Mettre à jour vos informations';
  static const miseAJourEffectuee = 'Mise à jour effectuée';
  static const votreLogement = 'Votre logement';
  static const ouHabitezVous = 'Où habitez-vous ?';
  static const combienEtesVousDansVotreLogement =
      'Combien êtes-vous dans votre logement (vous inclus) ?';
  static const adultes = 'Adulte(s)';
  static const enfants = 'Enfant(s) de moins de 18 ans';
  static const votreResidencePrincipaleEst =
      'Votre résidence principale est ...';
  static const unAppartement = 'Un appartement';
  static const uneMaison = 'Une maison';
  static const vousEtesProprietaireDeVotreLogement =
      'Vous êtes propriétaire de votre logement ?';
  static const oui = 'Oui';
  static const non = 'Non';
  static const quelleEstLaSuperficie = 'Quelle est la superficie ?';
  static const moinsDe35m2 = 'Moins de 35 m²';
  static const entre35et70m2 = 'Entre 35 et 70 m²';
  static const entre70et100m2 = 'Entre 70 et 100 m²';
  static const entre100et150m2 = 'Entre 100 et 150 m²';
  static const plusDe150m2 = 'Plus de 150 m²';
  static const quelleEstVotreModeDeChauffagePrincipal =
      'Quelle est votre mode de chauffage principal ?';
  static const electricite = 'Électricité';
  static const boisPellets = 'Bois / Pellets';
  static const fioul = 'Fioul';
  static const gaz = 'Gaz';
  static const autreJeNeSaisPas = 'Autre / Je ne sais pas';
  static const votreLogementPlusDe15Ans =
      'Votre logement a-t-il plus de 15 ans ?';
  static const consommationsEnergetiques = 'Consommations énergétiques';
  static const dpeA = 'A';
  static const dpeB = 'B';
  static const dpeC = 'C';
  static const dpeD = 'D';
  static const dpeE = 'E';
  static const dpeF = 'F';
  static const dpeG = 'G';
  static const dpeJeNeSaisPas = 'Je ne sais pas';
  static const dpeExplication = "**Qu'est-ce qu'un DPE ?**";
  static const optionsAvancees = 'Options avancées';
  static const changerVotreMotDePasse = 'Changer votre mot de passe';
  static const changerVotreMotDePasseConfirmation =
      'Votre mot de passe a été changé.';
  static const supprimerVotreCompte = 'Supprimer votre compte';
  static const supprimerVotreCompteContenu =
      'Vous pouvez à tout moment choisir de supprimer votre compte ainsi que l’ensemble des données qui y sont associées. ';
  static const attentionAucuneDonneeNePourraEtreRecuperee =
      'Attention, aucune donnée ne pourra être récupérée.';
  static const supprimerVotreCompteConfirmation =
      'Veuillez confirmer la suppression du compte';
  static const confirmer = 'Confirmer';
  static const annuler = 'Annuler';
  static const lesCategories = 'Les catégories';
  static const lesCategoriesTout = 'Tout';
  static const lesCategoriesAlimentation = 'En cuisine';
  static const lesCategoriesTransport = 'Les transports';
  static const lesCategoriesLogement = 'À la maison';
  static const lesCategoriesConsommation = 'En courses';
  static const lesCategoriesClimat = 'La planète';
  static const lesCategoriesDechet = 'Déchets';
  static const lesCategoriesLoisir = 'Les vacances';
  static const maReponse = 'Ma réponse';
  static const valider = 'Valider';
}
