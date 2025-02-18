import 'package:equatable/equatable.dart';

final class ServiceItem extends Equatable {
  const ServiceItem({
    required this.idService,
    required this.titre,
    required this.sousTitre,
    required this.externalUrl,
    required this.iconUrl,
  });

  final String idService;
  final String titre;
  final String sousTitre;
  final String externalUrl;
  final String iconUrl;

  bool get isInternalService => idService == 'fruits_legumes' || idService == 'recettes';
  bool get isFruitsLegumesService => idService == 'fruits_legumes';
  bool get isRecipeService => idService == 'recettes';

  @override
  List<Object?> get props => [idService, titre, sousTitre, externalUrl, iconUrl];
}
