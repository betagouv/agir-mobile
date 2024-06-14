import 'package:equatable/equatable.dart';

enum MesInformationsStatut { initial, chargement, succes }

final class MesInformationsState extends Equatable {
  const MesInformationsState({
    required this.prenom,
    required this.nom,
    required this.email,
    required this.nombreDePartsFiscales,
    required this.revenuFiscal,
    required this.statut,
  });

  const MesInformationsState.empty()
      : this(
          prenom: '',
          nom: '',
          email: '',
          nombreDePartsFiscales: 0,
          revenuFiscal: null,
          statut: MesInformationsStatut.initial,
        );

  final String prenom;
  final String nom;
  final String email;
  final double nombreDePartsFiscales;
  final int? revenuFiscal;
  final MesInformationsStatut statut;

  MesInformationsState copyWith({
    final String? prenom,
    final String? nom,
    final String? email,
    final double? nombreDePartsFiscales,
    final int? revenuFiscal,
    final MesInformationsStatut? statut,
  }) =>
      MesInformationsState(
        prenom: prenom ?? this.prenom,
        nom: nom ?? this.nom,
        email: email ?? this.email,
        nombreDePartsFiscales:
            nombreDePartsFiscales ?? this.nombreDePartsFiscales,
        revenuFiscal: revenuFiscal ?? this.revenuFiscal,
        statut: statut ?? this.statut,
      );

  @override
  List<Object?> get props =>
      [prenom, nom, email, nombreDePartsFiscales, revenuFiscal, statut];
}
