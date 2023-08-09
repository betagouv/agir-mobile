import 'package:agir/interactions/ports/interactions_repository.dart';

enum InteractionCategorie {
  ENERGIE,
  CONSOMMATION,
  ALIMENTATION,
  GLOBAL,
  TRANSPORTS,
}

enum InteractionType {
  QUIZ,
  ARTICLE,
  KYC,
  SUIVIDUJOUR,
}

class Interaction {
  final String id;
  final InteractionType type;
  final String titre;
  final String sousTitre;
  final InteractionCategorie categorie;
  final String nombreDePointsAGagner;
  final String miseEnAvant;
  final String illustrationURL;
  final String? url;
  final bool aEteFaite;
  final String idDuContenu;
  final String duree;
  final bool estBloquee;

  Interaction({
    required this.id,
    required this.type,
    required this.titre,
    required this.sousTitre,
    required this.categorie,
    required this.nombreDePointsAGagner,
    required this.miseEnAvant,
    required this.illustrationURL,
    required this.url,
    required this.aEteFaite,
    required this.idDuContenu,
    required this.duree,
    required this.estBloquee,
  });
}


class FetchInteractionUseCase {
  final InteractionsRepository _interactionsRepository;

  FetchInteractionUseCase(this._interactionsRepository);

  Future<List<Interaction>> execute(String utilisateurId) async {
    return await _interactionsRepository.getInteractions(utilisateurId);
  }
}