import 'package:equatable/equatable.dart';

final class CreerCompteState extends Equatable {
  const CreerCompteState({
    required this.adresseMail,
    required this.motDePasse,
    required this.compteCree,
  });

  const CreerCompteState.empty()
      : this(adresseMail: '', motDePasse: '', compteCree: false);

  final String adresseMail;
  final String motDePasse;
  final bool compteCree;

  CreerCompteState copyWith({
    final String? adresseMail,
    final String? motDePasse,
    final bool? compteCree,
  }) =>
      CreerCompteState(
        adresseMail: adresseMail ?? this.adresseMail,
        motDePasse: motDePasse ?? this.motDePasse,
        compteCree: compteCree ?? this.compteCree,
      );

  @override
  List<Object> get props => [adresseMail, motDePasse, compteCree];
}
