const miniBilanQuestions = [
  {
    'code': 'KYC_transport_voiture_km',
    'question': "Quelle distance parcourez-vous à l'année en voiture ? (en km)",
    'reponse_unique': {'value': '13000', 'unite': 'km'},
    'is_answered': true,
    'categorie': 'mission',
    'points': 5,
    'type': 'entier',
    'is_NGC': true,
    'thematique': 'transport',
  },
  {
    'code': 'KYC_transport_avion_3_annees',
    'question':
        "Avez-vous pris l'avion au moins une fois ces 3 dernières années ?",
    'reponse_multiple': [
      {'code': 'oui', 'label': 'Oui', 'selected': false},
      {'code': 'non', 'label': 'Non', 'selected': true},
      {'code': 'ne_sais_pas', 'label': 'Je ne sais pas', 'selected': false},
    ],
    'is_answered': true,
    'categorie': 'mission',
    'points': 5,
    'type': 'choix_unique',
    'is_NGC': true,
    'thematique': 'transport',
  },
];
