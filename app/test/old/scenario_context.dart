import 'package:app/core/authentication/domain/authentication_status.dart';
import 'package:app/features/profil/logement/presentation/bloc/mon_logement_state.dart';
import 'package:app/features/quiz/domain/quiz.dart';

import '../helpers/dio_mock.dart';
import 'mocks/profil_port_mock.dart';
import 'mocks/quiz_port_mock.dart';

class ScenarioContext {
  factory ScenarioContext() => _instance ??= ScenarioContext._();
  ScenarioContext._();
  DioMock? dioMock;
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

  ProfilPortMock? profilPortMock;
  QuizPortMock? quizPortMock;
  static ScenarioContext? _instance;

  static void dispose() => _instance = null;
}
