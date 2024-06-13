import 'package:equatable/equatable.dart';

class AideVeloInformations extends Equatable {
  const AideVeloInformations({
    required this.codePostal,
    required this.ville,
    required this.nombreDePartsFiscales,
    required this.revenuFiscal,
  });

  final String codePostal;
  final String ville;
  final double nombreDePartsFiscales;
  final int? revenuFiscal;

  @override
  List<Object?> get props => [
        codePostal,
        ville,
        nombreDePartsFiscales,
        revenuFiscal,
      ];
}
