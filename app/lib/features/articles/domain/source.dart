import 'package:equatable/equatable.dart';

class Source extends Equatable {
  const Source({required this.libelle, required this.lien});

  final String libelle;
  final String lien;

  @override
  List<Object> get props => [libelle, lien];
}
