import 'package:equatable/equatable.dart';

sealed class MotDePasseOublieEvent extends Equatable {
  const MotDePasseOublieEvent();

  @override
  List<Object> get props => [];
}

final class MotDePasseOublieEmailChange extends MotDePasseOublieEvent {
  const MotDePasseOublieEmailChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

final class MotDePasseOublieValider extends MotDePasseOublieEvent {
  const MotDePasseOublieValider();
}
