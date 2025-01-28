import 'package:app/core/authentication/domain/authentication_status.dart';
import 'package:app/features/bibliotheque/domain/bibliotheque.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/profil/logement/presentation/bloc/mon_logement_state.dart';
import 'package:app/features/quiz/domain/quiz.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/theme/core/domain/mission_liste.dart';

import 'mocks/authentification_port_mock.dart';
import 'mocks/mieux_vous_connaitre_port_mock.dart';
import 'mocks/profil_port_mock.dart';
import 'mocks/quiz_port_mock.dart';
import 'mocks/theme_port_mock.dart';

class ScenarioContext {
  factory ScenarioContext() => _instance ??= ScenarioContext._();
  ScenarioContext._();
  AuthenticationStatus authentificationStatut = const Unauthenticated();
  String email = 'lucas@saudon.fr';
  String prenom = 'Lucas';
  String nom = 'Saudon';
  int anneeDeNaissance = 1990;
  String codePostal = '75018';
  String commune = 'Paris';
  int nombreAdultes = 1;
  int nombreEnfants = 0;
  TypeDeLogement? typeDeLogement;
  bool? estProprietaire;
  Superficie? superficie;
  bool? plusDe15Ans;
  Dpe? dpe;
  double nombreDePartsFiscales = 0;
  int? revenuFiscal;
  List<MissionListe> missionListe = <MissionListe>[];
  List<Recommandation> recommandations = <Recommandation>[];
  Quiz quiz = const Quiz(
    id: '',
    thematique: '',
    question: '',
    reponses: [],
    points: 0,
    explicationOk: '',
    explicationKo: '',
    article: null,
  );
  List<String> communes = <String>[];
  List<Question> questions = <Question>[];
  Bibliotheque bibliotheque = const Bibliotheque(contenus: [], filtres: []);

  ProfilPortMock? profilPortMock;
  AuthentificationPortMock? authentificationPortMock;
  QuizPortMock? quizPortMock;
  MieuxVousConnaitrePortMock? mieuxVousConnaitrePortMock;
  ThemePortMock? themePortMock;
  static ScenarioContext? _instance;

  static void dispose() => _instance = null;
}
