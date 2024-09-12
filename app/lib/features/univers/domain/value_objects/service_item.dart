import 'package:equatable/equatable.dart';

final class ServiceItem extends Equatable {
  const ServiceItem({
    required this.titre,
    required this.sousTitre,
    required this.externalUrl,
  });

  final String titre;
  final String sousTitre;
  final String externalUrl;

  @override
  List<Object?> get props => [titre, sousTitre, externalUrl];
}
