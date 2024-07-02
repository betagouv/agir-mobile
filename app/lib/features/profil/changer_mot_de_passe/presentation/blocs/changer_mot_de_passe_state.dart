import 'package:equatable/equatable.dart';

final class ChangerMotDePasseState extends Equatable {
  const ChangerMotDePasseState({
    required this.motDePasse,
    required this.motPasseEstChange,
  });

  const ChangerMotDePasseState.empty()
      : this(motDePasse: '', motPasseEstChange: false);

  final String motDePasse;
  bool get douzeCaracteresMinimum => motDePasse.length >= 12;
  bool get auMoinsUneMajusculeEtUneMinuscule =>
      motDePasse.contains(RegExp('[A-Z]')) &&
      motDePasse.contains(RegExp('[a-z]'));
  bool get unCaractereSpecialMinimum => motDePasse.contains(
        RegExp(r'''[&~»#)‘\-_`{[|`_\\^@)\]=}+%*$£¨!§/:;.?¿\'",§éèêëàâä»]'''),
      );
  bool get unChiffreMinimum => motDePasse.contains(RegExp(r'\d'));
  bool get estValide =>
      douzeCaracteresMinimum &&
      auMoinsUneMajusculeEtUneMinuscule &&
      unCaractereSpecialMinimum &&
      unChiffreMinimum;

  final bool motPasseEstChange;

  ChangerMotDePasseState copyWith({
    final String? motDePasse,
    final bool? motPasseEstChange,
  }) =>
      ChangerMotDePasseState(
        motDePasse: motDePasse ?? this.motDePasse,
        motPasseEstChange: motPasseEstChange ?? this.motPasseEstChange,
      );

  @override
  List<Object> get props => [motDePasse, motPasseEstChange];
}
