// ignore_for_file: avoid-duplicate-constant-values

import 'package:flutter/widgets.dart';

abstract final class Localisation {
  const Localisation._();

  static const aDecouvrir = 'À découvrir';
  static const accederAuSimulateur = 'Accéder au simulateur';
  static const accueilRecommandationsSousTitre =
      'Une sélection d’articles et de services, pour vous, selon vos préférences !';
  static const recommandationsTitre = 'Recommandé, pour vous';
  static const acheterUnVelo = 'Acheter un vélo';
  static const adresseEmail = 'Mon adresse email';
  static const adultes = 'Adulte(s)';
  static const aideVeloAvertissement =
      'Veuillez compléter ces informations afin de débuter l’estimation';
  static const ajouterEnFavoris = 'Ajouter en favoris';
  static const allerALAction = "Aller à l'action";
  static const anneeDeNaissance = 'Année de naissance';
  static const annuler = 'Annuler';
  static const appEstEnConstruction = 'J’agis est en construction !';
  static const appEstEnConstructionDescription =
      'Cette version est encore très incomplète et de nombreuses évolutions et nouvelles fonctionnalités sont mises en ligne chaque semaine.';
  static const appEstEncoreEnExperimentation =
      'J’agis est encore en expérimentation !';
  static const appEstEncoreEnExperimentationDetails =
      'Nous ajoutons progressivement les aides et contenus locaux à ';
  static const appEstEncoreEnExperimentationDetails2 =
      '\nRevenez régulièrement pour profiter de nos dernières nouveautés';
  static const article = 'Article';
  static const attentionAucuneDonneeNePourraEtreRecuperee =
      'Attention, aucune donnée ne pourra être récupérée.';
  static const aucuneAideDisponible = 'Aucune aide\ndisponible';
  static const bibliotheque = 'Ma bibliothèque';
  static const bibliothequeSousTitre =
      'Retrouver ici vos articles déjà consultés ainsi que vos favoris';
  static const bibliothequeAucunArticle = 'Aucun article trouvé';
  static const bienvenueSur = 'Bienvenue sur J’agis ! Faisons connaissance...';
  static const bienvenueSurDetails =
      'Nous avons quelques questions à vous poser pour personnaliser votre expérience !';
  static const bilanEnvironnemental = 'Mon bilan environnemental';
  static const bonjour = 'Bonjour,\n';
  static const bonnesAstucesPourRealiserCeDefi =
      'Bonnes astuces pour réaliser ce défi';
  static const cestParti = 'C’est parti !';
  static const cestPresqueTermine = 'C’est presque terminé !';
  static const cetteActionNeVousConvientPas =
      'Cette action ne vous convient pas ?';
  static const cetteActionNeVousConvientPasDetails =
      'On ne vise pas toujours juste ! Dites-nous pourquoi en quelques mots et nous affinerons nos recommandations à l’avenir. (facultatif)';
  static const changerMonMotDePasse = 'Changer mon mot de passe';
  static const changerVotreMotDePasseConfirmation =
      'Votre mot de passe a été changé.';
  static const codePostal = 'Code postal';
  static const combienEtesVousDansVotreLogement =
      'Combien êtes-vous dans votre logement (vous inclus) ?';
  static const commune = 'Commune';
  static const confirmer = 'Confirmer';
  static const consommationsEnergetiques = 'Consommations énergétiques';
  static const continuer = 'Continuer';
  static const continuerLaLecture = 'Continuer la lecture';
  static const creerMonCompte = 'Créer mon compte';
  static const creerMonCompteApp = 'Créer mon compte J’agis';
  static const declarationAccessibilite = "Déclaration d'accessibilité";
  static const declarationAccessibiliteSite =
      'https://jagis.beta.gouv.fr/accessibilite';
  static const statistiques = 'Statistiques';
  static const statistiquesSite = 'https://jagis.beta.gouv.fr/statistiques';
  static const defiRealise = 'Défi réalisé';
  static const donneesPersonnelles = 'Données personnelles';
  static const donneesUtiliseesPart1 = 'Données utilisées : code postal ';
  static const donneesUtiliseesPart2 = ', revenu fiscal de référence ';
  static const donneesUtiliseesPart3 = ', nombre de parts ';
  static const dpeA = 'A';
  static const dpeB = 'B';
  static const dpeC = 'C';
  static const dpeD = 'D';
  static const dpeE = 'E';
  static const dpeExplication = "**Qu'est-ce qu'un DPE ?**";
  static const dpeF = 'F';
  static const dpeG = 'G';
  static const dpeJeNeSaisPas = 'Je ne sais pas';
  static const elementsNecessaireAuCalcul = 'Éléments nécessaires au calcul';
  static const emailDeConnexionRenvoye = 'Email de connexion renvoyé';
  static const enCours = 'En cours !';
  static const enchante = 'Enchanté, ';
  static const enchanteDetails =
      'Pour découvrir des aides, services et contenus disponibles proches de chez vous, indiquez-nous votre lieu de résidence.';
  static const enfants = 'Enfant(s) de moins de 18 ans';
  static const entre100et150m2 = 'Entre 100 et 150 m²';
  static const entre35et70m2 = 'Entre 35 et 70 m²';
  static const entre70et100m2 = 'Entre 70 et 100 m²';
  static const entrezLeCodeRecuParMail = 'Entrez le code reçu par e-mail !';
  static const erreurInattendue = 'Erreur inattendue';
  static const erreurInattendueContent =
      'Désolé, le service rencontre un problème, nous y travaillons pour le résoudre le plus rapidement possible.';
  static const estimerMesAides = 'Estimer mes aides';
  static const facultatif = 'facultatif';
  static const fermer = 'Fermer';
  static const finalementPasPourMoi = 'Finalement, pas pour moi';
  static const firstNameEmpty = 'Le prénom ne peut pas être vide.';
  static const firstNameInvalid = "Le prénom n'est pas valide.";
  static const jaccepte = "J'accepte ";
  static const jaiCompris = "J'ai compris";
  static const jaiDejaUnCompte = "J'ai déjà un compte";
  static const jeCreeMonCompte = 'Je crée mon compte';
  static const jeReleveLeDefi = 'Je relève le défi';
  static const jusqua = "Jusqu'à ";
  static const leServiveNeCouvrePasEncoreVotreVille =
      'Le service ne couvre pas encore votre ville.';
  static const leServiveNeCouvrePasEncoreVotreVilleDescription =
      'Nous mettons les informations à jour progressivement.';
  static const lesCategories = 'Les catégories';
  static const lesCategoriesAlimentation = 'Alimentation';
  static const lesCategoriesClimat = 'Environnement';
  static const lesCategoriesConsommation = 'Consommation durable';
  static const lesCategoriesDechet = 'Déchets';
  static const lesCategoriesLogement = 'Logement';
  static const lesCategoriesLoisir = 'Loisirs';
  static const tout = 'Tout';
  static const lesCategoriesTransport = 'Transports';
  static const lesCgu = "les conditions générales d'utilisation";
  static const lesCguMenu = 'CGU';
  static const lesCguSite = 'https://jagis.beta.gouv.fr/cgu';
  static const maReponse = 'Ma réponse';
  static const meConnecter = 'Me connecter';
  static const mentionsLegales = 'Mentions légales';
  static const mentionsLegalesSite =
      'https://jagis.beta.gouv.fr/mentions-legales';
  static const menu = 'Menu';
  static const accueil = 'Accueil';
  static const mesInformationsAdresseEmail = 'Adresse e-mail : ';
  static const mesServices = 'Mes services';
  static const mettreAJour = 'Mettre à jour';
  static const mettreAJourMesInformations = 'Mettre à jour mes informations';
  static const mieuxVousConnaitre = 'Mieux vous connaître';
  static const miseAJourEffectuee = 'Mise à jour effectuée';
  static const modifier = 'Modifier';
  static const moinsDe35m2 = 'Moins de 35 m²';
  static const motDePasse = 'Mot de passe';
  static const motDePasse12CaractresMinimum = '12 caractères minimum';
  static const motDePasse1CaractreSpecialMinimum =
      '1 caractère spécial minimum';
  static const motDePasse1ChiffreMinimum = '1 chiffre minimum';
  static const motDePasse1MajusculeEt1Minuscule =
      'Au moins 1 majuscule et 1 minuscule';
  static const motDePasseOublie = 'Mot de passe oublié ?';
  static const motDePasseOublieDetails =
      'Saisissez l’adresse électronique associé à votre compte.';
  static const motDePasseOublieTitre = 'Mot de passe oublié - 1/2';
  static const motDePasseOublieTitre2 = 'Mot de passe oublié - 2/2';
  static const nom = 'Nom';
  static const nombreDePartsFiscales =
      'Nombre de parts fiscales de votre foyer';
  static const nombreDePartsFiscalesDescription =
      '(Pré-calculé à partir des membres de votre foyer)';
  static const non = 'Non';
  static const nouveau = 'NOUVEAU !';
  static const obligatoire = 'obligatoire';
  static const optionsAvancees = 'Options avancées';
  static const ouHabitezVous = 'Où habitez-vous ?';
  static const ouTrouverCesInformations = 'Où trouver ces informations ?';
  static const ouTrouverCesInformationsReponse = '''
Le revenu fiscal de référence et votre nombre de parts se trouvent sur la 1ère page de votre dernier avis d’impôt.

**Nombre de parts :**

Si vous ne disposez pas de votre dernier avis d’impôt, renseignez 1 part pour chaque adulte de votre foyer fiscal, puis 0,5 part par enfant jusqu’à 2 enfants, puis 1 part par enfant à partir du 3ème enfant.

**Revenu fiscal de référence :**

Si vous ne disposez pas de votre dernier avis d’impôt, renseignez la somme des revenus de toutes les personnes avec lequelles vous partagez vos déclarations d’impôts (pour toute l’année) pour vous faire une première idée.''';
  static const oui = 'Oui';
  static const pageConnexionTitre = 'Accédez à mon compte J’agis';
  static const partieDeux = '2. LIRE DES ARTICLES ET RÉPONDRE AUX QUIZ';
  static const partieQuatre = '4. GAGNER VOTRE CARTE';
  static const partieTrois = '3. RÉALISER AU MOINS UNE ACTION PROPOSÉE';
  static const partieUne = '1. ADAPTER VOTRE EXPÉRIENCE';
  static const pasPourMoi = 'Pas pour moi';
  static const plusDe150m2 = 'Plus de 150 m²';
  static const plusieursReponsesPossibles = 'Plusieurs réponses possibles';
  static const point = '.';
  static const politiqueDeConfidentialite = 'Politique de confidentialité';
  static const politiqueDeConfidentialiteSite =
      'https://jagis.beta.gouv.fr/politique-de-confidentialite';
  static const pourquoi = 'Pourquoi ?';
  static const pourquoiCeDefi = 'Pourquoi cette action ?';
  static const pourquoiCesQuestions = 'Pourquoi ces questions ?';
  static const pourquoiCesQuestionsReponse =
      'Votre revenu fiscal de référence et le nombre de parts permettent d’afficher les aides en fonction de vos ressources.';
  static const preOnboardingTitre =
      'Ensemble,\naméliorons\nnos habitudes\nau jour le jour';
  static const premiereFoisSur = 'Première fois sur J’agis ?';
  static const prenom = 'Prénom';
  static const prixDuVelo = 'Prix du vélo';
  static const prixDuVeloExplications =
      'À titre indicatif, voici quelques prix moyens';
  static const prixDuVeloObligatoire = 'Le prix du vélo ne peux pas être vide';
  static const proposePar = 'Proposé par';
  static const propulsePar = 'Propulsé par ';
  static const quelleEstLaSuperficie = 'Quelle est la superficie ?';
  static const quelquesQuestionPourMieuxVousConnaitre =
      'Quelques questions pour mieux vous connaître';
  static const quiz = 'Quiz';
  static const rafraichir = 'Rafraichir';
  static const rechercherParTitre = 'Rechercher par titre';
  static const recommande = 'Recommandé';
  static const renvoyerCode = 'Renvoyer le code';
  static const renvoyerEmailDeConnexion = "Renvoyer l'e-mail de connexion";
  static const reprendreLaction = "Reprendre l'action";
  static const retirerDesFavoris = 'Retirer des favoris';
  static const retour = 'Retour';
  static const revenirAuSimulateur = 'Revenir au simulateur';
  static const revenirEnArriere = 'Revenir en arrière';
  static const revenuFiscal = 'Revenu fiscal de référence de mon foyer';
  static const revenuQuestion = 'Quelle est votre tranche de revenus ?';
  static const seDeconnecter = 'Se déconnecter';
  static const simulateur = 'Simulateur';
  static const simulerMonAide = 'Simuler mon aide';
  static const supprimerVotreCompte = 'Supprimer mon compte';
  static const supprimerVotreCompteConfirmation =
      'Veuillez confirmer la suppression du compte';
  static const supprimerVotreCompteContenu =
      'Vous pouvez à tout moment choisir de supprimer votre compte ainsi que l’ensemble des données qui y sont associées.';
  static const termine = 'TERMINÉ !';
  static const termine2 = 'Terminé !';
  static const termineLaMission = 'Terminer la mission';
  static const toutEstPret = 'Tout est prêt !';
  static const unAppartement = 'Un appartement';
  static const uneMaison = 'Une maison';
  static const valider = 'Valider';
  static const voirLesDemarches = 'Voir les démarches';
  static const mesActions = 'Mes actions';
  static const mesAides = 'Mes aides';
  static const mesAidesDisponibles = 'Mes aides disponibles';
  static const homeAssistanceTitlePart1 = 'Aides financières';
  static const homeAssistanceTitlePart2 = 'et bons plans';
  static const homeAssistanceSubTitle =
      "Toutes les aides **locales** et **nationales** pour vous aider à passer à l'action";
  static const assistanceListTitle =
      '**Aides financières** et bons plans **chez vous**';
  static const mesAidesLien = 'Voir toutes les aides';
  static const mesFavoris = 'Mes favoris';
  static const mesInformations = 'Mes informations';
  static const monIdentite = 'Mon identité';
  static const monLogement = 'Mon logement';
  static const monLogementPlusDe15Ans = 'Mon logement a-t-il plus de 15 ans ?';
  static const monMotDePasseDoitContenir = 'Mon mot de passe doit contenir :';
  static const monPrenom = 'Mon prénom';
  static const monProfil = 'Mon profil';
  static const maResidencePrincipaleEst = 'Ma résidence principale est ...';
  static const vousAvezDejaUnCompte = 'Vous avez déjà un compte ?';
  static const vousEtesProprietaireDeVotreLogement =
      'Vous êtes propriétaire de votre logement ?';

  static String cacherEmail(final String email) {
    final indexArobase =
        email.characters.findFirst(Characters('@'))!.stringBeforeLength;

    if (indexArobase > 2) {
      final debut = email.characters.getRange(0, 1);
      final fin = email.characters.getRange(indexArobase - 1, email.length);

      return '$debut${'*' * (indexArobase - 1 - 1)}$fin';
    }

    return email;
  }

  static String communeEtSaRegion(final String commune) =>
      '$commune et sa région.';

  static String donneesUtiliseesCodePostalEtCommune({
    required final String codePostal,
    required final String commune,
  }) =>
      '($codePostal - $commune)';

  static String donneesUtiliseesNombreDeParts(final double value) => '($value)';

  static String donneesUtiliseesRevenuFiscal(final int? value) =>
      '(${value == null ? '' : euro(value)})';

  static String entrezLeCodeRecuOublieMotDePasseParMailDetails(
    final String value,
  ) =>
      'Pour vérifier votre identité et vous permettre de modifier votre mot de passe, nous vous avons envoyé un e-mail à l’adresse : ${cacherEmail(value)}';

  static String entrezLeCodeRecuParMailDetails(final String value) =>
      'Pour vérifier votre identité et vous permettre d’accéder à votre compte, nous vous avons envoyé un e-mail à l’adresse : ${cacherEmail(value)}';

  static String euro(final int value) => '$value €';

  static String niveau(final int value) => 'NIVEAU $value';

  static String nombreArticle(final int value) =>
      value <= 1 ? '$value article' : '$value articles';

  static String nombrePoints(final int value) =>
      value <= 1 ? '$value point' : '$value points';

  static String prenomExclamation(final String value) => '$value !';

  static String questionCourantSurMax(final int actuel, final int max) =>
      '**Question $actuel** sur $max';

  static String recolterVosPoints(final int points) => 'Recolter vos $points';

  static String veloLabel(final String text) => '$text : ';
}
