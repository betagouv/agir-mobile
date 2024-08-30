import 'package:app/shared/helpers/mail_regex.dart';
import 'package:equatable/equatable.dart';

class MotDePasseOublieState extends Equatable {
  const MotDePasseOublieState({required this.email});

  final String email;
  bool get emailEstValide => mailRegex.hasMatch(email);

  MotDePasseOublieState copyWith({final String? email}) =>
      MotDePasseOublieState(email: email ?? this.email);

  @override
  List<Object> get props => [email];
}
