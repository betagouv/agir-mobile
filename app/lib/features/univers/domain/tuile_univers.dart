import 'package:equatable/equatable.dart';

class TuileUnivers extends Equatable {
  const TuileUnivers({
    required this.type,
    required this.titre,
    required this.imageUrl,
    required this.estTerminee,
  });

  final String type;
  final String titre;
  final String imageUrl;
  final bool estTerminee;

  @override
  List<Object?> get props => [type, titre, imageUrl, estTerminee];
}
