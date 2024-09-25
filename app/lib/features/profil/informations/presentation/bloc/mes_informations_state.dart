import 'package:equatable/equatable.dart';

enum MesInformationsStatut { initial, chargement, succes }

final class MesInformationsState extends Equatable {
  const MesInformationsState({
    required this.email,
    required this.prenom,
    required this.nom,
    required this.anneeDeNaissance,
    required this.nombreDePartsFiscales,
    required this.revenuFiscal,
    required this.statut,
  });

  const MesInformationsState.empty()
      : this(
          email: '',
          prenom: '',
          nom: '',
          anneeDeNaissance: null,
          nombreDePartsFiscales: 0,
          revenuFiscal: null,
          statut: MesInformationsStatut.initial,
        );

  final String? prenom;
  final String? nom;
  final int? anneeDeNaissance;
  final String email;
  final double nombreDePartsFiscales;
  final int? revenuFiscal;
  final MesInformationsStatut statut;

  MesInformationsState copyWith({
    final String? email,
    final String? prenom,
    final String? nom,
    final int? anneeDeNaissance,
    final double? nombreDePartsFiscales,
    final int? revenuFiscal,
    final MesInformationsStatut? statut,
  }) =>
      MesInformationsState(
        email: email ?? this.email,
        prenom: prenom ?? this.prenom,
        nom: nom ?? this.nom,
        anneeDeNaissance: anneeDeNaissance ?? this.anneeDeNaissance,
        nombreDePartsFiscales:
            nombreDePartsFiscales ?? this.nombreDePartsFiscales,
        revenuFiscal: revenuFiscal ?? this.revenuFiscal,
        statut: statut ?? this.statut,
      );

  @override
  List<Object?> get props => [
        email,
        prenom,
        nom,
        anneeDeNaissance,
        nombreDePartsFiscales,
        revenuFiscal,
        statut,
      ];
}
