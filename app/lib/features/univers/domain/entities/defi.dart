import 'package:app/features/univers/domain/value_objects/defi_id.dart';
import 'package:equatable/equatable.dart';

final class Defi extends Equatable {
  const Defi({
    required this.id,
    required this.thematique,
    required this.titre,
    required this.status,
    this.motif,
    required this.astuces,
    required this.pourquoi,
  });

  final DefiId id;
  final String thematique;
  final String titre;
  final String status;
  final String? motif;
  final String astuces;
  final String pourquoi;

  @override
  List<Object?> get props =>
      [id, thematique, titre, status, motif, astuces, pourquoi];
}
