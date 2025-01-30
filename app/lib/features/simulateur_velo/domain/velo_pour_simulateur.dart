enum VeloPourSimulateur {
  mechanique(label: 'Vélo mécanique', prix: 250),
  pliantStandard(label: 'Vélo pliant standard', prix: 500),
  electriqueStandard(label: 'Vélo électrique standard', prix: 2000),
  cargoElectrique(label: 'Vélo cargo électrique', prix: 7000);

  const VeloPourSimulateur({required this.label, required this.prix});

  final String label;
  final int prix;
}

enum VeloEtat {
  neuf(label: 'Neuf'),
  occasion(label: 'Occasion');

  const VeloEtat({required this.label});

  final String label;
}
