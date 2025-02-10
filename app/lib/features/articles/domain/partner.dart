import 'package:equatable/equatable.dart';

class Partner extends Equatable {
  const Partner({required this.nom, required this.url, required this.logo});

  final String nom;
  final String? url;
  final String logo;

  @override
  List<Object?> get props => [nom, url, logo];
}
