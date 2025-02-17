import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class QuestionCodePostalState extends Equatable {
  const QuestionCodePostalState({
    required this.prenom,
    required this.codePostal,
    required this.communes,
    required this.commune,
    required this.aEteChange,
  });

  final String prenom;
  final String codePostal;
  final List<String> communes;
  final String commune;
  final bool aEteChange;
  bool get estRempli => codePostal.isNotEmpty && commune.isNotEmpty;

  QuestionCodePostalState copyWith({
    final String? prenom,
    final String? codePostal,
    final List<String>? communes,
    final String? commune,
    final bool? aEteChange,
  }) => QuestionCodePostalState(
    prenom: prenom ?? this.prenom,
    codePostal: codePostal ?? this.codePostal,
    communes: communes ?? this.communes,
    commune: commune ?? this.commune,
    aEteChange: aEteChange ?? this.aEteChange,
  );

  @override
  List<Object> get props => [prenom, codePostal, communes, commune, aEteChange];
}
