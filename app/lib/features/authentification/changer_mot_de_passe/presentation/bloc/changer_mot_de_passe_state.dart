import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class ChangerMotDePasseState extends Equatable {
  const ChangerMotDePasseState({
    required this.motDePasse,
    required this.motPasseEstChange,
  });

  const ChangerMotDePasseState.empty()
    : this(motDePasse: '', motPasseEstChange: false);

  final String motDePasse;
  bool get estValide => motDePasse.isNotEmpty;

  final bool motPasseEstChange;

  ChangerMotDePasseState copyWith({
    final String? motDePasse,
    final bool? motPasseEstChange,
  }) => ChangerMotDePasseState(
    motDePasse: motDePasse ?? this.motDePasse,
    motPasseEstChange: motPasseEstChange ?? this.motPasseEstChange,
  );

  @override
  List<Object> get props => [motDePasse, motPasseEstChange];
}
