import 'package:agir/agir_state.dart';
import 'package:agir/interactions/fetchInteractions_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../interactions/redux/interactions_actions.dart';

class InteractionDisplayModel {
  final String id;
  final String type;
  final String titre;
  final String sousTitre;
  final String categorie;
  final String nombreDePointsAGagner;
  final String miseEnAvant;
  final String illustrationURL;
  final String url;
  final String idDuContenu;
  final String duree;
  final bool estBloquee;

  InteractionDisplayModel(
      this.id,
      this.type,
      this.titre,
      this.sousTitre,
      this.categorie,
      this.nombreDePointsAGagner,
      this.miseEnAvant,
      this.illustrationURL,
      this.url,
      this.idDuContenu,
      this.duree,
      this.estBloquee);
}

class InteractionsViewModel extends Equatable {
  final List<InteractionDisplayModel> interactions;

  const InteractionsViewModel._internal(this.interactions);

  factory InteractionsViewModel(AgirState agirState) {
    debugPrint("id : ${agirState.utilisateurState.id}");
    final interactions = agirState.interactionsState.interactions
        .map((e) => InteractionDisplayModel(
              e.id,
              getType(e.type),
              e.titre,
              e.sousTitre,
              getCategorie(e.categorie),
              e.nombreDePointsAGagner,
              e.miseEnAvant,
              e.illustrationURL,
              determineUrl(e),
              e.idDuContenu,
              e.duree,
              e.estBloquee,
            ))
        .toList();

    return InteractionsViewModel._internal(interactions);
  }

  @override
  List<Object?> get props => [interactions];

  static String getType(InteractionType type) {
    switch (type) {
      case InteractionType.QUIZ:
        return "QUIZ";
      case InteractionType.ARTICLE:
        return "ARTICLE";
      case InteractionType.KYC:
        return "KYC";
      case InteractionType.SUIVIDUJOUR:
        return "SUIVI";
    }
  }

  static String getCategorie(InteractionCategorie categorie) {
    switch (categorie) {
      case InteractionCategorie.ALIMENTATION:
        return "🥦 Alimentation";
      case InteractionCategorie.ENERGIE:
        return "⚡️ Énergie";
      case InteractionCategorie.CONSOMMATION:
        return "📱 Consommation";
      case InteractionCategorie.GLOBAL:
        return "🌍 Global";
      case InteractionCategorie.TRANSPORTS:
        return "🚲 Transports";
    }
  }

  static String determineUrl(Interaction interaction) {
    switch (interaction.type) {
      case InteractionType.QUIZ:
        return "/coach/quiz/${interaction.idDuContenu}";
      case InteractionType.ARTICLE:
        return interaction.url!;
      case InteractionType.KYC:
        return "";
      case InteractionType.SUIVIDUJOUR:
        return "/coach/suivi-du-jour";
    }
  }
}

class InteractionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactions List'),
      ),
      body: StoreConnector<AgirState, InteractionsViewModel>(
        converter: (store) => InteractionsViewModel(store.state),
        distinct: true,
        onInit: (store) {
          store.dispatch(
              LoadInteractionsActions(store.state.utilisateurState.id));
        },
        builder: (BuildContext context, InteractionsViewModel vm) =>
            ListView.builder(
          itemCount: vm.interactions.length,
          itemBuilder: (context, index) {
            InteractionDisplayModel interaction = vm.interactions[index];
            return Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(interaction.illustrationURL),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          SizedBox(height: 4.0),
                          Text(
                            interaction.categorie,
                            style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              interaction.titre.length > 30
                                  ? "${interaction.titre.substring(0, 30)}..."
                                  : interaction.titre,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]))
                  ],
                ));
          },
        ),
      ),
    );
  }
}
