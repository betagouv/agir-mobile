import 'package:equatable/equatable.dart';

final class SaisieCodeState extends Equatable {
  const SaisieCodeState({
    required this.email,
    required this.renvoyerCodeDemandee,
  });

  final String email;
  final bool renvoyerCodeDemandee;

  SaisieCodeState copyWith({
    final String? email,
    final bool? renvoyerCodeDemandee,
  }) =>
      SaisieCodeState(
        email: email ?? this.email,
        renvoyerCodeDemandee: renvoyerCodeDemandee ?? this.renvoyerCodeDemandee,
      );

  @override
  List<Object> get props => [email, renvoyerCodeDemandee];
}
